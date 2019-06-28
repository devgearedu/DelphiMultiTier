//---------------------------------------------------------------------------

// This software is Copyright (c) 2013 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DBXUtilsTests;

interface

uses
  TestFramework, DB, DBXTypedTableStorage, DBXUtils, SqlExpr, Classes, DBXCommonTable,
  SysUtils, DBXCommon, DBXMetaDataReader, DBXMetaDataWriter,
  DBXMetaDataProvider, DBClient, Generics.Collections, TestBase;

type

  TDBXUtilsTests = class(TTestBase)
  private
    FConnection: TSQLConnection;

    procedure VerifyParam(AParam: TParam; const AExpectedName: string;
      const AExpectedDataType: TFieldType; AExpectedValue: Variant;
      AExpectedParamType: TParamType; AExpectedSize: Integer);
    procedure VerifyCDS(ADataSet: TClientDataSet; AIsEmpty: Boolean);
    procedure VerifyConnection(AConnection: TSQLConnection; AFree: Boolean = True;
      AExtraProc: TProc = nil);
    procedure ClearProps(AConnection: TSQLConnection);
    procedure VerifyParams(AExpected, AActual: TParams);
    procedure VerifyDataSet(ADataSet: TSQLDataSet;
      AExpectedType: TSQLCommandType; AExpectedSQL: string;
      AExpectedParams: TParams = nil; AExpectedOwner: TComponent = nil);
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure CreateConnectionTest;
    procedure CreateConnectionInvalidSectionTest;
    procedure CreateConnectionInvalidIniTest;

    procedure InitConnectionTest;
    procedure InitConnectionInvalidSectionTest;
    procedure InitConnectionInvalidIniTest;

    procedure CreateConnectionNameTest;
    procedure CreateConnectionNameInvalidNameTest;

    procedure InitConnectionNameTest;
    procedure InitConnectionNameInvalidNameTest;

    procedure CreateConnectionIniTest;
    procedure CreateConnectionIniInvalidSectionTest;

    procedure CreateConnectionPropsTest;
    procedure CreateConnectionPropsInvalidDriverTest;
    procedure InitConnectionPropsTest;
    procedure InitConnectionPropsInvalidDriverTest;

    procedure GetValueTest;
    procedure QueryValueTest;
    procedure GetCountTest;
    procedure GetValueNullDefaultTest;
    procedure QueryValueNullDefaultTest;
    procedure GetBytesTest;
    procedure GetMemoTest;
    procedure MakeParamListTest;
    procedure ExecNoQueryTest;
    procedure ExecProcTest;
    procedure CreateDataSetTest;
    procedure CreateQueryTest;
    procedure CreateStoredProcTest;
    procedure GetDataSetTest;
    procedure GetClientDataSetTest;
    procedure DataSetToCDSTest;

    procedure ListFromSQLTest;

    procedure GetParamValueTest;
  end;

implementation

uses
  DbxInterbase, DBUtils;

const
  cnTestConnection = 'DBXUtilsTest';
  cnTestConnectionIni = 'DBXUtilsTestIni';
  cnInvalidConnection = 'DUnitInvalidConnection';
  cnDatabase = 'localhost:c:\radstudiodemos\branches\RadStudio_XE4\Delphi\Database\Utilities\Tests\Data\dbutilstest.ib';
  cnDriver = 'INTERBASE';
  cnInvalidDriver = 'ORACLE';

procedure TDBXUtilsTests.CreateConnectionIniInvalidSectionTest;
begin
  CheckExceptionEx(procedure
    begin
      TDBXUtils.CreateConnectionIni(cnInvalidConnection);
    end, EDBUtils, Format(StrInvalidSection, [cnInvalidConnection]));
end;

procedure TDBXUtilsTests.CreateConnectionIniTest;
var
  lConnection: TSQLConnection;
begin
  lConnection := TDBXUtils.CreateConnectionIni(cnTestConnectionIni);
  VerifyConnection(lConnection);

  lConnection := TDBXUtils.CreateConnectionIni(cnTestConnectionIni, TDBUtils.ModuleIniFile);
  VerifyConnection(lConnection);
end;

procedure TDBXUtilsTests.CreateConnectionNameTest;
var
  lConnection: TSQLConnection;
begin
  lConnection := TDBXUtils.CreateConnectionName(cnTestConnection);
  VerifyConnection(lConnection, True, procedure
    begin
      CheckEqualsString(cnTestConnection, lConnection.ConnectionName);
    end);
end;

procedure TDBXUtilsTests.CreateConnectionNameInvalidNameTest;
begin
  CheckExceptionEx(procedure begin
    TDBXUtils.CreateConnectionName(cnInvalidConnection);
  end, TDBXError, 'Invalid argument:  ' + cnInvalidConnection);
end;


procedure TDBXUtilsTests.InitConnectionInvalidIniTest;
var
  lConnection: TSQLConnection;
begin
  lConnection := TSQLConnection.Create(nil);
  try
    CheckExceptionEx(procedure
      begin
        TDBXUtils.InitConnection(lConnection, cnTestConnectionIni, cnInvalidIni);
      end, EDBUtils, Format(StrCouldNotOpenConnection, [cnTestConnectionIni,
        Format(StrAppIniMissing, [cnInvalidIni]), 'Invalid argument:  ' + cnTestConnectionIni]));
  finally
    lConnection.Free;
  end;
