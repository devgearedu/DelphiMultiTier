unit DataAccessModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, System.JSON.Writers, REST.Types;

type
  TdmDataAccess = class(TDataModule)
    RESTClient1: TRESTClient;
    reqList: TRESTRequest;
    resList: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    memBookList: TFDMemTable;
    reqDetail: TRESTRequest;
    rspDetail: TRESTResponse;
    RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter;
    memBookDetail: TFDMemTable;
    memBookDetailBOOK_SEQ: TWideStringField;
    memBookDetailBOOK_TITLE: TWideStringField;
    memBookDetailBOOK_ISBN: TWideStringField;
    memBookDetailBOOK_AUTHOR: TWideStringField;
    memBookDetailBOOK_PRICE: TIntegerField;
    memBookDetailBOOK_LINK: TWideStringField;
    memBookDetailBOOK_DESCRIPTION: TWideStringField;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetBookData: TJSONObject;
  end;

var
  dmDataAccess: TdmDataAccess;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmDataAccess }

function TdmDataAccess.GetBookData: TJSONObject;
var
  Writer: TJsonObjectWriter;
begin
  Writer := TJsonObjectWriter.Create(False);
  try
    Writer.WriteStartObject;  // start resource
    Writer.WritePropertyName('book');

    Writer.WriteStartObject;  // start item
    Writer.WritePropertyName('BOOK_TITLE');
    Writer.WriteValue(memBookDetail.FieldByName('BOOK_TITLE').AsString);

    Writer.WritePropertyName('BOOK_ISBN');
    Writer.WriteValue(memBookDetail.FieldByName('BOOK_ISBN').AsString);

    Writer.WritePropertyName('BOOK_AUTHOR');
    Writer.WriteValue(memBookDetail.FieldByName('BOOK_AUTHOR').AsString);

    Writer.WritePropertyName('BOOK_PRICE');
    Writer.WriteValue(memBookDetail.FieldByName('BOOK_PRICE').AsString);

    Writer.WritePropertyName('BOOK_LINK');
    Writer.WriteValue(memBookDetail.FieldByName('BOOK_LINK').AsString);

    Writer.WritePropertyName('BOOK_DESCRIPTION');
    Writer.WriteValue(memBookDetail.FieldByName('BOOK_DESCRIPTION').AsString);

    Writer.WriteEndObject;  // end item
    Writer.WriteEndObject;  // end resource

    Result := Writer.JSON as TJSONObject;
  finally
    Writer.Free;
  end;
end;

end.
