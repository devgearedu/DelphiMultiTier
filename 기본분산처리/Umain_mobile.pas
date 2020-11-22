unit Umain_mobile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Fmx.Bind.GenData, Data.Bind.GenData, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  FMX.StdCtrls, Data.Bind.ObjectScope, FMX.ListView, FMX.Edit,
  FMX.Controls.Presentation, FMX.TabControl, FMX.Layouts, System.Actions,
  FMX.ActnList, FMX.Gestures, Data.DBXDataSnap, Data.DBXCommon, IPPeerClient,
  Data.DB, Data.Bind.DBScope, Datasnap.DBClient, Datasnap.DSConnect,
  Data.SqlExpr, UClientClass_mobile;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ToolBar1: TToolBar;
    Edit1: TEdit;
    Button1: TButton;
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    StyleBook1: TStyleBook;
    ActionList1: TActionList;
    GestureManager1: TGestureManager;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    Dept: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    LinkListControlToField1: TLinkListControlToField;
    InsaQuery: TClientDataSet;
    DataSource1: TDataSource;
    ListView2: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SQLConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Demo:TServerMethods1Client;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    button1.text := demo.ReverseString('abc');
  except
    on e:exception do
       showmessage('이 작업을 처리할 권한이 없습니다');
  end;
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  InsaQuery.Close;
  InsaQuery.Params[0].asstring :=
  dept.Fields[0].AsString;
  InsaQuery.Open;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  demo.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 try
   SQLConnection1.Open;
   Dept.Open;
   demo := TServerMethods1Client.Create(sqlconnection1.DBXConnection);
 except
   on e:exception do
      Showmessage(e.Message);
 end;
end;

procedure TForm1.SQLConnection1BeforeConnect(Sender: TObject);
begin
 SQLConnection1.Params.Values['HOSTNAME'] := Edit1.Text;
// SQLConnection1.Params.Values[TDBXPropertyNames.DSAuthenticationUser] := Edit2.Text;
// SQLConnection1.Params.Values[TDBXPropertyNames.DSAuthenticationPassword] := Edit3.text;

end;

end.