end;

procedure TDBXUtilsTests.InitConnectionInvalidSectionTest;
var
  lConnection: TSQLConnection;
begin
  lConnection := TSQLConnection.Create(nil);
  try
    CheckExceptionEx(procedure
      begin
        TDBXUtils.InitConnection(lConnection, cnInvalidConnection);
      end, EDBUtils, Format(StrCouldNotOpenConnection, [cnInvalidConnection,
      Format(StrInvalidSection, [cnInvalidConnection]),
      'Invalid argument:  ' + cnInvalidConnection]));
  finally
    lConnection.Free;
  end;
end;

procedure TDBXUtilsTests.InitConnectionNameInvalidNameTest;
var
  lConnection: TSQLConnection;
begin
  lConnection := TSQLConnection.Create(nil);
  try
    CheckExceptionEx(procedure begin
      TDBXUtils.InitConnectionName(lConnection, cnInvalidConnection);
    end, TDBXError, 'Invalid argument:  ' + cnInvalidConnection);
  finally
    lConnection.Free;
  end;
end;

procedure TDBXUtilsTests.InitConnectionNameTest;
var
  lConnection: TSQLConnection;
begin
  lConnection := TSQLConnection.Create(nil);
  try
    TDBXUtils.InitConnectionName(lConnection, cnTestConnection);
    VerifyConnection(lConnection, False, procedure
      begin
        CheckEqualsString(cnTestConnection, lConnection.ConnectionName);
      end);
  finally
    lConnection.Free;
  end;
end;

procedure TDBXUtilsTests.CreateConnectionPropsTest;
var
  lCon: TSQLConnection;
begin
  lCon := TDBXUtils.CreateConnectionProps(cnDatabase, cnUserName, cnPassword);
  VerifyConnection(lCon);
  lCon := TDBXUtils.CreateConnectionProps(cnDatabase, cnUserName, cnPassword, cnDriver);
  VerifyConnection(lCon);
end;

procedure TDBXUtilsTests.CreateConnectionPropsInvalidDriverTest;
begin
  CheckExceptionEx(procedure
    begin
      TDBXUtils.CreateConnectionProps(cnDatabase, cnUserName, cnPassword, cnInvalidDriver);
    end, TDBXError);
end;

procedure TDBXUtilsTests.InitConnectionPropsTest;
var
  lCon: TSQLConnection;
begin
  lCon := TSQLConnection.Create(nil);
  try
    TDBXUtils.InitConnectionProps(lCon, cnDatabase, cnUserName, cnPassword);
    VerifyConnection(lCon, False);

    ClearProps(lCon);
    TDBXUtils.InitConnectionProps(lCon, cnDatabase, cnUserName, cnPassword, cnDriver);
    VerifyConnection(lCon, False);
  finally
    lCon.Free;
  end;
end;

procedure TDBXUtilsTests.InitConnectionPropsInvalidDriverTest;
var
  lCon: TSQLConnection;
begin
  lCon := TSQLConnection.Create(nil);
  try
    CheckExceptionEx(procedure
      begin
        TDBXUtils.InitConnectionProps(lCon, cnDatabase, cnUserName, cnPassword, cnInvalidDriver);
      end, TDBXError);
  finally
    lCon.Free;
  end;
end;

procedure TDBXUtilsTests.VerifyConnection(AConnection: TSQLConnection;
  AFree: Boolean = True; AExtraProc: TProc = nil);
begin
  try
    CheckNotNull(AConnection, 'Connection not assigned');
    CheckTrue(AConnection.ConnectionState = csStateOpen, 'Connection not open');
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

procedure TDBXUtilsTests.CreateConnectionTest;
var
  lConnection: TSQLConnection;
begin
  lConnection := TDBXUtils.CreateConnection(cnTestConnection);
  VerifyConnection(lConnection);

  lConnection := TDBXUtils.CreateConnection(cnTestConnection, TDBXUtils.ModuleIniFile);
  VerifyConnection(lConnection);

  lConnection := TDBXUtils.CreateConnection(cnTestConnection);
  VerifyConnection(lConnection, True, procedure
    begin
      CheckEqualsString(cnTestConnection, lConnection.ConnectionName);
    end);
end;

procedure TDBXUtilsTests.CreateConnectionInvalidSectionTest;
begin
  CheckExceptionEx(procedure
    begin
      TDBXUtils.CreateConnection(cnInvalidConnection);
    end, EDBUtils, Format(StrCouldNotOpenConnection, [cnInvalidConnection,
      Format(StrInvalidSection, [cnInvalidConnection]),
      'Invalid argument:  ' + cnInvalidConnection]));
end;

procedure TDBXUtilsTests.CreateConnectionInvalidIniTest;
begin
  CheckExceptionEx(procedure
    begin
      TDBXUtils.CreateConnection(cnTestConnectionIni, cnInvalidIni);
    end, EDBUtils, Format(StrCouldNotOpenConnection, [cnTestConnectionIni,
      Format(StrAppIniMissing, [cnInvalidIni]), 'Invalid argument:  ' + cnTestConnectionIni]));
end;

