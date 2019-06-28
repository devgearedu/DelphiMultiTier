
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// Register a DataSnap DBX/HTTP communication layer that can be used with Fiddler to
// monitor HTTP traffic.
unit HTTPProxyProtocol;

interface

uses
  System.SysUtils,
  Data.DBXCommon,
  Data.DBXTransport,
  IdHTTP, IdStack,
  Datasnap.DSHTTPLayer,
  Data.DBXHTTPLayer;

type
  THTTPProxyProtocolLayer = class(TDBXHTTPLayer)
  public
    procedure Open(const DBXProperties: TDBXProperties); override;
  end;

const
  sHTTPProxyProtocolLayer = 'fiddler-http';


implementation

uses Rtti;

// Use RTTI to extract value of private variable: TDSHTTPNativeClient.FHttp.
function GetDSHTTPNativeClientIdHTTP(AHttpClient: TDSHTTPClient): TIdHTTP;
var
  rttiType : TRttiType;
  rttiField : TRttiField;
  rttiContext: TRttiContext;
  LValue: TValue;
begin
  rttiType := rttiContext.GetType(AHttpClient.ClassType);
  rttiField := rttiType.GetField('FHttp');
  Assert(rttiField <> nil);
  LValue := rttiField.GetValue(AHttpClient);
  Assert(LValue.AsObject <> nil);
  Result := TIdHttp(LValue.AsObject);
end;

{ THTTPProxyProtocolLayer }

procedure THTTPProxyProtocolLayer.Open(const DBXProperties: TDBXProperties);
var
  LIdHttp: TIdHTTP;
begin
  //if host is localhost, modify so that fiddler will recognize
  if (DBXProperties.Values[TDBXPropertyNames.HostName] = 'localhost') or
     (DBXProperties.Values[TDBXPropertyNames.HostName] = '127.0.0.1') then
    DBXProperties.Values[TDBXPropertyNames.HostName] := 'localhost.';

  // let connection string specify proxy port and host, otherwise use default values
  if DBXProperties.Values['FiddlerServer'] = '' then
    DBXProperties.Values['FiddlerServer'] := '127.0.0.1';
  if DBXProperties.Values['FiddlerPort'] = '' then
    DBXProperties.Values['FiddlerPort'] := '8888';

  LIdHTTP := GetDSHTTPNativeClientIdHTTP(FHttp);
  LIdHTTP.ProxyParams.ProxyServer := DBXProperties.Values['FiddlerServer'];
  LIdHTTP.ProxyParams.ProxyPort := StrToInt(DBXProperties.Values['FiddlerPort']);
  try
    inherited;
  except on E: EIdSocketError do
  begin
    if E.Message = 'TODO' then //try again without proxy in case it is proxy is down or non-existant
    begin
      inherited;
    end
    else raise;
  end;
  end;
end;

initialization
  TDBXCommunicationLayerFactory.RegisterLayer(sHTTPProxyProtocolLayer, THTTPProxyProtocolLayer);

finalization
  TDBXCommunicationLayerFactory.UnregisterLayer(sHTTPProxyProtocolLayer);

end.
