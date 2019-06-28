
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit HTPServerTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdTCPServer, IdHTTPServer, IdCustomHTTPServer, IdContext, StdCtrls,
  IdBaseComponent, IdComponent, IdCustomTCPServer, DSHTTP, WideStrings,
  DbxDatasnap, DB, SqlExpr, DSSession, DSTCPServerTransport,
  DbxSocketChannelNative, DSCommonServer, DSServer, DSHTTPCommon, DSAuth,
  IPPeerServer, IPPeerClient, IndyPeerImpl;

type
  TForm6 = class(TForm)
    lstLog: TListBox;
    btnClearLog: TButton;
    chkActive: TCheckBox;
    btnClose: TButton;
    lblActiveTunnelSessions: TLabel;
    lblOpenSessions: TLabel;
    btnRefresh: TButton;
    btnCloseAll: TButton;
    Button1: TButton;
    cbFailover: TCheckBox;
    DSHTTPService1: TDSHTTPService;
    DSAuthenticationManager1: TDSAuthenticationManager;
    procedure btnClearLogClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure DSHTTPService1Trace(Sender: TObject; AContext: TDSHTTPContext;
                                    ARequest: TDSHTTPRequest;
                                    AResponse: TDSHTTPResponse);
    procedure btnCloseAllClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure cbFailoverClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      const UserRoles: TStrings);
  private
    { Private declarations }
    sessionCount: Integer;

    procedure Log(Data: String);
    procedure LogServerState;
    function CommandTypeToString( cmdType: TDSHTTPCommandType ): String;

    procedure Redirect(Sender: TObject; Session: TDSTunnelSession; Content: TBytes;
                                           var Count: Integer);


    procedure OpenBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes;
                                           var Count: Integer);
    procedure CloseBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes;
                                           var Count: Integer);
    procedure WriteBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes;
                                           var Count: Integer);
    procedure ReadBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes;
                                           var Count: Integer);
    procedure ErrorWriteBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes;
                                           var Count: Integer);
    procedure ErrorReadBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes;
                                           var Count: Integer);

    procedure LogBytes(SessionContent: TBytesStream; Buf: TBytes; Count: integer; Op: byte);
    function ReadLogBytes(SessionContent: TBytesStream; var Buf: TBytes; out Count: integer): byte;
    procedure RestoreSessionState(Session: TDSTunnelSession);

  public
    { Public declarations }
    constructor Create(component: TComponent); override;

    destructor Destroy; override;
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses DBXCommon, DSUtilityUnit;

procedure TForm6.btnClearLogClick(Sender: TObject);
begin
  lstLog.Clear;
end;

procedure TForm6.btnCloseAllClick(Sender: TObject);
begin
  DSHTTPService1.HttpServer.TunnelService.TerminateAllSessions;
  lblOpenSessions.Caption := IntToStr(DSHTTPService1.HttpServer.TunnelService.SessionCount);
end;

procedure TForm6.btnCloseClick(Sender: TObject);
begin
  DSHTTPService1.Active := false;
  Form6.Close;
end;

procedure TForm6.btnRefreshClick(Sender: TObject);
begin
  lblOpenSessions.Caption := IntToStr(DSHTTPService1.HttpServer.TunnelService.SessionCount);
end;

procedure TForm6.Button1Click(Sender: TObject);
var
  Keys: TStringList;
  I: Integer;
begin
  Keys := TStringList.Create;
  DSHTTPService1.HttpServer.TunnelService.GetOpenSessionKeys(Keys);
  for I := 0 to Keys.Count - 1 do
  begin
    Log(Keys.Strings[I]);
  end;
  Keys.Destroy;
end;

procedure TForm6.cbFailoverClick(Sender: TObject);
begin
  if cbFailover.Checked then
  begin
    DSHTTPService1.HttpServer.TunnelService.OnErrorOpenSession := Redirect;
    DSHTTPService1.HttpServer.TunnelService.OnErrorWriteSession := ErrorWriteBackupSession;
    DSHTTPService1.HttpServer.TunnelService.OnErrorReadSession := ErrorReadBackupSession;
    DSHTTPService1.HttpServer.TunnelService.OnOpenSession := OpenBackupSession;
    DSHTTPService1.HttpServer.TunnelService.OnWriteSession := WriteBackupSession;
    DSHTTPService1.HttpServer.TunnelService.OnReadSession := ReadBackupSession;
    DSHTTPService1.HttpServer.TunnelService.OnCloseSession := CloseBackupSession;
  end else begin
    DSHTTPService1.HttpServer.TunnelService.OnErrorOpenSession := nil;
    DSHTTPService1.HttpServer.TunnelService.OnErrorWriteSession := nil;
    DSHTTPService1.HttpServer.TunnelService.OnErrorReadSession := nil;
    DSHTTPService1.HttpServer.TunnelService.OnOpenSession := nil;
    DSHTTPService1.HttpServer.TunnelService.OnWriteSession := nil;
    DSHTTPService1.HttpServer.TunnelService.OnReadSession := nil;
    DSHTTPService1.HttpServer.TunnelService.OnCloseSession := nil;
  end;