procedure TDBXUtilsTests.ClearProps(AConnection: TSQLConnection);
begin
  AConnection.Params.Text := '';
  AConnection.ConnectionName := '';
end;

procedure TDBXUtilsTests.InitConnectionTest;
var
  lConnection: TSQLConnection;
begin
  lConnection := TSQLConnection.Create(nil);
  try
    TDBXUtils.InitConnection(lConnection, cnTestConnectionIni);
    VerifyConnection(lConnection, False);

    //Recreate the connection each time for this test, so we don't have to
    //clear properties to ensure we know
    ClearProps(lConnection);
    TDBXUtils.InitConnection(lConnection, cnTestConnectionIni, TDBXUtils.ModuleIniFile);
    VerifyConnection(lConnection, False);

    ClearProps(lConnection);
    TDBXUtils.InitConnection(lConnection, cnTestConnection);
    VerifyConnection(lConnection, False, procedure
      begin
        CheckEqualsString(cnTestConnection, lConnection.ConnectionName);
      end);
  finally
    lConnection.Free;
  end;
end;

procedure TDBXUtilsTests.CreateDataSetTest;
var
  lRetVal: TSQLDataSet;

  procedure VerifyDataSet(const AExpectedSQL: string; AExpectedType: TSQLCommandType);
  begin
    CheckNotNull(lRetVal);
    CheckEqualsString(AExpectedSQL, lRetVal.CommandText);
    CheckTrue(AExpectedType = lRetVal.CommandType);
    CheckTrue(lRetVal.State = dsInactive);
  end;

begin
  lRetVal := TDBXUtils.CreateDataSet(FConnection, 'select foo from bar');
  try
    VerifyDataSet('select foo from bar', ctQuery);
  finally
    lRetVal.Free;
  end;

  lRetVal := TDBXUtils.CreateDataSet(FConnection, 'some_proc', ctStoredProc);
  try
    VerifyDataSet('some_proc', ctStoredProc);
  finally
    lRetVal.Free;
  end;
end;


procedure TDBXUtilsTests.VerifyDataSet(ADataSet: TSQLDataSet; AExpectedType: TSQLCommandType;
  AExpectedSQL: string; AExpectedParams: TParams = nil; AExpectedOwner: TComponent = nil);
begin
  CheckNotNull(ADataSet);
  CheckSame(FConnection, ADataSet.SQLConnection);
  CheckEqualsString(AExpectedSQL, Trim(ADataSet.CommandText));
  CheckTrue(AExpectedType = ADataSet.CommandType);
  CheckTrue(ADataSet.State = dsInactive);
  if Assigned(AExpectedParams) then
    VerifyParams(AExpectedParams, ADataSet.Params);
  CheckSame(ADataSet.Owner, AExpectedOwner);
end;

procedure TDBXUtilsTests.VerifyParams(AExpected, AActual: TParams);
var
  I: Integer;
begin
  CheckEquals(AExpected.Count, AActual.Count);
  for I := 0 to AExpected.Count -1 do
    VerifyParam(AActual[I], AExpected[I].Name, AExpected[I].DataType,
      AExpected[I].Value, AExpected[I].ParamType, AExpected[I].Size);
end;

procedure TDBXUtilsTests.CreateQueryTest;
const
  cnSQL = 'select foo from bar';
var
  lRetVal: TSQLDataSet;
  lParams: TParams;
begin
  lRetVal := TDBXUtils.CreateQuery(FConnection, cnSQL);
  try
    VerifyDataSet(lRetVal, ctQuery, cnSQL);
  finally
    lRetVal.Free;
  end;

  lRetVal := TDBXUtils.CreateQuery(FConnection);
  try
    VerifyDataSet(lRetVal, ctQuery, '');
  finally
    lRetVal.Free;
  end;

  lParams := TDBXUtils.MakeParamList('StringParam', ftString, 'Fourty Two', ptInput, 42);
  try
    lRetVal := TDBXUtils.CreateQuery(FConnection, cnSQL, lParams, FConnection);
    try
      VerifyDataSet(lRetVal, ctQuery, cnSQL, lParams, FConnection);
    finally
      lRetVal.Free;
    end;
  finally
    lParams.Free;
  end;
end;

procedure TDBXUtilsTests.CreateStoredProcTest;
const
  cnSQL = 'test_proc';
var
  lRetVal: TSQLDataSet;
  lParams: TParams;
begin
  lRetVal := TDBXUtils.CreateStoredProc(FConnection, cnSQL);
  try
    VerifyDataSet(lRetVal, ctStoredProc, cnSQL);
  finally
    lRetVal.Free;
  end;

  lRetVal := TDBXUtils.CreateStoredProc(FConnection);
  try
    VerifyDataSet(lRetVal, ctStoredProc, '');
  finally
    lRetVal.Free;
  end;

  lParams := TDBXUtils.MakeParamList('StringParam', ftString, 'Fourty Two', ptInput, 42);
  try
    lRetVal := TDBXUtils.CreateStoredProc(FConnection, cnSQL, lParams, FConnection);
    try
      VerifyDataSet(lRetVal, ctStoredProc, cnSQL, lParams, FConnection);
    finally
      lRetVal.Free;
    end;
  finally
    lParams.Free;
  end;
end;

procedure TDBXUtilsTests.DataSetToCDSTest;
var
  lDataSet: TSQLDataSet;
  lCDS: TClientDataSet;
  lField: TField;
