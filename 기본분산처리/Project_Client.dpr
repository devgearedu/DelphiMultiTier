program Project_Client;

uses
  Vcl.Forms,
  Umain_Client in 'Umain_Client.pas' {Form213},
  UClientClass in 'UClientClass.pas',
  Vcl.RecError in 'Vcl.RecError.pas' {ReconcileErrorForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm213, Form213);
  Application.Run;
end.
