
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program MonitorConnectionsClientProject;

uses
  Forms,
  MonitorClientUI in 'MonitorClientUI.pas' {ClientUIForm},
  CMClientClassesUnit in 'CMClientClassesUnit.pas',
  CMClientModuleUnit in 'CMClientModuleUnit.pas' {CMClientModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClientUIForm, ClientUIForm);
  Application.CreateForm(TCMClientModule, CMClientModule);
  Application.Run;
end.
