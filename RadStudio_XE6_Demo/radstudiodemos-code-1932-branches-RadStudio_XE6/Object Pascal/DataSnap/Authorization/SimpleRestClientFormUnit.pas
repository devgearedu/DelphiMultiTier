
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit SimpleRestClientFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WideStrings, DbxDatasnap, DB, SqlExpr, DBXCommon, AppEvnts,
  DSClientRest, IPPeerClient, IndyPeerImpl;

type
  TForm58 = class(TForm)
    EditURLPath: TEdit;
    Label9: TLabel;
    EditPort: TEdit;
    Label8: TLabel;
    EditHost: TEdit;
    Label6: TLabel;
    ButtonEchoString: TButton;
    EditValue: TEdit;
    Label1: TLabel;
    EditServerClass: TEdit;
    ButtonClearSession: TButton;
    ApplicationEvents1: TApplicationEvents;
    EditMethodName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditUser: TEdit;
    Label4: TLabel;
    EditPassword: TEdit;
    Memo1: TMemo;
    ButtonClear: TButton;
    DSRestConnection1: TDSRestConnection;
    ButtonTestConnection: TButton;
    CheckBoxUseProxy: TCheckBox;
    Label11: TLabel;
    LabelTime: TLabel;
    Label5: TLabel;
    EditRepeatCount: TEdit;
    procedure ButtonEchoStringClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonClearSessionClick(Sender: TObject);
    procedure EditPortChange(Sender: TObject);
    procedure EditHostChange(Sender: TObject);
    procedure EditURLPathChange(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonTestConnectionClick(Sender: TObject);
  private
    function EchoString(const AServerClassName,
      AMethodName, AValue: string): string;
    procedure OpenConnection(const AHost: string; APort: Integer;
      const AURLPath: string; const AUser, APassword: string);
    procedure ClearSession;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form58: TForm58;

implementation

{$R *.dfm}

uses DSHTTPLayer;

procedure TForm58.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonEchoString.Caption := EditMethodName.Text;
  ButtonClearSession.Enabled := DSRestConnection1.SessionID <> '';
end;

procedure TForm58.ButtonClearClick(Sender: TObject);
begin
Memo1.Lines.Clear;
end;

procedure TForm58.ButtonClearSessionClick(Sender: TObject);
begin
  DSRestConnection1.SessionID := '';
  DSRestConnection1.HTTP.Disconnect;
end;

procedure TForm58.ClearSession;
begin
  DSRestConnection1.SessionID := '';
  DSRestConnection1.HTTP.Disconnect;
end;

procedure TForm58.ButtonEchoStringClick(Sender: TObject);
var
  LResult: string;
  LStart: Cardinal;
  I: Integer;
  LCount: Integer;
begin
  LabelTime.Caption := '0';
  LCount := StrToInt(EditRepeatCount.Text);
  try
    OpenConnection(EditHost.Text,
        StrToInt(EditPort.Text),
        EditURLPath.Text,
        EditUser.Text, EditPassword.Text);
    LStart := GetTickCount;
    for I := 0 to LCount - 1 do
    begin
      LResult := EchoString(
        EditServerClass.Text, EditMethodName.Text, EditValue.Text);
    end;
    LabelTime.Caption := IntToStr(GetTickCount - LStart);
    Memo1.Lines.Insert(0, LResult);
  except
    on E: TDSRestProtocolException do
      Memo1.Lines.Insert(0, Format('Exception: %s, Message: %s, Status: %d, ErrorText: %s', [E.ClassName, E.Message,
        TDSRestProtocolException(E).Status, TDSRestProtocolException(E).ResponseText]));
    on E: Exception do
      Memo1.Lines.Insert(0, Format('Exception: %s, %s', [E.ClassName, E.Message]));
  end;
end;

procedure TForm58.ButtonTestConnectionClick(Sender: TObject);
begin
  OpenConnection(EditHost.Text,
    StrToInt(EditPort.Text),
    EditURLPath.Text,
    EditUser.Text, EditPassword.Text);
  DSRestConnection1.TestConnection([toNoLoginPrompt]);
  MessageDlg('Connection OK', TMsgDlgType.mtConfirmation, [mbOK], 0);
end;

function TForm58.EchoString(
  const AServerClassName, AMethodName: string; const AValue: string): string;
var
  LEchoStringCommand: TDSRestCommand;
begin
  LEchoStringCommand := DSRestConnection1.CreateCommand;
  try
    LEchoStringCommand.Text := AServerClassName + '.' + AMethodName;
    LEchoStringCommand.Prepare;
    LEchoStringCommand.Parameters[0].Value.SetWideString(AValue);
    LEchoStringCommand.Execute;
    Result := LEchoStringCommand.Parameters[1].Value.GetWideString;
  finally
    LEchoStringCommand.Free;
  end;
end;

procedure TForm58.EditHostChange(Sender: TObject);
begin
  ClearSession;
end;

procedure TForm58.EditPortChange(Sender: TObject);
begin
  ClearSession;
end;

procedure TForm58.EditURLPathChange(Sender: TObject);
begin
  ClearSession;
end;

procedure TForm58.OpenConnection(
  const AHost: string;
  APort: Integer;
  const AURLPath: string;
  const AUser, APassword: string);
begin
  if CheckBoxUseProxy.Checked then
  begin
    DSRestConnection1.HTTP.ProxyParams.ProxyPort := 8888;
    DSRestConnection1.HTTP.ProxyParams.ProxyServer := '127.0.0.1';
    if SameText(AHost, 'localhost') then
      // Fiddler ignores localhost, so add "."
      DSRestConnection1.Host := 'localhost.'
    else
      DSRestConnection1.Host := AHost
  end
  else
  begin
    DSRestConnection1.Host := AHost;
    DSRestConnection1.HTTP.ProxyParams.ProxyServer := '';
  end;

  DSRestConnection1.Port := APort;
  DSRestConnection1.UrlPath := AUrlPath;
  DSRestConnection1.UserName := AUser;
  DSRestConnection1.Password := APassword;
end;


end.
