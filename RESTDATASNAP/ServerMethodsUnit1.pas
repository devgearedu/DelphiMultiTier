unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth,data.db, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.BatchMove.JSON, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.DataSet,System.JSON.Writers,EMS.ResourceAPI,
  FireDAC.Stan.StorageJSON;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Dept: TFDTable;
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDBatchMoveJSONWriter1: TFDBatchMoveJSONWriter;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function GetDept:TJSONValue;
    function GetDept1:TJSONArray;
//    function GetDept2:Tjsonvalue;
    function ReverseString(Value: string): string;
  end;

implementation

{$R *.dfm}
uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetDept: TJSONValue;
var
 Writer: TJsonObjectWriter;
begin
  if dept.state = dsInactive then
     dept.Open;

  begin
     if dept.state = dsInactive then
        dept.Open;

    Writer := TJsonObjectWriter.Create;
    try
      Writer.WriteStartObject;
  // start resource;
      Writer.WritePropertyName('depts');

      Writer.WriteStartObject;
  // start item
      Writer.WritePropertyName('total');
      Writer.WriteValue(dept.RecordCount);

      Writer.WritePropertyName('dept');
      Writer.WriteStartArray;

      Dept.First;
      while not Dept.Eof do
      begin
        Writer.WriteStartObject;
        Writer.WritePropertyName('code');
        Writer.WriteValue(dept.FieldByName('code').Asstring);

        Writer.WritePropertyName('dept');
        Writer.WriteValue(dept.FieldByName('Dept').AsString);

        Writer.WritePropertyName('section');
        Writer.WriteValue(dept.FieldByName('section').AsString);

        Writer.WriteEndObject;
        dept.Next;
      end;

      Writer.WriteEndArray;

      Writer.WriteEndObject;
  // end item
      Writer.WriteEndObject;
  // end resource

      result := TJSONValue(writer.json);
    except
      Writer.Free;
      raise;
    end;
end;
end;

function TServerMethods1.GetDept1: TJSONArray;
var
 jRecord,jRecord2: TJSONObject;
 I: Integer;
begin
 if dept.state = dsInactive then
     dept.Open;

 Result := TJSonArray.Create;

 while not dept.EOF do
  begin
     jRecord := TJSONObject.Create;
     for I := 0 to Dept.FieldCount - 1 do
       jRecord.AddPair( dept.Fields[I].FieldName,TJSONString.Create (dept.Fields[I].AsString));
       Result.AddElement(jRecord);
      dept.Next;
  end;

end;

//function TServerMethods1.GetDept2: Tjsonvalue;
//var
// Stream: TMemoryStream;
// obj:tjsonObject;

//begin
//  if dept.state = dsInactive then
//     dept.Open;

//  dept.SaveToFile('sample.json',sfjson);
//  obj := tjsonobject.create;
//  result := dept.LoadFromFile('sampel.json');
//end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

