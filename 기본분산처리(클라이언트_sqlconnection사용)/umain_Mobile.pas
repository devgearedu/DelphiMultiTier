unit umain_Mobile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.DbxDatasnap, Data.DBXCommon, IPPeerClient, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.DB, Data.Bind.DBScope, Datasnap.DBClient,
  Datasnap.DSConnect, Data.SqlExpr, FMX.ListView, FMX.TabControl, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, FMX.Gestures,
  System.Actions, FMX.ActnList;

type
  TForm20 = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Edit1: TEdit;
    Button1: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    Dept: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    ListView2: TListView;
    insa: TClientDataSet;
    deptsource: TDataSource;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkListControlToField1: TLinkListControlToField;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    GestureManager1: TGestureManager;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SQLConnection1BeforeConnect(Sender: TObject);
    procedure deptsourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form20: TForm20;

implementation

{$R *.fmx}

uses uClientclass_Mobile;
var
  Demo : TServerMethods1Client;

procedure TForm20.Button1Click(Sender: TObject);
begin
   demo := TServerMethods1Client.Create(SQLCONNECTION1.DBXConnection);
   BUTTON1.text := DEMO.ReverseString('ABC');
   demo.Free;
end;

procedure TForm20.deptsourceDataChange(Sender: TObject; Field: TField);
begin
    Insa.close;
    Insa.params[0].asstring :=dept.Fields[0].AsString;
    Insa.OPEN;
end;

procedure TForm20.FormCreate(Sender: TObject);
begin
  try
    sqlconnection1.Open;
    dept.Open;
    insa.Open;
  except
    on e:exception do
       showmessage(e.Message);
  end;
end;

procedure TForm20.SQLConnection1BeforeConnect(Sender: TObject);
begin
   sqlconnection1.Params.Values['HOSTNAME'] := EDIT1.Text;
end;

end.
