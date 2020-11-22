unit BookResource;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes,system.ioutils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,system.json.writers,
  FireDAC.Stan.StorageJSON;

type
  [ResourceName('books')]
  TBooksResource1 = class(TDataModule)
    ConBookRental: TFDConnection;
    qryBook: TFDQuery;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    BookQuery: TFDQuery;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDSchemaAdapter1: TFDSchemaAdapter;
    procedure ConBookRentalBeforeConnect(Sender: TObject);
  published

    [EndPointRequestSummary('Tests', 'ListItems', 'Retrieves list of items', 'application/json', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
//    procedure Get(const AContext: TendpointContext;
//              const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Tests', 'GetItem', 'Retrieves item with specified ID', 'application/json', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Tests', 'GetItem', 'Retrieves item with specified ID', 'application/json', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('{item}/photo')]
    procedure GetItemphoto(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Tests', 'PostItem', 'Creates new item', '', 'application/json')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Body, 'body', 'A new item content', true, TAPIDoc.TPrimitiveType.spObject,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spObject, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(409, 'Item Exist', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Tests', 'PutItem', 'Updates item with specified ID', '', 'application/json')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Body, 'body', 'A item changes', true, TAPIDoc.TPrimitiveType.spObject,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spObject, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('{item}')]
    procedure PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Tests', 'DeleteItem', 'Deletes item with specified ID', '', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('{item}')]
    procedure DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}


  procedure TBooksResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  const
    SQL_LIST ='SELECT BOOK_SEQ, BOOK_TITLE, BOOK_AUTHOR, BOOK_PRICE FROM BOOK';
  var
    Writer: TJsonObjectWriter;
  begin
    qryBook.Close;
    qryBook.SQL.Text := SQL_LIST;
    qryBook.Open;

    Writer := TJsonObjectWriter.Create;
    try
      Writer.WriteStartObject; // start resource
      Writer.WritePropertyName('books');
      Writer.WriteStartObject; // start item
      Writer.WritePropertyName('total');
      Writer.WriteValue(qryBook.RecordCount);

      Writer.WritePropertyName('book');
      Writer.WriteStartArray;
      qryBook.First;

      while not qryBook.Eof do
      begin
        Writer.WriteStartObject;
        Writer.WritePropertyName('BOOK_SEQ');
        Writer.WriteValue(qryBook.FieldByName('BOOK_SEQ').AsInteger);
        Writer.WritePropertyName('BOOK_TITLE');
        Writer.WriteValue(qryBook.FieldByName('BOOK_TITLE').AsString);
        Writer.WritePropertyName('BOOK_AUTHOR');
        Writer.WriteValue(qryBook.FieldByName('BOOK_AUTHOR').AsString);
        Writer.WritePropertyName('BOOK_PRICE');
        Writer.WriteValue(qryBook.FieldByName('BOOK_PRICE').AsString);
        Writer.WriteEndObject;

        qryBook.Next;
      end;

      Writer.WriteEndArray;
      Writer.WriteEndObject;  // end item
      Writer.WriteEndObject;  // end resource
      AResponse.Body.SetValue(Writer.JSON as TJSONValue, True);
    except
      Writer.Free;
      raise;
    end;
  end;


//procedure TBooksResource1.Get(const AContext: TendpointContext;
//  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
//var
// mStream : TMemoryStream;
//begin
// mStream := TMemoryStream.Create;
// bookQuery.Open;
// FDSchemaAdapter1.SaveToStream(mStream, TFDStorageFormat.sfJSON);
// AResponse.Body.SetStream(mStream, 'application/json', true);
//end;

procedure TBooksResource1.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
const
  SQL_ITEM_INFO = 'SELECT ' +
                  'BOOK_SEQ, BOOK_TITLE, BOOK_ISBN, BOOK_AUTHOR, BOOK_PRICE, ' +
                  'BOOK_LINK, BOOK_DESCRIPTION ' +
                  'FROM BOOK WHERE BOOK_SEQ = :BOOK_SEQ';

var
  BOOK_SEQ: string;
  Writer: TJsonObjectWriter;
