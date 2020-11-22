unit UMain_Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DbxDatasnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Data.SqlExpr, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, system.json,Vcl.DBGrids, Datasnap.DBClient, Datasnap.DSConnect, Data.FMTBcd,dbxjson;

type
  TCallBackClient = class(TDBXCALLBack)
    function execute(const arg:TJSONValue):tjsonvalue; override;
  end;

  TForm221 = class(TForm)
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    Dept: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    InsaQuery: TClientDataSet;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    SqlServerMethod1: TSqlServerMethod;
    Edit1: TEdit;
    Edit2: TEdit;
    Button9: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Button8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button6Click(Sender: TObject);
    procedure DeptReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure Button7Click(Sender: TObject);
    procedure SQLConnection1BeforeConnect(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form221: TForm221;

implementation

uses UClientClass, Vcl.RecError;
var
  ServerMethods1Client:TServerMethods1Client;

{$R *.dfm}

procedure TForm221.Button1Click(Sender: TObject);
begin
  Dept.CancelUpdates;
end;
procedure TForm221.Button2Click(Sender: TObject);
begin
  dept.RevertRecord;
end;
procedure TForm221.Button3Click(Sender: TObject);
begin
  dept.ApplyUpdates(-1);
end;
procedure TForm221.Button4Click(Sender: TObject);
begin
  dept.SaveToFile('sample.cds');
end;
procedure TForm221.Button5Click(Sender: TObject);
begin
   dept.LoadFromFile('sample.cds');
end;

procedure TForm221.Button6Click(Sender: TObject);
begin
  button6.Caption :=
  Inttostr(ServerMethods1Client.Get_Count(dept.Fields[0].asstring));
end;

procedure TForm221.Button7Click(Sender: TObject);
var
  MycallBack:TCallbackClient;
begin
   MycallBack := TCallbackClient.Create;
   button7.Caption := ServerMethods1Client.EchoString('hi',mycallback);
end;

procedure TForm221.Button8Click(Sender: TObject);
begin
//  SqlServerMethod1.Close;
//  SqlServerMethod1.Params[0].asstring := 'abc';
//  SqlServerMethod1.ExecuteMethod;
//  button8.Caption := SqlServerMethod1.Params[1].asstring;
  try
   button8.Caption :=
   ServerMethods1Client.reverseString('abc');
  except
    on e:exception do
       showmessage('이 권한으로는 호출 못함');
  end;
end;

procedure TForm221.Button9Click(Sender: TObject);
begin
  try
    sqlconnection1.Open;
    dept.Open;
    ServerMethods1Client := TServerMethods1Client.create(sqlconnection1.DBXConnection);
 except
   on e:exception do
      showmessage(e.Message);
 end;
end;

procedure TForm221.DataSource1DataChange(Sender: TObject; Field: TField);
begin
   InsaQuery.Close;
   InsaQuery.Params[0].AsString := dept.Fields[0].AsString;
   insaquery.Open;
end;

procedure TForm221.DeptReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  action := HandleReconcileError(Dataset,updatekind,e);
end;

procedure TForm221.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ServerMethods1Client.Free;
end;

procedure TForm221.SQLConnection1BeforeConnect(Sender: TObject);
begin
  sqlconnection1.Params.Values[TDBXPropertyNames.DSAuthenticationUser] := edit1.Text;
  sqlconnection1.Params.Values[TDBXPropertyNames.DSAuthenticationPassword] := edit2.Text;
end;

{ TCallBackClient }

function TCallBackClient.execute(const arg: TJSONValue): tjsonvalue;
var
  Data:TJSONValue;
begin
  Data := TJSONValue(arg.Clone);
  Showmessage('콜백결과:' + tjsonobject(data).Get(0).jsonvalue.value);
  result := data;
end;

end.
