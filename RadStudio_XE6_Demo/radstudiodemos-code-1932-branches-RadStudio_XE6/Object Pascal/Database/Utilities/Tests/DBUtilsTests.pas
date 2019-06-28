unit DBUtilsTests;

interface

uses
  TestFramework, TestBase, SysUtils, DBClient;

type

  TDBUtilsTests = class(TTestBase)
  private
    function CreateTestCDS: TClientDataSet;
  published
    procedure MakeParamTest;
    procedure PropNameToFieldNameTest;
    procedure FieldNameToPropNameTest;

    procedure ListFromDataSetTest;
    procedure ObjectFromDataSetTest;

    procedure TorFTest;
    procedure YorNTest;

    procedure DecodeStringTest;
    procedure AsAnsiStringTest;
    procedure AsUTF7StringTest;
    procedure AsUTF8StringTest;
    procedure AsUnicodeStringTest;
  end;

implementation

uses
  DB, DBUtils, FireDac.Comp.Client, Generics.Collections, FDUtils;

const
  cnAnsiField = 'AnsiField';
  cnUTF7Field = 'UTF7Field';
  cnUTF8Field = 'UTF8Field';
  cnUnicodeField = 'UnicodeField';

  cnAnsiString = 'Here is a string';
  cnUTF7String = '这里是一个字符串';
  cnUTF8String = 'Εδώ είναι ένα string';
  cnUnicodeString = 'Вот строки';


{ TDBUtilsTests }

procedure TDBUtilsTests.PropNameToFieldNameTest;
begin
  CheckEqualsString('FOO_BAR', TDBUtils.PropNameToFieldName('FooBar'));
  CheckEqualsString('BAR_FOO_BAR', TDBUtils.PropNameToFieldName('BarFooBar'));
  CheckEqualsString('FOO_BAR', TDBUtils.PropNameToFieldName('FooBAR'));
  CheckEqualsString('FOO_BARFOO', TDBUtils.PropNameToFieldName('FooBARFoo'));
end;

procedure TDBUtilsTests.AsAnsiStringTest;
var
  lDS: TClientDataSet;
  lStr: string;
begin
  lDS := CreateTestCDS;
  try
    lStr := TDBUtils.AsAnsiString(lDS.FieldByName(cnAnsiField));
    CheckEqualsString(cnAnsiString, lStr);
  finally
    lDS.Free;
  end;
end;

procedure TDBUtilsTests.AsUnicodeStringTest;
var
  lDS: TClientDataSet;
  lStr: string;
begin
  lDS := CreateTestCDS;
  try
    lStr := TDBUtils.AsUnicodeString(lDS.FieldByName(cnUnicodeField));
    CheckEqualsString(cnUnicodeString, lStr);
  finally
    lDS.Free;
  end;
end;

procedure TDBUtilsTests.AsUTF7StringTest;
var
  lDS: TClientDataSet;
  lStr: string;
begin
  lDS := CreateTestCDS;
  try
    lStr := TDBUtils.AsUTF7String(lDS.FieldByName(cnUTF7Field));
    CheckEqualsString(cnUTF7String, lStr);
  finally
    lDS.Free;
  end;
end;

procedure TDBUtilsTests.AsUTF8StringTest;
var
  lDS: TClientDataSet;
  lStr: string;
begin
  lDS := CreateTestCDS;
  try
    lStr := TDBUtils.AsUTF8String(lDS.FieldByName(cnUTF8Field));
    CheckEqualsString(cnUTF8String, lStr);
  finally
    lDS.Free;
  end;;
end;

function TDBUtilsTests.CreateTestCDS: TClientDataSet;
begin
  Result := TClientDataSet.Create(nil);
  Result.FieldDefs.Add(cnAnsiField, ftMemo);
  Result.FieldDefs.Add(cnUTF7Field, ftMemo);
  Result.FieldDefs.Add(cnUTF8Field, ftMemo);
  Result.FieldDefs.Add(cnUnicodeField, ftMemo);
  Result.CreateDataSet;

  Result.Insert;
  Result.FieldByName(cnAnsiField).AsBytes := TEncoding.ANSI.GetBytes(cnAnsiString);
  Result.FieldByName(cnUTF7Field).AsBytes := TEncoding.UTF7.GetBytes(cnUTF7String);
  Result.FieldByName(cnUTF8Field).AsBytes := TEncoding.UTF8.GetBytes(cnUTF8String);
  Result.FieldByName(cnUnicodeField).AsBytes := TEncoding.Unicode.GetBytes(cnUnicodeString);
  Result.Post;
  Result.First;
