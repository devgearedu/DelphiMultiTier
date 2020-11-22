unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Datasnap.Provider,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Moni.Base, FireDAC.Moni.FlatFile,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink;
    Dept: TFDTable;
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
    InsaQuery: TFDQuery;
    deptProvider: TDataSetProvider;
    InsaProvider: TDataSetProvider;
    InsaQueryProvider: TDataSetProvider;
    FDStoredProc1: TFDStoredProc;
    Tot_Query: TFDQuery;
    DeptQuery: TFDQuery;
    DeptqueryProvider: TDataSetProvider;
    FDQuery1: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Insert_Dept(code, dept,section:string):integer;
    function Get_Count(code:string):integer;
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

function TServerMethods1.Get_Count(code: string): integer;
begin
  Tot_Query.close;
  Tot_Query.Params[0].AsString := code;
  Tot_Query.Open;
  Result := Tot_Query.Fieldbyname('total').Asinteger;
end;

function TServerMethods1.Insert_Dept(code, dept, section: string): integer;
begin
   result := 0;
   try
     FDStoredProc1.Close;
     FDStoredProc1.params[0].asstring := code;
     FDStoredProc1.params[1].asstring := dept;
     FDStoredProc1.params[2].asstring := section;
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
