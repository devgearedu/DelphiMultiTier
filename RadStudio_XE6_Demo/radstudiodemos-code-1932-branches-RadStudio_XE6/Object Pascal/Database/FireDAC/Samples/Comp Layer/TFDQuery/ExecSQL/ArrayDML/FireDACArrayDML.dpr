program FireDACArrayDML;

uses
  Forms,
  fMain in 'fMain.pas' {frmDMLArrayTest};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDMLArrayTest, frmDMLArrayTest);
  Application.Run;
end.
