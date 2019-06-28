unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  Datasnap.Provider, FireDAC.Phys.IBBase, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.DataSet,dbxjson;

type
  TServerMethods1 = class(TDSServerModule)
    totQuery: TFDQuery;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    DeptProvider: TDataSetProvider;
    Dept: TFDTable;
    InsaQuery: TFDQuery;
    InsaQueryProviderer: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string; CallBackid:TDBXCallback): string;
    function GetCount(value:string):integer;
    [TRoleAuth('Admin')]
    function ReverseString(Value: string): string;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string;CallBackid:tdbxcallback): string;
var
  Msg:TJSONObject;
  Pair:TJSONPair;
begin
  MSG := tjsonobject.Create;
  Pair := TjsonPair.create('Echo' ,value);
  Pair.Owned := true;
  msg.AddPair(pair);
  callbackid.Execute(msg);
  Result := Value;
end;

function TServerMethods1.GetCount(value: string): integer;
begin
  totquery.Close;
  totQuery.params[0].AsString := value;
  totQuery.Open;
  result := totQuery.FieldByName('total').AsInteger;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

