
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program DBXClientChannels;

uses
  Forms,
  DBXClientFormUnit56 in 'DBXClientFormUnit56.pas' {DBXClientForm56};

{$R *.res}

type
  TNeverFreed = class

  end;
begin
//  TNeverFreed.Create;  // Make sure fastmm memory leak detection is working
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDBXClientForm56, DBXClientForm56);
  Application.Run;
end.
