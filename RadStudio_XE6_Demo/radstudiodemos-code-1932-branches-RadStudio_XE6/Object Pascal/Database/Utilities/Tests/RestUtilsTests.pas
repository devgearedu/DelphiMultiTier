//---------------------------------------------------------------------------

// This software is Copyright (c) 2013 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit RestUtilsTests;

interface

uses
  TestBase, TestFramework, SysUtils, DataSnap.DSClientRest;

type
  TRestUtilsTests = class(TTestBase)
  private
    procedure VerifyRestConnection(AConnection: TDSRestConnection;
      AConnectionName: string; AFree: Boolean = True;
      AExtraProc: TProc = nil);
    function CreateTestCommand(AConnection: TDSRestConnection): TDSRestCommand;
    procedure ClearRestProps(AConnection: TDSRestConnection);
  published
    procedure CreateRestConnectionTest;
    procedure CreateRestConnectionInvalidIniTest;
    procedure InitRestConnectionTest;
    procedure InitRestConnectionInvalidIniTest;
    procedure CreateRestConnectionPropsTest;
    procedure InitRestConnectionPropsTest;
  end;

implementation

uses
  System.IniFiles, RestUtils, DBUtils;

const
  cnTestRestAllConnection = 'RestUtilsTestAll';
  cnTestRestWorkingConnection = 'RestUtilsTestWorking';

{ TRestUtilsTests }

procedure TRestUtilsTests.ClearRestProps(AConnection: TDSRestConnection);
begin
  AConnection.Protocol := '';
  AConnection.Host := '';
  AConnection.Port := 0;
  AConnection.UrlPath := '';
  AConnection.Context := '';
  AConnection.UserName := '';
  AConnection.Password := '';
  AConnection.ProxyHost := '';
  AConnection.ProxyPort := 0;
  AConnection.ProxyUsername := '';
  AConnection.ProxyPassword := '';
end;

procedure TRestUtilsTests.CreateRestConnectionPropsTest;
var
  lIni: TIniFile;
  lHost: string;
  lUrlPath: string;
  lProtocol: string;
  lContext: string;
  lUserName: string;
  lPassword: string;
  lProxyHost: string;
  lProxyUserName: string;
  lProxyPassword: string;
  lPort: Integer;
  lProxyPort: Integer;
  lConnection: TDSRestConnection;
begin
  lIni := TIniFile.Create(TRestUtils.ModuleIniFile);
  try
    lHost := lIni.ReadString(cnTestRestAllConnection, SHost, SDefaultHost);
    lUrlPath := lIni.ReadString(cnTestRestAllConnection, SUrlPath, SDefaultUrlPath);
    lProtocol := lIni.ReadString(cnTestRestAllConnection, SProtocol, SDefaultProtocol);
    lContext := lIni.ReadString(cnTestRestAllConnection, SContext, SDefaultContext);
    lUserName := lIni.ReadString(cnTestRestAllConnection, SUserName, SDefaultRestUser);
    lPassword := lIni.ReadString(cnTestRestAllConnection, SPassword, SDefaultRestPassword);
    lProxyHost := lIni.ReadString(cnTestRestAllConnection, SProxyHost, SDefaultProxyHost);
    lProxyUserName := lIni.ReadString(cnTestRestAllConnection, SProxyUserName, SDefaultProxyUser);
    lProxyPassword := lIni.ReadString(cnTestRestAllConnection, SProxyPassword, SDefaultProxyPassword);
    lPort := lIni.ReadInteger(cnTestRestAllConnection, SPort, SDefaultPort);
    lProxyPort := lIni.ReadInteger(cnTestRestAllConnection, SProxyPort, SDefaultProxyPort);

    lConnection := TRestUtils.CreateRestConnectionProps(lHost, lUrlPath, lPort, lProtocol, lContext,
      lUserName, lPassword, lProxyHost, lProxyPort, lProxyUserName, lProxyPassword);
    VerifyRestConnection(lConnection, cnTestRestAllConnection);

    lHost := lIni.ReadString(cnTestRestWorkingConnection, SHost, SDefaultHost);
    lUrlPath := lIni.ReadString(cnTestRestWorkingConnection, SUrlPath, SDefaultUrlPath);
    lPort := lIni.ReadInteger(cnTestRestWorkingConnection, SPort, SDefaultPort);
    lConnection := TRestUtils.CreateRestConnectionProps(lHost, lUrlPath, lPort);
    VerifyRestConnection(lConnection, cnTestRestWorkingConnection, True,
      procedure
      var
        lCmd: TDSRestCommand;
      begin
        lCmd := CreateTestCommand(lConnection);
        try
          lCmd.Execute;
        finally
          lCmd.Free;
        end;
      end);
  finally
    lIni.Free;
  end;
