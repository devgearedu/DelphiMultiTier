unit ProxyRegister;

interface

uses
  System.SysUtils,
  ClientClassesUnit1,
  IndyPeerImpl,
  Datasnap.DSClientRest,
  inifiles,
  DSHTTPCommon, DSHTTPLayer,
  DBXJSON;

function GetProxy: TCompanyTweetClient;
function GetCTCallback(AnExceptionEvent: TDSCallbackChannelEvent)
  : TDSClientCallbackChannelManager;
function GetCMDCallback(AnExceptionEvent: TDSCallbackChannelEvent): TDSClientCallbackChannelManager;
procedure ResetProxy;
function ConnectionBuilder: TDSRestConnection;

var
  Port: Integer;
  Host, Protocol: String;

implementation

var
  Proxy: TCompanyTweetClient;
  CTCallback: TDSClientCallbackChannelManager;
  CMDCallback: TDSClientCallbackChannelManager;
  DSRestConnection: TDSRestConnection;

function GetCTCallback(AnExceptionEvent: TDSCallbackChannelEvent)
  : TDSClientCallbackChannelManager;
var
  DSCon: TDSRestConnection;
begin
  if not Assigned(CTCallback) then
  begin
    DSCon := ConnectionBuilder;
    CTCallback := TDSClientCallbackChannelManager.Create(nil);
    CTCallback.OnServerConnectionTerminate := AnExceptionEvent;
    CTCallback.OnServerConnectionError := AnExceptionEvent;

    CTCallback.CommunicationProtocol := DSCon.Protocol;
    CTCallback.DSHostname := DSCon.Host;
    CTCallback.DSPort := IntToStr(DSCon.Port);
    CTCallback.ChannelName := 'ct'; // ChannelName;
    CTCallback.ManagerId := IntToStr(Random(100000)) + '.' +
      IntToStr(Random(100000));
  end;

  Result := CTCallback;
end;

function GetCMDCallback(AnExceptionEvent: TDSCallbackChannelEvent): TDSClientCallbackChannelManager;
var
  DSCon: TDSRestConnection;
begin
  if not Assigned(CMDCallback) then
  begin
    DSCon := ConnectionBuilder;
    CMDCallback := TDSClientCallbackChannelManager.Create(nil);
    CMDCallback.OnServerConnectionTerminate := AnExceptionEvent;
    CMDCallback.OnServerConnectionError := AnExceptionEvent;
    CMDCallback.CommunicationProtocol := DSCon.Protocol;
    CMDCallback.DSHostname := DSCon.Host;
    CMDCallback.DSPort := IntToStr(DSCon.Port);
    CMDCallback.ChannelName := 'cmd'; // ChannelName;
    CMDCallback.ManagerId := IntToStr(Random(100000)) + '.' +
      IntToStr(Random(100000));
  end;

  Result := CMDCallback;

end;

procedure ResetProxy;
begin
  try
    if Assigned(CTCallback) then
      CTCallback.CloseClientChannel;

    if Assigned(CMDCallback) then
      CMDCallback.CloseClientChannel;

    if Assigned(Proxy) then
    begin
      try
        Proxy.Logout;
      except
      end;
      Proxy.Free;
      Proxy := nil;
    end;
  except
  end;

  FreeAndNil(CTCallback);
  FreeAndNil(CMDCallback);
  FreeAndNil(DSRestConnection);
end;

function ConnectionBuilder: TDSRestConnection;
begin
  if not Assigned(DSRestConnection) then
  begin
    DSRestConnection := TDSRestConnection.Create(nil);
    DSRestConnection.Port := Port;
    DSRestConnection.Host := Host;
    DSRestConnection.Protocol := Protocol;
  end;
  Result := DSRestConnection;
end;

function GetProxy: TCompanyTweetClient;
begin
  if not Assigned(Proxy) then
  begin
    Proxy := TCompanyTweetClient.Create(ConnectionBuilder, False);
  end;
  Result := Proxy;
end;

initialization

finalization

FreeAndNil(Proxy);

end.
