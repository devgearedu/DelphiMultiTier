
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program ThreadedQuery;

uses
  Forms,
  frmMain in 'frmMain.pas' {Main},
  frmQueryResultsU in 'frmQueryResultsU.pas' {frmQueryResults},
  dmThreadU in 'dmThreadU.pas' {dmThread: TDataModule},
  ThreadQueryU in 'ThreadQueryU.pas',
  frmQueryGridResultsU in 'frmQueryGridResultsU.pas' {frmQueryGridResults};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
