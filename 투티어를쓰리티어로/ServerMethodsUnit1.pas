unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Datasnap.Provider, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Phys.IBBase, FireDAC.Comp.UI;

type
  TServerMethods1 = class(TDSServerModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    Insa: TFDTable;
    InsaID: TIntegerField;
    InsaNAME: TStringField;
    InsaAGE: TSmallintField;
    InsaDEPT_CODE: TStringField;
    InsaSection: TStringField;
    InsaIPSA_DATE: TDateField;
    InsaDuring: TIntegerField;
    InsaCLASS: TStringField;
    InsaSALARY: TIntegerField;
    InsaTax: TFloatField;
    InsaPHOTO: TBlobField;
    InsaGRADE: TStringField;
    Dept: TFDTable;
    InsaQuery: TFDQuery;
    DeptProvider: TDataSetProvider;
    InsaProvider: TDataSetProvider;
    InsaQueryProvider: TDataSetProvider;
    Tot_Query: TFDQuery;
    FDStoredProc1: TFDStoredProc;
    FDQuery1: TFDQuery;
    DeptQuery: TFDQuery;
    DeptQueryProvider: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetCount(value:string):integer;
    function Insert_Dept(code,dept,section:string):integer;
    function Delete_Dept(code:string):integer;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.Delete_Dept(code: string): integer;
begin
  result := 0;
  FDConnection1.StartTransaction;
  try
    try
      FDQuery1.Close;
      FDQuery1.SQL.Text := 'delete from insa where dept_code =:code';
      FDQuery1.Params[0].AsString := code;
      FDQuery1.ExecSQL;
    except
      result := 1;
      raise;
    end;
    try
      FDQuery1.Close;
      FDQuery1.SQL.Text := 'delete from dept where code =:code';
      FDQuery1.Params[0].AsString := code;
      FDQuery1.ExecSQL;
    except
      result := 2;
      raise;
    end;

   FDConnection1.Commit;
  except
   FDConnection1.Rollback;
  end;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetCount(value: string): integer;
begin
    Tot_Query.Close;
    Tot_Query.Params[0].AsString := value;
    Tot_Query.Open;
    result := Tot_Query.FieldByName('Total').Asinteger;
end;

function TServerMethods1.Insert_Dept(code, dept, section: string): integer;
begin
   result := 0;
   try
     FDStoredProc1.Close;
     FDStoredProc1.params[0].asstring := Code;
     FDStoredProc1.params[1].asstring := Dept;
     FDStoredProc1.params[2].asstring := Section;
     FDStoredProc1.ExecProc;
   except
     result := 1;
   end;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

