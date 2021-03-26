program Project_client2;

uses
  Vcl.Forms,
  Umain_client_broadtochannel2 in 'Umain_client_broadtochannel2.pas' {Form15};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm15, Form15);
  Application.Run;
end.
