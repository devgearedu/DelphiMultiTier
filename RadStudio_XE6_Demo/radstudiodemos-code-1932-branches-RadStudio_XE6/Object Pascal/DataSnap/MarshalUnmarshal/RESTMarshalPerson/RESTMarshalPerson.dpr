
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program RESTMarshalPerson;
{$APPTYPE GUI}

{$R *.dres}

uses
  Forms,
  WebReq,
  IdHTTPWebBrokerBridge,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {WebModule2: TWebModule},
  ServerMethodsUnit2 in '..\ServerMethodsUnit2.pas',
  StringsField in '..\StringsField.pas',
  PersonISODate in '..\PersonISODate.pas',
  Person1 in '..\Person1.pas',
  MarshalUnsupportedFields in '..\MarshalUnsupportedFields.pas',
  MarshallingUtils in '..\MarshallingUtils.pas',
  GenericListField in '..\GenericListField.pas',
  GenericDictionaryField in '..\GenericDictionaryField.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
