program Project_Client;

uses
  Vcl.Forms,
  UMain_Client in 'UMain_Client.pas' {Form221},
  UClientClass in 'UClientClass.pas',
  Vcl.RecError in 'Vcl.RecError.pas' {ReconcileErrorForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm221, Form221);
  Application.Run;
end.
