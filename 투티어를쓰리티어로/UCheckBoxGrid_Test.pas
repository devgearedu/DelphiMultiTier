unit UCheckBoxGrid_Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Ucheckgrid, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI;

type
  TForm185 = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDTable1: TFDTable;
    DataSource1: TDataSource;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form185: TForm185;

implementation

{$R *.dfm}

procedure TForm185.Button1Click(Sender: TObject);
var
  sum: integer;
  I: integer;
begin
  if DBGrid1.SelectedRows.Count > 0 then
  begin
    sum := 0;
    with DBGrid1.DataSource.DataSet do
    begin
      DisableControls;
      try
        for I := 0 to DBGrid1.SelectedRows.Count-1 do
        begin
          GotoBookmark(DBGrid1.SelectedRows.Items[I]);  // i 번째 선택된 레코드로 이동
          Sum := Sum +  FDTable1.FieldByName('Salary').AsInteger;
        end;
      finally
        EnableControls;
      end;
    end;
    Label1.Caption := FormatFloat('#,##0원',Sum);
  end;

end;

procedure TForm185.Button2Click(Sender: TObject);
begin
   Dbgrid1.SelectedRows.Clear;
end;

end.
