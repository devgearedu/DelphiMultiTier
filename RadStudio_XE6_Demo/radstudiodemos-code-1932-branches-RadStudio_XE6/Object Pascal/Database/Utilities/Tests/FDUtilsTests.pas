unit FDUtilsTests;

interface

uses
  TestFramework, FireDac.Comp.Client, SysUtils, Data.DB, FireDac.Stan.Param, TestBase;

type
  TFDUtilsTests = class(TTestBase)
  private
    FDeleteConnectionDef: Boolean;
    procedure VerifyConnection(AConnection: TFDConnection; AFree: Boolean = True;
      AExtraProc: TProc = nil);
    procedure EnsureConnectionDef;
    procedure ClearProps(AConnection: TFDConnection);
    procedure VerifyParam(AParam: TFDParam; const AExpectedName: string;
      const AExpectedDataType: TFieldType; AExpectedValue: Variant;
      AExpectedParamType: TParamType; AExpectedSize: Integer); overload;
    procedure VerifyParams(AExpected, AActual: TFDParams);
  public
    procedure SetUp; override;
  published
    procedure CreateConnectionTest;
    procedure CreateConnectionInvalidSectionTest;
    procedure CreateConnectionInvalidIniTest;

    procedure CreateConnectionNameTest;
    procedure CreateConnectionNameInvalidSectionTest;

    procedure CreateConnectionPropsTest;
    procedure CreateConnectionPropsInvalidDatabaseTest;

    procedure CreateConnectionIniTest;
    procedure CreateConnectionIniInvalidSectionTest;

    procedure InitConnectionTest;
    procedure InitConnectionInvalidSectionTest;
    procedure InitConnectionInvalidIniTest;

    procedure InitConnectionNameTest;
    procedure InitConnectionNameInvalidSectionTest;

    procedure InitConnectionPropsTest;
    procedure InitConnectionPropsInvalidDatabaseTest;

    procedure CreateQueryTest;
    procedure GetQueryTest;

    procedure MakeParamListTest;
    procedure ADParamFromParamTest;

    procedure GetValueNullDefaultTest;
    procedure GetValueTest;
    procedure QueryValueNullDefaultTest;
    procedure QueryValueTest;
    procedure GetCountTest;
    procedure GetBytesTest;
    procedure GetMemoTest;

    procedure ExecNoQueryTest;
    procedure ExecProcTest;

    procedure GetParamValueTest;
    procedure CreateStoredProcTest;
  end;

const
  cnTestConnectionIni = 'FDUtilsTestIni';

implementation

uses
  FDUtils, DBUtils, FireDac.Phys.IB, FireDac.Stan.Intf, System.IniFiles, System.Classes,
  FireDac.Phys.IBWrapper, FireDac.Stan.Async, Variants;

const
  cnTestConnection = 'FDUtilsTest';
  cnInvalidConnection = 'DUnitInvalidConnection';
  cnInvalidIni = 'DUnitInvalidIni';
  cnServer = 'localhost';
  cnDatabase = 'c:\radstudiodemos\branches\RadStudio_XE5\Delphi\Database\Utilities\Tests\Data\dbutilstest.ib';
  cnDriver = 'IB';

{ TFDUtilsTests }

procedure TFDUtilsTests.ADParamFromParamTest;
var
  lParam: TParam;
  lParams: TFDParams;
  lParam2: TFDParam;
  lParam3: TFDParam;
begin
  lParam := TDBUtils.MakeParam('IntParam', ftInteger, 42);
  lParams := TFDParams.Create;
  try
    lParam2 := TFDUtils.ADParamFromParam(lParam, lParams, False);
    CheckEquals(1, lParams.Count);
    CheckSame(lParam2, lParams[0]);
    VerifyParam(lParams[0], 'IntParam', ftInteger, 42, ptInput, 0);

    lParam3 := TFDUtils.ADParamFromParam(lParam, lParams);
    CheckEquals(2, lParams.Count);
    CheckSame(lParam3, lParams[1]);
    VerifyParam(lParams[1], 'IntParam', ftInteger, 42, ptInput, 0);
  finally
    lParams.Free;
  end;
end;

procedure TFDUtilsTests.VerifyConnection(AConnection: TFDConnection;
  AFree: Boolean = True; AExtraProc: TProc = nil);
begin
  try
    CheckNotNull(AConnection, 'Connection not assigned');
    CheckTrue(AConnection.Connected, 'Connection not open');
    if Assigned(AExtraProc) then
      AExtraProc;
    AConnection.Close;
  finally
    if AFree then
    begin
      AConnection.Free;
    end;
  end;
end;

procedure TFDUtilsTests.CreateConnectionIniInvalidSectionTest;
begin
  CheckExceptionEx(procedure
    begin
      TFDUtils.CreateConnectionIni(cnInvalidConnection);
    end, EDBUtils, Format(StrInvalidSection, [cnInvalidConnection]));
end;

