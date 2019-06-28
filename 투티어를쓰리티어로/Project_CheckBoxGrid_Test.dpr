program Project_CheckBoxGrid_Test;

uses
  Vcl.Forms,
  UCheckBoxGrid_Test in 'UCheckBoxGrid_Test.pas' {Form185},
  Ucheckgrid in 'Ucheckgrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm185, Form185);
  Application.Run;
end.
