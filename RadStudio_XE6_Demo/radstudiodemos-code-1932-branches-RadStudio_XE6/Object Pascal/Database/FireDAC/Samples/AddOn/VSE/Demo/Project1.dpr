program Project1;

uses
  Forms,
  FireDAC.Comp.VSE in '..\FireDAC.Comp.VSE.pas',
  FireDAC.Comp.VSEXML in '..\FireDAC.Comp.VSEXML.pas',
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
