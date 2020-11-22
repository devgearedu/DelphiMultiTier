program Project_Client;

uses
  Vcl.Forms,
  umain_Client in 'umain_Client.pas' {Form19},
  Vcl.RecError in 'Vcl.RecError.pas' {ReconcileErrorForm},
  uClientclass in 'uClientclass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm19, Form19);
  Application.CreateForm(TForm19, Form19);
  Application.Run;
end.