begin
  BOOK_SEQ := ARequest.Params.Values['item'];
  // Sample code
  qryBook.Close;
  qryBook.SQL.Text := SQL_ITEM_INFO;
  qryBook.ParamByName('BOOK_SEQ').AsString := BOOK_SEQ;
  qryBook.Open;

  if qryBook.RecordCount = 0 then
     AResponse.RaiseNotFound('Not found', '''' + BOOK_SEQ + ''' is not found');

  Writer := TJsonObjectWriter.Create;
  try
    Writer.WriteStartObject;  // start resource
    Writer.WritePropertyName('book');
    Writer.WriteStartObject;  // start item
    Writer.WritePropertyName('BOOK_SEQ');
    Writer.WriteValue(qryBook.FieldByName('BOOK_SEQ').AsInteger);
    Writer.WritePropertyName('BOOK_TITLE');
    Writer.WriteValue(qryBook.FieldByName('BOOK_TITLE').AsString);
    Writer.WritePropertyName('BOOK_ISBN');
    Writer.WriteValue(qryBook.FieldByName('BOOK_ISBN').AsString);
    Writer.WritePropertyName('BOOK_AUTHOR');
    Writer.WriteValue(qryBook.FieldByName('BOOK_AUTHOR').AsString);
    Writer.WritePropertyName('BOOK_PRICE');
    Writer.WriteValue(qryBook.FieldByName('BOOK_PRICE').AsString);
    Writer.WritePropertyName('BOOK_LINK');
    Writer.WriteValue(qryBook.FieldByName('BOOK_LINK').AsString);
    Writer.WritePropertyName('BOOK_DESCRIPTION');
    Writer.WriteValue(qryBook.FieldByName('BOOK_DESCRIPTION').AsString);
    Writer.WriteEndObject;  // end item
    Writer.WriteEndObject;  // end resource

    AResponse.Body.SetValue(Writer.JSON as TJSONValue, True);
  except
    Writer.Free;
    raise;
  end;
end;

procedure TBooksResource1.GetItemphoto(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
const
  SQL_ITEM_IMAGE ='SELECT BOOK_IMAGE FROM BOOK WHERE BOOK_SEQ = :BOOK_SEQ';
var
  BOOK_SEQ: string;
  Stream: TMemoryStream;
begin
  BOOK_SEQ := ARequest.Params.Values['item'];

  Stream := TMemoryStream.Create;
  try
    qryBook.Close;
    qryBook.SQL.Text := SQL_ITEM_IMAGE;
    qryBook.ParamByName('BOOK_SEQ').AsString := BOOK_SEQ;
    qryBook.Open;

    if qryBook.RecordCount = 0 then
       AResponse.RaiseNotFound('Not found', '''' + BOOK_SEQ + ''' is not found');

    TBlobField(qryBook.FieldByName('BOOK_IMAGE')).SaveToStream(Stream);

    if Stream.Size = 0 then
      AResponse.RaiseNotFound('Not found', '''' + BOOK_SEQ + ''' is not found');

    Stream.Position := 0;
    AResponse.Body.SetStream(Stream, 'image/jpg', True);
  except
    Stream.Free;
    raise;
  end;

end;

procedure TBooksResource1.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
const
  SQL_ITEM_INSERT = 'INSERT INTO BOOK(BOOK_TITLE, BOOK_ISBN, BOOK_AUTHOR, BOOK_PRICE, BOOK_LINK, BOOK_DESCRIPTION)' +
                    '  VALUES (:BOOK_TITLE, :BOOK_ISBN, :BOOK_AUTHOR, :BOOK_PRICE, :BOOK_LINK, :BOOK_DESCRIPTION)';

var
  Title, Author, Price, ISBN, Link, Desc: string;
  Json: TJSONValue;
begin
  JSON := ARequest.Body.GetValue;

  Title := JSON.GetValue<string>('book.BOOK_TITLE');
  ISBN := JSON.GetValue<string>('book.BOOK_ISBN');
  Author := JSON.GetValue<string>('book.BOOK_AUTHOR');
  Price := JSON.GetValue<string>('book.BOOK_PRICE');
  Link := JSON.GetValue<string>('book.BOOK_LINK');
  Desc := JSON.GetValue<string>('book.BOOK_DESCRIPTION');

  qryBook.Close;
  qryBook.SQL.Text := SQL_ITEM_INSERT;
  qryBook.ParamByName('BOOK_TITLE').AsString := Title;
  qryBook.ParamByName('BOOK_ISBN').AsString := ISBN;
  qryBook.ParamByName('BOOK_AUTHOR').AsString := Author;
  qryBook.ParamByName('BOOK_PRICE').AsString := Price;
  qryBook.ParamByName('BOOK_LINK').AsString := Link;
  qryBook.ParamByName('BOOK_DESCRIPTION').AsString := Desc;
  qryBook.ExecSQL;
end;

procedure TBooksResource1.PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
const
  SQL_ITEM_UPDATE = 'UPDATE BOOK SET ' +
                    '  BOOK_TITLE = :BOOK_TITLE,' +
                    '  BOOK_ISBN = :BOOK_ISBN, ' +
                    '  BOOK_AUTHOR = :BOOK_AUTHOR,' +
                    '  BOOK_PRICE = :BOOK_PRICE,' +
                    '  BOOK_LINK = :BOOK_LINK, ' +
                    '  BOOK_DESCRIPTION = :BOOK_DESCRIPTION ' +
                    ' WHERE ' +
                    '  BOOK_SEQ = :BOOK_SEQ';

var
  BOOK_SEQ: string;
  Title, Author, Price, ISBN, Link, Desc: string;
  Json: TJSONValue;
begin
  BOOK_SEQ := ARequest.Params.Values['item'];

  JSON := ARequest.Body.GetValue;
  Title := JSON.GetValue<string>('book.BOOK_TITLE');
  ISBN := JSON.GetValue<string>('book.BOOK_ISBN');
  Author := JSON.GetValue<string>('book.BOOK_AUTHOR');
  Price := JSON.GetValue<string>('book.BOOK_PRICE');
  Link := JSON.GetValue<string>('book.BOOK_LINK');
  Desc := JSON.GetValue<string>('book.BOOK_DESCRIPTION');

  qryBook.Close;
  qryBook.SQL.Text := SQL_ITEM_UPDATE;
  qryBook.ParamByName('BOOK_TITLE').AsString := Title;
  qryBook.ParamByName('BOOK_ISBN').AsString := ISBN;
  qryBook.ParamByName('BOOK_AUTHOR').AsString := Author;
  qryBook.ParamByName('BOOK_PRICE').AsString := Price;
  qryBook.ParamByName('BOOK_LINK').AsString := Link;
  qryBook.ParamByName('BOOK_DESCRIPTION').AsString := Desc;
  qryBook.ParamByName('BOOK_SEQ').AsString := BOOK_SEQ;
  qryBook.ExecSQL;

  if qryBook.RowsAffected = 0 then
     AResponse.RaiseNotFound('Not found', '''' + BOOK_SEQ + ''' is not found');
end;

procedure TBooksResource1.ConBookRentalBeforeConnect(Sender: TObject);
var
  Path: string;
begin
  Path := TPath.GetFullPath('..\DB\BOOKRENTAL.IB');
  if not TFile.Exists(Path) then
  begin
      raise Exception.Create('Not found database.');
    end;

  conBookRental.Params.Values['Database'] := Path;

end;

procedure TBooksResource1.DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
const
  SQL_ITEM_DELETE ='DELETE FROM BOOK WHERE BOOK_SEQ = :BOOK_SEQ';
var
  BOOK_SEQ: string;
begin
  BOOK_SEQ := ARequest.Params.Values['item'];

  qryBook.Close;
  qryBook.SQL.Text := SQL_ITEM_DELETE;
  qryBook.ParamByName('BOOK_SEQ').AsString := BOOK_SEQ;
  qryBook.ExecSQL;

  if qryBook.RowsAffected = 0 then
    AResponse.RaiseNotFound('Not found', '''' + BOOK_SEQ + ''' is not found');

end;

procedure Register;
begin
  RegisterResource(TypeInfo(TBooksResource1));
end;

initialization
  Register;
end.


