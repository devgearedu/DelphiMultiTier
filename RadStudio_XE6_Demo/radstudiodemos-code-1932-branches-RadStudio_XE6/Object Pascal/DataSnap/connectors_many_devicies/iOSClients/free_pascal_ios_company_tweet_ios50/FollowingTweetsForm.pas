unit FollowingTweetsForm;

interface

{$IFDEF FPC}
{$MODESWITCH ObjectiveC1}
{$ENDIF}

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls,
  FMX_Forms,
  FMX_Dialogs, FMX_Edit, FMX_Objects, FMX_Layouts, FMX_ListBox, DSRestTypes,
  FPCSound,CTCallback,
{$IFDEF FPC}
  FPCProxyRegister,
  DBXFPCJSON,
  DBXFPCCallback,
  iPhoneAll, FPCStrings,
  Sound,
{$ELSE}
  Windows,
  DBXJSON,
  ProxyRegister,
  DSHTTPCommon, DSHTTPLayer,
{$ENDIF}
  MenuForm, FMX_Memo, LockedStringListU;

type
  TfrmFollowingTweets = class;


  TfrmFollowingTweets = class(TForm)
    Rectangle1: TRectangle;
    StyleBook1: TStyleBook;
    lbTweets: TListBox;
    lblUser: TLabel;
    imgSettings: TImage;
    Rectangle2: TRectangle;
    btnTweet: TButton;
    edtTweet: TEdit;
    CBTimer: TTimer;
    CTCMDTimer: TTimer;
    procedure btnTweetClick(Sender: TObject);
    procedure imgSettingsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CBTimerTimer(Sender: TObject);
    procedure CTCMDTimerTimer(Sender: TObject);
  public
    FUserName, FTweet: String;
  end;

implementation

uses FollowingUsersForm, MainForm;

{$R *.lfm}
procedure TfrmFollowingTweets.btnTweetClick(Sender: TObject);
begin
  try
    GetProxy.SendTweet(edtTweet.Text);
    edtTweet.Text := '';
  except
    on E: Exception do
    begin
      ShowMessage(E.message);
      ModalResult := mrOK;
    end;
  end;
end;

procedure TfrmFollowingTweets.FormActivate(Sender: TObject);
begin
  lblUser.Text := 'User: ' + TfrmMain.GetUserName;
end;

procedure TfrmFollowingTweets.imgSettingsClick(Sender: TObject);
var
  frmMenu: TfrmMenu;
  frm: TfrmFollowingUsers;
begin
  frmMenu := TfrmMenu.Create(Self);
  try
    if frmMenu.ShowModal = mrOK then
    begin
      case frmMenu.ResultCode of
        // active user
        1:
          begin
            try
              frm := TfrmFollowingUsers.Create(Self);
              try
                frm.ShowModal;
              finally
                frm.Free;
              end;
            except
              on E: Exception do
              begin
                ShowMessage(E.message);
                ModalResult := mrCancel;
              end;
            end;
          end;
        // logout
        2:
          begin
            ModalResult := mrOK;
          end;
      end;
    end;
  finally
    frmMenu.Free;
  end;
end;

procedure TfrmFollowingTweets.CBTimerTimer(Sender: TObject);
var
  sl: TStringList;
  i: Integer;
  itm: TListBoxItem;
  usr: String;
begin
  sl := TLockedStringList.Instance.GetLockedStringList;
  try
    if sl.Count > 0 then
      for i := 0 to sl.Count - 1 do
      begin
        itm := TListBoxItem.Create(Self); // Create a Listbox item
        itm.Parent := lbTweets;
        usr := Copy(sl[i], 0, pos(':', sl[i]));
        if usr = 'ADMIN:' then
          itm.StyleLookup := 'AdminStyle'
        else
          itm.StyleLookup := 'UserStyle';

        itm.Binding['Txttweet'] := sl[i];
{$IFNDEF FPC}
        Beep(400, 80);
        Beep(600, 100);
        Beep(800, 120);
        Beep(400, 80);
        Beep(600, 100);
        Beep(800, 120);
{$ENDIF}
      end;
    sl.Clear;
  finally
    TLockedStringList.Instance.UnLock;
  end;
end;

procedure TfrmFollowingTweets.CTCMDTimerTimer(Sender: TObject);
var
  sl: TStringList;
  i: Integer;
begin
  sl := TCMDLockedStringList.Instance.GetLockedStringList;
  try
    if sl.Count > 0 then
      for i := 0 to sl.Count - 1 do
      begin
        if sl[i] = 'ring' then
        begin
{$IFDEF FPC}
{$IFNDEF WINDOWS}
          PlaySound(NSSTR('/cmd.mp3'));
{$ENDIF}
{$ELSE}
          Beep(200, 80);
          Beep(400, 100);
          Beep(600, 120);
          Beep(200, 80);
          Beep(400, 100);
          Beep(600, 220);
{$ENDIF}
        end
        else if sl[i] = 'vibrate' then

        begin
{$IFDEF FPC}
          AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
{$ELSE}
          Beep(200, 2000);
{$ENDIF}
        end;
      end;
    sl.Clear;
  finally
    TCMDLockedStringList.Instance.UnLock;
  end;
end;


end.
