
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit HWCDBXClientMonitorUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IndyPeerImpl, Datasnap.DSHTTPCommon,
  System.JSON, IPPeerServer, Data.DBXJSON,
  Datasnap.DSServer, Datasnap.DSCommon, IPPeerClient; //used for event types;

type
  MyCallback = class(TDBXCallback)
  private
    FIsForFirstCallback: boolean;
  public
    constructor Create(IsForFirstCallback: boolean);
    function Execute(const Arg: TJSONValue): TJSONValue; override;
  end;

  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    MemoFirstCB: TMemo;
    ButtonFirstStop: TButton;
    ButtonFirstStart: TButton;
    MemoSecondCB: TMemo;
    ButtonAllStop: TButton;
    ButtonSecondStart: TButton;
    ButtonSecondStop: TButton;
    ChannelManager: TDSClientCallbackChannelManager;
    procedure ChannelManagerChannelStateChange(Sender: TObject;
      const EventItem: TDSClientChannelEventItem);
    procedure ButtonFirstStartClick(Sender: TObject);
    procedure ButtonSecondStartClick(Sender: TObject);
    procedure ButtonSecondStopClick(Sender: TObject);
    procedure ButtonFirstStopClick(Sender: TObject);
    procedure ButtonAllStopClick(Sender: TObject);
  private
    procedure LogMessage(const Msg: String; const IsForFirstCallback: boolean);
    procedure UpdateButtonEnablement(const EventType: TDSCallbackTunnelEventType;
                                     const CallbackId: String);
    procedure UpdateButtonsForCallbackStart(const CallbackId: String);
    procedure UpdateButtonsForCallbackStop(const CallbackId: String);
  end;

var
  Form2: TForm2;

implementation

{ MyCallback }

constructor MyCallback.Create(IsForFirstCallback: boolean);
begin
  FIsForFirstCallback := IsForFirstCallback;
end;

function MyCallback.Execute(const Arg: TJSONValue): TJSONValue;
begin
  if Arg Is TJSONString then
    Form2.LogMessage(Arg.Value, FIsForFirstCallback);

  Exit(TJSONTrue.Create);
end;

{$R *.dfm}

procedure TForm2.LogMessage(const Msg: String; const IsForFirstCallback: boolean);
begin
  TThread.Queue(nil,
     procedure
     begin
       if IsForFirstCallback then
         MemoFirstCB.Lines.Add(Msg)
       else
         MemoSecondCB.Lines.Add(Msg);
     end);
end;

procedure TForm2.ButtonFirstStartClick(Sender: TObject);
begin
  ChannelManager.RegisterCallback('cb1', MyCallback.Create(true));
end;

procedure TForm2.ButtonSecondStartClick(Sender: TObject);
begin
  ChannelManager.RegisterCallback('cb2', MyCallback.Create(false));
end;

procedure TForm2.ButtonFirstStopClick(Sender: TObject);
begin
  ChannelManager.UnregisterCallback('cb1');
end;

procedure TForm2.ButtonSecondStopClick(Sender: TObject);
begin
  ChannelManager.UnregisterCallback('cb2');
end;

procedure TForm2.ButtonAllStopClick(Sender: TObject);
begin
  ChannelManager.CloseClientChannel;
end;

procedure TForm2.ChannelManagerChannelStateChange(Sender: TObject;
                      const EventItem: TDSClientChannelEventItem);
begin
  UpdateButtonEnablement(EventItem.EventType, EventItem.CallbackId);
end;

procedure TForm2.UpdateButtonEnablement(const EventType: TDSCallbackTunnelEventType;
                                        const CallbackId: String);
begin
  TThread.Queue(nil,
    procedure
    begin
      case EventType of
        //tunnel was created. Meaning a callback was added
        TunnelCreate: UpdateButtonsForCallbackStart(CallbackId);

        //a callback was added, could be either cb1 or cb2
        CallbackAdded: UpdateButtonsForCallbackStart(CallbackId);

        //the tunnel was closed. all callbacks are removed
        TunnelClose,
        TunnelClosedByServer:
        begin
          ButtonAllStop.Enabled := False;
          ButtonFirstStart.Enabled := True;
          ButtonFirstStop.Enabled := False;
          ButtonSecondStart.Enabled := True;
          ButtonSecondStop.Enabled := False;
        end;

        //a callback was removed. if it was the last one, the tunnel is now closed
        CallbackRemoved:
          UpdateButtonsForCallbackStop(CallbackId);
      end;
    end);
end;

procedure TForm2.UpdateButtonsForCallbackStart(const CallbackId: String);
begin
  ButtonAllStop.Enabled := True;

  if CallbackId = 'cb1' then
  begin
    ButtonFirstStart.Enabled := False;
    ButtonFirstStop.Enabled := True;
  end;

  if CallbackId = 'cb2' then
  begin
    ButtonSecondStart.Enabled := False;
    ButtonSecondStop.Enabled := True;
  end;
end;

procedure TForm2.UpdateButtonsForCallbackStop(const CallbackId: String);
begin
  if CallbackId = 'cb1' then
  begin
    ButtonFirstStart.Enabled := True;
    ButtonFirstStop.Enabled := False;
  end;

  if CallbackId = 'cb2' then
  begin
    ButtonSecondStart.Enabled := True;
    ButtonSecondStop.Enabled := False;
  end;

  if ChannelManager.State = ctsStopped then
    ButtonAllStop.Enabled := False;
end;

end.
