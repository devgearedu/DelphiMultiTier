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
  FireDAC.Stan.StorageJSON,System.IOUtils, FireDAC.Stan.StorageBin;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Dept: TFDTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    InsaQuery: TFDQuery;
    FDSchemaAdapter1: TFDSchemaAdapter;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function GetDept:TJSONValue;
    function GetDept1:TJSONArray;         // json 다른 방법
    function GetDept2:Tstream;            // stream 으로 구현 하는 방법
    function GetInsa(value:string):tjsonValue;
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

function TServerMethods1.GetDept2: tstream;
begin
    result := TMemoryStream.Create;
    Dept.Close;
    Dept.Close;
   try
      FDSchemaAdapter1.SaveToStream(result, TFDStorageFormat.sfJSON);
      Result.Position := 0;
   except
      raise;
   end;
end;



function TServerMethods1.GetInsa(value: string): tjsonValue;
var
 Writer: TJsonObjectWriter;
begin
    InsaQuery.Close;
    InsaQuery.Params[0].AsString := value;
    InsaQuery.Open;

    Writer := TJsonObjectWriter.Create;
    try
      Writer.WriteStartObject;
  // start resource;
      Writer.WritePropertyName('Insas');

      Writer.WriteStartObject;
  // start item
      Writer.WritePropertyName('total');
      Writer.WriteValue(InsaQuery.RecordCount);

      Writer.WritePropertyName('Insa');
      Writer.WriteStartArray;

      InsaQuery.First;
      while not InsaQuery.Eof do
      begin
        Writer.WriteStartObject;
        Writer.WritePropertyName('id');
        Writer.WriteValue(InsaQuery.FieldByName('id').Asstring);

        Writer.WritePropertyName('Name');
        Writer.WriteValue(InsaQuery.FieldByName('Name').AsString);

        Writer.WritePropertyName('Dept_Code');
        Writer.WriteValue(InsaQuery.FieldByName('Dept_Code').AsString);

        Writer.WritePropertyName('Class');
        Writer.WriteValue(InsaQuery.FieldByName('Class').AsString);

        Writer.WriteEndObject;
        InsaQuery.Next;
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

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

