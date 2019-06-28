
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program DockEx;

uses
  Forms,
  Graphics,
  SysUtils,
  uMain in 'uMain.pas' {MainForm},
  uDockForm in 'uDockForm.pas' {DockableForm},
  uConjoinHost in 'uConjoinHost.pas' {ConjoinDockHost},
  uTabHost in 'uTabHost.pas' {TabDockHost},
  Vcl.Themes in 'Vcl.Themes.pas',
  DockingUtils in 'DockingUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
