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
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDSQLiteFunction1: TFDSQLiteFunction;
    FDSQLiteFunction2: TFDSQLiteFunction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FDSQLiteFunction1Calculate(AFunc: TSQLiteFunction;
      AInputs: TSQLiteInputs; AOutput: TSQLiteOutput; var AUserData: TObject);
    procedure FDSQLiteFunction2Calculate(AFunc: TSQLiteFunction;
      AInputs: TSQLiteInputs; AOutput: TSQLiteOutput; var AUserData: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{-------------------------------------------------------------------------------}
{ XmY - the trivial user function =X*Y }

procedure TForm1.FDSQLiteFunction1Calculate(AFunc: TSQLiteFunction;
  AInputs: TSQLiteInputs; AOutput: TSQLiteOutput; var AUserData: TObject);
begin
  AOutput.AsInteger := AInputs[0].AsInteger * AInputs[1].AsInteger;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // demo query
  FDQuery1.Open('select RegionID, XmY(RegionID, 10) from "Region"');
end;

{-------------------------------------------------------------------------------}
{ DBLookup - the user function, performing lookup of a result value
             by an id in a table }

procedure TForm1.FDSQLiteFunction2Calculate(AFunc: TSQLiteFunction;
  AInputs: TSQLiteInputs; AOutput: TSQLiteOutput; var AUserData: TObject);
var
  V: Variant;
begin
  V := FDConnection1.ExecSQLScalar(Format('select %s from %s where %s = %d', [
    AInputs[0].AsString,  // field to read
    AInputs[1].AsString,  // table name
    AInputs[2].AsString,  // id field
    AInputs[3].AsInteger  // id value
  ]));
  if VarIsNull(V) then
    AOutput.Clear
  else
    AOutput.AsString := V;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  // demo query
  FDQuery1.Open('select *, DBLookup(''RegionDescription'', ''"Region"'', ''RegionID'', RegionID) from "Territories"');
end;

end.