end;

procedure TForm6.chkActiveClick(Sender: TObject);
begin
  try
    // de-/activate server
    DSHTTPService1.Active := chkActive.Checked;
  except
    on E: Exception do
      Log( E.Message );
  end;
  // log to list box
  LogServerState;
end;

procedure TForm6.Log(Data: String);
begin
//    Synchronize(procedure begin
          lstLog.Items.Add(FormatDateTime('hh:mm:ss.zzz',Now) + ' - ' + Data);
//          end);
end;

procedure TForm6.LogServerState;
begin
  if DSHTTPService1.Active then
    Log(DSHTTPService1.ServerSoftware + ' is active')
  else
    Log(DSHTTPService1.ServerSoftware + ' is not active');
end;


procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  DSServer1.Stop;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  sessionCount := 0;
  DSHTTPService1.Active := True;
  chkActive.Checked := self.DSHTTPService1.Active;
  LogServerState;
  cbFailoverClick(nil)
end;

function TForm6.CommandTypeToString( cmdType: TDSHTTPCommandType ): String;
begin
  case cmdType of
    hcUnknown: Result := 'UNKWON';
    hcOther: Result := 'OTHER';
    hcGET: Result := 'GET';
    hcPOST: Result := 'POST';
    hcDELETE: Result := 'DELETE';
    hcPUT: Result := 'PUT';
  end;
end;

procedure TForm6.DSAuthenticationManager1UserAuthenticate(Sender: TObject;
  const Protocol, Context, User, Password: string; var valid: Boolean;
  const UserRoles: TStrings);
begin
  Log('User ' + User + ' authenticated');
  valid := true;
end;

procedure TForm6.DSHTTPService1Trace(Sender: TObject; AContext: TDSHTTPContext;
                                    ARequest: TDSHTTPRequest;
                                    AResponse: TDSHTTPResponse);
var
  sessionId: String;
  cmdType: String;
  i, count: Integer;
  paramName, paramValue: String;

  dataStream: TStream;
begin
  cmdType := CommandTypeToString(ARequest.CommandType );

  sessionId := '*';
  Inc(sessionCount);
  if TDSHTTPRequestIndy(ARequest).RequestInfo.Session <> nil then
    sessionId := TDSHTTPRequestIndy(ARequest).RequestInfo.Session.SessionID
  else
    sessionId := IntToStr(self.sessionCount);

  sessionId := sessionId + ': ';

  Log(sessionId + 'Request started');
  Log(sessionId + '  Command: ' + ARequest.Command);
  Log(sessionId + '  Document: ' + ARequest.Document);
  if ARequest.Params <> nil then
  begin
    Log(sessionId + '  Params');
    count := ARequest.Params.Count;
    for I := 0 to count - 1 do
      begin
        paramName := ARequest.Params.Names[I];
        paramValue := ARequest.Params.Values[ paramName ];
        Log(sessionId + '    ' + paramName + '=' + paramValue );
      end;
  end;

  Log(sessionId + '  Response No:' + IntToStr( AResponse.ResponseNo ) );
  Log(sessionId + '  Response Text:' + AResponse.ResponseText );
  Log(sessionId + '  Response close connection:' + BoolToStr(AResponse.CloseConnection, true));
  Log(sessionId + '  Response connection:' + TDSHTTPResponseIndy(AResponse).ResponseInfo.Connection);

  Log(sessionId + 'Request ended');
end;


procedure TForm6.DSServerClass1GetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDSUtilityMethods;
end;

procedure TForm6.Redirect(Sender: TObject; Session: TDSTunnelSession; Content: TBytes; var Count: Integer);
var
  DBXProperties: TDBXDatasnapProperties;
  Msg: String;
