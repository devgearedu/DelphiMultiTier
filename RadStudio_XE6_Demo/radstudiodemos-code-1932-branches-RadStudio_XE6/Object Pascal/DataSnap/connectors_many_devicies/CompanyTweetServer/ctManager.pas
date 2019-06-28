
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ctManager;

interface

uses
  System.Classes,
  ctUser,
  Datasnap.DSServer,
  Data.DBXJSON,
  System.JSON,
  System.Generics.Defaults,
  System.Types,
  System.SysUtils,
  System.Generics.Collections;

type
  TUserHook = reference to procedure();

  TctManager = class
  private
    FQueue: TThreadedQueue<string>;
    FUsers: TDictionary<string, TUser>;
    FUserHook: TUserHook;
    class var FInstance: TctManager;

    procedure NotifyUserHook;
  public
    constructor Create;
    destructor Destroy; override;

    class function Instance: TctManager;
    procedure RemoveUser(UserName: string);
    procedure ForEachUser(Proc: TProc<string>);
    function GetQueue: TThreadedQueue<string>;
    procedure SetDSServer(DSServer: TDSServer);
    procedure BroadcastMessageToFollowers(DSServer: TDSServer; UserName: string; Tweet: TJSONValue);
    function GetUserByUserName(UserName: string): TUser;
    procedure SetMyFollowing(UserName: string; Following: TStringList);
    procedure LoginUser(UserName: string);
    function GetUsers: TDictionary<string, TUser>;

    property UserHook: TUserHook read FUserHook write FUserHook;
  end;

implementation

uses
  System.SyncObjs;

{ TctManager }

procedure TctManager.BroadcastMessageToFollowers(DSServer: TDSServer; UserName: string;
  Tweet: TJSONValue);
var
  FollowerName: string;
  msg: TJSONObject;
begin
  msg := TJSONObject.Create;
  try
    msg.AddPair(TJSONPair.Create('username', UserName));
    msg.AddPair(TJSONPair.Create('message', Tweet.Value));
    DSServer.BroadcastMessage('ctconsole', msg.Clone as TJSONValue);
    for FollowerName in FUsers[UserName].Followers do
      DSServer.BroadcastMessage('ct', FollowerName, msg.Clone as TJSONValue);
    //auto send the tweet
    DSServer.BroadcastMessage('ct', UserName, msg.Clone as TJSONValue);
  finally
    msg.Free;
  end;
end;

constructor TctManager.Create;
begin
  inherited;
  FUsers := TDictionary<string, TUser>.Create;
  FUserHook := nil;
end;

destructor TctManager.Destroy;
begin
  FUsers.Free;
  inherited;
end;

procedure TctManager.ForEachUser(Proc: TProc<string>);
var
  usr: string;
begin
  TMonitor.Enter(FUsers);
  try
    for usr in FUsers.Keys.ToArray do
      Proc(usr);
  finally
    TMonitor.Exit(FUsers);
  end;
end;

function TctManager.GetQueue: TThreadedQueue<string>;
begin
  Result := FQueue;
end;

function TctManager.GetUserByUserName(UserName: string): TUser;
begin
  Result := FUsers[UserName];
end;

procedure TctManager.RemoveUser(UserName: string);
begin
  TMonitor.Enter(FUsers);
  try
    FUsers.Remove(UserName);
  finally
    TMonitor.Exit(FUsers);
    NotifyUserHook;
  end;
end;

function TctManager.GetUsers: TDictionary<string, TUser>;
begin
  Result := FUsers;
end;

class function TctManager.Instance: TctManager;
begin
  if not Assigned(FInstance) then
    FInstance := TctManager.Create;
  Result := FInstance;
end;

procedure TctManager.LoginUser(UserName: string);
begin
  TMonitor.Enter(FUsers);
  try
    if Length(UserName) < 4 then
      raise Exception.Create('Username too short. It should be 4 chars at least.');
    if FUsers.ContainsKey(UserName) then
      raise Exception.Create('User already exists');
    FUsers.add(UserName, TUser.Create(UserName));
  finally
    TMonitor.Exit(FUsers);
    NotifyUserHook;
  end;
end;

procedure TctManager.NotifyUserHook;
begin
  try
    if Assigned(FUserHook) then
      FUserHook();
  except
  end;
end;

procedure TctManager.SetDSServer(DSServer: TDSServer);
begin

end;

procedure TctManager.SetMyFollowing(UserName: string;
  Following:
  TStringList);
var
  User: TUser;
  FollowingUserName, OtherUserName: string;
begin
  TMonitor.Enter(FUsers);
  try
    if not FUsers.ContainsKey(UserName) then
      raise Exception.Create('Invalid User');
    User := FUsers[UserName];
    User.Following.Clear;
    for FollowingUserName in Following do
      User.Following.add(FollowingUserName);

    // Write in the other's users follower list
    for OtherUserName in FUsers.Keys.ToArray do
    begin
      // if UserName = OtherUserName then
      // Continue;
      if Following.IndexOf(OtherUserName) > -1 then
      begin
        if FUsers[OtherUserName].Followers.IndexOf(UserName) = -1 then
          FUsers[OtherUserName].Followers.add(UserName);
      end
      else
      begin
        if FUsers[OtherUserName].Followers.IndexOf(UserName) > -1 then
          FUsers[OtherUserName].Followers.Delete(FUsers[OtherUserName].Followers.IndexOf(UserName));
      end;
    end;
  finally
    TMonitor.Exit(FUsers);
  end;
end;

end.
