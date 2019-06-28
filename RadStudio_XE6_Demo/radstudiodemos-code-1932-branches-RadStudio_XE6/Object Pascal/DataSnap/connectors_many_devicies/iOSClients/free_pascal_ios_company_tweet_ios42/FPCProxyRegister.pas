unit FPCProxyRegister;

interface

uses
{$IFNDEF FPC}
  DSProxy,
  DSFPCCallbackChannelManager,
  DSRestConnection,
{$ENDIF}
{$IFDEF FPC}
  DBXFPCJSON,
  DSProxy,
  DSRestConnection,
  DSFPCCallbackChannelManager,
{$ENDIF}
  SysUtils, inifiles;

function GetProxy: TCompanyTweet;
function GetCTCallback(AnExceptionEvent: TDSFPCExceptionEvent)
  : TDSFPCCallbackChannelManager;
function GetCMDCallback(AnExceptionEvent: TDSFPCExceptionEvent)
  : TDSFPCCallbackChannelManager;
procedure ResetProxy;
function ConnectionBuilder: TDSRestConnection;

var
  Port: Integer;
  Host, Protocol: String;

implementation

var
  Proxy: TCompanyTweet;
  CTCallback: TDSFPCCallbackChannelManager;
  CMDCallback: TDSFPCCallbackChannelManager;
  DSRestConnection: TDSRestConnection;

function GetCTCallback(AnExceptionEvent: TDSFPCExceptionEvent)
  : TDSFPCCallbackChannelManager;
var
  DSCon: TDSRestConnection;
begin
  if not Assigned(CTCallback) then
  begin
    DSCon := ConnectionBuilder;
    CTCallback := TDSFPCCallbackChannelManager.Create(DSCon, 'ct',
      TDSFPCCallbackChannelManager.GetNewManagerID);
    CTCallback.OnException := AnExceptionEvent;
  end;

  Result := CTCallback;
end;

function GetCMDCallback(AnExceptionEvent: TDSFPCExceptionEvent)
  : TDSFPCCallbackChannelManager;
var
  DSCon: TDSRestConnection;
begin
  if not Assigned(CMDCallback) then
  begin
    DSCon := ConnectionBuilder;
    CMDCallback := TDSFPCCallbackChannelManager.Create(DSCon, 'cmd',
      TDSFPCCallbackChannelManager.GetNewManagerID +
      TDSFPCCallbackChannelManager.GetNewManagerID);
    CMDCallback.OnException := AnExceptionEvent;
  end;

  Result := CMDCallback;

end;

procedure ResetProxy;
begin
  try
    if Assigned(CTCallback) then
    begin
      try
        CTCallback.CloseClientChannel;
      except
      end;
      CTCallback.Free;
      CTCallback := nil;
    end;

    if Assigned(CMDCallback) then
    begin
      try
        CMDCallback.CloseClientChannel;
      except
      end;
      CMDCallback.Free;
      CMDCallback := nil;
    end;

    if Assigned(Proxy) then
    begin
      try
        Proxy.Logout;
      except
      end;
      Proxy.Free;
      Proxy := nil;
    end;

    if Assigned(DSRestConnection) then
    begin
      DSRestConnection.Free;
      DSRestConnection := nil;
    end;
  except
  end;
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

function GetProxy: TCompanyTweet;
begin
  if not Assigned(Proxy) then
  begin
    Proxy := TCompanyTweet.Create(ConnectionBuilder);
  end;
  Result := Proxy;
end;

initialization

finalization

begin
  Proxy.Free;
  Proxy := nil;
end;

end.
