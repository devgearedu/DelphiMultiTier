//---------------------------------------------------------------------------

// This software is Copyright (c) 2013 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
{*******************************************************}
{                                                       }
{          Delphi REST Framework Utilities              }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit RestUtils;

interface

uses
  System.SysUtils, DBUtils, Datasnap.DSClientRest, Data.DB;

type
  ERestUtils = class(Exception);

  TDSConnectionProc = reference to procedure(AConnection: TDSRestConnection);

  TRestUtils = class(TDBUtils)
  private
    class function CreateConnection(AInitConnection: TDSConnectionProc): TDSRestConnection;
  public
    ///  <summary>
    ///  Create a <c>TDSRestConnection</c> with the specified connection name
    ///  using the configuration parameters specified in application.ini
    ///  </summary>
    ///  <param name="AName">Name of connection to open</param>
    ///  <param name="AIniFile">Optional. Name of the Ini file.
    ///  Defaults to the application name + '.ini'</param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class function CreateRestConnection(const AName: string;
      AIniFile: string = ''): TDSRestConnection;

    ///  <summary>
    ///  Create a <c>TDSRestConnection</c> with the specified connection properties
    ///  </summary>
    ///  <param name="AHost">Name of the host where the REST server resides</param>
    ///  <param name="AUrlPath">URL path of the REST server. Defaults to ''</param>
    ///  <param name="APort">Port that the REST server is listening on. Defaults to 8080</param>
    ///  <param name="AProtocol">Protocol to use when communicating with the REST server. Defaults to 'http'</param>
    ///  <param name="AContext">Context of the REST server. Defaults to 'datasnap/'</param>
    ///  <param name="AUserName">REST user name</param>
    ///  <param name="APassword">Password for <c>AUserName</c></param>
    ///  <param name="AProxyHost">Name of the proxy server to use. If an empty string is specified, no proxy server is used. Defaults to ''</param>
    ///  <param name="AProxyPort">Port of the proxy server. Defaults to 8888 (default port for Fiddler) </param>
    ///  <param name="AProxyUserName">Proxy server user name. Defaults to ''</param>
    ///  <param name="AProxyPassword">Password for <c>AProxyUserName</c>. Defaults to ''</param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class function CreateRestConnectionProps(
      const AHost: string; const AUrlPath: string = ''; const APort: Integer = 8080;
      const AProtocol: string = 'http'; AContext: string = 'datasnap/';
      AUserName: string = ''; APassword: string = ''; AProxyHost: string = '';
      AProxyPort: Integer = 8888; AProxyUserName: string = ''; AProxyPassword: string = ''): TDSRestConnection;

    ///  <summary>
    ///  Initialize a <c>TDSRestConnection</c> with the specified connection name
    ///  using the configuration specified in application.ini
    ///  </summary>
    ///  <param name="AConnection">The TDSRestConnection instance to initialize</param>
    ///  <param name="AName">Name of connection to open</param>
    ///  <param name="AIniFile">Optional. Name of the Ini file.
    ///  Defaults to the application name + '.ini'</param>
    class procedure InitRestConnection(AConnection: TDSRestConnection; const AName: string;
      AIniFile: string = '');

     ///  <summary>
    ///  Initializes a <c>TDSRestConnection</c> with the specified connection properties
    ///  </summary>
    ///  <param name="AConnection". The TDSRestConnection instance to intialize</param>
    ///  <param name="AHost">Name of the host where the REST server resides</param>
    ///  <param name="AUrlPath">URL path of the REST server. Defaults to ''</param>
    ///  <param name="APort">Port that the REST server is listening on. Defaults to 8080</param>
    ///  <param name="AProtocol">Protocol to use when communicating with the REST server. Defaults to 'http'</param>
    ///  <param name="AContext">Context of the REST server. Defaults to 'datasnap/'</param>
    ///  <param name="AUserName">REST user name</param>
    ///  <param name="APassword">Password for <c>AUserName</c></param>
    ///  <param name="AProxyHost">Name of the proxy server to use. If an empty string is specified, no proxy server is used. Defaults to ''</param>
    ///  <param name="AProxyPort">Port of the proxy server. Defaults to 8888 (default port for Fiddler) </param>
    ///  <param name="AProxyUserName">Proxy server user name. Defaults to ''</param>
    ///  <param name="AProxyPassword">Password for <c>AProxyUserName</c>. Defaults to ''</param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class procedure InitRestConnectionProps(
      AConnection: TDSRestConnection;
      const AHost: string; const AUrlPath: string = ''; const APort: Integer = 8080;
      const AProtocol: string = 'http'; AContext: string = 'datasnap/';
      AUserName: string = ''; APassword: string = ''; AProxyHost: string = '';
      AProxyPort: Integer = 8888; AProxyUserName: string = ''; AProxyPassword: string = '');
  end;

