unit Umain_Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, system.json,Datasnap.DSConnect, Data.SqlExpr, Data.FMTBcd,dbxjson;

type
  TMyCallBack = class(TDBXCallBack)
     function execute(const arg:tjsonvalue):tjsonvalue; override;
  end;
  TForm213 = class(TForm)
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
    InsaQuery: TClientDataSet;
    InsaQuerySource: TDataSource;
    DBGrid2: TDBGrid;
    SqlServerMethod1: TSqlServerMethod;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button7Click(Sender: TObject);
    procedure DeptReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form213: TForm213;

implementation

uses UClientClass, Vcl.RecError;
var
  demo:TServerMethods1Client;
{$R *.dfm}

procedure TForm213.Button1Click(Sender: TObject);
begin
  dept.CancelUpdates;
end;

procedure TForm213.Button2Click(Sender: TObject);
begin
  dept.RevertRecord;
end;

procedure TForm213.Button3Click(Sender: TObject);
begin
 dept.applyupdates(-1);
end;

procedure TForm213.Button4Click(Sender: TObject);
begin
  dept.savetofile('sample.xml',dfxml);
end;

procedure TForm213.Button5Click(Sender: TObject);
begin
  dept.LoadFromFile('sample.xml');
end;
procedure TForm213.Button6Click(Sender: TObject);
var
  mycallback:TMYCallback;
begin
// SQLServerMethod1.Close;
// SQLServerMethod1.Params[0].AsString := 'hi';
// SQLServerMethod1.ExecuteMethod;
// button6.Caption := SQLServerMethod1.Params[1].AsString
   mycallback := tmycallback.Create;
   button6.Caption := demo.EchoString('hi',mycallback);
end;

procedure TForm213.Button7Click(Sender: TObject);
begin
 button7.Caption :=
 inttostr(demo.GetCount(dept.Fields[0].asstring));
end;

procedure TForm213.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  insaquery.Close;
  insaquery.Params[0].AsString := dept.FieldByName('code').AsString;
  insaquery.Open;
end;

procedure TForm213.DeptReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  action := HandleReconcileError(DataSet,updateKind,e);
end;

procedure TForm213.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  demo.Free;
end;

procedure TForm213.FormCreate(Sender: TObject);
begin
  demo := TServerMethods1Client.create(sqlconnection1.dbxconnection);
end;

{ TMyCallBack }

function TMyCallBack.execute(const arg: tjsonvalue): tjsonvalue;
var
  Data:TJSONValue;
begin
  Data := TJSONValue(arg.Clone);
  Showmessage('ฤÝน้:' + tjsonoBJECT(DATA).get(0).jsonvalue.value);
  result := data;
end;

end.
