unit TestBase;

interface

uses
  TestFramework, Data.DB, System.SysUtils, FireDac.Comp.Client, Generics.Collections;

type

  TTestTable = class
  private
    FInt64Field: Int64;
    FDecimalField: Double;
    FSingleField: Single;
    FStringField: string;
    FMemoField: string;
    FID: Integer;
    FDoubleField: Double;
    FInt32Field: Integer;
    FTestTableID: Integer;
    FDateField: TDateTime;
  public
    property ID: Integer read FID write FID;
    property TestTableID: Integer read FTestTableID write FTestTableID;
    property StringField: string read FStringField write FStringField;
    property Int32Field: Integer read FInt32Field write FInt32Field;
    property DoubleField: Double read FDoubleField write FDoubleField;
    property MemoField: string read FMemoField write FMemoField;
    property DecimalField: Double read FDecimalField write FDecimalField;
    property Int64Field: Int64 read FInt64Field write FInt64Field;
    property SingleField: Single read FSingleField write FSingleField;
    property DateField: TDateTime read FDateField write FDateField;
  end;

  TTestBase = class(TTestCase)
  private
    FAnonMethod: TProc;
    FADConnection: TFDConnection;
    FDateValue: TDateTime;
    FBlobValue: TBytes;
    procedure CallAnonMethod;
    procedure PopulateTestTable;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  protected
    procedure VerifyParam(AParam: TParam; const AExpectedName: string;
      const AExpectedDataType: TFieldType; AExpectedValue: Variant;
      AExpectedParamType: TParamType; AExpectedSize, AExpectedPrecision: Integer);
    procedure VerifyList(ADataSet: TDataSet; AList: TObjectList<TTestTable>;
      ASmartID: Boolean);
    procedure VerifyObject(ADataSet: TDataSet; AObject: TTestTable;
      ASmartID: Boolean);
    procedure VerifyBytes(const AExpected, AActual: TBytes);
    procedure VerifyDates(const AExpected, AActual: TDateTime);

    procedure CheckExceptionEx(AProc: TProc;
      AExceptionClass: TClass; AExceptionText: string = ''; AMsg: string = ''); overload;
    procedure CheckExceptionEx(AMethod: TTestMethod; AExceptionClass: TClass;
      AExceptionText: string = ''; AMsg: string = ''); overload;

    property DateValue: TDateTime read FDateValue;
    property BlobValue: TBytes read FBlobValue;
    property ADConnection: TFDConnection read FADConnection;
  end;

const
  cnInvalidConnection = 'DUnitInvalidConnection';
  cnInvalidIni = 'DUnitInvalidIni';
  cnUserName = 'sysdba';
  cnPassword = 'masterkey';
  cnInvalidDatabase = 'DUnitInvalidDatabase';
  cnInvalidDriver = 'DUnitInvalidDriver';

  cnIDValue = 6;
  cnStringValue = 'Test';
  cnDecimalValue = 1.23456;
  cnDoubleValue = 1.5;
  cnSingleValue = 0.75;
  cnInt32Value = 42;
  cnInt64Value = MaxLongInt;
  cnMemoValue = '备注测试';

  cnTestProcName = 'TEST_PROC';
  cnTestProcWithParamName = 'TEST_PROC_WITH_PARAM';
  cnTestProcWithReturnValue = 'TEST_PROC_WITH_RETURN_VALUE';
  cnParam = 'PARAM';
  cnReturnValue = 'RETURN_VALUE';

  cnSelectAll = 'SELECT * FROM TEST_TABLE';

  cnSelectStringField = 'select string_field from test_table';
  cnWhereNotHere = ' where 0 = 1';
  cnSelectStringFieldNotHere = cnSelectStringField + cnWhereNotHere;
  cnSelectStringFieldNull = 'select null as string_field from test_table';
  cnStringDefault = 'oops';
  cnStringNullDefault = 'oopsnull';

  cnSelectInt32Field = 'select int32_field from test_table';
  cnSelectInt32FieldNotHere = cnSelectInt32Field + cnWhereNotHere;
  cnSelectInt32FieldNull = 'select null as int32_field from test_table';
  cnInt32Default = -1;
  cnInt32NullDefault = 0;

  cnSelectInt64Field = 'select int64_field from test_table';
  cnSelectInt64FieldNotHere = cnSelectInt64Field + cnWhereNotHere;
  cnSelectInt64FieldNull =  'select null as int64_field from test_table';
  cnSelectInt64FieldParam = cnSelectInt64Field + ' where int64_field = :val';
  cnSelectInt64FieldParamNull = cnSelectInt64FieldNull + ' where int64_field = :val';
  cnInt64Default = -1;
  cnInt64NullDefault = 0;

  cnSelectDoubleField = 'select double_field from test_table';
  cnSelectDoubleFieldNotHere = cnSelectDoubleField + cnWhereNotHere;
  cnSelectDoubleFieldNull = 'select null as double_field from test_table';
  cnDoubleDefault = -1;
  cnDoubleNullDefault = 0;

  cnSelectDateField = 'select date_field from test_table';
  cnSelectDateFieldNotHere = cnSelectDateField + cnWhereNotHere;
  cnSelectDateFieldNull = 'select null as date_field from test_table';
  cnDateDefault = 0;
  cnDateNullDefault = 1;