const
  SHost = 'Host';
  SUrlPath = 'UrlPath';
  SProtocol = 'Protocol';
  SContext = 'Context';
  SProxyHost = 'ProxyHost';
  SProxyUserName = 'ProxyUserName';
  SProxyPassword = 'ProxyPassword';
  SPort = 'Port';
  SProxyPort = 'ProxyPort';
  SDefaultHost = '';
  SDefaultUrlPath = '';
  SDefaultProtocol = 'http';
  SDefaultContext = '';
  SDefaultRestUser = '';
  SDefaultRestPassword = '';
  SDefaultProxyHost = '';
  SDefaultProxyUser = '';
  SDefaultProxyPassword = '';
  SDefaultPort = 8080;
  SDefaultProxyPort = 8888;

resourcestring
  StrCouldNotInitConnection = 'Could not initialize connection %s via application.ini (%s)';

implementation

uses
  System.Classes, System.IniFiles, IPPeerClient;


class function TRestUtils.CreateConnection(
  AInitConnection: TDSConnectionProc): TDSRestConnection;
begin
  ThreadLock.Acquire;
  try
    Result := TDSRestConnection.Create(nil);
    try
      AInitConnection(Result);
    except
      Result.Free;
      raise;
    end;
  finally
    ThreadLock.Release;
  end;
end;

class function TRestUtils.CreateRestConnection(const AName: string;
  AIniFile: string = ''): TDSRestConnection;
begin
  Result := CreateConnection(procedure(AConnection: TDSRestConnection)
  begin
    InitRestConnection(AConnection, AName, AIniFile);
  end);
end;

class function TRestUtils.CreateRestConnectionProps(
  const AHost: string; const AUrlPath: string = ''; const APort: Integer = 8080;
  const AProtocol: string = 'http'; AContext: string = 'datasnap/';
  AUserName: string = ''; APassword: string = ''; AProxyHost: string = '';
  AProxyPort: Integer = 8888; AProxyUserName: string = ''; AProxyPassword: string = ''): TDSRestConnection;
begin
  Result := CreateConnection(procedure(AConnection: TDSRestConnection)
  begin
    InitRestConnectionProps(AConnection, AHost, AUrlPath, APort, AProtocol, AContext,
      AUserName, APassword, AProxyHost, AProxyPort, AProxyUserName, AProxyPassword);
  end);
end;

class procedure TRestUtils.InitRestConnection(AConnection: TDSRestConnection; const AName: string;
  AIniFile: string = '');
var
  host,
  urlPath,
  protocol,
  context,
  userName,
  password,
  proxyHost,
  proxyUserName,
  proxyPassword: string;
  port,
  proxyPort: Integer;
  Ini: TIniFile;

begin
  try
    if Length(Trim(AIniFile)) = 0 then // default to exe name with .ini extension
      AIniFile := ModuleIniFile;
    if FileExists(AIniFile) then
    begin
      Ini := TIniFile.Create(AIniFile);
      try
        host := Ini.ReadString(AName, SHost, SDefaultHost);
        urlPath := Ini.ReadString(AName, SUrlPath, SDefaultUrlPath);
        protocol := Ini.ReadString(AName, SProtocol, SDefaultProtocol);
        context := Ini.ReadString(AName, SContext, SDefaultContext);
        userName := Ini.ReadString(AName, SUserName, SDefaultRestUser);
        password := Ini.ReadString(AName, SPassword, SDefaultRestPassword);
        proxyHost := Ini.ReadString(AName, SProxyHost, SDefaultProxyHost);
        proxyUserName := Ini.ReadString(AName, SProxyUserName, SDefaultProxyUser);
        proxyPassword := Ini.ReadString(AName, SProxyPassword, SDefaultProxyPassword);
        port := Ini.ReadInteger(AName, SPort, SDefaultPort);
        proxyPort := Ini.ReadInteger(AName, SProxyPort, SDefaultProxyPort);
        InitRestConnectionProps(AConnection, host, urlPath, port, protocol, context, userName, password, proxyHost, proxyPort, proxyUserName, ProxyPassword);
      finally
        Ini.Free;
      end;
    end
    else
      raise ERestUtils.CreateFmt(StrAppIniMissing, [AIniFile]);
  except
    on E: Exception do
    begin
      raise ERestUtils.CreateFmt(StrCouldNotInitConnection,
          [AName, E.Message] );
    end;
  end;
end;


class procedure TRestUtils.InitRestConnectionProps(
  AConnection: TDSRestConnection;
  const AHost: string; const AUrlPath: string = ''; const APort: Integer = 8080;
  const AProtocol: string = 'http'; AContext: string = 'datasnap/';
  AUserName: string = ''; APassword: string = ''; AProxyHost: string = '';
  AProxyPort: Integer = 8888; AProxyUserName: string = ''; AProxyPassword: string = '');
begin
  AConnection.Host := AHost;
  AConnection.UrlPath := AUrlPath;
  AConnection.Port := APort;
  AConnection.Protocol := AProtocol;
  AConnection.Context := AContext;
  AConnection.UserName := AUserName;
  AConnection.Password := APassword;
  AConnection.LoginPrompt := False;
  AConnection.ProxyHost := AProxyHost;
  AConnection.ProxyPort := AProxyPort;
  AConnection.ProxyUsername := AProxyUserName;
  AConnection.ProxyPassword := AProxyPassword;
  AConnection.ProxyPort := AProxyPort;
end;


end.
