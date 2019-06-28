
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit TunnelServerContainerUnit;

interface

uses
  SysUtils, Classes, 
  DSHTTPCommon, DSHTTP,
  DSServer, DSCommonServer, DSAuth, IPPeerServer, IndyPeerImpl;

type

  TAuthenticationMode = (authenticateAllUsers, authenticateUsersWithName, authenticateNoUsers);

  TServerContainer5 = class(TDataModule)
    DSHTTPService1: TDSHTTPService;
    DSAuthenticationManager1: TDSAuthenticationManager;
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
  private
    FLogMessageProc: TProc<string>;
    FAuthenticationMode: TAuthenticationMode;
    procedure LogMessage(const AMessage: string);
    procedure SetAuthenticationMode(const Value: TAuthenticationMode);
  public
    property LogMessageProc: TProc<string> read FLogMessageProc write FLogMessageProc;
    property AuthenticationMode: TAuthenticationMode read FAuthenticationMode write SetAuthenticationMode;
  end;

var
  ServerContainer5: TServerContainer5;

implementation

uses Windows;

{$R *.dfm}

const
  sFalseTrue: array[false..true] of string = ('false', 'true');

procedure TServerContainer5.DSAuthenticationManager1UserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
begin
  LogMessage('Enter UserAuthenticate');
  LogMessage(Format('User: %s, Password: %s',
    [User, password]));
  LogMessage(Format('Protocol: %s, Context: %s',
    [Protocol, Context]));
  case FAuthenticationMode of
    authenticateAllUsers:
      valid := True;
    authenticateUsersWithName:
      valid := User <> '';
    authenticateNoUsers:
      valid := False;
  else
    Assert(False);
  end;
  LogMessage(Format('Exit UserAuthenticate, Valid: %s'#13#10,
    [sFalseTrue[valid]]));
end;

procedure TServerContainer5.DSAuthenticationManager1UserAuthorize(
  Sender: TObject; AuthorizeEventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
begin
  valid := True;
end;

procedure TServerContainer5.LogMessage(const AMessage: string);
begin
  if Assigned(FLogMessageProc) then
    FLogMessageProc(AMessage);
end;


procedure TServerContainer5.SetAuthenticationMode(
  const Value: TAuthenticationMode);
begin
  FAuthenticationMode := Value;
end;

end.

