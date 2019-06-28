program Project_Mobile_Client;

uses
  System.StartUpCopy,
  FMX.Forms,
  Umain_mobile in 'Umain_mobile.pas' {Form1},
  UClientClass_mobile in 'UClientClass_mobile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
