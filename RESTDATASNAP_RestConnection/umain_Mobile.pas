unit umain_Mobile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Datasnap.DSClientRest, FMX.Gestures, FMX.TabControl, System.Actions,
  FMX.ActnList, FMX.ListView, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.FireDACJSONReflect,
  System.Rtti, FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.ScrollBox,
  FMX.Grid;

type
  TForm19 = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Edit1: TEdit;
    Button1: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    GestureManager1: TGestureManager;
    DSRestConnection1: TDSRestConnection;
    Dept: TFDMemTable;
    DeptSorce: TDataSource;
    Insa: TFDMemTable;
    InsaSource: TDataSource;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    Grid1: TGrid;
    Grid2: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DeptSorceDataChange(Sender: TObject; Field: TField);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure GetInsa(const code: string);
    procedure GetDepts;

    { Public declarations }
  end;

var
  Form19: TForm19;


implementation

{$R *.fmx}

uses ClientClassesUnit3;
var
   ServerMethods1Client: TServerMethods1Client;

procedure TForm19.Button1Click(Sender: TObject);
begin
  button1.Text := ServerMethods1Client.ReverseString('abc');
end;

procedure TForm19.DeptSorceDataChange(Sender: TObject; Field: TField);
begin
  GetInsa(Dept.Fields[0].asstring);
end;

procedure TForm19.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ServerMethods1Client.free;
end;

procedure TForm19.FormCreate(Sender: TObject);
begin
   ServerMethods1Client:= TServerMethods1Client.Create(DSRestConnection1);
   GetDepts;
end;

procedure TForm19.GetDepts;
var
  LDataSetList: TFDJSONDataSets;
begin
  try
    // Get dataset list containing department names
    LDataSetList := ServerMethods1Client.GetDepts;

    // Update UI
    Dept.Active  := False;
    Assert(TFDJSONDataSetsReader.GetListCount(LDataSetList) = 1);
    Dept.AppendData(
        TFDJSONDataSetsReader.GetListValue(LDataSetList, 0));
  except
    on E: TDSRestProtocolException do
          ShowMessage(e.Message);
    else
      raise;
  end;

end;

procedure TForm19.GetInsa(const code: string);
var
  LDataSetList: TFDJSONDataSets;
  LDataSet: TFDDataSet;
begin
  try
    LDataSetList := ServerMethods1Client.GetInsas(code);
    // Update UI
    LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList, 'insa');
    Insa.Active  := False;
    INSA.AppendData(LDataSet);
  except
    on E: TDSRestProtocolException do
       showmessage('Get insa error');
    else
      raise;
  end;

end;

end.
