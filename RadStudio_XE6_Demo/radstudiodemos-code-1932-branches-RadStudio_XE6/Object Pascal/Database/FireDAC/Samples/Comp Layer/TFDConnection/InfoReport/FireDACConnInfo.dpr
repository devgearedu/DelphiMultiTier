program FireDACConnInfo;

uses
  Forms,
  fMain in 'fMain.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
