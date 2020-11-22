unit ServerMethodsUnit1;

interface

uses
  System.SysUtils, System.Classes, System.Json,DataSnap.DSProviderDataModuleAdapter,
  Datasnap.DSServer, Datasnap.DSAuth,data.db, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  EMS.ResourceAPI,
  FireDAC.Stan.StorageJSON,System.IOUtils,FireDAC.Stan.StorageBin, Data.FireDACJSONReflect,
  FireDAC.Comp.BatchMove.JSON, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.DataSet;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Dept: TFDTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    DeptQuery: TFDQuery;
    InsaQuery: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetDept:Tstream;
    function GetDepts: TFDJSONDataSets;
    function GetInsas(const code: string): TFDJSONDataSets;
    function GetDeptJSON: TJSONObject;
    function GetInsaJSON(const code: string): TJSONObject;
    procedure ApplyChangesDeptInsa(const ADeltaList: TFDJSONDeltas);
    procedure ApplyChangesDeptInsaJSON(const AJSONObject: TJSONObject);

  end;

implementation

{$R *.dfm}
uses System.StrUtils;
const
  sInsa = 'Insa';
  sDept = 'Dept';

procedure TServerMethods1.ApplyChangesDeptInsa(const ADeltaList: TFDJSONDeltas);
var
  LApply: IFDJSONDeltasApplyUpdates;
begin
  // Create the apply object
  LApply := TFDJSONDeltasApplyUpdates.Create(ADeltaList);
  // Apply the department delta
  LApply.ApplyUpdates(sDept, Dept.Command);
  if LApply.Errors.Count = 0 then
    // If no errors, apply the employee delta
    LApply.ApplyUpdates(sInsa, InsaQuery.Command);
  if LApply.Errors.Count > 0 then
    // Raise an exception if any errors.
    raise Exception.Create(LApply.Errors.Strings.Text);

end;

procedure TServerMethods1.ApplyChangesDeptInsaJSON(
  const AJSONObject: TJSONObject);
var
  LDeltas: TFDJSONDeltas;
begin
  LDeltas := TFDJSONDeltas.Create;
  TFDJSONInterceptor.JSONObjectToDataSets(AJSONObject, LDeltas);
  ApplyChangesDeptInsa(LDeltas);
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;


function TServerMethods1.GetDept: Tstream;
var
 mStream : TMemoryStream;
begin
 mStream := TMemoryStream.Create;
 Dept.Open;
 FDSchemaAdapter1.SaveToStream(mStream, TFDStorageFormat.sfJSON);
end;

function TServerMethods1.GetDeptJSON: TJSONObject;
var
  LDataSets: TFDJSONDataSets;
begin
  LDataSets := GetDepts;
  try
    Result := TJSONObject.Create;
    TFDJSONInterceptor.DataSetsToJSONObject(LDataSets, Result);
  finally
    LDataSets.Free;
  end;

end;

function TServerMethods1.GetDepts: TFDJSONDataSets;
begin
  DeptQuery.close;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, DeptQuery);
end;

function TServerMethods1.GetInsaJSON(const code: string): TJSONObject;
  var
  LDataSets: TFDJSONDataSets;
begin
  LDataSets := GetInsas(Code);
  try
    Result := TJSONObject.Create;
    TFDJSONInterceptor.DataSetsToJSONObject(LDataSets, Result)
  finally
    LDataSets.Free;
  end;
end;

function TServerMethods1.GetInsas(const code: string): TFDJSONDataSets;
begin
  insaQuery.close;
  insaQuery.Params[0].Value := code;
  // Create dataset list
  Result := TFDJSONDataSets.Create;
  // Add departments dataset
  TFDJSONDataSetsWriter.ListAdd(Result, sInsa,InsaQuery);
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

