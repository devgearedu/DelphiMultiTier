unit Umain_client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Vcl.Grids, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.DBGrids;

type
  TForm212 = class(TForm)
    Button2: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter;
    InsaQuery: TFDMemTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    procedure Button2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    procedure RequestDetail(code:String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form212: TForm212;

implementation

{$R *.dfm}


procedure TForm212.Button2Click(Sender: TObject);
begin
//  RestClient1.BaseURL := 'http://localhost:8080/datasnap/rest/TServerMethods1/getDept';
 // RESTRequest1.Method := TRESTRequestMethod.rmGET;
//  BindSourceDB1.DataSource.Enabled := False;
  RESTRequest1.Execute;
  RESTResponseDataSetAdapter1.ACTIVE:= true;
  RESTResponseDataSetAdapter1.Dataset := FDMemTable1;
  FDMemTable1.Open;

end;

procedure TForm212.DataSource1DataChange(Sender: TObject; Field: TField);
begin
   if FDMemTable1.RecordCount = 0 then
    Exit;
    RequestDetail(FDMemTable1.FieldByName('CODE').AsString);

end;

procedure TForm212.RequestDetail(code:string);
begin
  RESTRequest2.Params.ParameterByName('item').Value := code;
  RESTRequest2.Execute;

end;

end.
