program Project_Mobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  umain_Mobile in 'umain_Mobile.pas' {Form19},
  ClientClassesUnit3 in 'ClientClassesUnit3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm19, Form19);
  Application.Run;
end.