procedure TFDUtilsTests.CreateConnectionIniTest;
var
  lConnection: TFDConnection;
begin
  lConnection := TFDUtils.CreateConnectionIni(cnTestConnectionIni);
  VerifyConnection(lConnection);

  lConnection := TFDUtils.CreateConnectionIni(cnTestConnectionIni, TDBUtils.ModuleIniFile);
  VerifyConnection(lConnection);
end;

procedure TFDUtilsTests.CreateConnectionInvalidIniTest;
begin
  CheckExceptionEx(procedure
    begin
      TFDUtils.CreateConnection(cnTestConnectionIni, cnInvalidIni);
    end, EDBUtils, Format(StrCouldNotOpenConnection, [cnTestConnectionIni,
      Format(StrAppIniMissing, [cnInvalidIni]),
      Format(StrInvalidConnectionDefName, [cnTestConnectionIni])
      ]));
end;

procedure TFDUtilsTests.CreateConnectionInvalidSectionTest;
var
  lCon: TFDConnection;
begin
  CheckExceptionEx(procedure
    begin
      lCon := TFDUtils.CreateConnection(cnInvalidConnection);
    end, EDBUtils, Format(StrCouldNotOpenConnection, [cnInvalidConnection,
      Format(StrInvalidSection, [cnInvalidConnection]),
      Format(StrInvalidConnectionDefName, [cnInvalidConnection])
      ]));
end;

procedure TFDUtilsTests.CreateConnectionTest;
var
  lConnection: TFDConnection;
begin
  lConnection := TFDUtils.CreateConnection(cnTestConnectionIni);
  VerifyConnection(lConnection);

  lConnection := TFDUtils.CreateConnection(cnTestConnectionIni, TDBUtils.ModuleIniFile);
  VerifyConnection(lConnection);

  lConnection := TFDUtils.CreateConnection(cnTestConnection);
  VerifyConnection(lConnection, True, procedure
    begin
      CheckEqualsString(cnTestConnection, lConnection.ConnectionDefName);
    end);
end;

procedure TFDUtilsTests.SetUp;
begin
  inherited;
  EnsureConnectionDef;
end;

procedure TFDUtilsTests.EnsureConnectionDef;
var
  lIni: TIniFile;
  lDef: IFDStanConnectionDef;
begin
  if not FDManager.IsConnectionDef(cnTestConnection) then
  begin
    lIni := TIniFile.Create(TDBUtils.ModuleIniFile);
    try
      FDeleteConnectionDef := True;
      lDef := FDManager.ConnectionDefs.AddConnectionDef;
      lDef.Name := cnTestConnection;
      lDef.DriverID := SDefaultDriver;
      lDef.Server := lIni.ReadString(cnTestConnectionIni, SServer, SDefaultServer);
      lDef.Database := lIni.ReadString(cnTestConnectionIni, SDatabase, '');
      lDef.UserName := lIni.ReadString(cnTestConnectionIni, SUserName, SDefaultUser);
      lDef.Password := lIni.ReadString(cnTestConnectionIni, SPassword, SDefaultPassword);
      lDef.Apply;
    finally
      lIni.Free;
    end;
  end;
end;


procedure TFDUtilsTests.ExecNoQueryTest;
var
  lVal: Integer;
  lParams: TFDParams;
begin
  lVal := TFDUtils.GetValue(ADConnection, 'int32_field', 'test_table', -1);
  CheckEquals(cnInt32Value, lVal);

  CheckEquals(1, TFDUtils.ExecNoQuery(ADConnection, Format('update test_table set int32_field = %d', [cnInt32Value * 2])));
  lVal := TFDUtils.GetValue(ADConnection, 'int32_field', 'test_table', -1);
  CheckEquals(cnInt32Value * 2, lVal);

  lParams := TFDUtils.MakeParamList('val', ftInteger, cnInt32Value * 4);
  CheckEquals(1, TFDUtils.ExecNoQuery(ADConnection, 'update test_table set int32_field = :val',
    lParams, False));
  lVal := TFDUtils.GetValue(ADConnection, 'int32_field', 'test_table', -1);
  CheckEquals(cnInt32Value * 4, lVal);
  CheckEquals(1, TFDUtils.ExecNoQuery(ADConnection,
    'update test_table set int32_field = int32_field - :val', lParams, True));
  lVal := TFDUtils.GetValue(ADConnection, 'int32_field', 'test_table', -1);
  CheckEquals(0, lVal);

  CheckEquals(0, TFDUtils.ExecNoQuery(ADConnection, 'update test_table set int32_field = 1 where 1 = 0'));
end;

procedure TFDUtilsTests.ExecProcTest;
var
  lParams: TFDParams;
  lRetVal: Double;
