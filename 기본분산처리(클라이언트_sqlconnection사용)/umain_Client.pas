unit umain_Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DbxDatasnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Data.SqlExpr, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Data.FMTBcd,
  uClientclass, Vcl.RecError,dbxjson, system.JSON;

type
  TCallbackClient = class(TDBXCallback)
     PUBLIC
       function Execute(const arg:TJSONValue):tjsonvalue; override;
  end;

  TForm19 = class(TForm)
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
    SqlServerMethod1: TSqlServerMethod;
    insaquery: TClientDataSet;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    Button8: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button7Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DeptReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form19: TForm19;
  Demo_client :   TServerMethods1Client;

implementation

{$R *.dfm}

procedure TForm19.Button1Click(Sender: TObject);
begin
  dept.ApplyUpdates(-1);
end;

procedure TForm19.Button2Click(Sender: TObject);
begin
  dept.RevertRecord;
end;

procedure TForm19.Button3Click(Sender: TObject);
begin
   dept.CancelUpdates;
end;

procedure TForm19.Button4Click(Sender: TObject);
begin
  dept.SaveToFile('sample.cds');
end;

procedure TForm19.Button5Click(Sender: TObject);
begin
  dept.LoadFromFile('sample.cds');
end;

procedure TForm19.Button6Click(Sender: TObject);
begin
    sqlServerMethod1.Close;
    sqlservermethod1.Params[0].AsString := 'abc';
    sqlServerMethod1.ExecuteMethod;
    button6.Caption := sqlserverMethod1.params[1].asstring;
end;

procedure TForm19.Button7Click(Sender: TObject);
begin
  button7.Caption := inttostr(demo_client.Get_Count(dept.Fields[0].asstring));
end;

procedure TForm19.Button8Click(Sender: TObject);
var
  MycallBack:TCallBackClient;
begin
  MycallBack := TCallBackClient.create;
  button8.Caption := demo_client.EchoString('hi', mycallback);
end;
procedure TForm19.DataSource1DataChange(Sender: TObject; Field: TField);
begin
   insaquery.close;
   insaquery.params[0].asstring := dept.Fields[0].asstring;
   insaquery.open;
end;

procedure TForm19.DeptReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  action :=  HandleReconcileError(DataSet,UpdateKind,e);
end;

procedure TForm19.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   demo_client.Free;
end;

procedure TForm19.FormCreate(Sender: TObject);
begin
   demo_client := TServerMethods1Client.create(sqlconnection1.DBXConnection);
end;

{ TCallbackClient }

function TCallbackClient.Execute(const arg: TJSONValue): tjsonvalue;
var
  Data:TJSONValue;
begin
  Data := TJSonvalue(arg.Clone);
  showmessage('ฤÝน้ :' + TJSONObject(data).Get(0).JsonValue.value);
  result := data;
end;

end.
