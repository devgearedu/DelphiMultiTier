//---------------------------------------------------------------------------

// This software is Copyright (c) 2013 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program ScrollableFormDemo;

uses
  FMX.Forms,
  FMX.Types,
  KeyboardDemoForm in 'KeyboardDemoForm.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  VKAutoShowMode := TVKAutoShowMode.Always;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
