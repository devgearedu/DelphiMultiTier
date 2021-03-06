program sample_Client;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  USplash in 'USplash.pas' {SplashForm},
  uInsa in 'uInsa.pas' {InsaForm},
  uDM in 'uDM.pas' {DM: TDataModule},
  uDept in 'uDept.pas' {DeptForm},
  Utrans in 'Utrans.pas' {TransForm},
  uTree in 'uTree.pas' {TreeForm},
  Vcl.RecError in 'Vcl.RecError.pas' {ReconcileErrorForm},
  uClientClass in 'uClientClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  SplashForm := TSplashForm.Create(application);
  SplashFOrm.Show;
  SplaShForm.Refresh;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDM, DM);
  SplashForm.Hide;
  SplashForm.free;
  Application.Run;
end.
