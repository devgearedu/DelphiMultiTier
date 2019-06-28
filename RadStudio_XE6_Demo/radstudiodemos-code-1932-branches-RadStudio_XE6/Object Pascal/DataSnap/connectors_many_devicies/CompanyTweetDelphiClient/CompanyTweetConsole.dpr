
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program CompanyTweetConsole;

uses
  Forms,
  MainClientForm in 'MainClientForm.pas' {Form8},
  ClientClassesUnit in 'ClientClassesUnit.pas',
  ClientModuleUnit in 'ClientModuleUnit.pas' {ClientModule1: TDataModule},
  TweetCallbackUnit in 'TweetCallbackUnit.pas';

{$R *.res}


begin
 // ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;

end.
