
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit HWCServerMonitorUI;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  DataSnap.DSCommon, System.JSON;

type
  TForm5 = class(TForm)
    Label1: TLabel;
    LogMemo: TMemo;
    BroadcastField: TEdit;
    BroadcastButton: TButton;
    ButtonBrowser: TButton;
    procedure BroadcastButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ButtonBrowserClick(Sender: TObject);
  private
    procedure LogMessage(const Msg: String);
  end;

var
  Form5: TForm5;

implementation

uses Data.DBXJSON, //used for TJSONString result value for broadcasting
     DataSnap.DSServer, //used for TDSCallbackTunnelManager instance
     ServerContainerUnit1,
     ShellAPI;

{$R *.dfm}

procedure TForm5.BroadcastButtonClick(Sender: TObject);
var
  Val: String;
  Msg: TJSONString;
begin
  Val := Trim(BroadcastField.Text);
  if Val <> EmptyStr then
  begin
    Msg := TJSONString.Create(Val);
    ServerContainer1.DSServer1.BroadcastMessage('MemoChannel', Msg);
    BroadcastField.Text := EmptyStr;
  end;
end;

procedure TForm5.LogMessage(const Msg: String);
begin
  TThread.Queue(nil,
    procedure
    begin
      LogMemo.Lines.Add(Msg);
    end);
end;

procedure TForm5.ButtonBrowserClick(Sender: TObject);
var
  LURL: String;
begin
  LURL := Format('http://localhost:%s/index.html',
                 [IntToStr(Integer(ServerContainer1.DSHTTPService1.HttpPort))]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TForm5.FormActivate(Sender: TObject);
begin
  TDSCallbackTunnelManager.Instance.AddTunnelEvent(
    procedure(Sender: TObject; const EventItem: TDSCallbackTunnelEventItem)
    begin
      case EventItem.EventType of
        //event when a tunnel (client channel) is created
        TunnelCreate: LogMessage('A Tunnel was created - ' +
                                  EventItem.TunnelId + ', ' +
                                  EventItem.CallbackId);

        //eveny when a tunnel (client channel) is closed
        TunnelClose: LogMessage('A Tunnel was closed - ' +
                                EventItem.TunnelId);

        //event when a callback is added to a tunnel
        CallbackAdded: LogMessage('A callback was added - ' +
                                  EventItem.TunnelId + ', ' +
                                  EventItem.CallbackId);

        //event when a callback is removed from a tunnel
        CallbackRemoved: LogMessage('A callback was removed - ' +
                                    EventItem.TunnelId + ', ' +
                                    EventItem.CallbackId);
      end;
    end);
end;

end.

