
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program ctServer;

uses
  Forms,
  MainServerForm in 'MainServerForm.pas' {Form9},
  CompanyTweetServerContainer in 'CompanyTweetServerContainer.pas' {ServerContainer1: TDataModule},
  ctServerMethods in 'ctServerMethods.pas' {CompanyTweet: TDataModule},
  ctManager in 'ctManager.pas',
  ctUser in 'ctUser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