begin
  lDataSet := TDBXUtils.GetDataSet(FConnection, 'select int32_field, int64_field from test_table');
  try
    lCDS := TDBXUtils.DataSetToCDS(lDataSet);
    try
      CheckNotNull(lCDS);
      CheckEquals(lDataSet.RecordCount, lCDS.RecordCount);
      CheckEquals(lDataSet.FieldCount, lCDS.FieldCount);
      lDataSet.First;
      for lField in lDataSet.Fields do
        CheckEquals(lField.AsLargeInt, lCDS.FieldByName(lField.FieldName).AsLargeInt);
    finally
      lCDS.Free;
    end;
  finally
    lDataSet.Free;
  end;
end;


procedure TDBXUtilsTests.ExecNoQueryTest;
var
  lVal: Integer;
  lParams: TParams;
begin
  lVal := TDBXUtils.GetValue(FConnection, 'int32_field', 'test_table', -1);
  CheckEquals(cnInt32Value, lVal);

  CheckEquals(TDBXUtils.ExecNoQuery(FConnection, Format('update test_table set int32_field = %d', [cnInt32Value * 2])), 1);
  lVal := TDBXUtils.GetValue(FConnection, 'int32_field', 'test_table', -1);
  CheckEquals(cnInt32Value * 2, lVal);

  lParams := TDBXUtils.MakeParamList('val', ftInteger, cnInt32Value * 4);
  CheckEquals(TDBXUtils.ExecNoQuery(FConnection, 'update test_table set int32_field = :val',
    lParams, False), 1);
  lVal := TDBXUtils.GetValue(FConnection, 'int32_field', 'test_table', -1);
  CheckEquals(cnInt32Value * 4, lVal);
  CheckEquals(TDBXUtils.ExecNoQuery(FConnection,
    'update test_table set int32_field = int32_field - :val', lParams, True), 1);
  lVal := TDBXUtils.GetValue(FConnection, 'int32_field', 'test_table', -1);
  CheckEquals(0, lVal);
end;

procedure TDBXUtilsTests.ExecProcTest;
var
  lParams: TParams;
  lRetVal: Double;
begin
  TDBXUtils.ExecProc(FConnection, 'TEST_PROC');
  TDBXUtils.ExecProc(FConnection, 'TEST_PROC_WITH_PARAM', TDBXUtils.MakeParamList('PARAM', ftInteger, cnInt32Value));

  lParams := TDBXUtils.MakeParamList(
    [TDBXUtils.MakeParam('PARAM', ftInteger, cnInt32Value),
     TDBXUtils.MakeParam('RETURN_VALUE', ftLargeInt, 0, ptOutput)]);
  try
    lRetVal := TDBXUtils.ExecProc(FConnection, 'TEST_PROC_WITH_RETURN_VALUE', lParams, False,
      'RETURN_VALUE', False);
    CheckEquals(cnInt32Value * 2, lRetVal);
  finally
    lParams.Free;
  end;
end;

procedure TDBXUtilsTests.GetBytesTest;
var
  lRetVal: TBytes;
  lExpected: TBytes;
  i: Integer;
  lParams: TParams;
begin
  SetLength(lExpected, 3);
  for i := Low(lExpected) to High(lExpected) do
    lExpected[i] := i;

  lRetVal := TDBXUtils.GetBytes(FConnection, 'blob_field', 'test_table', nil);
  VerifyBytes(BlobValue, lRetVal);
  lRetVal := TDBXUtils.GetBytes(FConnection, 'blob_field', 'test_table', lExpected, '0 = 1');
  VerifyBytes(lExpected, lRetVal);

  lParams := TDBXUtils.MakeParamList('val', ftInteger, 0);
  lRetVal := TDBXUtils.GetBytes(FConnection, 'blob_field', 'test_table', nil, '0 = :val',
    lParams, False);
  VerifyBytes(BlobValue, lRetVal);
  lRetVal := TDBXUtils.GetBytes(FConnection, 'blob_field', 'test_table', nil, '0 = :val',
    lParams, True);
  VerifyBytes(BlobValue, lRetVal);
end;

procedure TDBXUtilsTests.VerifyCDS(ADataSet: TClientDataSet; AIsEmpty: Boolean);
begin
  CheckNotNull(ADataSet);
  CheckEquals(2, ADataSet.FieldCount);
  CheckTrue(ADataSet.State = dsBrowse);
  if AIsEmpty then
    CheckEquals(0, ADataSet.RecordCount)
  else
  begin
    CheckEquals(1, ADataSet.RecordCount);
    CheckEquals(cnInt32Value, ADataSet.FieldByName('int32_field').AsInteger);
    CheckEquals(cnInt64Value, ADataSet.FieldByName('int64_field').AsLargeInt);
    ADataSet.Next;
    CheckTrue(ADataSet.Eof);
  end;
end;

procedure TDBXUtilsTests.GetClientDataSetTest;
var
  lRetVal: TClientDataSet;
  lParams: TParams;
