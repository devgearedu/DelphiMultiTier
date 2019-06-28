unit fSchemaAdapter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGrids, DBCtrls, DB,
  fMainCompBase,
  FireDAC.Stan.Intf, FireDAC.DatS, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Error;

type
  TfrmSchemaAdapter = class(TfrmMainCompBase)
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDTableAdapter1: TFDTableAdapter;
    FDTableAdapter2: TFDTableAdapter;
    FDCommand1: TFDCommand;
    FDCommand2: TFDCommand;
    FDMemTable1: TFDMemTable;
    FDMemTable2: TFDMemTable;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Button1: TButton;
    procedure cbDBClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSchemaAdapter: TfrmSchemaAdapter;

implementation

uses
  dmMainComp;

{$R *.dfm}

procedure TfrmSchemaAdapter.cbDBClick(Sender: TObject);
begin
  FDMemTable2.Active := False;
  FDMemTable1.Active := False;
  inherited cbDBClick(Sender);
  FDMemTable1.Active := True;
  FDMemTable2.Active := True;

  // Add relation
  with FDSchemaAdapter1.DatSManager do begin
    Relations.Clear;
    with Relations.Add(
          'Orders_OrderDetails',
          FDMemTable1.Table.Columns.ItemsS['id1'],
          FDMemTable2.Table.Columns.ItemsS['fk_id1']).ChildKeyConstraint do begin
      InsertRule := crCascade;
      UpdateRule := crCascade;
      DeleteRule := crCascade;
    end;
  end;
end;

procedure TfrmSchemaAdapter.Button1Click(Sender: TObject);
begin
  FDSchemaAdapter1.ApplyUpdates;
  FDMemTable1.CommitUpdates;
  FDMemTable2.CommitUpdates;
end;

end.

