unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, DB, Grids, DBGrids, StdCtrls, ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Def, FireDAC.Stan.Error, FireDAC.Stan.Param,
    FireDAC.Stan.ExprFuncs, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.DatS,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleCli, FireDAC.Phys.OracleWrapper,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDStoredProc1: TFDStoredProc;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysOracleDriverLink1: TFDPhysOracleDriverLink;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDConnection1.Connected := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  FDConnection1.ResourceOptions.ServerOutput := True;

  FDStoredProc1.Params[0].ArraySize := Memo1.Lines.Count;
  for i := 0 to Memo1.Lines.Count - 1 do
    FDStoredProc1.Params[0].AsStrings[i] := Memo1.Lines[i];
  Memo1.Lines.Clear;

  try
    FDStoredProc1.ExecProc;
    for i := 0 to FDStoredProc1.Params[0].ArraySize - 1 do
      Memo1.Lines.Add(FDStoredProc1.Params[0].AsStrings[i]);
  finally
    if FDConnection1.Messages <> nil then
      for i := 0 to FDConnection1.Messages.ErrorCount - 1 do
        Memo1.Lines.Add(FDConnection1.Messages[i].Message);
  end;
end;

end.
