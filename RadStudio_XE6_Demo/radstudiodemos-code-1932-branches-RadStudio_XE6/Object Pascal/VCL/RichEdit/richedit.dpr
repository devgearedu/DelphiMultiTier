
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program richeditdemo;

uses
  Forms,
  reabout in 'reabout.pas' {AboutBox},
  remain in 'remain.pas' {MainForm},
  reinit in 'reinit.pas';

{$R richedit.RES}

begin
  Application.Initialize;
  Application.Title := 'Rich Edit Control Demo';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
