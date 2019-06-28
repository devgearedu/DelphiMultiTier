
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program ShowSessionDataExample;
{$APPTYPE GUI}



uses
  Forms,
  WebReq,
  IdHTTPWebBrokerBridge,
  Unit1 in 'Unit1.pas' {Form1},
  ServerMethodsUnit2 in 'ServerMethodsUnit2.pas',
  Unit2 in 'Unit2.pas' {WebModule2: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
