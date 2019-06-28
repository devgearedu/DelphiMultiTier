//
// Created by the DataSnap proxy generator.
// 05/12/2011 12:55:43
// 

unit ClientClassesUnit1;

interface

uses Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, DSProxy, Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXJSONReflect;

type
  TCompanyTweetClient = class(TDSAdminRestClient)
  private
    FLogoutCommand: TDSRestCommand;
    FLoginUserCommand: TDSRestCommand;
    FUsersListCommand: TDSRestCommand;
    FUsersListCommand_Cache: TDSRestCommand;
    FConnectedUsersCommand: TDSRestCommand;
    FConnectedUsersCommand_Cache: TDSRestCommand;
    FSetUsersToFollowCommand: TDSRestCommand;
    FSendTweetCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure Logout;
    function LoginUser(UserName: string; out ReturnMessage: string; const ARequestFilter: string = ''): Boolean;
    function UsersList(const ARequestFilter: string = ''): TJSONArray;
    function UsersList_Cache(const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function ConnectedUsers(const ARequestFilter: string = ''): TJSONArray;
    function ConnectedUsers_Cache(const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    procedure SetUsersToFollow(Users: TJSONArray);
    procedure SendTweet(Tweet: string);
  end;

const
  TCompanyTweet_LoginUser: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'UserName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ReturnMessage'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TCompanyTweet_UsersList: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TCompanyTweet_UsersList_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TCompanyTweet_ConnectedUsers: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TCompanyTweet_ConnectedUsers_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TCompanyTweet_SetUsersToFollow: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Users'; Direction: 1; DBXType: 37; TypeName: 'TJSONArray')
  );

  TCompanyTweet_SendTweet: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Tweet'; Direction: 1; DBXType: 26; TypeName: 'string')
  );

implementation

procedure TCompanyTweetClient.Logout;
begin
  if FLogoutCommand = nil then
  begin
    FLogoutCommand := FConnection.CreateCommand;
    FLogoutCommand.RequestType := 'GET';
    FLogoutCommand.Text := 'TCompanyTweet.Logout';
  end;
  FLogoutCommand.Execute;
end;

function TCompanyTweetClient.LoginUser(UserName: string; out ReturnMessage: string; const ARequestFilter: string): Boolean;
begin
  if FLoginUserCommand = nil then
  begin
    FLoginUserCommand := FConnection.CreateCommand;
    FLoginUserCommand.RequestType := 'GET';
    FLoginUserCommand.Text := 'TCompanyTweet.LoginUser';
    FLoginUserCommand.Prepare(TCompanyTweet_LoginUser);
  end;
  FLoginUserCommand.Parameters[0].Value.SetWideString(UserName);
  FLoginUserCommand.Execute(ARequestFilter);
  ReturnMessage := FLoginUserCommand.Parameters[1].Value.GetWideString;
  Result := FLoginUserCommand.Parameters[2].Value.GetBoolean;
end;

function TCompanyTweetClient.UsersList(const ARequestFilter: string): TJSONArray;
begin
  if FUsersListCommand = nil then
  begin
    FUsersListCommand := FConnection.CreateCommand;
    FUsersListCommand.RequestType := 'GET';
    FUsersListCommand.Text := 'TCompanyTweet.UsersList';
    FUsersListCommand.Prepare(TCompanyTweet_UsersList);
  end;
  FUsersListCommand.Execute(ARequestFilter);
  Result := TJSONArray(FUsersListCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TCompanyTweetClient.UsersList_Cache(const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FUsersListCommand_Cache = nil then
  begin
    FUsersListCommand_Cache := FConnection.CreateCommand;
    FUsersListCommand_Cache.RequestType := 'GET';
    FUsersListCommand_Cache.Text := 'TCompanyTweet.UsersList';
    FUsersListCommand_Cache.Prepare(TCompanyTweet_UsersList_Cache);
  end;
  FUsersListCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FUsersListCommand_Cache.Parameters[0].Value.GetString);
end;

function TCompanyTweetClient.ConnectedUsers(const ARequestFilter: string): TJSONArray;
begin
  if FConnectedUsersCommand = nil then
  begin
    FConnectedUsersCommand := FConnection.CreateCommand;
    FConnectedUsersCommand.RequestType := 'GET';
    FConnectedUsersCommand.Text := 'TCompanyTweet.ConnectedUsers';
    FConnectedUsersCommand.Prepare(TCompanyTweet_ConnectedUsers);
  end;
  FConnectedUsersCommand.Execute(ARequestFilter);
  Result := TJSONArray(FConnectedUsersCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TCompanyTweetClient.ConnectedUsers_Cache(const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FConnectedUsersCommand_Cache = nil then
  begin
    FConnectedUsersCommand_Cache := FConnection.CreateCommand;
    FConnectedUsersCommand_Cache.RequestType := 'GET';
    FConnectedUsersCommand_Cache.Text := 'TCompanyTweet.ConnectedUsers';
    FConnectedUsersCommand_Cache.Prepare(TCompanyTweet_ConnectedUsers_Cache);
  end;
  FConnectedUsersCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FConnectedUsersCommand_Cache.Parameters[0].Value.GetString);
end;

procedure TCompanyTweetClient.SetUsersToFollow(Users: TJSONArray);
begin
  if FSetUsersToFollowCommand = nil then
  begin
    FSetUsersToFollowCommand := FConnection.CreateCommand;
    FSetUsersToFollowCommand.RequestType := 'POST';
    FSetUsersToFollowCommand.Text := 'TCompanyTweet."SetUsersToFollow"';
    FSetUsersToFollowCommand.Prepare(TCompanyTweet_SetUsersToFollow);
  end;
  FSetUsersToFollowCommand.Parameters[0].Value.SetJSONValue(Users, FInstanceOwner);
  FSetUsersToFollowCommand.Execute;
end;

procedure TCompanyTweetClient.SendTweet(Tweet: string);
begin
  if FSendTweetCommand = nil then
  begin
    FSendTweetCommand := FConnection.CreateCommand;
    FSendTweetCommand.RequestType := 'GET';
    FSendTweetCommand.Text := 'TCompanyTweet.SendTweet';
    FSendTweetCommand.Prepare(TCompanyTweet_SendTweet);
  end;
  FSendTweetCommand.Parameters[0].Value.SetWideString(Tweet);
  FSendTweetCommand.Execute;
end;

constructor TCompanyTweetClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TCompanyTweetClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TCompanyTweetClient.Destroy;
begin
  FreeAndNil(FLogoutCommand);
  FreeAndNil(FLoginUserCommand);
  FreeAndNil(FUsersListCommand);
  FreeAndNil(FUsersListCommand_Cache);
  FreeAndNil(FConnectedUsersCommand);
  FreeAndNil(FConnectedUsersCommand_Cache);
  FreeAndNil(FSetUsersToFollowCommand);
  FreeAndNil(FSendTweetCommand);
  inherited;
end;

end.
