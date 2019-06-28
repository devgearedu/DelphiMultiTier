program Project_restClient;

uses
  Vcl.Forms,
  Umain_client in 'Umain_client.pas' {Form212};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm212, Form212);
  Application.Run;
end.
