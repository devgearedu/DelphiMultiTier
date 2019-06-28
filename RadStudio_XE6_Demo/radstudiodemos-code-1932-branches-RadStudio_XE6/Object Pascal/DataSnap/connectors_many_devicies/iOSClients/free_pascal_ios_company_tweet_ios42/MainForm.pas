unit MainForm;

{$IFDEF FPC}
{$mode DELPHI}
{$IFNDEF WINDOWS}
{$modeswitch objectivec1}
{$ENDIF}
{$ENDIF}
{$I dsrestdefines.inc}

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls,
  FMX_Forms, inifiles, FMX_Platform,
  FMX_Dialogs, FMX_Objects, FMX_Edit, FollowingUsersForm, FollowingTweetsForm,
  SettingsForm, CTCallback, {$IFDEF FPC} DSFPCCallbackChannelManager, {$ENDIF} LockedStringListU;

type
  TfrmMain = class(TForm)
    Image1: TImage;
    btnLogin: TButton;
    edtUsername: TEdit;
    Label1: TLabel;
    Rectangle1: TRectangle;
    imgSettings: TImage;
    lblHost: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure imgSettingsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtUsernameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    ini: TIniFile;
    FErrorMessageFromCallback: String;
    class var FUserName: String;
    procedure RegisterCallbacks(username: String);
    procedure ShowSynchConnectionError;
    procedure ShowConnectionError(const AMessage: String);
{$IFDEF FPC}
    procedure DoException(Sender: TObject; mngr: TDSFPCCallbackChannelManager;
      E: Exception);
{$ELSE}
    procedure DoException(Sender: TObject);
{$ENDIF}
  public
    class function GetUserName: String;

  end;

var
  frmMain: TfrmMain;

implementation

uses
{$IFDEF FPC}
  FPCProxyRegister, iPhoneAll, FPCStrings;
{$ELSE}
  ProxyRegister;
{$ENDIF}
{$R *.lfm}

procedure TfrmMain.btnLoginClick(Sender: TObject);
var
  ret: String;
  FollowingUsers: TfrmFollowingUsers;
  FollowingTweets: TfrmFollowingTweets;
  res: boolean;
begin

  SetFocused(Image1);
  try
    if GetProxy.LoginUser(edtUsername.Text, ret) then
    begin
      FUserName := edtUsername.Text;
      FollowingUsers := TfrmFollowingUsers.Create(self, ret);
      try
        res := FollowingUsers.ShowModal = mrOk;
      finally
        FollowingUsers.Free;
      end;

      if res then
      begin
        FollowingTweets := TfrmFollowingTweets.Create(self);
        try
          RegisterCallbacks(edtUsername.Text);
          FollowingTweets.ShowModal;
          ResetProxy;
        finally
          FollowingTweets.Free;
        end;
      end
      else
       ResetProxy;
    end
    else
      ShowMessage(ret);
  except
    on E: Exception Do
    begin
      ShowMessage(E.message);
      ResetProxy;
    end;
  end;
end;

procedure TfrmMain.edtUsernameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    btnLoginClick(self);

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
{$IFDEF FPC}
  Host := NSToString(NSUserDefaults.standardUserDefaults.stringForKey
    (StringToNS('HOST')));
  Port := NSUserDefaults.standardUserDefaults.integerForKey(StringToNS('PORT'));
{$ELSE}
  ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  Port := ini.ReadInteger('DSCONNECTION', 'PORT', 8080);
  Host := ini.ReadString('DSCONNECTION', 'HOST', 'localhost');
  Protocol := ini.ReadString('DSCONNECTION', 'PROTOCOL', 'http');
{$ENDIF}
  if Host = '' then
    Host := 'localhost';
  if Port < 0 then
    Port := 8080;
  if Protocol <> 'https' then
    Protocol := 'http';

  lblHost.Text := 'host: ' + Host + ' port: ' + IntToStr(Port);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
{$IFNDEF FPC}
  ini.Free;
{$ENDIF}
end;

class function TfrmMain.GetUserName: String;
begin
  Result := FUserName;
end;

procedure TfrmMain.imgSettingsClick(Sender: TObject);
var
  frmset: TfrmSettings;
{$IFDEF FPC}
  defaults: NSUserDefaults;
{$ENDIF}
begin
  frmset := TfrmSettings.Create(self);
  frmset.edtHost.Text := Host;
  frmset.edtPort.Text := IntToStr(Port);
  try
    if frmset.ShowModal = mrOk then
    begin
      ResetProxy;
      Port := StrToInt(frmset.edtPort.Text);
      Host := frmset.edtHost.Text;
      lblHost.Text := 'host: ' + Host + ' port: ' + IntToStr(Port);
{$IFDEF FPC}
      defaults := NSUserDefaults.standardUserDefaults;
      defaults.setObject_forKey(StringToNS(Host), StringToNS('HOST'));
      defaults.setObject_forKey(NSNumber.NumberWithInt(Port),
        StringToNS('PORT'));
{$ELSE}
      ini.WriteInteger('DSCONNECTION', 'PORT', Port);
      ini.WriteString('DSCONNECTION', 'HOST', Host);
      ini.WriteString('DSCONNECTION', 'PROTOCOL', Protocol);
{$ENDIF}
    end;
  finally
    frmset.Free;
  end;
end;

{$IFDEF FPC}

procedure TfrmMain.DoException(Sender: TObject;
  mngr: TDSFPCCallbackChannelManager; E: Exception);
begin
  ShowConnectionError(E.message);
end;
{$ELSE}

procedure TfrmMain.DoException(Sender: TObject);
begin
  ShowConnectionError('Some problem...');
end;
{$ENDIF}

procedure TfrmMain.RegisterCallbacks(username: String);
begin
  try
    GetCTCallback(DoException).RegisterCallback(username,
      TCTCallback.Create(TLockedStringList.Instance));


    GetCMDCallback(DoException).RegisterCallback('cbcmd',
      TCMDCallback.Create(TCMDLockedStringList.Instance));

  except
    on E: Exception do
      ShowMessage
        ('Connection problems, Company Tweet,\n You are disconnected. Click here to login.');
  end;
end;

procedure TfrmMain.ShowConnectionError(const AMessage: String);
begin
  FErrorMessageFromCallback := AMessage;
  TThread.Synchronize(nil, ShowSynchConnectionError);
end;

procedure TfrmMain.ShowSynchConnectionError;
begin
  ShowMessage(FErrorMessageFromCallback);
end;

end.
