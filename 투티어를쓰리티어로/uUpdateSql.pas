unit uUpdateSql;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, Vcl.Mask, FireDAC.Stan.StorageXML;

type
  TUpdateForm = class(TForm)
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    CheckBox1: TCheckBox;
    DBNavigator2: TDBNavigator;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    FDUpdateSQL1: TFDUpdateSQL;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Button5: TButton;
    Button6: TButton;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdateForm: TUpdateForm;

implementation

{$R *.dfm}

uses Udm;

procedure TUpdateForm.Button1Click(Sender: TObject);
begin
 FDQuery1.Delete;
 DM.FDConnection1.ApplyUpdates([FDQuery1]);
end;

procedure TUpdateForm.Button2Click(Sender: TObject);
begin
  dm.Dept.CancelUpdates;
end;

procedure TUpdateForm.Button3Click(Sender: TObject);
begin
  dm.Dept.RevertRecord;
end;

procedure TUpdateForm.Button4Click(Sender: TObject);
begin
  dm.Dept.ApplyUpdates(-1);
end;

procedure TUpdateForm.Button5Click(Sender: TObject);
begin
 dm.Dept.SaveTofile('sample.xml');
end;

procedure TUpdateForm.Button6Click(Sender: TObject);
begin
  dm.Dept.LoadFromFile('sample.xml');
end;

procedure TUpdateForm.CheckBox1Click(Sender: TObject);
begin
  DM.Dept.CachedUpdates := CheckBox1.Checked;
end;

procedure TUpdateForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

end.