begin
  TFDUtils.ExecProc(ADConnection, cnTestProcName);
  TFDUtils.ExecProc(ADConnection, cnTestProcWithParamName, TFDUtils.MakeParamList(cnParam, ftInteger, cnInt32Value));

  lParams := TFDUtils.MakeParamList(
    [TDBUtils.MakeParam(cnParam, ftInteger, cnInt32Value),
     TDBUtils.MakeParam(cnReturnValue, ftLargeInt, 0, ptOutput)]);
  try
    lRetVal := TFDUtils.ExecProc(ADConnection, cnTestProcWithReturnValue, lParams, False,
      cnReturnValue);
    CheckEquals(cnInt32Value * 2, lRetVal);
  finally
    lParams.Free;
  end;
end;

procedure TFDUtilsTests.QueryValueNullDefaultTest;
var
  lInt64: Int64;
  lInt32: Integer;
  lDouble: Double;
  lDate: TDateTime;
  lStr: string;
  lParams: TFDParams;
begin
  lStr := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectStringField, cnStringDefault, cnStringNullDefault);
  CheckEquals(cnStringValue, lStr);
  lStr := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectStringFieldNotHere, cnStringDefault, cnStringNullDefault);
  CheckEquals(cnStringDefault, lStr);
  lStr := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectStringFieldNull, cnStringDefault, cnStringNullDefault);
  CheckEquals(cnStringNullDefault, lStr);

  lInt32 := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectInt32Field, cnInt32Default, cnInt32NullDefault);
  CheckEquals(cnInt32Value, lInt32);
  lInt32 := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectInt32FieldNotHere, cnInt32Default, cnInt32NullDefault);
  CheckEquals(cnInt32Default, lInt32);
  lInt32 := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectInt32FieldNull, cnInt32Default, cnInt32NullDefault);
  CheckEquals(cnInt32NullDefault, lInt32);

  lDouble := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectDoubleField, cnDoubleDefault, cnDoubleNullDefault);
  CheckEquals(cnDoubleValue, lDouble);
  lDouble := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectDoubleFieldNotHere, cnDoubleDefault, cnDoubleNullDefault);
  CheckEquals(cnDoubleDefault, lDouble);
  lDouble := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectDoubleFieldNull, cnDoubleDefault, cnDoubleNullDefault);
  CheckEquals(cnDoubleNullDefault, lDouble);

  lDate := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectDateField, cnDateDefault, cnDateNullDefault);
  VerifyDates(DateValue, lDate);
  lDate := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectDateFieldNotHere, cnDateDefault, cnDateNullDefault);
  CheckEquals(cnDateDefault, lDate);
  lDate := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectDateFieldNull, cnDateDefault, cnDateNullDefault);
  CheckEquals(cnDateNullDefault, lDate);

  lInt64 := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectInt64Field, cnInt64Default, cnInt64NullDefault);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectInt64FieldNotHere, cnInt64Default, cnInt64NullDefault);
  CheckEquals(cnInt64Default, lInt64);
  lInt64 := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectInt64FieldNull, cnInt64Default, cnInt64NullDefault);
  CheckEquals(cnInt64NullDefault, lInt64);

  lParams := TFDUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectInt64FieldParam, cnInt64Default, cnInt64NullDefault, lParams, False);
  CheckEquals(cnInt64Value, lInt64);

  lInt64 := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectInt64FieldParamNull, cnInt64Default, cnInt64NullDefault, lParams);
  CheckEquals(cnInt64NullDefault, lInt64);

  lParams := TFDUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TFDUtils.QueryValueNullDefault(ADConnection, cnSelectInt64FieldParam, cnInt64Default, cnInt64NullDefault, lParams);
  CheckEquals(cnInt64Value, lInt64);
end;

procedure TFDUtilsTests.QueryValueTest;
var
  lInt64: Int64;
  lInt32: Integer;
  lDouble: Double;
  lDate: TDateTime;
  lStr: string;
  lParams: TFDParams;
begin
  lStr := TFDUtils.QueryValue(ADConnection, cnSelectStringField, cnStringDefault);
  CheckEquals(cnStringValue, lStr);
  lStr := TFDUtils.QueryValue(ADConnection, cnSelectStringFieldNotHere, cnStringDefault);
  CheckEquals(cnStringDefault, lStr);

  lInt32 := TFDUtils.QueryValue(ADConnection, cnSelectInt32Field, cnInt32Default);
  CheckEquals(cnInt32Value, lInt32);
  lInt32 := TFDUtils.QueryValue(ADConnection, cnSelectInt32FieldNotHere, cnInt32Default);
  CheckEquals(cnInt32Default, lInt32);

  lDouble := TFDUtils.QueryValue(ADConnection, cnSelectDoubleField, cnDoubleDefault);
  CheckEquals(cnDoubleValue, lDouble);
  lDouble := TFDUtils.QueryValue(ADConnection, cnSelectDoubleFieldNotHere, cnDoubleDefault);
  CheckEquals(cnDoubleDefault, lDouble);

  lDate := TFDUtils.QueryValue(ADConnection, cnSelectDateField, cnDateDefault);
  VerifyDates(DateValue, lDate);
  lDate := TFDUtils.QueryValue(ADConnection, cnSelectDateFieldNotHere, cnDateDefault);
  CheckEquals(cnDateDefault, lDate);

  lInt64 := TFDUtils.QueryValue(ADConnection, cnSelectInt64Field, cnInt32Default);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TFDUtils.QueryValue(ADConnection, cnSelectInt64FieldNotHere, cnInt32Default);
  CheckEquals(cnInt64Default, lInt64);

  lParams := TFDUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TFDUtils.QueryValue(ADConnection, cnSelectInt64FieldParam, cnInt64Default, lParams, False);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TFDUtils.QueryValue(ADConnection, cnSelectInt64FieldParam, cnInt64Default, lParams, True);
  CheckEquals(cnInt64Value, lInt64);

  lInt32 := TFDUtils.QueryValue(ADConnection, cnSelectInt32FieldNull, -1);
  CheckEquals(-1, lInt32);
