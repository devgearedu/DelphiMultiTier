unit umain_client_restconnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Datasnap.DSClientRest, Data.FireDACJSONReflect,
  Vcl.ComCtrls, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FireDAC.Stan.StorageJSON, Vcl.Grids,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,SYSTEM.jSON,
  FireDAC.Stan.StorageBin, Vcl.DBGrids, FireDAC.DApt;

type
  TForm18 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Dept: TFDMemTable;
    Insa: TFDMemTable;
    Button4: TButton;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    DeptSorce: TDataSource;
    InsaSource: TDataSource;
    DBGrid2: TDBGrid;
    DBGrid1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DeptSorceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    procedure GetInsa(const code: string);
    procedure GetDepts;
    procedure UpdateDept(const ADataSetList: TFDJSONDataSets);
    procedure UpdateInsa(ADataSetList: TFDJSONDataSets);
    procedure ApplyUpdates;
    function  GetDeltas: TFDJSONDeltas;
    { Public declarations }
  end;

var
  Form18: TForm18;

implementation

uses UDM;
const
  sDept = 'Dept';
  sInsa = 'Insa';
{$R *.dfm}

procedure HandleRESTException(const AConnection: TDSRestConnection; const APrefix: string; const E: TDSRestProtocolException);
var
  LJSONValue: TJSONValue;
  LMessage: string;
  LPair: TJSONPair;
begin
  LJSONValue := TJSONObject.ParseJSONValue(BytesOf(E.ResponseText), 0);
  try
    if LJSONValue is TJSONObject then
    begin
      LPair := TJSONObject(LJSONValue).Get(0);
      if LPair.JsonString.Value = 'SessionExpired' then
        // Clear session id because it is no good
        AConnection.SessionID := '';
      // Extract error message
      LMessage := LPair.JSONValue.Value;
    end
    else
      LMessage :=  E.ResponseText;
  finally
    LJSONValue.Free;
  end;
  ShowMessageFmt('%s: %s', [APrefix, LMessage]);
end;

procedure TForm18.ApplyUpdates;
 var
  LDeltaList: TFDJSONDeltas;
begin
  LDeltaList := GetDeltas;
  try
    // Call server method.  Pass the delta list.
    dm.ServerMethods1Client.ApplyChangesDeptInsa(LDeltaList);
  except
    on E: TDSRestProtocolException do
      HandleRestException(dm.DSRestConnection1, 'Apply Updates error', E)
    else
      raise;
  end;
end;

procedure TForm18.Button1Click(Sender: TObject);
begin
   GetDepts;
end;

procedure TForm18.Button2Click(Sender: TObject);
begin
  ApplyUpdates;
end;

procedure TForm18.Button3Click(Sender: TObject);
var
  Code: string;
begin
  if dept.active then
  begin
    // Show department/employee details
    Code := Dept.fieldbyname('code').AsString;
    GetInsa(Code);
  end;

end;

procedure TForm18.Button4Click(Sender: TObject);
begin
  dm.DSRestConnection1.SessionID := '';
end;


procedure TForm18.DeptSorceDataChange(Sender: TObject; Field: TField);
var
  Dept_Code: string;
begin

  Dept_Code := Dept.fieldbyname('code').AsString;
  GetInsa(Dept_Code);

end;

function TForm18.GetDeltas: TFDJSONDeltas;
BEGIN
 // Post if editing
  if dept.State in dsEditModes then
  begin
    Dept.Post;
  end;

  if Insa.State in dsEditModes then
  begin
    insa.Post;
  end;

  // Create a delta list
  Result := TFDJSONDeltas.Create;
  // Add deltas
  TFDJSONDeltasWriter.ListAdd(Result, sinsa, Insa);
  TFDJSONDeltasWriter.ListAdd(Result, sDept, Dept);

end;

procedure TForm18.GetDepts;
var
  LDataSetList: TFDJSONDataSets;
begin
  try
    // Get dataset list containing department names
    LDataSetList := dm.ServerMethods1Client.GetDepts;

    // Update UI
    Updatedept(LDataSetList);
  except
    on E: TDSRestProtocolException do
      HandleRestException(dm.DSRestConnection1, 'Get Departments error', E)
    else
      raise;
  end;
end;

procedure TForm18.GetInsa(const code: string);
var
  LDataSetList: TFDJSONDataSets;
begin
  try
    // Call server method to get a dataset list
    LDataSetList := dm.ServerMethods1Client.GetInsas(code);
    // Update UI
    UpdateInsa(LDataSetList);
  except
    on E: TDSRestProtocolException do
      HandleRestException(dm.DSRestConnection1, 'Get departments error', E)
    else
      raise;
  end;
end;

procedure TForm18.UpdateDept(const ADataSetList: TFDJSONDataSets);
begin
  Dept.Active  := False;
  Assert(TFDJSONDataSetsReader.GetListCount(ADataSetList) = 1);
  Dept.AppendData(
    TFDJSONDataSetsReader.GetListValue(ADataSetList, 0));

end;

procedure TForm18.UpdateInsa(ADataSetList: TFDJSONDataSets);
var
  LDataSet: TFDDataSet;
begin
  // Get employees dataset
  LDataSet := TFDJSONDataSetsReader.GetListValueByName(ADataSetList, sinsa);
  // Update UI
  Insa.Active  := False;
  INSA.AppendData(LDataSet);

end;

end.
