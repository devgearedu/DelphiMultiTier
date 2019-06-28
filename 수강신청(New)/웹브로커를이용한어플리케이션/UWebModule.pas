unit UWebModule;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, Web.DBWeb, Web.HTTPProd, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase;

type
  TWebModule8 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    MainProducer: TPageProducer;
    courseProducer: TPageProducer;
    ListProducer: TPageProducer;
    CurriDateProducer: TDataSetTableProducer;
    AcceptProducer: TPageProducer;
    Query_KindCount: TFDQuery;
    Query_curriname: TFDQuery;
    Query_curridate: TFDQuery;
    CustTemp: TFDTable;
    FailedProducer: TPageProducer;
    CompleteProducer: TPageProducer;
    procedure WebModule8DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule8WebActionItem3Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule8WebActionItem4Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure ListProducerHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure CurriDateProducerFormatCell(Sender: TObject; CellRow,
      CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
      var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
    procedure AcceptProducerHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule8;
  Curricode: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWebModule8.AcceptProducerHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  ReplaceText := '<tr>' + '<td width="500">' + '<input type="hidden" size="10" maxlength="10" name="ctcode" value="' + Curricode + '"></td>' + '</tr>';

end;

procedure TWebModule8.CurriDateProducerFormatCell(Sender: TObject; CellRow,
  CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
  var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
begin
  if (CellColumn = 0) and (CellRow <> 0) then
  begin
    Curricode := Query_curridate.FieldByName('ctcode').asstring;
    CellData := '<a href=http://localhost:8080/reg?p_code=' + Curricode + '>' + CellData + '</a>';
end;
end;
procedure TWebModule8.ListProducerHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  KindStr, PresentKind: string;
  i, j: byte;
begin
  if CompareText(TagString, 'currilist') = 0 then
  begin
    with query_kindcount do
    begin
      Open;
      for i := 0 to RecordCount - 1 do
      begin
        KindStr := KindStr + Fields[0].asstring + '<br>';
        PresentKind := Fields[0].asstring;
        Query_curriname.Close;
        Query_curriname.Params[0].asstring := PresentKind;
        Query_curriname.Open;
        while not Query_curriname.eof do
        begin
          Curricode := Query_curriname.FieldByName('code').asstring;
          KindStr := KindStr + '<img src=../pic/onestep.gif></img>' + '<a href= ./date?p_code=' + Curricode + '>' +
            Query_curriname.FieldByName('Name').asstring + '</a><br>';
          Query_curriname.next;
        end;
        next;
      end; // For
    end; // with
    ReplaceText := KindStr;
  end; // if
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

procedure TWebModule8.WebModule8WebActionItem3Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Request.QueryFields.values['p_code'] := Request.QueryFields.values['p_code'] + '%';
  with Query_curridate do
  begin
    Close;
    Params[0].asstring := Request.QueryFields.values['p_code'];
    Open;
  end;
  Response.Content := curridateproducer.Content;
end;

procedure TWebModule8.WebModule8WebActionItem4Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if Request.QueryFields.values['option'] = 'write' then
  begin
    try

      CustTemp.Close;
      CustTemp.Open;
      CustTemp.Append;

      custtemp.FieldByName('RegDate').Asdatetime := date;
      custtemp.FieldByName('ctcode').asstring := Request.ContentFields.values['ctcode'];
      custtemp.FieldByName('name').asstring := Request.ContentFields.values['name'];
      custtemp.FieldByName('pno').asstring := Request.ContentFields.values['pno'];
      custtemp.FieldByName('tel').asstring := Request.ContentFields.values['tel'];
      custtemp.FieldByName('addr').asstring := Request.ContentFields.values['addr'];
      custtemp.FieldByName('company').asstring := Request.ContentFields.values['company'];
      custtemp.FieldByName('ccode').asstring := Request.ContentFields.values['ccode'];
      custtemp.FieldByName('cboss').asstring := Request.ContentFields.values['cboss'];
      custtemp.FieldByName('caddr').asstring := Request.ContentFields.values['caddr'];
      custtemp.FieldByName('ctel').asstring := Request.ContentFields.values['ctel'];
      custtemp.FieldByName('cfax').asstring := Request.ContentFields.values['cfax'];
      custtemp.FieldByName('Email').asstring := Request.ContentFields.values['email'];

      custtemp.post;
      Response.Content := CompleteProducer.Content;
    except
      on E: Exception do
      begin
        Response.Content := FailedProducer.Content;
      end;
    end;
  end
  else
  begin
    Curricode := Request.QueryFields.values['p_code'];
    Response.Content := acceptproducer.Content;
  end;

end;

end.
