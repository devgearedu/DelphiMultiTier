program Project37;

uses
  Forms,
  Unit37 in 'Unit37.pas' {Form37};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm37, Form37);
  Application.Run;
end.