end;

procedure TRestUtilsTests.CreateRestConnectionTest;
var
  lConnection: TDSRestConnection;
begin
  lConnection := TRestUtils.CreateRestConnection(cnTestRestAllConnection);
  VerifyRestConnection(lConnection, cnTestRestAllConnection);

  lConnection := TRestUtils.CreateRestConnection(cnTestRestAllConnection, TRestUtils.ModuleIniFile);
  VerifyRestConnection(lConnection, cnTestRestAllConnection);

  lConnection := TRestUtils.CreateRestConnection(cnTestRestWorkingConnection);
  VerifyRestConnection(lConnection, cnTestRestWorkingConnection, True, procedure
    var
      lCmd: TDSRestCommand;
    begin
      lCmd := CreateTestCommand(lConnection);
      try
        lCmd.Execute;
      finally
        lCmd.Free;
      end;
    end);
end;

procedure TRestUtilsTests.CreateRestConnectionInvalidIniTest;
begin
  CheckExceptionEx(procedure
    begin
      TRestUtils.CreateRestConnection(cnTestRestAllConnection, cnInvalidIni);
    end, ERestUtils, Format(StrCouldNotInitConnection, [cnTestRestAllConnection,
      Format(StrAppIniMissing, [cnInvalidIni])]));
end;

function TRestUtilsTests.CreateTestCommand(
  AConnection: TDSRestConnection): TDSRestCommand;
const
  TMembersMethods_Version: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

begin
  Result := AConnection.CreateCommand;
  Result.RequestType := 'GET';
  Result.Text := 'TMembersMethods.Version';
  Result.Prepare(TMembersMethods_Version);
end;

procedure TRestUtilsTests.InitRestConnectionPropsTest;
var
  lIni: TIniFile;
  lHost: string;
  lUrlPath: string;
  lProtocol: string;
  lContext: string;
  lUserName: string;
  lPassword: string;
  lProxyHost: string;
  lProxyUserName: string;
  lProxyPassword: string;
  lPort: Integer;
  lProxyPort: Integer;
  lConnection: TDSRestConnection;
begin
  lIni := TIniFile.Create(TRestUtils.ModuleIniFile);
  try
    lHost := lIni.ReadString(cnTestRestAllConnection, SHost, SDefaultHost);
    lUrlPath := lIni.ReadString(cnTestRestAllConnection, SUrlPath, SDefaultUrlPath);
    lProtocol := lIni.ReadString(cnTestRestAllConnection, SProtocol, SDefaultProtocol);
    lContext := lIni.ReadString(cnTestRestAllConnection, SContext, SDefaultContext);
    lUserName := lIni.ReadString(cnTestRestAllConnection, SUserName, SDefaultRestUser);
    lPassword := lIni.ReadString(cnTestRestAllConnection, SPassword, SDefaultRestPassword);
    lProxyHost := lIni.ReadString(cnTestRestAllConnection, SProxyHost, SDefaultProxyHost);
    lProxyUserName := lIni.ReadString(cnTestRestAllConnection, SProxyUserName, SDefaultProxyUser);
    lProxyPassword := lIni.ReadString(cnTestRestAllConnection, SProxyPassword, SDefaultProxyPassword);
    lPort := lIni.ReadInteger(cnTestRestAllConnection, SPort, SDefaultPort);
    lProxyPort := lIni.ReadInteger(cnTestRestAllConnection, SProxyPort, SDefaultProxyPort);

    lConnection := TDSRestConnection.Create(nil);
    try
      TRestUtils.InitRestConnectionProps(lConnection, lHost, lUrlPath, lPort, lProtocol, lContext,
        lUserName, lPassword, lProxyHost, lProxyPort, lProxyUserName, lProxyPassword);
      VerifyRestConnection(lConnection, cnTestRestAllConnection, False);

      ClearRestProps(lConnection);
      lHost := lIni.ReadString(cnTestRestWorkingConnection, SHost, SDefaultHost);
      lUrlPath := lIni.ReadString(cnTestRestWorkingConnection, SUrlPath, SDefaultUrlPath);
      lPort := lIni.ReadInteger(cnTestRestWorkingConnection, SPort, SDefaultPort);
      TRestUtils.InitRestConnectionProps(lConnection, lHost, lUrlPath, lPort);
      VerifyRestConnection(lConnection, cnTestRestWorkingConnection, False,
        procedure
        var
          lCmd: TDSRestCommand;
        begin
          lCmd := CreateTestCommand(lConnection);
          try
            lCmd.Execute;
          finally
            lCmd.Free;
          end;
        end);

    finally
      lConnection.Free;
    end;

  finally
    lIni.Free;
  end;
