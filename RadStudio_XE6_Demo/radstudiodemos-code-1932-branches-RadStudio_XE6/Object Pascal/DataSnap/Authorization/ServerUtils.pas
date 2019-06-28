
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ServerUtils;

interface

uses
    SysUtils, Classes,  WinSock,
      DBXCommon, DSNames, DBXCommonTable, DBXDataSnap;


type
  TServerSockUtils = class
  public
    class function GetIPAddress: String;
    class function GetHostName: AnsiString;
  end;

  TServerCommandLineUtils = class
  public
    class function GetPort(ADefaultPort: Integer): Integer;
  end;

  TServerMetaDataUtils = class
  public
    class function GetServerConnection(AHostName: string; APort: Integer): TDBXConnection;
    class procedure GetServerMethods(AConnection: TDBXConnection; out AReader: TDBXReader); overload;
    class procedure GetServerMethods(AHostName: string;
      APort: Integer; out AString: string); overload;
    class procedure GetServerMethods(AHostName: string;
      APort: Integer; out AStrings: TStrings); overload;
  end;

implementation


class function TServerSockUtils.GetHostName: AnsiString;
type
  TaPInAddr = Array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  WSAData: TWSAData;
  HostName: Array[0..255] of AnsiChar;
begin
  Result := '';
  if WSAStartup($101, WSAData) = 0 then
  try
    WinSock.GetHostName(@HostName[0], SizeOf(HostName));
    Result := HostName;
  finally
    WSACleanup;
  end;
end;

class function TServerSockUtils.GetIPAddress: String;
type
  TaPInAddr = Array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  WSAData: TWSAData;
  pHe: PHostEnt;
  pPtr: PaPInAddr;
  HostName: Array[0..255] of AnsiChar;
begin
  Result := '';
  if WSAStartup($101, WSAData) = 0 then
  try
    WinSock.GetHostName(@HostName[0], SizeOf(HostName));
    pHe := GetHostByName(@HostName[0]);
    if pHe <> nil then
    begin
      pPtr := PaPInAddr(phe^.h_addr_list);
      if pPtr^[0] <> nil then
      begin
        if String(inet_ntoa(pptr^[0]^)) = '10.10.10.10' then
          if pPtr^[1] <> nil then
            Result:= String(inet_ntoa(pPtr^[1]^))
          else
            Result:= '127.0.0.1'
        else
          Result := String(inet_ntoa(pptr^[0]^));
      end
      else
        Result := '127.0.0.1';
    end
  finally
    WSACleanup;
  end;
end;

class function TServerCommandLineUtils.GetPort(ADefaultPort: Integer): Integer;
var
  I: Integer;
begin
  Result:= ADefaultPort;
  if ParamCount > 0 then
  begin
    for I := 1 to ParamCount do
    begin
      if AnsiPos('port=',ParamStr(I))<>0 then
      try
        Result:= StrToInt(Copy(ParamStr(I),6, MaxInt));
      except
        Result:= 211;
      end;
    end;
  end;
end;

{ TDSMetaDataUtils }

class function TServerMetaDataUtils.GetServerConnection(AHostName: string;
  APort: Integer): TDBXConnection;
var
  LProperties: TDBXProperties;
begin
  LProperties := TDBXProperties.Create;
  try
    LProperties.SetProperties(Format('%s=DataSnap;%s=%d;%s=%s',
                          [TDBXPropertyNames.DriverName,
                           TDBXPropertyNames.Port, APort,
                           TDBXPropertyNames.HostName, AHostName]));
    Result := TDBXConnectionFactory.GetConnectionFactory.GetConnection(LProperties);
  finally
    LProperties.Free;
  end;
end;


class procedure TServerMetaDataUtils.GetServerMethods(AConnection: TDBXConnection; out AReader: TDBXReader);
var
  LCommand: TDBXCommand;
begin
  LCommand := AConnection.CreateCommand;
  try
    LCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    LCommand.Text := 'DSAdmin.GetServerMethods';
    LCommand.Prepare;
    LCommand.ExecuteUpdate;
    AReader := LCommand.Parameters[0].Value.GetDBXReader(False);  // False = this code will free reader
  finally
    LCommand.Free;
  end;
end;

class procedure TServerMetaDataUtils.GetServerMethods(AHostName: string;
  APort: Integer; out AString: string);
var
  LStrings: TStrings;
begin
  GetServerMethods(AHostName, APort, LStrings);
  try
    AString := LStrings.GetText
  finally
    LStrings.Free;
  end;
end;

class procedure TServerMetaDataUtils.GetServerMethods(AHostName: string;
  APort: Integer; out AStrings: TStrings);
var
  LConnection: TDBXConnection;
  LReader: TDBXReader;
  LClassName: string;
begin
  AStrings := TStringList.Create;
  LConnection := GetServerConnection(AHostName, APort);
  try
    GetServerMethods(LConnection, LReader);
    try
      while LReader.Next do
      begin
        LClassName := LReader.Value[TDSMethodColumns.ServerClassName].GetWideString;
        if (LClassName = 'DSAdmin') or (LClassName = 'DSMetadata') then
          // Skip built in methods
          continue;
        AStrings.Add(LReader.Value[TDSMethodColumns.MethodAlias].GetWideString);
      end;
      TStringList(AStrings).Sort;
    finally
      LReader.Free;
    end;
  finally
    LConnection.Free;
  end;
end;

end.
