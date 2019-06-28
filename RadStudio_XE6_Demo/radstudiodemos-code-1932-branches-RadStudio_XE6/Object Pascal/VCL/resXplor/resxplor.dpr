
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program ResXplor;



uses
  Forms,
  ExeImage,
  RXMain in 'RXMain.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Resource Explorer';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