end;

procedure TFDUtilsTests.ClearProps(AConnection: TFDConnection);
begin
  AConnection.Params.Text := '';
  AConnection.ConnectionDefName := '';
end;

procedure TFDUtilsTests.VerifyParam(AParam: TFDParam; const AExpectedName: string;
  const AExpectedDataType: TFieldType; AExpectedValue: Variant;
  AExpectedParamType: TParamType; AExpectedSize: Integer);
begin
  CheckNotNull(AParam);
  CheckEqualsString(AExpectedName, AParam.Name, 'AParam.Name');
  CheckTrue(AExpectedDataType = AParam.DataType, 'AParam.DataType');
  CheckTrue(AExpectedValue = AParam.Value, 'AParam.Value');
  CheckTrue(AExpectedParamType = AParam.ParamType, 'AParam.ParamType');
  CheckEquals(AExpectedSize, AParam.Size, 'AParam.Size');
end;

procedure TFDUtilsTests.InitConnectionInvalidIniTest;
var
  lConnection: TFDConnection;
begin
  lConnection := TFDConnection.Create(nil);
  try
    CheckExceptionEx(procedure
      begin
        TFDUtils.InitConnection(lConnection, cnTestConnectionIni, cnInvalidIni);
      end, EDBUtils, Format(StrCouldNotOpenConnection, [cnTestConnectionIni,
      Format(StrAppIniMissing, [cnInvalidIni]),
      Format(StrInvalidConnectionDefName, [cnTestConnectionIni])
      ]));
  finally
    lConnection.Free;
  end;
end;

procedure TFDUtilsTests.InitConnectionInvalidSectionTest;
var
  lConnection: TFDConnection;
begin
  lConnection := TFDConnection.Create(nil);
  try
    CheckExceptionEx(procedure
      begin
        TFDUtils.InitConnection(lConnection, cnInvalidConnection);
      end, EDBUtils, Format(StrCouldNotOpenConnection, [cnInvalidConnection,
      Format(StrInvalidSection, [cnInvalidConnection]),
      Format(StrInvalidConnectionDefName, [cnInvalidConnection])
      ]));
  finally
    lConnection.Free;
  end;
end;

procedure TFDUtilsTests.InitConnectionTest;
var
  lConnection: TFDConnection;
begin
  lConnection := TFDConnection.Create(nil);
  try
    TFDUtils.InitConnection(lConnection, cnTestConnectionIni);
    VerifyConnection(lConnection, False);

    ClearProps(lConnection);
    TFDUtils.InitConnection(lConnection, cnTestConnectionIni, TDBUtils.ModuleIniFile);
    VerifyConnection(lConnection, False);

    ClearProps(lConnection);
    TFDUtils.InitConnection(lConnection, cnTestConnection);
    VerifyConnection(lConnection, False, procedure
      begin
        CheckEqualsString(cnTestConnection, lConnection.ConnectionDefName);
      end);
  finally
    lConnection.Free;
  end;
end;

procedure TFDUtilsTests.CreateConnectionNameTest;
var
  lConnection: TFDConnection;
begin
  lConnection := TFDUtils.CreateConnectionName(cnTestConnection);
  VerifyConnection(lConnection, True, procedure
    begin
      CheckEqualsString(cnTestConnection, lConnection.ConnectionDefName);
    end);
end;

procedure TFDUtilsTests.CreateConnectionNameInvalidSectionTest;
begin
  CheckExceptionEx(procedure
    begin
      TFDUtils.CreateConnectionName(cnInvalidConnection);
    end, EDBUtils, Format(StrInvalidConnectionDefName, [cnInvalidConnection]));
end;

procedure TFDUtilsTests.InitConnectionNameTest;
var
  lConnection: TFDConnection;
begin
  lConnection := TFDConnection.Create(nil);
  try
    TFDUtils.InitConnectionName(lConnection, cnTestConnection);
    VerifyConnection(lConnection, False, procedure
      begin
        CheckEqualsString(cnTestConnection, lConnection.ConnectionDefName);
      end);
  finally
    lConnection.Free;
  end;
