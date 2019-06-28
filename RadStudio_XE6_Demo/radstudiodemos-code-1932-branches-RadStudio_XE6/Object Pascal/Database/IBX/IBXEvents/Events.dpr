
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program Events;

uses
  Forms,
  Event1 in 'Event1.pas' {frmEvents},
  Event2 in 'Event2.pas' {dmEvents};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmEvents, dmEvents);
  Application.CreateForm(TfrmEvents, frmEvents);
  Application.Run;
end.
