unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, DB, Grids, DBGrids, StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Def, FireDAC.Stan.Error, FireDAC.Stan.Param,
    FireDAC.Stan.ExprFuncs, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.DatS,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Phys.Intf, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteCli, FireDAC.Phys.SQLiteWrapper,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDSQLiteCollation1: TFDSQLiteCollation;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  FDQuery1.Open('SELECT * FROM "Employees" ORDER BY LastName COLLATE UTF16NoCase');

//  FDQuery1.ExecSQL('CREATE TABLE IF NOT EXISTS test_col (f1 VARCHAR(10) COLLATE UTF16NoCase)');
//  FDQuery1.Open('SELECT * FROM test_col ORDER BY f1');
end;

end.