end;

procedure TFDUtilsTests.InitConnectionNameInvalidSectionTest;
var
  lConnection: TFDConnection;
begin
  lConnection := TFDConnection.Create(nil);
  try
    CheckExceptionEx(procedure
      begin
        TFDUtils.InitConnectionName(lConnection, cnInvalidConnection);
      end, EDBUtils, Format(StrInvalidConnectionDefName, [cnInvalidConnection]));
  finally
    lConnection.Free;
  end;
end;

procedure TFDUtilsTests.CreateConnectionPropsTest;
var
  lCon: TFDConnection;
begin
  lCon := TFDUtils.CreateConnectionProps(cnServer, cnDatabase, cnUserName, cnPassword);
  VerifyConnection(lCon);
  lCon := TFDUtils.CreateConnectionProps(cnServer, cnDatabase, cnUserName, cnPassword, cnDriver);
  VerifyConnection(lCon);
end;

procedure TFDUtilsTests.CreateConnectionPropsInvalidDatabaseTest;
begin
  CheckExceptionEx(procedure
    begin
      TFDUtils.CreateConnectionProps(cnServer, cnInvalidDatabase, cnUserName, cnPassword);
    end, EIBNativeException);
end;

procedure TFDUtilsTests.InitConnectionPropsTest;
var
  lCon: TFDConnection;
begin
  lCon := TFDConnection.Create(nil);
  try
    TFDUtils.InitConnectionProps(lCon, cnServer, cnDatabase, cnUserName, cnPassword);
    VerifyConnection(lCon, False);

    ClearProps(lCon);
    TFDUtils.InitConnectionProps(lCon, cnServer, cnDatabase, cnUserName, cnPassword, cnDriver);
    VerifyConnection(lCon, False);
  finally
    lCon.Free;
  end;
end;

procedure TFDUtilsTests.InitConnectionPropsInvalidDatabaseTest;
var
  lCon: TFDConnection;
begin
  lCon := TFDConnection.Create(nil);
  try
    CheckExceptionEx(procedure
      begin
        TFDUtils.InitConnectionProps(lCon, cnServer, cnInvalidDatabase, cnUserName, cnPassword);
      end, EIBNativeException);
  finally
    lCon.Free;
  end;
end;


procedure TFDUtilsTests.VerifyParams(AExpected, AActual: TFDParams);
var
  I: Integer;
begin
  CheckEquals(AExpected.Count, AActual.Count);
  for I := 0 to AExpected.Count -1 do
    VerifyParam(AActual[I], AExpected[I].Name, AExpected[I].DataType,
      AExpected[I].Value, AExpected[I].ParamType, AExpected[I].Size);
end;

procedure TFDUtilsTests.CreateQueryTest;
const
  cnSQL = 'select foo from bar';
var
  lRetVal: TFDQuery;
  lParams: TFDParams;

  procedure ValidateQuery(AQuery: TFDQuery; AExpectedSQL: string; AExpectedParams: TFDParams = nil; AExpectedOwner: TComponent = nil);
  begin
    CheckNotNull(AQuery);
    CheckEqualsString(AExpectedSQL, Trim(AQuery.SQL.Text));
    CheckTrue(AQuery.State = dsInactive);
    if Assigned(AExpectedParams) then
      VerifyParams(AExpectedParams, AQuery.Params);
    CheckSame(AQuery.Owner, AExpectedOwner);
  end;

begin
  lRetVal := TFDUtils.CreateQuery(ADConnection, cnSQL);
  try
    ValidateQuery(lRetVal, cnSQL);
  finally
    lRetVal.Free;
  end;

  lRetVal := TFDUtils.CreateQuery(ADConnection);
  try
    ValidateQuery(lRetVal, '');
  finally
    lRetVal.Free;
  end;

  lParams := TFDUtils.MakeParamList('StringParam', ftString, 'Fourty Two', ptInput, 42);
  try
    lRetVal := TFDUtils.CreateQuery(ADConnection, cnSQL, lParams, ADConnection);
    try
      ValidateQuery(lRetVal, cnSQL, lParams, ADConnection);
    finally
      lRetVal.Free;
    end;
  finally
    lParams.Free;
  end;
end;

procedure TFDUtilsTests.CreateStoredProcTest;
var
  lProc: TFDStoredProc;
  lParams: TFDParams;

  procedure ValidateProc(AProc: TFDStoredProc; AExpectedProcName: string; AExpectedParams: TFDParams = nil; AExpectedOwner: TComponent = nil);
  begin
    CheckNotNull(AProc);
    CheckEqualsString(AExpectedProcName, Trim(AProc.StoredProcName));
    if Assigned(AExpectedParams) then
      VerifyParams(AExpectedParams, AProc.Params);
    CheckSame(AProc.Owner, AExpectedOwner);
  end;

