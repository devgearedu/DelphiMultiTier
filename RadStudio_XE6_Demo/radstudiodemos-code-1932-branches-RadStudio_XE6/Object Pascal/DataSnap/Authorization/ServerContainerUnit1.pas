
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ServerContainerUnit1;

interface

uses
  SysUtils, Classes, 
  DSTCPServerTransport,
  DSServer, DSCommonServer, DBXCommon, DSHTTPCommon, UsersAndRoles,
  Generics.Collections, DSService, DSHTTP, DSAuth, DbxSocketChannelNative,
  IPPeerServer, IndyPeerImpl;

type

  // Keep track of user / roles
  TUserDictionary = class;
  TUserInfo = class;

  // Different techniques for authentication
  TAuthorizationChecking = (authDefaultAuth, authOnAuthorize, authOnPrepare);
  TAuthorizationRequirments = (useRoles, allowAll,DenyAll);
  TAuthenticationMode = (authenticateAllUsers, authenticateUsersWithRoles, authenticateNoUsers);

  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSAuthenticationManager1: TDSAuthenticationManager;
    DSServerClass1: TDSServerClass;
    DSHTTPService1: TDSHTTPService;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      DSAuthorizeEventObject: TDSAuthorizeEventObject;
      //const UserName: string; const RoleAuth: TRoleAuth;
      var valid: Boolean);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DSServerClass1Prepare(
      DSPrepareEventObject: TDSPrepareEventObject);
  private
    { Private declarations }
    FUserRoleItems: TUserRoleItems;
    FReadWriteSync: IReadWriteSync;
    FLogMessageProc: TProc<string>;
    FAuthorizeMode: TAuthorizationChecking;
    FUserDictionary: TUserDictionary;
    FAllowDenyMode: TAuthorizationRequirments;
    FAuthenticationMode: TAuthenticationMode;
    procedure LogMessage(const AMessage: string);
    function LockUserInfo(const AUserName: string;
      ACallback: TProc<TUserInfo>): Boolean;
    procedure LogServerEvent(EventObject: TDSServerMethodUserEventObject);
    procedure SetAuthorizeMode( AValue: TAuthorizationChecking);
    procedure SetAuthenticationMode(const Value: TAuthenticationMode);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AuthenticationMode: TAuthenticationMode read FAuthenticationMode write SetAuthenticationMode;
    property AuthorizationMode: TAuthorizationChecking read FAuthorizeMode write SetAuthorizeMode;
    property AllowDenyMode: TAuthorizationRequirments read FAllowDenyMode write FAllowDenyMode;
    property LogMessageProc: TProc<string> read FLogMessageProc write FLogMessageProc;
    property UserRoleItems: TUserRoleItems read FUserRoleItems;
    procedure UserRoleItemsChanged;
  end;

  TUserDictionary = class(TObjectDictionary<string, TUserInfo>)
  public
    constructor Create;
  end;

  TUserInfo = class
  private
    FRoles: TSTrings;
    procedure AddRole(const ARoleName: string);
    procedure GetRoles(AStrings: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    function HasRole(const ARole: string): Boolean;
    function IsAuthorized(const AAuthorized: TStrings; const ADenied: TStrings): Boolean;
  end;

var
  ServerContainer1: TServerContainer1;

implementation

uses Windows, ServerMethodsUnit1, DBXClientResStrs;

{$R *.dfm}

const
  sFalseTrue: array[false..true] of string = ('false', 'true');

procedure TServerContainer1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit1.TServerMethods1;
end;

// Demonstrate how to authorize in the prepare event, if desired.
procedure TServerContainer1.DSServerClass1Prepare(
  DSPrepareEventObject: TDSPrepareEventObject);
var
  LValid: Boolean;
begin
  LogMessage('Enter Prepare');
  LogServerEvent(DSPrepareEventObject);
  try
    if FAuthorizeMode = authOnPrepare then
    begin
      if AllowDenyMode = TAuthorizationRequirments.DenyAll then
        LValid := False
      else
      if AllowDenyMode = TAuthorizationRequirments.allowAll then
        LValid := True
      else
      begin
        LValid := False;
        if not LockUserInfo(DSPrepareEventObject.UserName,
            procedure(AUserInfo: TUserInfo)
            begin
              LValid := AUserInfo.IsAuthorized(DSPrepareEventObject.AuthorizedRoles, DSPrepareEventObject.DeniedRoles);
            end) then
        begin
          case TDSAuthenticationManager.CompareRoles(nil, DSPrepareEventObject.AuthorizedRoles, DSPrepareEventObject.DeniedRoles) of
            rcNoMethodRoles:  // Allow if not roles associated with method
              LValid := True;
          else
            LValid := False;
          end;
        end;
        LogMessage(Format('IsAuthorized UserName: %s, valid: %s',
          [DSPrepareEventObject.UserName, sFalseTrue[LValid]]));
      end;
      if not LValid then
        raise TDBXError.Create(TDBXErrorCodes.AuthorizationFailed, Format(SAuthorizationFail, [DSPrepareEventObject.UserName]));
    end;
  finally
    LogMessage('Leave Prepare'#13#10);
  end;

end;

constructor TServerContainer1.Create(AOwner: TComponent);
begin
  inherited;
  FUserRoleItems := TUserRoleItems.Create(nil);
  FReadWriteSync := SysUtils.TSimpleRWSync.Create;
  FUserDictionary := TUserDictionary.Create;
  with TUserRoleItem(FUserRoleItems.Add) do
  begin
    // Initialize user roles with something
    UserNames.DelimitedText := 'Jim';
    Roles.DelimitedText := 'EchoStringAuthorizedRole';
    UserRoleItemsChanged;
  end;

end;

destructor TServerContainer1.Destroy;
begin
  FUserRoleItems.Free;
  FUserDictionary.Free;
  inherited;
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
var
  LIsUser: Boolean;
begin
  LogMessage('Enter UserAuthenticate');
  LogMessage(Format('User: %s, Password: %s',
    [User, password]));
  LogMessage(Format('Protocol: %s, Context: %s',
    [Protocol, Context]));
  // Assign to user roles here.
  // User roles will be used for default authorization.
  // if not method roles or user role matches method's authorized roles then user is authorized.
  // otherwize user is denied.
  LIsUser := LockUserInfo(User,
    procedure(AUserInfo: TUserInfo)
    begin
      AUserInfo.GetRoles(UserRoles);
    end);
  case FAuthenticationMode of
    authenticateAllUsers:
      valid := True;
    authenticateUsersWithRoles:
      valid := LIsUser;
    authenticateNoUsers:
      valid := False;
  else
    Assert(False);
  end;
  LogMessage(Format('GetRoles: %s', [UserRoles.DelimitedText]));
  LogMessage(Format('Exit UserAuthenticate, Valid: %s'#13#10,
    [sFalseTrue[valid]]));
end;

function TServerContainer1.LockUserInfo(const AUserName: string;
  ACallback: TProc<TUserInfo>): Boolean;
var
  LUserInfo: TUserInfo;
begin
  FReadWriteSync.BeginRead;
  try
    if FUserDictionary.TryGetValue(Lowercase(AUserName), LUserInfo) then
    begin
      ACallback(LUserInfo);
      Result := True;
    end
    else
      Result := False;
  finally
    FReadWriteSync.EndRead;
  end;
end;

procedure TServerContainer1.LogServerEvent(EventObject: TDSServerMethodUserEventObject);
begin
  LogMessage(Format('UserName: %s',
    [EventObject.UserName]));
  if EventObject.AuthorizedRoles <> nil then
    LogMessage(Format('AuthorizedRoles: %s',
      [EventObject.AuthorizedRoles.DelimitedText]))
  else
    LogMessage('AuthorizedRoles: nil');
  if EventObject.DeniedRoles <> nil then
    LogMessage(Format('DeniedRoles: %s',
      [EventObject.DeniedRoles.DelimitedText]))
  else
    LogMessage('DeniedRoles: nil');
  LogMessage(Format('MethodAlias: %s',
    [EventObject.MethodAlias]));
  LogMessage(Format('ConProperties: %s',
    [EventObject.ServerConnectionHandler.ConProperties.Properties.DelimitedText]));
end;

procedure TServerContainer1.SetAuthenticationMode(
  const Value: TAuthenticationMode);
begin
  FAuthenticationMode := Value;
end;

procedure TServerContainer1.SetAuthorizeMode(
  AValue: TAuthorizationChecking);
begin
  FAuthorizeMode := AValue;
  Self.DSAuthenticationManager1.OnUserAuthorize := nil;
  Self.DSServerClass1.OnPrepare := nil;
  case AValue of
   authDefaultAuth:
     ; // no events
   authOnAuthorize:
     Self.DSAuthenticationManager1.OnUserAuthorize := DSAuthenticationManager1UserAuthorize;
   authOnPrepare:
     Self.DSServerClass1.OnPrepare := DSServerClass1Prepare;
  end;
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthorize(
  Sender: TObject; DSAuthorizeEventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
var
  LValid: Boolean;
begin
  LogMessage('Enter UserAuthorize');
  // Default value is based on comparison of user roles with method roles
  LogMessage(Format('Default value, valid: %s', [sFalseTrue[valid]]));
  LogServerEvent(DSAuthorizeEventObject);
  if FAuthorizeMode = authOnAuthorize then
  begin
    if AllowDenyMode = TAuthorizationRequirments.DenyAll then
      valid := False
    else
    if AllowDenyMode = TAuthorizationRequirments.allowAll then
      valid := True
    else
    begin
      LValid := False;
      if not LockUserInfo(DSAuthorizeEventObject.UserName,
          procedure(AUserInfo: TUserInfo)
          begin
            LValid := AUserInfo.IsAuthorized(DSAuthorizeEventObject.AuthorizedRoles, DSAuthorizeEventObject.DeniedRoles);
          end) then
      begin
        case TDSAuthenticationManager.CompareRoles(nil, DSAuthorizeEventObject.AuthorizedRoles, DSAuthorizeEventObject.DeniedRoles) of
          rcNoMethodRoles:  // Allow if not roles associated with method
            LValid := True;
        else
          LValid := False;
        end;
      end;
      valid := LValid;
    end;
    LogMessage(Format('IsAuthorized: %s',
      [sFalseTrue[valid]]));
  end;
  LogMessage(Format('Exit UserAuthorize, valid: %s'#13#10,
    [sFalseTrue[valid]]));

end;

procedure TServerContainer1.LogMessage(const AMessage: string);
begin
  if Assigned(FLogMessageProc) then
    FLogMessageProc(AMessage);
end;

procedure TServerContainer1.UserRoleItemsChanged;
var
  I: Integer;
  LUserName: string;
  LRole: string;
  LUserInfo: TUserInfo;
begin
  FReadWriteSync.BeginRead;
  try
    FReadWriteSync.BeginWrite;
    try
      FUserDictionary.Clear;
      for I := 0 to UserRoleItems.Count - 1 do
      begin
        for LUserName in UserRoleItems[I].UserNames do
          if not FUserDictionary.TryGetValue(Lowercase(LUserName), LUserInfo) then
          begin
            LUserInfo := TUserInfo.Create;
            FUserDictionary.Add(Lowercase(LUserName), LUserInfo);
          end;
        for LRole in UserRoleItems[I].Roles do
          LUserInfo.AddRole(LRole);
      end;
    finally
      FReadWriteSync.EndWrite;
    end;
  finally
    FReadWriteSync.EndRead;
  end;
end;

{ TUserInfo }

procedure TUserInfo.AddRole(const ARoleName: string);
begin
  if not HasRole(ARoleName) then
    FRoles.Add(ARoleName);
end;

constructor TUserInfo.Create;
begin
  FRoles := TStringList.Create;
end;

destructor TUserInfo.Destroy;
begin
  FRoles.Free;
  inherited;
end;

procedure TUserInfo.GetRoles(AStrings: TStrings);
begin
  AStrings.Clear;
  AStrings.Assign(FRoles);
end;

function TUserInfo.HasRole(const ARole: string): Boolean;
begin
  Result := FRoles.IndexOf(ARole) >= 0;
end;

function TUserInfo.IsAuthorized(const AAuthorized, ADenied: TStrings): Boolean;
var
  LComparison:  TDSRoleComparison; // = (rcNoUserRoles, rcNoMethodRoles, rcUserRoleAllowed, rcUserRoleDenied, rcNoMatch);
begin
  Result := False;
  // Use built in role comparison routine to compare roles
  LComparison := TDSAuthenticationManager.CompareRoles(FRoles, AAuthorized, ADenied);
  case LComparison of
    rcNoUserRoles:
      Result := False;
    rcNoMethodRoles:
      Result := True;
    rcUserRoleAllowed:
      Result := True;
    rcUserRoleDenied:
      Result := False;
    rcNoMatch:
      Result := False;
  end;
end;

{ TUserDictionary }

constructor TUserDictionary.Create;
begin
  inherited Create([doOwnsValues]);
end;

end.

