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
  System.Actions, FMX.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.DS,
  FireDAC.Phys.DSDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Phys.TDBXBase, FireDAC.Stan.StorageBin, FireDAC.Comp.UI;

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
    ListView2: TListView;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    GestureManager1: TGestureManager;
    FDConnection1: TFDConnection;
    FDPhysDSDriverLink1: TFDPhysDSDriverLink;
    FDStoredProc1: TFDStoredProc;
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStoredProcGet: TFDStoredProc;
    dsDept: TDataSource;
    taDept: TFDTableAdapter;
    mtDept: TFDMemTable;
    mtinsa: TFDMemTable;
    tainsa: TFDTableAdapter;
    dsinsa: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
      procedure GetTables;
    { Public declarations }
  end;

var
  Form20: TForm20;

implementation

{$R *.fmx}

procedure TForm20.Button1Click(Sender: TObject);
begin
   FDStoredProc1.Close;
   FDStoredProc1.Params[0].AsString := 'abc';
   FDStoredProc1.Execproc;
   Button1.Text := FDStoredProc1.Params[1].AsString;
end;


procedure TForm20.FormCreate(Sender: TObject);
begin
 GetTables;
end;

procedure TForm20.GetTables;
var
  LStringStream: TStringStream;
begin
  FDStoredProcGet.ExecProc;
  LStringStream := TStringStream.Create(FDStoredProcGet.Params[0].asBlob);
  try
    if LStringStream <> nil then
    begin
      LStringStream.Position := 0;
      FDSchemaAdapter1.LoadFromStream(LStringStream, TFDStorageFormat.sfBinary);
    end;
  finally
    LStringStream.Free;
  end;

end;

end.
