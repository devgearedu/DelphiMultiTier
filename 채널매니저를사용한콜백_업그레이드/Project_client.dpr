program Project_client;

uses
  Vcl.Forms,
  Umain_client_broadtochannel in 'Umain_client_broadtochannel.pas' {Form15};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm15, Form15);
  Application.Run;
end.