begin
  lProc := TFDUtils.CreateStoredProc(ADConnection, cnTestProcName);
  try
    ValidateProc(lProc, cnTestProcName);
  finally
    lProc.Free;
  end;

  lProc := TFDUtils.CreateStoredProc(ADConnection);
  try
    ValidateProc(lProc, '');
  finally
    lProc.Free;
  end;

  lProc := TFDUtils.CreateStoredProc(ADConnection, cnTestProcName);
  try
    ValidateProc(lProc, cnTestProcName);
  finally
    lProc.Free;
  end;

  lParams := TFDUtils.MakeParamList('StringParam', ftString, 'Fourty Two', ptInput, 42);
  try
    lProc := TFDUtils.CreateStoredProc(ADConnection, cnTestProcName, lParams, ADConnection);
    try
      ValidateProc(lProc, cnTestProcName, lParams, ADConnection);
    finally
      lProc.Free;
    end;
  finally
    lParams.Free;
  end;
end;

procedure TFDUtilsTests.MakeParamListTest;
var
  lParams: TFDParams;
begin
  lParams := TFDUtils.MakeParamList('IntParam', ftInteger, 1);
  try
    VerifyParam(lParams[0], 'IntParam', ftInteger, 1, ptInput, 0);
  finally
    lParams.Free;
  end;

  lParams := TFDUtils.MakeParamList('FloatParam', ftFloat, 2.5, ptOutput);
  try
    VerifyParam(lParams[0], 'FloatParam', ftFloat, 2.5, ptOutput, 0);
  finally
    lParams.Free;
  end;

  lParams := TFDUtils.MakeParamList('StringParam', ftString, 'ParamVal', ptInputOutput, 10);
  try
    VerifyParam(lParams[0], 'StringParam', ftString, 'ParamVal', ptInputOutput, 10);
  finally
    lParams.Free;
  end;

  lParams := TFDUtils.MakeParamList('LongStringParam', ftString, 'ParamVal', ptInput, 3);
  try
    VerifyParam(lParams[0], 'LongStringParam', ftString, 'Par', ptInput, 3);
  finally
    lParams.Free;
  end;

  lParams := TFDUtils.MakeParamList([TDBUtils.MakeParam('IntArrayParam', ftInteger, 42)]);
  try
    VerifyParam(lParams[0], 'IntArrayParam', ftInteger, 42, ptInput, 0);
  finally
    lParams.Free;
  end;
end;

procedure TFDUtilsTests.GetBytesTest;
var
  lRetVal: TBytes;
  lExpected: TBytes;
  i: Integer;
  lParams: TFDParams;
begin
  SetLength(lExpected, 3);
  for i := Low(lExpected) to High(lExpected) do
    lExpected[i] := i;

  lRetVal := TFDUtils.GetBytes(ADConnection, 'blob_field', 'test_table', nil);
  VerifyBytes(BlobValue, lRetVal);
  lRetVal := TFDUtils.GetBytes(ADConnection, 'blob_field', 'test_table', lExpected, '0 = 1');
  VerifyBytes(lExpected, lRetVal);

  lParams := TFDUtils.MakeParamList('val', ftInteger, 0);
  lRetVal := TFDUtils.GetBytes(ADConnection, 'blob_field', 'test_table', nil, '0 = :val',
    lParams, False);
  VerifyBytes(BlobValue, lRetVal);
  lRetVal := TFDUtils.GetBytes(ADConnection, 'blob_field', 'test_table', nil, '0 = :val',
    lParams, True);
  VerifyBytes(BlobValue, lRetVal);
end;

procedure TFDUtilsTests.GetCountTest;
begin
  CheckEquals(1, TFDUtils.GetCount(ADConnection, 'test_table',
    'string_field = :string_field',
      TFDUtils.MakeParamList('string_field', ftString, cnStringValue)));
  CheckEquals(0, TFDUtils.GetCount(ADConnection, 'test_table',
    'string_field = :string_field',
      TFDUtils.MakeParamList('string_field', ftString, cnStringValue + 'foo')));
end;

procedure TFDUtilsTests.GetMemoTest;
var
  lRetVal: string;
  lExpectedVal: string;
  lParams: TFDParams;
begin
  lRetVal := TFDUtils.GetMemo(ADConnection, 'memo_field', 'test_table', TEncoding.UTF8, 'oops');
  CheckEquals(cnMemoValue, lRetVal);
  lRetVal := TFDUtils.GetMemo(ADConnection, 'memo_field', 'test_table', TEncoding.UTF8, 'oops', '0 = 1');
  CheckEquals('oops', lRetVal);

  lRetVal := TFDUtils.GetMemo(ADConnection, 'memo_field', 'test_table', 'oops');
  CheckEquals(cnMemoValue, lRetVal);

  lExpectedVal := TEncoding.ANSI.GetString(TEncoding.UTF8.GetBytes(cnMemoValue));
  lRetVal := TFDUtils.GetMemo(ADConnection, 'memo_field', 'test_table', TEncoding.ANSI, 'oops');
  CheckEquals(lExpectedVal, lRetVal);

  lParams := TFDUtils.MakeParamList('val', ftInteger, 0);
  lRetVal := TFDUtils.GetMemo(ADConnection, 'memo_field', 'test_table',  TEncoding.UTF8,
    'oops', '0 = :val', lParams, False);
  CheckEquals(cnMemoValue, lRetVal);

  lRetVal := TFDUtils.GetMemo(ADConnection, 'memo_field', 'test_table', TEncoding.UTF8,
    'oops', '0 = :val', lParams, True);
  CheckEquals(cnMemoValue, lRetVal);