begin
  lRetVal := TDBXUtils.GetClientDataSet(FConnection,
    'select int32_field, int64_field from test_table');
  try
    VerifyCDS(lRetVal, False);
  finally
    lRetVal.Free;
  end;

  lRetVal := TDBXUtils.GetClientDataSet(FConnection,
    'select int32_field, int64_field from test_table', nil, True, False);
  try
    VerifyCDS(lRetVal, False);
  finally
    lRetVal.Free;
  end;

  lParams := TDBXUtils.MakeParamList('int32_field', ftInteger, cnInt32Value);
  lRetVal := TDBXUtils.GetClientDataSet(FConnection, 'select int32_field, int64_field from test_table where int32_field = :int32_field', lParams, False);
  try
    VerifyCDS(lRetVal, False);
  finally
    lRetVal.Free;
  end;

  lParams[0].Value := cnInt32Value + 1;
  lRetVal := TDBXUtils.GetClientDataSet(FConnection, 'select int32_field, int64_field from test_table where int32_field = :val', lParams, True);
  try
    VerifyCDS(lRetVal, True);
  finally
    lRetVal.Free;
  end;

  lRetVal := TDBXUtils.GetClientDataSet(FConnection, 'int32_field, int64_field', 'test_table');
  try
    VerifyCDS(lRetVal, False);
  finally
    lRetVal.Free;
  end;

  lParams := TDBXUtils.MakeParamList('val', ftInteger, cnInt32Value);
  lRetVal := TDBXUtils.GetClientDataSet(FConnection, 'int32_field, int64_field', 'test_table', 'int32_field = :val', lParams, False);
  try
    VerifyCDS(lRetVal, False);
  finally
    lRetVal.Free;
  end;

  lParams[0].Value := cnInt32Value + 1;
  lRetVal := TDBXUtils.GetClientDataSet(FConnection, 'int32_field, int64_field', 'test_table', 'int32_field = :val', lParams, True);
  try
    VerifyCDS(lRetVal, True);
  finally
    lRetVal.Free;
  end;
end;

procedure TDBXUtilsTests.GetCountTest;
begin
  CheckEquals(1, TDBXUtils.GetCount(FConnection, 'test_table',
    'string_field = :string_field',
      TDBXUtils.MakeParamList('string_field', ftString, cnStringValue)));
  CheckEquals(0, TDBXUtils.GetCount(FConnection, 'test_table',
    'string_field = :string_field',
      TDBXUtils.MakeParamList('string_field', ftString, cnStringValue + 'foo')));
end;

procedure TDBXUtilsTests.GetDataSetTest;
var
  lRetVal: TSQLDataSet;
  lParams: TParams;

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
      //CheckEquals(1, lRetVal.RecordCount);
      CheckFalse(lRetVal.Eof);
      CheckEquals(cnInt32Value, lRetVal.FieldByName('int32_field').AsInteger);
      CheckEquals(cnInt64Value, lRetVal.FieldByName('int64_field').AsLargeInt);
      lRetVal.Next;
      CheckTrue(lRetVal.Eof);
    end;
  end;

begin
  lRetVal := TDBXUtils.GetDataSet(FConnection, 'select int32_field, int64_field from test_table');
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lRetVal := TDBXUtils.GetDataSet(FConnection, 'select int32_field, int64_field from test_table',nil, False, nil, False);
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lParams := TDBXUtils.MakeParamList('int32_field', ftInteger, cnInt32Value);
  lRetVal := TDBXUtils.GetDataSet(FConnection, 'select int32_field, int64_field from test_table where int32_field = :int32_field', lParams, False);
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lParams[0].Value := cnInt32Value + 1;
  lRetVal := TDBXUtils.GetDataSet(FConnection, 'select int32_field, int64_field from test_table where int32_field = :val', lParams, True);
  try
    VerifyDataSet(True);
  finally
    lRetVal.Free;
  end;

  lRetVal := TDBXUtils.GetDataSet(FConnection, 'int32_field, int64_field', 'test_table');
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lParams := TDBXUtils.MakeParamList('val', ftInteger, cnInt32Value);
  lRetVal := TDBXUtils.GetDataSet(FConnection, 'int32_field, int64_field', 'test_table', 'int32_field = :val', lParams, False);
  try
    VerifyDataSet(False);
  finally
    lRetVal.Free;
  end;

  lParams[0].Value := cnInt32Value + 1;
  lRetVal := TDBXUtils.GetDataSet(FConnection, 'int32_field, int64_field', 'test_table', 'int32_field = :val', lParams, True);
  try
    VerifyDataSet(True);
  finally
    lRetVal.Free;
  end;
end;

procedure TDBXUtilsTests.GetMemoTest;
var
  lRetVal: string;
  lParams: TParams;
  lExpectedVal: string;