begin
  if Sender is Exception then
    Msg := Exception(Sender).Message;
  Log('>>' + Msg);

  if Session.UserFlag = 1 then
    Raise Exception.Create('Backup session cannot be redirected once more.' + Msg);

  DBXProperties := TDBXDatasnapProperties.Create(nil);
  DBXProperties.Values[TDBXPropertyNames.DriverName] := 'Datasnap';
  DBXProperties.Values[TDBXPropertyNames.HostName]  := 'localhost';
  DBXProperties.Values[TDBXPropertyNames.Port]      := '213';

  try
    try
      Session.Reopen(DBXProperties);
      Session.UserFlag := 1;

      Msg := 'Flow commuted to alternate resource.';
      Log('>>' + Msg);
    except
      Raise Exception.Create(Msg + '. Commuting to alternate resource failed.');
    end;
  finally
    DBXProperties.free;
  end;

end;

procedure TForm6.LogBytes(SessionContent: TBytesStream; Buf: TBytes; Count: Integer; Op: Byte);
var
  Header: TBytes;
begin
  SetLength(Header, 5);
  Header[0] := Op;
  Header[1] := (Count shr 24) and 255;
  Header[2] := (Count shr 16) and 255;
  Header[3] := (Count shr 8) and 255;
  Header[4] := Count and 255;

  SessionContent.Write(Header[0], 5);
  SessionContent.Write(Buf[0], Count);
end;

function TForm6.ReadLogBytes(SessionContent: TBytesStream; var Buf: TBytes; out Count: Integer): Byte;
var
  Header: TBytes;
begin
  if SessionContent.Position < SessionContent.Size then
  begin
    SetLength(Header, 5);

    SessionContent.Read(Header[0], 5);
    Result := Header[0];

    Count := Header[1];
    Count := (Count shl 8) or Header[2];
    Count := (Count shl 8) or Header[3];
    Count := (Count shl 8) or Header[4];
    SetLength(Buf, Count);
    SessionContent.Read(Buf[0], Count);
  end
  else
    Result := 0;
end;

procedure TForm6.RestoreSessionState(Session: TDSTunnelSession);
var
  SessionContent: TBytesStream;
  Buf: TBytes;
  Count: Integer;
  Op: Byte;
begin
  SessionContent := TBytesStream(Session.UserPointer);
  SessionContent.Position := 0;
  repeat
    Op := ReadLogBytes(SessionContent, Buf, Count);
    case Op of
      2: //read
      begin
        Session.Read(Buf, 0, Count);
      end;
      1: // write
      begin
        Session.Write(Buf, 0, Count);
      end;
    end;
  until op = 0;
end;

procedure TForm6.OpenBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes; var Count: Integer);
begin
  if Session.UserFlag = 0 then
  begin
    Session.UserPointer := Pointer(TBytesStream.Create());
  end;
end;

procedure TForm6.WriteBackupSession(Sender: TObject; Session: TDSTunnelSession;
                                    Content: TBytes; var Count: Integer);
var
  SessionContent: TBytesStream;
begin
  if Session.UserFlag = 0 then
  begin
    SessionContent := TBytesStream(Session.UserPointer);
    LogBytes(SessionContent, Content, Count, 1);
  end;
end;

procedure TForm6.ReadBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes; var Count: Integer);
var
  SessionContent: TBytesStream;
begin
  if Session.UserFlag = 0 then
  begin
    SessionContent := TBytesStream(Session.UserPointer);
    LogBytes(SessionContent, Content, Count, 2);
  end;
end;

procedure TForm6.CloseBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes; var Count: Integer);
var
  SessionContent: TBytesStream;
begin
  SessionContent := TBytesStream(Session.UserPointer);
  if SessionContent <> nil then
  begin
    SessionContent.Free;
    Session.UserPointer := nil;
  end;
end;

procedure TForm6.ErrorWriteBackupSession(Sender: TObject; Session: TDSTunnelSession;
                                         Content: TBytes; var Count: Integer);
begin
  if Session.UserFlag = 0 then
  begin
    Redirect(Sender, Session, Content, Count);
    RestoreSessionState(Session);
    CloseBackupSession(Sender, Session, Content, Count);

    Count := Session.Write(Content, 0, Count);
  end;
end;

procedure TForm6.ErrorReadBackupSession(Sender: TObject; Session: TDSTunnelSession; Content: TBytes; var Count: Integer);
begin
  if Session.UserFlag = 0 then
  begin
    Redirect(Sender, Session, Content, Count);
    RestoreSessionState(Session);
    CloseBackupSession(Sender, Session, Content, Count);

    Count := Session.Read(Content, 0, Count);
  end;
end;

constructor TForm6.Create(component: TComponent);
begin
  inherited Create(component);
end;

destructor TForm6.Destroy;
begin

end;

end.
