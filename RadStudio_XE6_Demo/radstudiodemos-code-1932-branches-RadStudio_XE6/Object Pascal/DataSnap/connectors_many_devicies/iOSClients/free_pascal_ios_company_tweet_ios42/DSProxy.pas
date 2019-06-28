// 
// Created by the DataSnap proxy generator.
// 15/12/2011 18:54:14
// 

unit DSProxy ;

interface
  uses
    Classes,
    DB,
    DSAdmin,
    DSRESTParameterMetaData,
    DBXFPCJson,
    DBXValue,
    DBXFPCCommon,
    DSRESTConnection, DSRestTypes;

  type
    TCompanyTweet = class(TDSAdmin)
    Private
      FTCompanyTweet_Logout:TDSRESTParameterMetaDataArray;
      FTCompanyTweet_LoginUser:TDSRESTParameterMetaDataArray;
      FTCompanyTweet_UsersList:TDSRESTParameterMetaDataArray;
      FTCompanyTweet_ConnectedUsers:TDSRESTParameterMetaDataArray;
      FTCompanyTweet_SetUsersToFollow:TDSRESTParameterMetaDataArray;
      FTCompanyTweet_SendTweet:TDSRESTParameterMetaDataArray;
    protected
      function getTCompanyTweet_Logout:TDSRESTParameterMetaDataArray;
      function getTCompanyTweet_LoginUser:TDSRESTParameterMetaDataArray;
      function getTCompanyTweet_UsersList:TDSRESTParameterMetaDataArray;
      function getTCompanyTweet_ConnectedUsers:TDSRESTParameterMetaDataArray;
      function getTCompanyTweet_SetUsersToFollow:TDSRESTParameterMetaDataArray;
      function getTCompanyTweet_SendTweet:TDSRESTParameterMetaDataArray;
    public
      destructor Destroy;override;

      procedure Logout();

      (*
       * @param UserName [in] - Type on server: string
       * @param ReturnMessage [out] - Type on server: string
       * @return result - Type on server: boolean
       *)
      function LoginUser(UserName: string;out ReturnMessage: string):boolean;

      (*
       * @return result - Type on server: TJSONArray
       *)
      function UsersList():TJSONArray;

      (*
       * @return result - Type on server: TJSONArray
       *)
      function ConnectedUsers():TJSONArray;

      (*
       * @param Users [in] - Type on server: TJSONArray
       *)
      procedure SetUsersToFollow(Users: TJSONArray);

      (*
       * @param Tweet [in] - Type on server: string
       *)
      procedure SendTweet(Tweet: string);
    end;

implementation


{TCompanyTweet}

function TCompanyTweet.getTCompanyTweet_Logout:TDSRESTParameterMetaDataArray;
begin
  if Length(FTCompanyTweet_Logout) = 0 then
  begin
    SetLength(Result, 0);
  end
  else
    result:= FTCompanyTweet_Logout;
end;

function TCompanyTweet.getTCompanyTweet_LoginUser:TDSRESTParameterMetaDataArray;
begin
  if Length(FTCompanyTweet_LoginUser) = 0 then
  begin
    SetLength(Result, 3);
    Result[0] := TDSRESTParameterMetaData.CreateParam( 'UserName',Input,WideStringType,'string');
    Result[1] := TDSRESTParameterMetaData.CreateParam( 'ReturnMessage',Output,WideStringType,'string');
    Result[2] := TDSRESTParameterMetaData.CreateParam( '',ReturnValue,BooleanType,'boolean');
  end
  else
    result:= FTCompanyTweet_LoginUser;
end;

function TCompanyTweet.getTCompanyTweet_UsersList:TDSRESTParameterMetaDataArray;
begin
  if Length(FTCompanyTweet_UsersList) = 0 then
  begin
    SetLength(Result, 1);
    Result[0] := TDSRESTParameterMetaData.CreateParam( '',ReturnValue,JsonValueType,'TJSONArray');
  end
  else
    result:= FTCompanyTweet_UsersList;
end;

function TCompanyTweet.getTCompanyTweet_ConnectedUsers:TDSRESTParameterMetaDataArray;
begin
  if Length(FTCompanyTweet_ConnectedUsers) = 0 then
  begin
    SetLength(Result, 1);
    Result[0] := TDSRESTParameterMetaData.CreateParam( '',ReturnValue,JsonValueType,'TJSONArray');
  end
  else
    result:= FTCompanyTweet_ConnectedUsers;
end;

function TCompanyTweet.getTCompanyTweet_SetUsersToFollow:TDSRESTParameterMetaDataArray;
begin
  if Length(FTCompanyTweet_SetUsersToFollow) = 0 then
  begin
    SetLength(Result, 1);
    Result[0] := TDSRESTParameterMetaData.CreateParam( 'Users',Input,JsonValueType,'TJSONArray');
  end
  else
    result:= FTCompanyTweet_SetUsersToFollow;
