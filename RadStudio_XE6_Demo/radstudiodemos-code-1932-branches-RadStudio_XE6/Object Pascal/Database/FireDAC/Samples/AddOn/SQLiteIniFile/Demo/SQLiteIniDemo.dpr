program SQLiteIniDemo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FireDAC.Phys.SQLiteIniFile in '..\FireDAC.Phys.SQLiteIniFile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
