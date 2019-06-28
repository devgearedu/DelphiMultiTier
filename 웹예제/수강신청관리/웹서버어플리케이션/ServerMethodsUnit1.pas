unit ServerMethodsUnit1;

interface

uses
  SysUtils, Classes, DSServer, DBXInterBase, FMTBcd, DB, SqlExpr, Provider,
  DBWeb, DBXpressWeb, DBClient, SimpleDS, HTTPApp, HTTPProd;

type
  TServerMethods1 = class(TDSServerModule)
    MainProducer: TPageProducer;
    SQLConnection1: TSQLConnection;
    courseProducer: TPageProducer;
    query_kindcount: TSQLQuery;
    Query_curriname: TSQLQuery;
    Query_curridate: TSQLQuery;
    orders: TSimpleDataSet;
    Customer: TSimpleDataSet;
    CustomerCUSTNO: TStringField;
    CustomerNAME: TStringField;
    CustomerPNO: TStringField;
    CustomerTEL: TStringField;
    CustomerADDR: TStringField;
    CustomerCOMPANY: TStringField;
    CustomerCCODE: TStringField;
    CustomerCBOSS: TStringField;
    CustomerCADDR: TStringField;
    CustomerCTEL: TStringField;
    CustomerCFAX: TStringField;
    CustomerEMAIL: TStringField;
    CustTemp: TSimpleDataSet;
    ListProducer: TPageProducer;
    curridateproducer: TSQLQueryTableProducer;
    acceptproducer: TPageProducer;
    FailedProducer: TPageProducer;
    CompleteProducer: TPageProducer;
    CustTempProvider: TDataSetProvider;
    curritb: TSimpleDataSet;
    curritbCTCODE: TStringField;
    curritbSTART: TSQLTimeStampField;
    curritbLIMIT: TIntegerField;
    curritbPCOUNT: TIntegerField;
    curritbPRICE: TIntegerField;
    curritbTEACHER: TStringField;
    curritbDURING: TIntegerField;
    curritbROOM: TIntegerField;
    Curri: TSQLTable;
    CurriCODE: TStringField;
    CurriKIND: TStringField;
    CurriNAME: TStringField;
    CurriLOGO: TBlobField;
    Currikind_name: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
  end;

var
  ServerMethods1:TServerMethods1;
  CURRICODE:STRING;
implementation

{$R *.dfm}

uses StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := StrUtils.ReverseString(Value);
end;

end.

