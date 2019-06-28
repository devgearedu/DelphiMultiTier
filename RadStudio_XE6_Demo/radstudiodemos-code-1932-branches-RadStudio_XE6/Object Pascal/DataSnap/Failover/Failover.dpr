
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program Failover;

uses
  Forms,
  HTPServerTest in 'HTPServerTest.pas' {Form6},
  DSUtilityUnit in 'DSUtilityUnit.pas' {DSUtilityMethods: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TDSUtilityMethods, DSUtilityMethods);
  Application.Run;
end.