begin
  lRetVal := TDBXUtils.GetMemo(FConnection, 'memo_field', 'test_table', TEncoding.UTF8,
    'oops');
  CheckEquals(cnMemoValue, lRetVal);
  lRetVal := TDBXUtils.GetMemo(FConnection, 'memo_field', 'test_table', TEncoding.UTF8,
    'oops', '0 = 1');
  CheckEquals('oops', lRetVal);

  lRetVal := TDBXUtils.GetMemo(FConnection, 'memo_field', 'test_table', 'oops');
  CheckEquals(cnMemoValue, lRetVal);
  lExpectedVal := TEncoding.ANSI.GetString(TEncoding.UTF8.GetBytes(cnMemoValue));
  lRetVal := TDBXUtils.GetMemo(FConnection, 'memo_field', 'test_table', TEncoding.ANSI, 'oops');
  CheckEquals(lExpectedVal, lRetVal);

  lParams := TDBXUtils.MakeParamList('val', ftInteger, 0);
  lRetVal := TDBXUtils.GetMemo(FConnection, 'memo_field', 'test_table', TEncoding.UTF8,
    'oops', '0 = :val', lParams, False);
  CheckEquals(cnMemoValue, lRetVal);

  lRetVal := TDBXUtils.GetMemo(FConnection, 'memo_field', 'test_table',
    TEncoding.UTF8, 'oops', '0 = :val', lParams, True);
  CheckEquals(cnMemoValue, lRetVal);
end;

procedure TDBXUtilsTests.GetParamValueTest;
var
  lProc: TSQLDataSet;
  lParams: TParams;
begin
  lParams := TDBXUtils.MakeParamList(
    [TDBXUtils.MakeParam(cnParam, ftInteger, cnInt32Value),
     TDBXUtils.MakeParam(cnReturnValue, ftLargeInt, 0, ptOutput)]);
  try
    lProc := TDBXUtils.CreateStoredProc(FConnection, cnTestProcWithReturnValue, lParams, nil, False);
    try
      lProc.ExecSQL;

      CheckEquals(cnInt32Value, TDBXUtils.GetParamValue(lProc, cnParam));
      CheckEquals(cnInt32Value * 2, TDBXUtils.GetParamValue(lProc, cnReturnValue));
      CheckNull(TDBXUtils.GetParamValue(lProc, 'DUnitInvalidParam'));
    finally
      lProc.Free;
    end;
  finally
    lParams.Free;
  end;
end;

procedure TDBXUtilsTests.GetValueNullDefaultTest;
var
  lInt64: Int64;
  lInt32: Integer;
  lDouble: Double;
  lDate: TDateTime;
  lStr: string;
  lParams: TParams;
begin
  lStr := TDBXUtils.GetValueNullDefault(FConnection, 'string_field', 'test_table', 'oops', 'oopsnull');
  CheckEquals(cnStringValue, lStr);
  lStr := TDBXUtils.GetValueNullDefault(FConnection, 'string_field', 'test_table', 'oops', 'oopsnull', '0 = 1');
  CheckEquals('oops', lStr);
  lStr := TDBXUtils.GetValueNullDefault(FConnection, 'null asstring_field', 'test_table', 'oops', 'oopsnull');
  CheckEquals('oopsnull', lStr);

  lInt32 := TDBXUtils.GetValueNullDefault(FConnection, 'int32_field', 'test_table', -1, 0);
  CheckEquals(cnInt32Value, lInt32);
  lInt32 := TDBXUtils.GetValueNullDefault(FConnection, 'int32_field', 'test_table', -1, 0, '0 = 1');
  CheckEquals(-1, lInt32);
  lInt32 := TDBXUtils.GetValueNullDefault(FConnection, 'null as int32_field', 'test_table', -1, 0);
  CheckEquals(0, lInt32);

  lDouble := TDBXUtils.GetValueNullDefault(FConnection, 'double_field', 'test_table', -1, 0);
  CheckEquals(cnDoubleValue, lDouble);
  lDouble := TDBXUtils.GetValueNullDefault(FConnection, 'double_field', 'test_table', -1, 0, '0 = 1');
  CheckEquals(-1, lDouble);
  lDouble := TDBXUtils.GetValueNullDefault(FConnection, 'null as double_field', 'test_table', -1, 0);
  CheckEquals(0, lDouble);

  lDate := TDBXUtils.GetValueNullDefault(FConnection, 'date_field', 'test_table', 0, 1);
  VerifyDates(DateValue, lDate);
  lDate := TDBXUtils.GetValueNullDefault(FConnection, 'date_field', 'test_table', 0, 1, '0 = 1');
  CheckEquals(0, lDate);
  lDate := TDBXUtils.GetValueNullDefault(FConnection, 'null as date_field', 'test_table', 0, 1);
  CheckEquals(1, lDate);

  lInt64 := TDBXUtils.GetValueNullDefault(FConnection, 'int64_field', 'test_table', -1, 0);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TDBXUtils.GetValueNullDefault(FConnection, 'int64_field', 'test_table', -1, 0, '0 = 1');
  CheckEquals(-1, lInt64);
  lInt64 := TDBXUtils.GetValueNullDefault(FConnection, 'null as int64_field', 'test_table', -1, 0);
  CheckEquals(0, lInt64);

  lParams := TDBXUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TDBXUtils.GetValueNullDefault(FConnection, 'int64_field', 'test_table', -1, 0,
    'int64_field = :val', lParams, False);
  CheckEquals(cnInt64Value, lInt64);
//  lParams[0].Value := cnInt64Value + 1;
//  lInt64 := TDBXUtils.GetValueNullDefault(FConnection, 'null as nt64_field', 'test_table', -1, 0,
//    'int64_field = :val', lParams, False);
//  CheckEquals(-1, lInt64);
  lParams[0].Value := cnInt64Value;
  lInt64 := TDBXUtils.GetValueNullDefault(FConnection, 'null as nt64_field', 'test_table', -1, 0,
    'int64_field = :val', lParams, False);
  CheckEquals(0, lInt64);
  lInt64 := TDBXUtils.GetValueNullDefault(FConnection, 'int64_field', 'test_table', -1, 0,
    'int64_field = :val', lParams, True);
  CheckEquals(cnInt64Value, lInt64);