resourcestring
  sExceptionNothing = 'nothing';

implementation

uses
  FDUtils, FDUtilsTests;

procedure TTestBase.VerifyParam(AParam: TParam; const AExpectedName: string;
  const AExpectedDataType: TFieldType; AExpectedValue: Variant;
  AExpectedParamType: TParamType; AExpectedSize, AExpectedPrecision: Integer);
begin
  CheckNotNull(AParam);
  CheckEqualsString(AExpectedName, AParam.Name, 'AParam.Name');
  CheckTrue(AExpectedDataType = AParam.DataType, 'AParam.DataType');
  CheckTrue(AExpectedValue = AParam.Value, 'AParam.Value');
  CheckTrue(AExpectedParamType = AParam.ParamType, 'AParam.ParamType');
  CheckEquals(AExpectedSize, AParam.Size, 'AParam.Size');
  CheckEquals(AExpectedPrecision, AParam.Precision, 'AParam.Precision');
end;

procedure TTestBase.CheckExceptionEx(AProc: TProc;
  AExceptionClass: TClass; AExceptionText: string = ''; AMsg: string = '');
begin
  FAnonMethod := AProc;
  CheckExceptionEx(CallAnonMethod, AExceptionClass, AExceptionText, AMsg);
end;

procedure TTestBase.CallAnonMethod;
begin
  FAnonMethod;
end;

procedure TTestBase.CheckExceptionEx(AMethod: TTestMethod;
  AExceptionClass: TClass; AExceptionText: string = ''; AMsg: string = '');
begin
  FCheckCalled := True;
  try
    Invoke(AMethod);
  except
    on e :Exception do
    begin
      if  not Assigned(AExceptionClass) then
        raise
      else if not e.ClassType.InheritsFrom(AExceptionClass) then
        FailNotEquals(AExceptionClass.ClassName, e.ClassName, AMsg, ReturnAddress)
      else if (AExceptionText <> '') and (AExceptionText <> e.Message) then
        FailNotEquals(AExceptionText, e.Message, AMsg, ReturnAddress)
      else
        AExceptionClass := nil;
    end;
  end;
  if Assigned(AExceptionClass) then
    FailNotEquals(AExceptionClass.ClassName, sExceptionNothing, AMsg, ReturnAddress)
end;

procedure TTestBase.PopulateTestTable;
const
  cnInsertSQL =
    'insert into test_table(test_table_id, string_field, int32_field, double_field, date_field, ' +
    'memo_field, decimal_field, int64_field, blob_field, single_field) ' +
    'values (:test_table_id, :string_field, :int32_field, :double_field, :date_field, ' +
    ':memo_field, :decimal_field, :int64_field, :blob_field, :single_field)';
  cnBlobLength = ($FFFF * 2) + 5;
var
  i: Integer;
begin
  FDateValue := Now;
  SetLength(FBlobValue, cnBlobLength);
  for i := 0 to Pred(cnBlobLength) do
    FBlobValue[i] := i;

  TFDUtils.ExecNoQuery(FADConnection, cnInsertSQL, TFDUtils.MakeParamList([
    TFDUtils.MakeParam('test_table_id', ftInteger, cnIDValue),
    TFDUtils.MakeParam('string_field', ftWideString, cnStringValue),
    TFDUtils.MakeParam('int32_field', ftInteger, cnInt32Value),
    TFDUtils.MakeParam('double_field', ftFloat, cnDoubleValue),
    TFDUtils.MakeParam('date_field', ftDateTime, FDateValue),
    TFDUtils.MakeParam('memo_field', ftBytes, TEncoding.UTF8.GetBytes(cnMemoValue)),
    TFDUtils.MakeParam('decimal_field', ftFloat, cnDecimalValue),
    TFDUtils.MakeParam('int64_field', ftLargeint, cnInt64Value),
    TFDUtils.MakeParam('blob_field', ftBlob, FBlobValue),
    TFDUtils.MakeParam('single_field', ftSingle, cnSingleValue)
  ]));
