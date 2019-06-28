
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit TunnelServerFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AppEvnts;

type
  TForm52 = class(TForm)
    ButtonStopHTTP: TButton;
    ButtonStartHTTP: TButton;
    ApplicationEvents1: TApplicationEvents;
    MemoLog: TMemo;
    Label6: TLabel;
    ButtonClearLog: TButton;
    GroupBox1: TGroupBox;
    CheckBoxCredentialPassthrough: TCheckBox;
    ButtonChangeProperties: TButton;
    Label3: TLabel;
    EditAuthPassword: TEdit;
    EditAuthUserName: TEdit;
    Label4: TLabel;
    EditTunnelTCPPort: TEdit;
    Label1: TLabel;
    EditRemoteHostName: TEdit;
    Label5: TLabel;
    EditHTTPPort: TEdit;
    Label2: TLabel;
    RadioButtonAuthenticateUsersWithName: TRadioButton;
    RadioButtonAuthenticateNone: TRadioButton;
    RadioButtonAuthenticateAll: TRadioButton;
    Label7: TLabel;
    procedure ButtonStartHTTPClick(Sender: TObject);
    procedure ButtonStopHTTPClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonRefreshPropertiesClick(Sender: TObject);
    procedure ButtonChangePropertiesClick(Sender: TObject);
    procedure OnEditChange(Sender: TObject);
    procedure ButtonClearLogClick(Sender: TObject);
    procedure RadioButtonAuthenticateAllClick(Sender: TObject);
  private
    FCanApplyChanges: Boolean;
    procedure UpdateServerProperties;
    procedure SetServiceProperties;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form52: TForm52;

implementation

{$R *.dfm}

uses TunnelServerContainerUnit;

procedure TForm52.ButtonChangePropertiesClick(Sender: TObject);
begin
  SetServiceProperties;
end;

procedure TForm52.ButtonClearLogClick(Sender: TObject);
begin
  MemoLog.Clear;
end;

procedure TForm52.ButtonRefreshPropertiesClick(Sender: TObject);
begin
  UpdateServerProperties;
end;

procedure TForm52.ButtonStartHTTPClick(Sender: TObject);
begin
  SetServiceProperties;
  ServerContainer5.DSHTTPService1.Start;
end;

procedure TForm52.SetServiceProperties;
begin
  try
    ServerContainer5.DSHTTPService1.Active := False;
  except
    Application.HandleException(Self);
  end;
  ServerContainer5.DSHTTPService1.DSHostname := EditRemoteHostName.Text;
  ServerContainer5.DSHTTPService1.DSPort := StrToInt(EditTunnelTCPPort.Text);
  ServerContainer5.DSHTTPService1.HTTPPort := StrToInt(EditHTTPPort.Text);
  ServerContainer5.DSHTTPService1.CredentialsPassThrough := CheckBoxCredentialPassthrough.Checked;
  ServerContainer5.DSHTTPService1.DSAuthUser := EditAuthUserName.Text;
  ServerContainer5.DSHTTPService1.DSAuthPassword := EditAuthPassword.Text;
  FCanApplyChanges := False;
  try
    ServerContainer5.DSHTTPService1.Active := True;
  except
    Application.HandleException(Self);
  end;
end;

procedure TForm52.ButtonStopHTTPClick(Sender: TObject);
begin
  ServerContainer5.DSHTTPService1.Stop;
  EditTunnelTCPPort.Text := IntToStr(ServerContainer5.DSHTTPService1.DSPort);
  EditHTTPPort.Text := IntToStr( ServerContainer5.DSHTTPService1.HTTPPort);
end;

procedure TForm52.FormShow(Sender: TObject);
var
  LMemo: TMemo;
begin
  UpdateServerProperties;
  LMemo := MemoLog;
  ServerContainer5.LogMessageProc :=
    procedure(AMessage: string)
    begin
      TThread.Queue(nil, procedure
      begin
        LMemo.Lines.Add(AMessage)
      end);
    end;
end;

procedure TForm52.OnEditChange(Sender: TObject);
begin
  FCanApplyChanges := True;
end;

procedure TForm52.RadioButtonAuthenticateAllClick(Sender: TObject);
begin
  if RadioButtonAuthenticateAll.Checked then
    ServerContainer5.AuthenticationMode := TAuthenticationMode.authenticateAllUsers
  else if RadioButtonAuthenticateUsersWithName.Checked then
    ServerContainer5.AuthenticationMode :=  TAuthenticationMode.authenticateUsersWithName
  else if RadioButtonAuthenticateNone.Checked then
    ServerContainer5.AuthenticationMode :=  TAuthenticationMode.authenticateNoUsers
end;

procedure TForm52.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStartHTTP.Enabled := not ServerContainer5.DSHTTPService1.Active;
  ButtonStopHTTP.Enabled := ServerContainer5.DSHTTPService1.Active;
  ButtonChangeProperties.Enabled := FCanApplyChanges;
end;

procedure TForm52.UpdateServerProperties;
begin
  EditRemoteHostName.Text := ServerContainer5.DSHTTPService1.DSHostName;
  EditTunnelTCPPort.Text := IntToStr(ServerContainer5.DSHTTPService1.DSPort);
  EditHTTPPort.Text := IntToStr( ServerContainer5.DSHTTPService1.HTTPPort);
  CheckBoxCredentialPassthrough.Checked := ServerContainer5.DSHTTPService1.CredentialsPassThrough;
  EditAuthUserName.Text := ServerContainer5.DSHTTPService1.DSAuthUser;
  EditAuthPassword.Text := ServerContainer5.DSHTTPService1.DSAuthPassword;
  FCanApplyChanges := False;
end;


end.

