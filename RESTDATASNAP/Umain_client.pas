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
    StringGrid1: TStringGrid;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
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
//  RESTRequest1.Method := TRESTRequestMethod.rmGET;
  BindSourceDB1.DataSource.Enabled := False;
  RESTRequest1.Execute;
//  executeAsync(procedure
//  begin
    BindSourceDB1.DataSource.Enabled := True;
//  end);
end;

end.
