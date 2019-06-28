program Project_Client;

uses
  Vcl.Forms,
  Umain_client_broadtochannel in 'Umain_client_broadtochannel.pas' {Form15},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TForm15, Form15);
  Application.Run;
end.
