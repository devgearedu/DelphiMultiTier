
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ctServerMethods;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DSServer,
  Data.DBXPlatform,
  System.JSON,
  ctUser,
  System.Generics.Collections,
  Data.DBXJSON;

type
{$METHODINFO ON}
  TCompanyTweet = class(TDataModule)
  public
    procedure Logout;
    function LoginUser(UserName: string; out ReturnMessage: string): Boolean;
    function UsersList: TJSONArray;
    function ConnectedUsers: TJSONArray;
    procedure SetUsersToFollow(Users: TJSONArray);
    procedure SendTweet(Tweet: string);
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}


uses
  Datasnap.DSHTTPWebBroker,
  CompanyTweetServerContainer,
  System.StrUtils,
  Datasnap.DSService,
  Datasnap.DSSession,
  ctManager;

procedure TCompanyTweet.Logout;
var
  LSession: TDSSession;
begin
  LSession := TDSSessionManager.GetThreadSession;
  if LSession <> nil then
  begin
    TctManager.Instance.RemoveUser(LSession.GetData('username'));
    TDSSessionManager.Instance.CloseSession(LSession.SessionName);
  end;
end;

procedure TCompanyTweet.SendTweet(Tweet: string);
begin
  TctManager.Instance.BroadcastMessageToFollowers(
    ServerContainer1.DSServer1,
    TDSSessionManager.GetThreadSession.GetData('username'),
    TJSONString.Create(Tweet));
end;

function TCompanyTweet.ConnectedUsers: TJSONArray;
var
  List: TJSONArray;
begin
  List := TJSONArray.Create;
  TctManager.Instance.ForEachUser(
    procedure (UserName: String)
    begin
        List.Add(UserName);
    end);
  Result := List;
end;

function TCompanyTweet.LoginUser(UserName: string;
  out ReturnMessage: string): Boolean;
begin
  Result := false;
  try
    TctManager.Instance.LoginUser(UserName);
    TDSSessionManager.GetThreadSession.PutData('username', UserName);
    ReturnMessage := 'Welcome ' + UserName;
    Result := true;
  except
    on E: Exception do
    begin
      ReturnMessage := E.Message;
    end;
  end;
end;

procedure TCompanyTweet.SetUsersToFollow(Users: TJSONArray);
var
  UserName: string;
  Followers: TStringList;
  I: Integer;
begin
  UserName := TDSSessionManager.GetThreadSession.GetData('username');
  Followers := TStringList.Create;
  try
    for I := 0 to Users.Size - 1 do
      Followers.Add((Users.Get(I) as TJSONString).Value);
    TctManager.Instance.SetMyFollowing(UserName, Followers);
  finally
    Followers.Free;
  end;
end;

function TCompanyTweet.UsersList: TJSONArray;
var
  CurrentUser: TUser;
  CurrentUserName: string;
  isAFollower: TJSONValue;
  List: TJSONArray;
begin
  CurrentUserName := TDSSessionManager.GetThreadSession.GetData('username');
  CurrentUser := TctManager.Instance.GetUserByUserName(CurrentUserName);
  List := TJSONArray.Create;
  TctManager.Instance.ForEachUser(
    procedure (UserName: String) begin
      if UserName <> CurrentUser.UserName then
      begin
        if CurrentUser.Following.IndexOf(UserName) > -1 then
          isAFollower := TJSONTrue.Create
        else
          isAFollower := TJSONFalse.Create;
        List.Add(
          TJSONObject.Create
          .AddPair('username', UserName)
          .AddPair('followed', isAFollower));
      end;
    end
  );
  Result := List;
end;

end.
