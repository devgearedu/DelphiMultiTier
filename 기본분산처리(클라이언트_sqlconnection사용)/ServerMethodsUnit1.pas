unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, Datasnap.Provider,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Phys.IBBase,dbxjson;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    Dept: TFDTable;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    deptProvider: TDataSetProvider;
    InsaQuery: TFDQuery;
    InsaQueryProvider: TDataSetProvider;
    tot_query: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function Get_Count(value:string):integer;
    function EchoString(Value: string; callback:TDBXCallBack): string;
    function ReverseString(Value: string): string;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string; callback:TDBXCallBack): string;
var
  Msg:TJSONObject;
  Pair:TJSONPair;
begin
  Msg := TJSONObject.Create;
  Pair := TJSONPair.Create('echo', value);
  Msg.AddPair(pair);
  callback.Execute(msg);
  Result := Value;
end;

function TServerMethods1.Get_Count(value: string): integer;
begin
  tot_query.Close;
  tot_query.Params[0].AsString := value;
  tot_query.Open;
  result := tot_query.FieldByName('total').AsInteger;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

