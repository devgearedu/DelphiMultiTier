unit FollowingUsersForm;

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls,
  FMX_Forms, FMX_Ani,
  FMX_Dialogs, FMX_Objects, FMX_Layouts, FMX_ListBox,

{$IFNDEF FPC}
  DBXJSON, ClientClassesUnit1, ProxyRegister,
{$ELSE}
  FPCProxyRegister, DBXFPCJSON,
{$ENDIF}
  FollowingTweetsForm;

type
  TfrmFollowingUsers = class(TForm)
    Panel1: TPanel;
    lbFollowing: TListBox;
    btnRefresh: TButton;
    btnNext: TButton;
    Label1: TLabel;
    txtToast: TText;
    FloatAnimation1: TFloatAnimation;
    procedure btnRefreshClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    UserToFollow: TJSONArray;
    FMsg: String;
    procedure Load;
    procedure Refresh;
    procedure addUsersToFollow;
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent; msg: String = ''); reintroduce;
  end;

implementation

{$R *.lfm}
{ TfrmFollowingUsers }

procedure TfrmFollowingUsers.addUsersToFollow;
var
  I: Integer;
begin
  for I := 0 to lbFollowing.Count - 1 do
  begin
    if lbFollowing.ListItems[I].IsChecked then
      UserToFollow.Add(lbFollowing.ListItems[I].Text);
  end;
end;

procedure TfrmFollowingUsers.btnNextClick(Sender: TObject);
var
  FollowingTweets: TfrmFollowingTweets;
begin
  addUsersToFollow;
  try
    GetProxy.SetUsersToFollow(UserToFollow);
    ModalResult := mrOk;
  except
    on e: exception do
    begin
      ShowMessage(e.Message);
      ModalResult := mrCancel;
    end;
  end;
end;

procedure TfrmFollowingUsers.btnRefreshClick(Sender: TObject);
begin
  try
    Refresh;
  except
    on e: exception do
    begin
      ShowMessage(e.Message);
      ModalResult := mrCancel;
    end;
  end;
end;

constructor TfrmFollowingUsers.Create(AOwner: TComponent; msg: String = '');
begin
  inherited Create(AOwner);
  FMsg := msg;
  UserToFollow := TJSONArray.Create;
  Refresh;
end;

destructor TfrmFollowingUsers.Destroy;
begin
  UserToFollow.Free;
  inherited;
end;

procedure TfrmFollowingUsers.FloatAnimation1Finish(Sender: TObject);
begin
  txtToast.Visible := False;
end;

procedure TfrmFollowingUsers.FormActivate(Sender: TObject);
begin
  if FMsg <> '' then
  begin
    txtToast.Text := FMsg;
    FMsg := '';
    txtToast.Visible := True;
  end;
end;

procedure TfrmFollowingUsers.Load;
var
  users: TJSONArray;
  user_name: String;
  obj: TJSONObject;
  I: Integer;
begin
  users := GetProxy.UsersList;
  try
    obj := TJSONObject.Create;
    try
      for I := 0 to users.Size - 1 do
      begin
        obj := TJSONObject(users.Get(I).clone);
{$IFNDEF FPC}
        user_name := StringReplace(obj.Get('username').JsonValue.ToString, '"',
          '', [rfReplaceAll, rfIgnoreCase]);
{$ELSE}
        user_name := obj.GetString('username');
{$ENDIF}
        lbFollowing.Items.Add(user_name);
{$IFNDEF FPC}
        if obj.Get('followed').JsonValue is TJSONTrue then
{$ELSE}
        if obj.GetBoolean('followed') then
{$ENDIF}
        begin
          lbFollowing.ListItems[I].IsChecked := True;
        end;
      end;
    finally
      obj.Free;
    end;
  finally
    users.Free
  end;
end;

procedure TfrmFollowingUsers.Refresh;
begin
  lbFollowing.Clear;
  Load;

end;

end.