end;

procedure TDBXUtilsTests.GetValueTest;
var
  lInt64: Int64;
  lInt32: Integer;
  lDouble: Double;
  lDate: TDateTime;
  lStr: string;
  lParams: TParams;
begin
  lStr := TDBXUtils.GetValue(FConnection, 'string_field', 'test_table', 'oops');
  CheckEquals(cnStringValue, lStr);
  lStr := TDBXUtils.GetValue(FConnection, 'string_field', 'test_table', 'oops', '0 = 1');
  CheckEquals('oops', lStr);

  lInt32 := TDBXUtils.GetValue(FConnection, 'int32_field', 'test_table', -1);
  CheckEquals(cnInt32Value, lInt32);
  lInt32 := TDBXUtils.GetValue(FConnection, 'int32_field', 'test_table', -1, '0 = 1');
  CheckEquals(-1, lInt32);

  lDouble := TDBXUtils.GetValue(FConnection, 'double_field', 'test_table', -1);
  CheckEquals(cnDoubleValue, lDouble);
  lDouble := TDBXUtils.GetValue(FConnection, 'double_field', 'test_table', -1, '0 = 1');
  CheckEquals(-1, lDouble);

  lDate := TDBXUtils.GetValue(FConnection, 'date_field', 'test_table', 0);
  VerifyDates(DateValue, lDate);
  lDate := TDBXUtils.GetValue(FConnection, 'date_field', 'test_table', 0, '0 = 1');
  CheckEquals(0, lDate);

  lInt64 := TDBXUtils.GetValue(FConnection, 'int64_field', 'test_table', -1);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TDBXUtils.GetValue(FConnection, 'int64_field', 'test_table', -1, '0 = 1');
  CheckEquals(-1, lInt64);

  lParams := TDBXUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TDBXUtils.GetValue(FConnection, 'int64_field', 'test_table', -1,
    'int64_field = :val', lParams, False);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TDBXUtils.GetValue(FConnection, 'int64_field', 'test_table', -1,
    'int64_field = :val', lParams, True);
  CheckEquals(cnInt64Value, lInt64);

  lInt32 := TDBXUtils.GetValue(FConnection, 'null as int32_field', 'test_table', -1);
  CheckEquals(-1, lInt32);
end;

procedure TDBXUtilsTests.VerifyParam(AParam: TParam; const AExpectedName: string;
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

procedure TDBXUtilsTests.MakeParamListTest;
var
  lParams: TParams;
begin
  lParams := TDBXUtils.MakeParamList('IntParam', ftInteger, 1);
  try
    VerifyParam(lParams[0], 'IntParam', ftInteger, 1, ptInput, 0);
  finally
    lParams.Free;
  end;

  lParams := TDBXUtils.MakeParamList('FloatParam', ftFloat, 2.5, ptOutput);
  try
    VerifyParam(lParams[0], 'FloatParam', ftFloat, 2.5, ptOutput, 0);
  finally
    lParams.Free;
  end;

  lParams := TDBXUtils.MakeParamList('StringParam', ftString, 'ParamVal', ptInputOutput, 10);
  try
    VerifyParam(lParams[0], 'StringParam', ftString, 'ParamVal', ptInputOutput, 10);
  finally
    lParams.Free;
  end;

  lParams := TDBXUtils.MakeParamList('LongStringParam', ftString, 'ParamVal', ptInput, 3);
  try
    VerifyParam(lParams[0], 'LongStringParam', ftString, 'Par', ptInput, 3);
  finally
    lParams.Free;
  end;
end;

procedure TDBXUtilsTests.QueryValueNullDefaultTest;
var
  lInt64: Int64;
  lInt32: Integer;
  lDouble: Double;
  lDate: TDateTime;
  lStr: string;
  lParams: TParams;
begin
  lStr := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectStringField, cnStringDefault, cnStringNullDefault);
  CheckEquals(cnStringValue, lStr);
  lStr := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectStringFieldNotHere, cnStringDefault, cnStringNullDefault);
  CheckEquals(cnStringDefault, lStr);
  lStr := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectStringFieldNull, cnStringDefault, cnStringNullDefault);
  CheckEquals(cnStringNullDefault, lStr);

  lInt32 := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectInt32Field, cnInt32Default, cnInt32NullDefault);
  CheckEquals(cnInt32Value, lInt32);
  lInt32 := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectInt32FieldNotHere, cnInt32Default, cnInt32NullDefault);
  CheckEquals(cnInt32Default, lInt32);
  lInt32 := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectInt32FieldNull, cnInt32Default, cnInt32NullDefault);
  CheckEquals(cnInt32NullDefault, lInt32);

  lDouble := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectDoubleField, cnDoubleDefault, cnDoubleNullDefault);
  CheckEquals(cnDoubleValue, lDouble);
  lDouble := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectDoubleFieldNotHere, cnDoubleDefault, cnDoubleNullDefault);
  CheckEquals(cnDoubleDefault, lDouble);
  lDouble := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectDoubleFieldNull, cnDoubleDefault, cnDoubleNullDefault);
  CheckEquals(cnDoubleNullDefault, lDouble);

  lDate := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectDateField, cnDateDefault, cnDateNullDefault);
  VerifyDates(DateValue, lDate);
  lDate := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectDateFieldNotHere, cnDateDefault, cnDateNullDefault);
  CheckEquals(cnDateDefault, lDate);
  lDate := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectDateFieldNull, cnDateDefault, cnDateNullDefault);
  CheckEquals(cnDateNullDefault, lDate);

  lInt64 := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectInt64Field, cnInt64Default, cnInt64NullDefault);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectInt64FieldNotHere, cnInt64Default, cnInt64NullDefault);
  CheckEquals(cnInt64Default, lInt64);
  lInt64 := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectInt64FieldNull, cnInt64Default, cnInt64NullDefault);
  CheckEquals(cnInt64NullDefault, lInt64);

  lParams := TDBXUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectInt64FieldParam, cnInt64Default, cnInt64NullDefault, lParams, False);
  CheckEquals(cnInt64Value, lInt64);

  lInt64 := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectInt64FieldParamNull, cnInt64Default, cnInt64NullDefault, lParams);
  CheckEquals(cnInt64NullDefault, lInt64);

  lParams := TDBXUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TDBXUtils.QueryValueNullDefault(FConnection, cnSelectInt64FieldParam, cnInt64Default, cnInt64NullDefault, lParams);
  CheckEquals(cnInt64Value, lInt64);
