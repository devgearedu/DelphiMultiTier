unit UMain_Mobile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.DbxDatasnap, Data.DBXCommon, IPPeerClient, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.DB, Data.Bind.Components, Data.Bind.DBScope, Datasnap.DBClient,
  Datasnap.DSConnect, Data.SqlExpr, FMX.Gestures, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.ListView, FMX.StdCtrls, FMX.Edit,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TForm222 = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Edit1: TEdit;
    Button1: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    ListView2: TListView;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    GestureManager1: TGestureManager;
    StyleBook1: TStyleBook;
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    Dept: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    InsaQuery: TClientDataSet;
    DeptSource: TDataSource;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure DeptSourceDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure SQLConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form222: TForm222;

implementation

uses UClientclassMobile;
var
 ServerMethods1Client:TServerMethods1Client;
{$R *.fmx}

procedure TForm222.Button1Click(Sender: TObject);
begin
  button1.Text :=
  IntTostr(ServerMethods1Client.Get_Count(dept.Fields[0].asstring));
end;

procedure TForm222.DeptSourceDataChange(Sender: TObject; Field: TField);
begin
  InsaQuery.Close;
  InsaQuery.Params[0].asstring := dept.FieldByName('CODE').AsString;
  InsaQuery.Open;
end;

procedure TForm222.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 ServerMethods1Client.Free;
end;

procedure TForm222.FormCreate(Sender: TObject);
begin
 try
   SQLConnection1.open;
   dept.Open;
   ServerMethods1Client := TServerMethods1Client.create(sqlconnection1.DBXConnection);
 except
   on e:exception do
      ShowMessage(e.Message);
 end;
end;

procedure TForm222.SQLConnection1BeforeConnect(Sender: TObject);
begin
// {$ifdef ios or Android}
    sqlConnection1.Params.Values['HostName'] := Edit1.Text;
// {$endif}
end;

end.
