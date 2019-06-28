unit WebModuleUnit;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Web.DBWeb, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase, Web.HTTPProd, Web.DSProd;

type
  TWebModule8 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Dept: TFDTable;
    DeptProducer: TDataSetTableProducer;
    HomeProducer: TPageProducer;
    InsaQuery: TFDQuery;
    InsaProducer: TDataSetTableProducer;
    DataSetPageProducer1: TDataSetPageProducer;
    procedure WebModule8DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule8WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure DeptProducerFormatCell(Sender: TObject; CellRow,
      CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
      var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
    procedure WebModule8WebActionItem2Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule8;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWebModule8.DeptProducerFormatCell(Sender: TObject; CellRow,
  CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
  var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
begin
  if (CellRow <>0 ) and (CellColumn =0) then
     CellData := '<a href =http://localhost:8080/Insa?code=' +
     Dept.Fields[0].AsString + '>' + CellData + '</a>';
end;

procedure TWebModule8.WebModule8DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>Web Server Application</title></head>' +
    '<body>Web Server Application</body>' +
    '</html>';
end;

procedure TWebModule8.WebModule8WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  DEPT.Close;
  DEPT.Open;
  RESPONSE.Content := DeptProducer.Content;

end;

procedure TWebModule8.WebModule8WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
   InsaQuery.Close;
   InsaQuery.Params[0].AsString :=
   Request.ContentFields.Values['code'];
   InsaQuery.Open;
   Response.Content := InsaProducer.Content;
end;

end.
