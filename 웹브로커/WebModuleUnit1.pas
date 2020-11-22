unit WebModuleUnit1;

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
  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Dept: TFDTable;
    DeptProducer: TDataSetTableProducer;
    HomeProducer: TPageProducer;
    InsaQuery: TFDQuery;
    InsaQueryProducer: TDataSetTableProducer;
    InsaQueryID: TIntegerField;
    InsaQueryNAME: TStringField;
    InsaQueryAGE: TSmallintField;
    InsaQueryDEPT_CODE: TStringField;
    InsaQueryCLASS: TStringField;
    InsaQueryIPSA_DATE: TDateField;
    InsaQuerySALARY: TIntegerField;
    InsaQueryPHOTO: TBlobField;
    InsaQueryGRADE: TStringField;
    DataSetPageProducer1: TDataSetPageProducer;
    InsaInformProducer: TDataSetPageProducer;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure DeptProducerFormatCell(Sender: TObject; CellRow,
      CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
      var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
    procedure WebModule1InsaActionItemAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure InsaQueryProducerFormatCell(Sender: TObject; CellRow,
      CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
      var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
    procedure WebModule1WebActionItem2Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWebModule1.DeptProducerFormatCell(Sender: TObject; CellRow,
  CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
  var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
begin
  if (CellColumn =0) and (CellRow <> 0) then
     CellData := '<a href = http://localhost:8080/Insa?Code='
     + Dept.Fields[0].AsString + '>' + CellData + '</a>';
end;

procedure TWebModule1.InsaQueryProducerFormatCell(Sender: TObject; CellRow,
  CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
  var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
begin
  if (CellColumn =0) and (CellRow <> 0) then
      CellData := '<a href = http://localhost:8080/Inform?code='
      + InsaQuery.Fields[0].Asstring + '>' + CellData + '</a>';
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>Web Server Application</title></head>' +
    '<body>Web Server Application</body>' +
    '</html>';
end;

procedure TWebModule1.WebModule1InsaActionItemAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
   InsaQuery.Close;
   InsaQuery.Params[0].AsString := Request.QueryFields.Values['Code'];
   InsaQuery.Open;
   response.Content := InsaQueryProducer.Content;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
   if not InsaQuery.Locate('id',strtoint(Request.QueryFields.Values['Code']),[]) then
      response.Content :=
      '<html>' +
      '<head><title>Web Server Application</title></head>' +
      '<body>그런 데이터가 없습니다</body>' +
      '</html>'
   else
      response.Content := InsainformProducer.Content;
end;

end.
