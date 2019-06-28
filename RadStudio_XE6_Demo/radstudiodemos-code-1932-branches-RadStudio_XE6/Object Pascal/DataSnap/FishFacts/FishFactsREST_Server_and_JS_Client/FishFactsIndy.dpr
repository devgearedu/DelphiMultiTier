
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program FishFactsIndy;
{$APPTYPE GUI}

{$R *.dres}

uses
  Forms,
  WebReq,
  IdHTTPWebBrokerBridge,
  Unit1 in 'Unit1.pas' {FormFishFacts},
  FishFactsServerMethods in 'FishFactsServerMethods.pas',
  WebModule in 'WebModule.pas' {FishFactsWebModule: TWebModule},
  DataModule in 'DataModule.pas' {FactsDataModule: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFormFishFacts, FormFishFacts);
  Application.CreateForm(TFactsDataModule, FactsDataModule);
  Application.Run;
end.
