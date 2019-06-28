
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program SessionStoreObject;

uses
  Vcl.Forms,
  SessionStoreObjectUI in 'SessionStoreObjectUI.pas' {Form3},
  SSOServerMethodsUnit in 'SSOServerMethodsUnit.pas',
  SSOServerContainer in 'SSOServerContainer.pas' {ServerContainer3: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TServerContainer3, ServerContainer3);
  Application.Run;
end.

