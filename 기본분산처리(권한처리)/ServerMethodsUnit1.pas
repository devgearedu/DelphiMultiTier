unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Datasnap.Provider,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.UI, FireDAC.Phys.IBBase,dbxjson;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Dept: TFDTable;
    DeptProvider: TDataSetProvider;
    InsaQuery: TFDQuery;
    InsaQueryProvider: TDataSetProvider;
    tot_query: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string; CallBackid:TDBXCallback): string;
    function Get_Count(value:string):integer;
    [TroleAuth('Admin')]
    function ReverseString(Value: string): string;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string;CallBackid:TDBXCallback): string;
var
  Msg:TJSONObject;
  Pair:TJSONPair;
begin
  Msg := TJSONObject.Create;
  Pair := TJSONPair.Create('ECHO°á°ú',value);
  Pair.Owned := true;
  Msg.AddPair(Pair);
  callbackid.Execute(msg);
  Result := Value;
end;

function TServerMethods1.Get_Count(value: string): integer;
begin
 tot_query.Close;
 tot_query.ParamByName('code').AsString := value;
 tot_query.Open;
 result := tot_query.FieldByName('total').AsInteger;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

