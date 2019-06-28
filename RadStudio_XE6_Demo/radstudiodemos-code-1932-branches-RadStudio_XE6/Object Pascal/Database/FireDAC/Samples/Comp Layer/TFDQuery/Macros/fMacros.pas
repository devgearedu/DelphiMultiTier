unit fMacros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, DB, ComCtrls, ValEdit,
  fMainQueryBase,
  FireDAC.Stan.Intf, FireDAC.DatS, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
    FireDAC.VCLUI.ResourceOptions, FireDAC.VCLUI.FetchOptions,
    FireDAC.VCLUI.FormatOptions, FireDAC.VCLUI.UpdateOptions, FireDAC.VCLUI.Controls,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmMacros = class(TfrmMainQueryBase)
    Bevel1: TBevel;
    DBGrid1: TDBGrid;
    qryMain: TFDQuery;
    DataSource1: TDataSource;
    btnOpenQuery: TButton;
    mmComment: TMemo;
    lstMacros: TValueListEditor;
    mmSQL: TMemo;
    lblDataType: TLabel;
    cbDataType: TComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnOpenQueryClick(Sender: TObject);
    procedure lstMacrosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure cbDataTypeChange(Sender: TObject);
    procedure cbDBClick(Sender: TObject);
    procedure lstMacrosSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMacros: TfrmMacros;

implementation

uses
  dmMainComp;

{$R *.dfm}

procedure TfrmMacros.FormCreate(Sender: TObject);
var
  i: Integer;
  l: Boolean;
begin
  inherited FormCreate(Sender);
  RegisterDS(qryMain);
  mmSQL.Lines := qryMain.SQL;
  lstMacros.Strings.Clear;
  for i := 0 to qryMain.Macros.Count - 1 do
    lstMacros.InsertRow(qryMain.Macros[i].Name, qryMain.Macros[i].Value, True);
  lstMacrosSelectCell(nil, 0, 1, l);
end;

procedure TfrmMacros.cbDBClick(Sender: TObject);
begin
  qryMain.Close;
  inherited cbDBClick(Sender);

  btnOpenQuery.Enabled := True;
end;

procedure TfrmMacros.btnOpenQueryClick(Sender: TObject);
begin
  qryMain.Open;
end;

procedure TfrmMacros.lstMacrosSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  cbDataType.ItemIndex := Ord(qryMain.Macros[ARow - 1].DataType);
end;

procedure TfrmMacros.cbDataTypeChange(Sender: TObject);
begin
  qryMain.Macros[lstMacros.Row - 1].DataType := TFDMacroDataType(cbDataType.ItemIndex);
end;

procedure TfrmMacros.lstMacrosSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
begin
  qryMain.Macros[ARow - 1].Value := Value;
end;

end.
