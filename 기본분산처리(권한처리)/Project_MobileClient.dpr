program Project_MobileClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMain_Mobile in 'UMain_Mobile.pas' {Form222},
  UClientclassMobile in 'UClientclassMobile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm222, Form222);
  Application.Run;
end.
