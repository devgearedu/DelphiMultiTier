
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program ServerProjectWithUserTypes;

uses
  Forms,
  ServerFormUnit60 in 'ServerFormUnit60.pas' {Form60},
  ServerContainerUnit8 in 'ServerContainerUnit8.pas' {ServerContainer8: TDataModule},
  ServerMethodsUnit2 in 'ServerMethodsUnit2.pas',
  StringsField in 'StringsField.pas',
  PersonISODate in 'PersonISODate.pas',
  Person1 in 'Person1.pas',
  MarshalUnsupportedFields in 'MarshalUnsupportedFields.pas',
  MarshallingUtils in 'MarshallingUtils.pas',
  GenericDictionaryField in 'GenericDictionaryField.pas',

  GenericListField in 'GenericListField.pas' ;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm60, Form60);
  Application.CreateForm(TServerContainer8, ServerContainer8);
  Application.Run;
end.

