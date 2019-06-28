
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program FishFactsDSClient;

uses
  Forms,
  FormDSClient in 'FormDSClient.pas' {FormDSClient1},
  ClientClassesUnit_FishFactsIndy in 'ClientClassesUnit_FishFactsIndy.pas',
  ClientModuleUnit_FishFactsIndy in 'ClientModuleUnit_FishFactsIndy.pas' {ClientModule_FishFactsIndy: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClientModule_FishFactsIndy, ClientModule_FishFactsIndy);
  Application.CreateForm(TFormDSClient1, FormDSClient1);
  Application.Run;
end.
