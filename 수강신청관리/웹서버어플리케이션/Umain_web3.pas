unit Umain_web3;

interface

uses
  SysUtils, Classes, HTTPApp, DSHTTP, DSHTTPCommon, DSHTTPWebBroker, DSServer,
  DSCommonServer, HTTPProd, FMTBcd, WideStrings, DBXInterbase, SqlExpr,
  Provider, DB, IWProducer, IWModuleController,iwApplication,iwPageForm, sqltimst,DBWeb,
  DBXpressWeb;

type
  TWebModule1 = class(TWebModule)
    DSServer1: TDSServer;
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServerClass1: TDSServerClass;
    MainProducer: TPageProducer;
    courseProducer: TPageProducer;
    custtemp: TSQLTable;
    SQLConnection1: TSQLConnection;
    custtempProvider: TDataSetProvider;
    query_kindcount: TSQLQuery;
    ListProducer: TPageProducer;
    acceptproducer: TPageProducer;
    Query_curriname: TSQLQuery;
    curridateproducer: TSQLQueryTableProducer;
    Query_curridate: TSQLQuery;
    CompleteProducer: TPageProducer;
    FailedProducer: TPageProducer;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure ListProducerHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1WebActionItem2Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure acceptproducerHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule1WebActionItem4Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem5Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure curridateproducerFormatCell(Sender: TObject; CellRow,
      CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
      var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
    procedure WebModule1WebActionItem3Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModule1: TWebModule1;
  curricode:string;


implementation

uses ServerMethodsUnit1, Uaccept_web;
var
  acceptForm:TacceptForm;
{$R *.dfm}

procedure TWebModule1.ListProducerHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  KindStr,PresentKind:String;
  i,j:byte;
begin
  if CompareText(TagString, 'currilist') = 0 then
  Begin
    with query_KindCount do
    Begin
      Open;
      For i:= 0 to RecordCount -1 do
      Begin
        KindStr := kindStr + Fields[0].asstring +'<br>';
        PresentKind := Fields[0].asString;
        Query_CurriName.Close;
        Query_CurriName.Params[0].AsString := PresentKind;
        Query_CurriName.open;
        while not Query_CurriName.eof do
        Begin
           Curricode := Query_CurriName.Fieldbyname('code').asstring;
           KindStr :=
           KindStr +
           '<img src=../pic/onestep.gif></img>' +
           '<a href= ./date?p_code=' + curricode +'>' +
            Query_CurriName.Fieldbyname('Name').asstring + '</a><br>';
            Query_CurriName.next;
        End;
        next;
      End;   //For
    End; //with    }
    ReplaceText := kindstr;
  End; //if  }
end;
procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := MainProducer.Content;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := listproducer.Content;
end;


procedure TWebModule1.WebModule1WebActionItem3Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
   curricode := Request.QueryFields.values['p_code'];
   Response.Content :=  acceptproducer.content;

end;

procedure TWebModule1.WebModule1WebActionItem4Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  request.QueryFields.values['p_code'] := request.QueryFields.values['p_code'] + '%';
  with query_curridate do
  begin
    close;
    params[0].AsString := request.QueryFields.values['p_code'];
    open;
  end;
  response.Content := curridateproducer.Content;
end;

procedure TWebModule1.WebModule1WebActionItem5Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
if Request.QueryFields.Values['option'] = 'write' then
begin
   with CustTemp do
   Begin
      Append;
      FieldByname('RegDate').Asdatetime := date;
      FieldByname('ctcode').Asstring := Request.ContentFields.Values['ctcode'];
      FieldByname('name').Asstring := Request.ContentFields.Values['name'];
      FieldByname('pno').Asstring := Request.ContentFields.Values['pno'];
//      FieldByname('tel').Asstring := Request.ContentFields.Values['tel'];
//      FieldByname('addr').Asstring := Request.ContentFields.Values['addr'];
//      FieldByname('company').Asstring := Request.ContentFields.Values['company'];
//      FieldByname('ccode').Asstring := Request.ContentFields.Values['ccode'];
//      FieldByname('cboss').Asstring := Request.ContentFields.Values['cboss'];
//      FieldByname('caddr').Asstring := Request.ContentFields.Values['caddr'];
//      FieldByname('ctel').Asstring := Request.ContentFields.Values['ctel'];
//      FieldByname('cfax').Asstring := Request.ContentFields.Values['cfax'];
//      FieldByname('Email').Asstring := Request.ContentFields.Values['email'];
      try
        post;
        response.Content :=
         '<html><body>' + request.contentFields.values['ctcode']+ '</body></html>';
      except
         response.Content :=
         '<html><body>' + request.contentFields.values['name']+ '</body></html>';
//        response.Content := failedproducer.Content;
      end;
  End;
end;
end;

procedure TWebModule1.acceptproducerHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  replacetext :=
  '<tr>' + '<td width="500">' +
  '<input type="hidden" size="10" maxlength="10" name="ctcode" value="'+curricode+'"></td>'+
  '</tr>';

end;

procedure TWebModule1.curridateproducerFormatCell(Sender: TObject; CellRow,
  CellColumn: Integer; var BgColor: THTMLBgColor; var Align: THTMLAlign;
  var VAlign: THTMLVAlign; var CustomAttrs, CellData: string);
begin
  if (cellcolumn = 0) and (cellrow <>0) then
  begin
    curricode := query_curridate.FieldByName('ctcode').asstring;
    celldata := '<a href=http://localhost:81/lec/pweb.exe/accept?p_code=' +
                curricode + '>' + celldata + '</a>';
  end;
end;

procedure TWebModule1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit1.TServerMethods1;
end;

end.