end;

procedure TDBXUtilsTests.QueryValueTest;
var
  lInt64: Int64;
  lInt32: Integer;
  lDouble: Double;
  lDate: TDateTime;
  lStr: string;
  lParams: TParams;
begin
  lStr := TDBXUtils.QueryValue(FConnection, cnSelectStringField, cnStringDefault);
  CheckEquals(cnStringValue, lStr);
  lStr := TDBXUtils.QueryValue(FConnection, cnSelectStringFieldNotHere, cnStringDefault);
  CheckEquals(cnStringDefault, lStr);

  lInt32 := TDBXUtils.QueryValue(FConnection, cnSelectInt32Field, cnInt32Default);
  CheckEquals(cnInt32Value, lInt32);
  lInt32 := TDBXUtils.QueryValue(FConnection, cnSelectInt32FieldNotHere, cnInt32Default);
  CheckEquals(cnInt32Default, lInt32);

  lDouble := TDBXUtils.QueryValue(FConnection, cnSelectDoubleField, cnDoubleDefault);
  CheckEquals(cnDoubleValue, lDouble);
  lDouble := TDBXUtils.QueryValue(FConnection, cnSelectDoubleFieldNotHere, cnDoubleDefault);
  CheckEquals(cnDoubleDefault, lDouble);

  lDate := TDBXUtils.QueryValue(FConnection, cnSelectDateField, cnDateDefault);
  VerifyDates(DateValue, lDate);
  lDate := TDBXUtils.QueryValue(FConnection, cnSelectDateFieldNotHere, cnDateDefault);
  CheckEquals(cnDateDefault, lDate);

  lInt64 := TDBXUtils.QueryValue(FConnection, cnSelectInt64Field, cnInt32Default);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TDBXUtils.QueryValue(FConnection, cnSelectInt64FieldNotHere, cnInt32Default);
  CheckEquals(cnInt64Default, lInt64);

  lParams := TDBXUtils.MakeParamList('val', ftLargeint, cnInt64Value);
  lInt64 := TDBXUtils.QueryValue(FConnection, cnSelectInt64FieldParam, cnInt64Default, lParams, False);
  CheckEquals(cnInt64Value, lInt64);
  lInt64 := TDBXUtils.QueryValue(FConnection, cnSelectInt64FieldParam, cnInt64Default, lParams, True);
  CheckEquals(cnInt64Value, lInt64);

  lInt32 := TDBXUtils.QueryValue(FConnection, cnSelectInt32FieldNull, -1);
  CheckEquals(-1, lInt32);
end;

procedure TDBXUtilsTests.ListFromSQLTest;
var
  lDS: TDataSet;
  lList: TObjectList<TTestTable>;
begin
  lDS := TDBXUtils.GetClientDataSet(FConnection, cnSelectAll);
  try
    lList := TDBXUtils<TTestTable>.ListFromSQL(FConnection, cnSelectAll);
    try
      VerifyList(lDS, lList, True);
    finally
      lList.Free;
    end;

    lList := TDBXUtils<TTestTable>.ListFromSQL(FConnection, cnSelectAll, False);
    try
      VerifyList(lDS, lList, False);
    finally
      lList.Free;
    end;
  finally
    lDS.Free;
  end;
end;

procedure TDBXUtilsTests.SetUp;
begin
  inherited;
  FConnection := TDBXUtils.CreateConnection(cnTestConnectionIni);
end;

procedure TDBXUtilsTests.TearDown;
begin
  if Assigned(FConnection) then
  begin
    if FConnection.ConnectionState = csStateOpen then
      FConnection.Close;
    FConnection.Free;
  end;
  inherited;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TDBXUtilsTests.Suite);
end.

