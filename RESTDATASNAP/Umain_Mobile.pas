unit Umain_Mobile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  REST.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, FMX.Grid.Style, Fmx.Bind.Grid, Data.Bind.Grid,
  FMX.ScrollBox, FMX.Grid, Data.Bind.Components, Data.Bind.DBScope, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.ObjectScope, FMX.StdCtrls, FMX.ListView, FMX.Edit,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TForm19 = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Edit1: TEdit;
    ListView1: TListView;
    Button1: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable_Dept: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter;
    InsaQuery: TFDMemTable;
    StringGrid1: TStringGrid;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    procedure Button1Click(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
  private
      procedure RequestDetail(code:String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form19: TForm19;

implementation

{$R *.fmx}

procedure TForm19.Button1Click(Sender: TObject);
begin
  RESTRequest1.Execute;
  RESTResponseDataSetAdapter1.ACTIVE:= true;
  RESTResponseDataSetAdapter1.Dataset := FDMemTable_Dept;
  FDMemTable_Dept.Open;
end;


procedure TForm19.FormCreate(Sender: TObject);
begin
  restClient1.ProxyPort := 8080;
  restClient1.ProxyServer := edit1.Text;
end;

procedure TForm19.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    if FDMemTable_Dept.RecordCount = 0 then
    Exit;

    RequestDetail(FDMemTable_Dept.FieldByName('CODE').AsString);

end;

procedure TForm19.RequestDetail(code: String);
begin
  RESTRequest2.Params.ParameterByName('item').Value := code;
  BindSourceDB2.DataSource.Enabled := False;
  RESTRequest2.ExecuteAsync(procedure
  begin
    BindSourceDB2.DataSource.Enabled := True;
  end);

end;

end.
