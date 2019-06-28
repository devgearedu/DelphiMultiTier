
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program CloudExplorer;

uses
//  FastMM4,
  Forms,
  CloudExplorerUI in 'CloudExplorerUI.pas' {CloudUIForm},
  CloudPopulator in 'CloudPopulator.pas',
  CloudAccountsIO in 'CloudAccountsIO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCloudUIForm, CloudUIForm);
  Application.Run;
end.