end;

procedure TDBUtilsTests.DecodeStringTest;
var
  lDS: TClientDataSet;
  lStr: string;
begin
  lDS := CreateTestCDS;
  try
    lStr := TDBUtils.DecodeString(lDS.FieldByName(cnUTF7Field), TEncoding.UTF7);
    CheckEqualsString(cnUTF7String, lStr);

    lStr := TDBUtils.DecodeString(lDS.FieldByName(cnUTF8Field), TEncoding.UTF8);
    CheckEqualsString(cnUTF8String, lStr);

    lStr := TDBUtils.DecodeString(lDS.FieldByName(cnUnicodeField), TEncoding.Unicode);
    CheckEqualsString(cnUnicodeString, lStr);

  finally
    lDS.Free;
  end;
end;

procedure TDBUtilsTests.FieldNameToPropNameTest;
begin
  CheckEqualsString('FOOBAR', TDBUtils.FieldNameToPropName('FOO_BAR'));
  CheckEqualsString('BARFOOBAR', TDBUtils.FieldNameToPropName('BAR_FOO_BAR'));
  CheckEqualsString('FOOBar', TDBUtils.FieldNameToPropName('FO_O_Bar'));
  CheckEqualsString('FOOBarFOO', TDBUtils.FieldNameToPropName('FOO_Bar__FOO'));
end;

procedure TDBUtilsTests.MakeParamTest;
var
  lParam: TParam;
begin
  lParam := TDBUtils.MakeParam('IntParam', ftInteger, 1);
  try
    VerifyParam(lParam, 'IntParam', ftInteger, 1, ptInput, 0, 0);
  finally
    lParam.Free;
  end;

  lParam := TDBUtils.MakeParam('FloatParam', ftFloat, 2.5, ptOutput);
  try
    VerifyParam(lParam, 'FloatParam', ftFloat, 2.5, ptOutput, 0, 0);
  finally
    lParam.Free;
  end;

  lParam := TDBUtils.MakeParam('StringParam', ftString, 'ParamVal', ptInputOutput, 10);
  try
    VerifyParam(lParam, 'StringParam', ftString, 'ParamVal', ptInputOutput, 10, 0);
  finally
    lParam.Free;
  end;

  lParam := TDBUtils.MakeParam('LongStringParam', ftString, 'ParamVal', ptInput, 3);
  try
    VerifyParam(lParam, 'LongStringParam', ftString, 'Par', ptInput, 3, 0);
  finally
    lParam.Free;
  end;

  lParam := TDBUtils.MakeParam('FloatParamWithPrecision', ftFloat, 4.2, ptInput, 10, 4);
  try
    VerifyParam(lParam, 'FloatParamWithPrecision', ftFloat, 4.2, ptInput, 10, 4);
  finally
    lParam.Free;
  end;

end;

procedure TDBUtilsTests.ObjectFromDataSetTest;
var
  lObj: TTestTable;
  lDS: TDataSet;
begin
  lDS := TFDUtils.GetQuery(ADConnection, cnSelectAll);
  try
    lObj := TDBUtils<TTestTable>.ObjectFromDataSet(lDS);
    try
      lDS.First;
      VerifyObject(lDS, lObj, True);
    finally
      lObj.Free;
    end;

    lObj := TDBUtils<TTestTable>.ObjectFromDataSet(lDS, False);
    try
      lDS.First;
      VerifyObject(lDS, lObj, False);
    finally
      lObj.Free;
    end;
  finally
    lDS.Free;
  end;
end;

procedure TDBUtilsTests.ListFromDataSetTest;
var
  lList: TObjectList<TTestTable>;
  lDS: TDataSet;
begin
  lDS := TFDUtils.GetQuery(ADConnection, cnSelectAll);
  try
    lList := TDBUtils<TTestTable>.ListFromDataSet(lDS);
    try
      VerifyList(lDS, lList, True);
    finally
      lList.Free;
    end;

    lDS.First;
    lList := TDBUtils<TTestTable>.ListFromDataSet(lDS, False);
    try
      VerifyList(lDS, lList, False);
    finally
      lList.Free;
    end;

  finally
    lDS.Free;
  end;
end;

procedure TDBUtilsTests.TorFTest;
begin
  CheckEquals('T', TDBUtils.TOrF(True));
  CheckEquals('F', TDBUtils.TOrF(False));
end;

procedure TDBUtilsTests.YorNTest;
begin
  CheckEquals('Y', TDBUtils.YOrN(True));
  CheckEquals('N', TDBUtils.YOrN(False));
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TDBUtilsTests.Suite);

end.