end;

procedure TFDUtilsTests.GetParamValueTest;
var
  lProc: TFDStoredProc;
  lParams: TFDParams;
begin
  lParams := TFDUtils.MakeParamList(
    [TFDUtils.MakeParam(cnParam, ftInteger, cnInt32Value),
     TFDUtils.MakeParam(cnReturnValue, ftLargeInt, 0, ptOutput)]);
  try
    lProc := TFDUtils.CreateStoredProc(ADConnection, cnTestProcWithReturnValue, lParams);
    try
      lProc.ExecProc;

      CheckEquals(cnInt32Value, TFDUtils.GetParamValue(lProc, cnParam));
      CheckEquals(cnInt32Value * 2, TFDUtils.GetParamValue(lProc, cnReturnValue));
      CheckNull(TFDUtils.GetParamValue(lProc, 'DUnitInvalidParam'));
    finally
      lProc.Free;
    end;
  finally
    lParams.Free;
  end;
end;

procedure TFDUtilsTests.GetQueryTest;
var
  lRetVal: TFDQuery;
  lParams: TFDParams;

  procedure VerifyDataSet(AIsEmpty: Boolean);
  begin
    CheckNotNull(lRetVal);
    CheckEquals(2, lRetVal.FieldCount);
    CheckTrue(lRetVal.State = dsBrowse);
    if AIsEmpty then
      CheckTrue(lRetVal.Bof and lRetVal.Eof)
    else
    begin
      //Gives an 'Operation Not Supported' exception for parameterized queries
      CheckEquals(1, lRetVal.RecordCount);
      CheckFalse(lRetVal.Eof);
      CheckEquals(cnInt32Value, lRetVal.FieldByName('int32_field').AsInteger);
      CheckEquals(cnInt64Value, lRetVal.FieldByName('int64_field').AsLargeInt);
      lRetVal.Next;
      CheckTrue(lRetVal.Eof);
    end;
  end;

begin
  lRetVal := TFDUtils.GetQuery(ADConnection, 'select int32_field, int64_field from test_table');
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lRetVal := TFDUtils.GetQuery(ADConnection, 'select int32_field, int64_field from test_table',nil, False, nil);
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lParams := TFDUtils.MakeParamList('int32_field', ftInteger, cnInt32Value);
  lRetVal := TFDUtils.GetQuery(ADConnection, 'select int32_field, int64_field from test_table where int32_field = :int32_field', lParams, False);
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lParams[0].Value := cnInt32Value + 1;
  lRetVal := TFDUtils.GetQuery(ADConnection, 'select int32_field, int64_field from test_table where int32_field = :val', lParams, True);
  try
    VerifyDataSet(True);
  finally
    lRetVal.Free;
  end;

  lRetVal := TFDUtils.GetQuery(ADConnection, 'int32_field, int64_field', 'test_table');
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lParams := TFDUtils.MakeParamList('val', ftInteger, cnInt32Value);
  lRetVal := TFDUtils.GetQuery(ADConnection, 'int32_field, int64_field', 'test_table', 'int32_field = :val', lParams, False);
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lParams[0].Value := cnInt32Value + 1;
  lRetVal := TFDUtils.GetQuery(ADConnection, 'int32_field, int64_field', 'test_table', 'int32_field = :val', lParams, True);
  try
    VerifyDataSet(True);
  finally
    lRetVal.Free;
  end;
end;

procedure TFDUtilsTests.GetValueNullDefaultTest;
var
  lInt64: Int64;
  lInt32: Integer;
  lDouble: Double;
  lDate: TDateTime;
  lStr: string;
  lParams: TFDParams;
