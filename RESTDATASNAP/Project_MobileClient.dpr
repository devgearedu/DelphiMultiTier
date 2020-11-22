program Project_MobileClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  Umain_Mobile in 'Umain_Mobile.pas' {Form19};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm19, Form19);
  Application.Run;
end.
