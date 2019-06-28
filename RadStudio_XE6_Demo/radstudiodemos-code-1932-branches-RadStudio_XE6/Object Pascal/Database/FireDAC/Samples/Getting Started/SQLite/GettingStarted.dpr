program GettingStarted;

uses
  Forms,
  fGettingStarted in 'fGettingStarted.pas' {frmGettingStarted};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmGettingStarted, frmGettingStarted);
  Application.Run;
end.