end;

procedure TRestUtilsTests.InitRestConnectionTest;
var
  lConnection: TDSRestConnection;
begin
  lConnection := TDSRestConnection.Create(nil);
  try
    TRestUtils.InitRestConnection(lConnection, cnTestRestAllConnection);
    VerifyRestConnection(lConnection, cnTestRestAllConnection, False);

    ClearRestProps(lConnection);
    TRestUtils.InitRestConnection(lConnection, cnTestRestAllConnection, TRestUtils.ModuleIniFile);
    VerifyRestConnection(lConnection, cnTestRestAllConnection, False);

    ClearRestProps(lConnection);
    TRestUtils.InitRestConnection(lConnection, cnTestRestWorkingConnection);
    VerifyRestConnection(lConnection, cnTestRestWorkingConnection, False, procedure
      var
        lCmd: TDSRestCommand;
      begin
        lCmd := CreateTestCommand(lConnection);
        try
          lCmd.Execute;
        finally
          lCmd.Free;
        end;
      end);
  finally
    lConnection.Free;
  end;
end;

procedure TRestUtilsTests.InitRestConnectionInvalidIniTest;
var
  lConnection: TDSRestConnection;
begin
  lConnection := TDSRestConnection.Create(nil);
  try
    CheckExceptionEx(procedure
      begin
        TRestUtils.InitRestConnection(lConnection, cnTestRestAllConnection, cnInvalidIni);
      end, ERestUtils, Format(StrCouldNotInitConnection, [cnTestRestAllConnection,
        Format(StrAppIniMissing, [cnInvalidIni])]));
  finally
    lConnection.Free;
  end;
end;

procedure TRestUtilsTests.VerifyRestConnection(AConnection: TDSRestConnection;
  AConnectionName: string; AFree: Boolean; AExtraProc: TProc);
var
  lIni: TIniFile;
begin
  try
    CheckNotNull(AConnection, 'Connection not assigned');
    lIni := TIniFile.Create(TRestUtils.ModuleIniFile);
    try
      CheckEqualsString(lIni.ReadString(AConnectionName, SHost, SDefaultHost), AConnection.Host);
      CheckEqualsString(lIni.ReadString(AConnectionName, SUrlPath, SDefaultUrlPath), AConnection.UrlPath);
      CheckEqualsString(lIni.ReadString(AConnectionName, SProtocol, SDefaultProtocol), AConnection.Protocol);
      CheckEqualsString(lIni.ReadString(AConnectionName, SContext, SDefaultContext), AConnection.Context);
      CheckEqualsString(lIni.ReadString(AConnectionName, SUserName, SDefaultRestUser), AConnection.UserName);
      CheckEqualsString(lIni.ReadString(AConnectionName, SPassword, SDefaultRestPassword), AConnection.Password);
      CheckEqualsString(lIni.ReadString(AConnectionName, SProxyHost, SDefaultProxyHost), AConnection.ProxyHost);
      CheckEqualsString(lIni.ReadString(AConnectionName, SProxyUserName, SDefaultProxyUser), AConnection.ProxyUsername);
      CheckEqualsString(lIni.ReadString(AConnectionName, SProxyPassword, SDefaultProxyPassword), AConnection.ProxyPassword);
      CheckEquals(lIni.ReadInteger(AConnectionName, SPort, SDefaultPort), AConnection.Port);
      CheckEquals(lIni.ReadInteger(AConnectionName, SProxyPort, SDefaultProxyPort), AConnection.ProxyPort);
    finally
      lIni.Free;
    end;
    if Assigned(AExtraProc) then
      AExtraProc;
  finally
    if AFree then
    begin
      AConnection.Free;
    end;
  end;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TRestUtilsTests.Suite);

end.
