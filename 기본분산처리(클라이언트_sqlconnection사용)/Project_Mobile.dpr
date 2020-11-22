program Project_Mobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  umain_Mobile in 'umain_Mobile.pas' {Form20},
  uClientclass_Mobile in 'uClientclass_Mobile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm20, Form20);
  Application.Run;
end.