begin
  lStr := TFDUtils.GetValueNullDefault(ADConnection, 'string_field', 'test_table', 'oops', 'oopsnull');
  CheckEquals(cnStringValue, lStr);
  lStr := TFDUtils.GetValueNullDefault(ADConnection, 'string_field', 'test_table', 'oops', 'oopsnull', '0 = 1');
  CheckEquals('oops', lStr);
  lStr := TFDUtils.GetValueNullDefault(ADConnection, 'null asstring_field', 'test_table', 'oops', 'oopsnull');
  CheckEquals('oopsnull', lStr);

  lInt32 := TFDUtils.GetValueNullDefault(ADConnection, 'int32_field', 'test_table', -1, 0);
  CheckEquals(cnInt32Value, lInt32);
  lInt32 := TFDUtils.GetValueNullDefault(ADConnection, 'int32_field', 'test_table', -1, 0, '0 = 1');
  CheckEquals(-1, lInt32);
  lInt32 := TFDUtils.GetValueNullDefault(ADConnection, 'null as int32_field', 'test_table', -1, 0);
  CheckEquals(0, lInt32);

  lDouble := TFDUtils.GetValueNullDefault(ADConnection, 'double_field', 'test_table', -1, 0);
  CheckEquals(cnDoubleValue, lDouble);
  lDouble := TFDUtils.GetValueNullDefault(ADConnection, 'double_field', 'test_table', -1, 0, '0 = 1');
  CheckEquals(-1, lDouble);
  lDouble := TFDUtils.GetValueNullDefault(ADConnection, 'null as double_field', 'test_table', -1, 0);
  CheckEquals(0, lDouble);

  lDate := TFDUtils.GetValueNullDefault(ADConnection, 'date_field', 'test_table', 0, 1);
  VerifyDates(DateValue, lDate);
  lDate := TFDUtils.GetValueNullDefault(ADConnection, 'date_field', 'test_table', 0, 1, '0 = 1');
  CheckEquals(0, lDate);
  lDate := TFDUtils.GetValueNullDefault(ADConnection, 'null as date_field', 'test_table', 0, 1);
  CheckEquals(1, lDate);

  lInt64 := TFDUtils.GetValueNullDefault(ADConnection, 'int64_field', 'test_table', -1, 0);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TFDUtils.GetValueNullDefault(ADConnection, 'int64_field', 'test_table', -1, 0, '0 = 1');
  CheckEquals(-1, lInt64);
  lInt64 := TFDUtils.GetValueNullDefault(ADConnection, 'null as int64_field', 'test_table', -1, 0);
  CheckEquals(0, lInt64);

  lParams := TFDUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TFDUtils.GetValueNullDefault(ADConnection, 'int64_field', 'test_table', -1, 0,
    'int64_field = :val', lParams, False);
  CheckEquals(cnInt64Value, lInt64);
  lParams[0].Value := cnInt64Value;
  lInt64 := TFDUtils.GetValueNullDefault(ADConnection, 'null as nt64_field', 'test_table', -1, 0,
    'int64_field = :val', lParams, False);
  CheckEquals(0, lInt64);
  lInt64 := TFDUtils.GetValueNullDefault(ADConnection, 'int64_field', 'test_table', -1, 0,
    'int64_field = :val', lParams);
  CheckEquals(cnInt64Value, lInt64);
end;

procedure TFDUtilsTests.GetValueTest;
var
  lInt64: Int64;
  lInt32: Integer;
  lDouble: Double;
  lDate: TDateTime;
  lStr: string;
  lParams: TFDParams;
begin
  lStr := TFDUtils.GetValue(ADConnection, 'string_field', 'test_table', 'oops');
  CheckEquals(cnStringValue, lStr);
  lStr := TFDUtils.GetValue(ADConnection, 'string_field', 'test_table', 'oops', '0 = 1');
  CheckEquals('oops', lStr);

  lInt32 := TFDUtils.GetValue(ADConnection, 'int32_field', 'test_table', -1);
  CheckEquals(cnInt32Value, lInt32);
  lInt32 := TFDUtils.GetValue(ADConnection, 'int32_field', 'test_table', -1, '0 = 1');
  CheckEquals(-1, lInt32);

  lDouble := TFDUtils.GetValue(ADConnection, 'double_field', 'test_table', -1);
  CheckEquals(cnDoubleValue, lDouble);
  lDouble := TFDUtils.GetValue(ADConnection, 'double_field', 'test_table', -1, '0 = 1');
  CheckEquals(-1, lDouble);

  lDate := TFDUtils.GetValue(ADConnection, 'date_field', 'test_table', 0);
  VerifyDates(DateValue, lDate);
  lDate := TFDUtils.GetValue(ADConnection, 'date_field', 'test_table', 0, '0 = 1');
  CheckEquals(0, lDate);

  lInt64 := TFDUtils.GetValue(ADConnection, 'int64_field', 'test_table', -1);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TFDUtils.GetValue(ADConnection, 'int64_field', 'test_table', -1, '0 = 1');
  CheckEquals(-1, lInt64);

  lParams := TFDUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TFDUtils.GetValue(ADConnection, 'int64_field', 'test_table', -1,
    'int64_field = :val', lParams, False);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TFDUtils.GetValue(ADConnection, 'int64_field', 'test_table', -1,
    'int64_field = :val', lParams, True);
  CheckEquals(cnInt64Value, lInt64);

  lInt32 := TFDUtils.GetValue(ADConnection, 'null as int32_field', 'test_table', -1);
  CheckEquals(-1, lInt32);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TFDUtilsTests.Suite);

end.
