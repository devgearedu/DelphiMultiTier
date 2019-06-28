
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program Swat;

uses
  Forms,
  Main in 'Main.pas' {SwatForm},
  about in 'about.pas' {AboutBox},
  options in 'options.pas' {OptionsDlg};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSwatForm, SwatForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TOptionsDlg, OptionsDlg);
  Application.Run;
end.