end;

function TCompanyTweet.getTCompanyTweet_SendTweet:TDSRESTParameterMetaDataArray;
begin
  if Length(FTCompanyTweet_SendTweet) = 0 then
  begin
    SetLength(Result, 1);
    Result[0] := TDSRESTParameterMetaData.CreateParam( 'Tweet',Input,WideStringType,'string');
  end
  else
    result:= FTCompanyTweet_SendTweet;
end;
destructor TCompanyTweet.Destroy;
begin
   TDSRESTParameterMetaData.releaseArray(FTCompanyTweet_Logout);
   TDSRESTParameterMetaData.releaseArray(FTCompanyTweet_LoginUser);
   TDSRESTParameterMetaData.releaseArray(FTCompanyTweet_UsersList);
   TDSRESTParameterMetaData.releaseArray(FTCompanyTweet_ConnectedUsers);
   TDSRESTParameterMetaData.releaseArray(FTCompanyTweet_SetUsersToFollow);
   TDSRESTParameterMetaData.releaseArray(FTCompanyTweet_SendTweet);
  inherited;
end;

procedure TCompanyTweet.Logout();
var
  cmd: TDSRestCommand;
begin

  cmd := Connection.createCommand;
  try
    cmd.RequestType := GET;
    cmd.text := 'TCompanyTweet.Logout';
    cmd.prepare(getTCompanyTweet_Logout);
    
    Connection.execute(cmd);
  finally
    cmd.free;
  end;
end;

(*
 * @param UserName [in] - Type on server: string
 * @param ReturnMessage [out] - Type on server: string
 * @return result - Type on server: boolean
 *)
function TCompanyTweet.LoginUser( username:string;out  returnmessage:string):boolean;
var
  cmd: TDSRestCommand;
begin

  cmd := Connection.createCommand;
  try
    cmd.RequestType := GET;
    cmd.text := 'TCompanyTweet.LoginUser';
    cmd.prepare(getTCompanyTweet_LoginUser);
    cmd.parameters.items[0].Value.AsString:=username;
    
    Connection.execute(cmd);
    returnmessage :=   cmd.parameters.items[1].Value.AsString;
    
    result:= cmd.parameters.items[2].Value.AsBoolean;
  finally
    cmd.free;
  end;
end;

(*
 * @return result - Type on server: TJSONArray
 *)
function TCompanyTweet.UsersList():TJSONArray;
var
  cmd: TDSRestCommand;
begin

  cmd := Connection.createCommand;
  try
    cmd.RequestType := GET;
    cmd.text := 'TCompanyTweet.UsersList';
    cmd.prepare(getTCompanyTweet_UsersList);
    
    Connection.execute(cmd);
    
    result:= cmd.parameters.items[0].Value.AsJSONValue as TJSONArray;
  finally
    cmd.free;
  end;
end;

(*
 * @return result - Type on server: TJSONArray
 *)
function TCompanyTweet.ConnectedUsers():TJSONArray;
var
  cmd: TDSRestCommand;
begin

  cmd := Connection.createCommand;
  try
    cmd.RequestType := GET;
    cmd.text := 'TCompanyTweet.ConnectedUsers';
    cmd.prepare(getTCompanyTweet_ConnectedUsers);
    
    Connection.execute(cmd);
    
    result:= cmd.parameters.items[0].Value.AsJSONValue as TJSONArray;
  finally
    cmd.free;
  end;
end;

(*
 * @param Users [in] - Type on server: TJSONArray
 *)
procedure TCompanyTweet.SetUsersToFollow( users:TJSONArray);
var
  cmd: TDSRestCommand;
begin

  cmd := Connection.createCommand;
  try
    cmd.RequestType := POST;
    cmd.text := 'TCompanyTweet.SetUsersToFollow';
    cmd.prepare(getTCompanyTweet_SetUsersToFollow);
    cmd.parameters.items[0].Value.AsJSONValue:=users;
    
    Connection.execute(cmd);
  finally
    cmd.free;
  end;
end;

(*
 * @param Tweet [in] - Type on server: string
 *)
procedure TCompanyTweet.SendTweet( tweet:string);
var
  cmd: TDSRestCommand;
begin

  cmd := Connection.createCommand;
  try
    cmd.RequestType := GET;
    cmd.text := 'TCompanyTweet.SendTweet';
    cmd.prepare(getTCompanyTweet_SendTweet);
    cmd.parameters.items[0].Value.AsString:=tweet;
    
    Connection.execute(cmd);
  finally
    cmd.free;
  end;
end;
end.
