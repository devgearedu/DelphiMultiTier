
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit HWCRESTClientMonitorUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Datasnap.DSClientRest, IndyPeerImpl, IPPeerClient, IPPeerServer,
  System.JSON,
  Datasnap.DSServer; //used for event types;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    MemoFirstCB: TMemo;
    ButtonFirstStop: TButton;
    ButtonFirstStart: TButton;
    MemoSecondCB: TMemo;
    ButtonAllStop: TButton;
    ButtonSecondStart: TButton;
    ButtonSecondStop: TButton;
    DSRestConnection1: TDSRestConnection;
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonFirstStartClick(Sender: TObject);
    procedure ButtonSecondStartClick(Sender: TObject);
    procedure ButtonFirstStopClick(Sender: TObject);
    procedure ButtonSecondStopClick(Sender: TObject);
    procedure ButtonAllStopClick(Sender: TObject);
  private
    FChannelManager: TDSRestClientChannel;
    FCB1: TDSRestClientCallback;
    FCB2: TDSRestClientCallback;

    procedure LogMessage(const Msg: String; const IsForFirstCallback: boolean);
    procedure UpdateButtonEnablement(const EventType: TDSRESTChannelEventType;
                                     const CallbackId: String);
    procedure UpdateButtonsForCallbackStart(const CallbackId: String);
    procedure UpdateButtonsForCallbackStop(const CallbackId: String);

    procedure ChannelManagerChannelStateChange(const EventItem:
                                               TDSRESTChannelEventItem);

    function ExecuteForCB1(AValue: TJSONValue; ADataType: string): Boolean;
    function ExecuteForCB2(AValue: TJSONValue; ADataType: string): Boolean;

  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.ButtonAllStopClick(Sender: TObject);
begin
  FChannelManager.Disconnect;
end;

procedure TForm6.ButtonFirstStartClick(Sender: TObject);
begin
  FCB1 :=  TDSRestClientCallback.Create(FChannelManager, 'cb1', ExecuteForCB1);
  if not FChannelManager.Connected then
    FChannelManager.Connect(FCB1)
  else
    FChannelManager.RegisterCallback(FCB1);
end;

procedure TForm6.ButtonFirstStopClick(Sender: TObject);
begin
  FChannelManager.UnregisterCallback(FCB1);
end;

procedure TForm6.ButtonSecondStartClick(Sender: TObject);
begin
  FCB2 :=  TDSRestClientCallback.Create(FChannelManager, 'cb2', ExecuteForCB2);
  if not FChannelManager.Connected then
    FChannelManager.Connect(FCB2)
  else
    FChannelManager.RegisterCallback(FCB2);
end;

procedure TForm6.ButtonSecondStopClick(Sender: TObject);
begin
  FChannelManager.UnregisterCallback(FCB2);
end;

procedure TForm6.ChannelManagerChannelStateChange(const EventItem: TDSRESTChannelEventItem);
begin
  UpdateButtonEnablement(EventItem.EventType, EventItem.CallbackId);
end;

function TForm6.ExecuteForCB1(AValue: TJSONValue; ADataType: string): Boolean;
begin
  if AValue Is TJSONString then
    Form6.LogMessage(AValue.Value, true);

  Exit(True);
end;

function TForm6.ExecuteForCB2(AValue: TJSONValue; ADataType: string): Boolean;
begin
  if AValue Is TJSONString then
    Form6.LogMessage(AValue.Value, false);

  Exit(True);
end;

procedure TForm6.FormActivate(Sender: TObject);
begin
  FChannelManager := TDSRestClientChannel.Create('tunnelID' + IntToStr(Random(10000)),
                                                 'MemoChannel', DSRestConnection1);
  FChannelManager.OnChannelStateChange := ChannelManagerChannelStateChange;
end;

procedure TForm6.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FChannelManager);
end;

procedure TForm6.LogMessage(const Msg: String; const IsForFirstCallback: boolean);
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

procedure TForm6.UpdateButtonEnablement(const EventType: TDSRESTChannelEventType;
                                        const CallbackId: String);
begin
  TThread.Queue(nil,
    procedure
    begin
      case EventType of
        //tunnel was created. Meaning a callback was added
        rChannelCreate: UpdateButtonsForCallbackStart(CallbackId);

        //a callback was added, could be either cb1 or cb2
        rCallbackAdded: UpdateButtonsForCallbackStart(CallbackId);

        //the tunnel was closed. all callbacks are removed
        rChannelClose,
        rChannelClosedByServer:
        begin
          ButtonAllStop.Enabled := False;
          ButtonFirstStart.Enabled := True;
          ButtonFirstStop.Enabled := False;
          ButtonSecondStart.Enabled := True;
          ButtonSecondStop.Enabled := False;
        end;

        //a callback was removed. if it was the last one, the tunnel is now closed
        rCallbackRemoved:
          UpdateButtonsForCallbackStop(CallbackId);
      end;
    end);
end;

procedure TForm6.UpdateButtonsForCallbackStart(const CallbackId: String);
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

procedure TForm6.UpdateButtonsForCallbackStop(const CallbackId: String);
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

  if (FChannelManager.Connected) then
    ButtonAllStop.Enabled := False;
end;

end.