end;

procedure TTestBase.VerifyBytes(const AExpected, AActual: TBytes);
var
  i: Integer;
begin
  CheckEquals(Length(AExpected), Length(AActual), 'Length');
  for i := Low(AExpected) to High(AExpected) do
    CheckEquals(AExpected[i], AActual[i], Format('Byte %d', [i]));
end;

procedure TTestBase.VerifyDates(const AExpected, AActual: TDateTime);
var
  ExpYear, ExpMonth, ExpDay, ExpHour, ExpMin, ExpSec, ExpMsec: Word;
  ActYear, ActMonth, ActDay, ActHour, ActMin, ActSec, ActMsec: Word;
begin
  DecodeDate(AExpected, ExpYear, ExpMonth, ExpDay);
  DecodeTime(AExpected, ExpHour, ExpMin, ExpSec, ExpMsec);
  DecodeDate(AActual, ActYear, ActMonth, ActDay);
  DecodeTime(AActual, ActHour, ActMin, ActSec, ActMsec);

  CheckEquals(ExpYear, ActYear, 'Year');
  CheckEquals(ExpMonth, ActMonth, 'Month');
  CheckEquals(ExpDay, ActDay, 'Day');
  CheckEquals(ExpHour, ActHour, 'Hour');
  CheckEquals(ExpMin, ActMin, 'Min');
  CheckEquals(ExpSec, ActSec, 'Sec');
end;

procedure TTestBase.VerifyList(ADataSet: TDataSet; AList: TObjectList<TTestTable>;
  ASmartID: Boolean);
var
  lCurrent: Integer;
begin
  CheckEquals(ADataSet.RecordCount, AList.Count);
  lCurrent := 0;
  ADataSet.First;
  while not ADataSet.EOF do
  begin
    VerifyObject(ADataSet, AList[lCurrent], ASmartID);
    Inc(lCurrent);
    ADataSet.Next;
  end;
end;

procedure TTestBase.VerifyObject(ADataSet: TDataSet; AObject: TTestTable; ASmartID: Boolean);
begin
  if ASmartID then
  begin
    CheckEquals(0, AObject.TestTableID);
    CheckEquals(ADataSet.FieldByName('TEST_TABLE_ID').AsInteger, AObject.ID);
  end
  else
  begin
    CheckEquals(0, AObject.ID);
    CheckEquals(ADataSet.FieldByName('TEST_TABLE_ID').AsInteger, AObject.TestTableID);
  end;
  CheckEqualsString(ADataSet.FieldByName('STRING_FIELD').AsString, AObject.StringField);
  CheckEquals(ADataSet.FieldByName('INT32_FIELD').AsInteger, AObject.Int32Field);
  CheckEquals(ADataSet.FieldByName('DOUBLE_FIELD').AsFloat, AObject.DoubleField);
  CheckEqualsString(ADataSet.FieldByName('MEMO_FIELD').AsString, AObject.MemoField);
  CheckEquals(ADataSet.FieldByName('DECIMAL_FIELD').AsFloat, AObject.DecimalField);
  CheckEquals(ADataSet.FieldByName('INT64_FIELD').AsLargeInt, AObject.Int64Field);
  CheckEquals(ADataSet.FieldByName('SINGLE_FIELD').AsSingle, AObject.SingleField);
end;


procedure TTestBase.SetUp;
begin
  inherited;
  FADConnection := TFDUtils.CreateConnection(FDUtilsTests.cnTestConnectionIni);
  PopulateTestTable;
end;

procedure TTestBase.TearDown;
begin
  if Assigned(FADConnection) then
  begin
    FADConnection.ExecSQL('delete from test_table');
    if FADConnection.Connected then
      FADConnection.Close;
    FADConnection.Free;
  end;
 inherited;
end;

end.
