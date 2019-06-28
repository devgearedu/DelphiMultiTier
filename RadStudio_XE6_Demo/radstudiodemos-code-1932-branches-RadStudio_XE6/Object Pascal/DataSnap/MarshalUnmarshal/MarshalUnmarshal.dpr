
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program MarshalUnmarshal;

uses
  Forms,
  FormUnit in 'FormUnit.pas' {Form56},
  TestTypeFactory in 'TestTypeFactory.pas',
  MarshalUnsupportedFields in 'MarshalUnsupportedFields.pas',
  GenericListField in 'GenericListField.pas',
  Person1 in 'Person1.pas',
  PersonFactories in 'PersonFactories.pas',
  PersonISODate in 'PersonISODate.pas',
  MarshallingUtils in 'MarshallingUtils.pas',
  StringsField in 'StringsField.pas',
  RegisterTypeFactories in 'RegisterTypeFactories.pas',
  GenericDictionaryField in 'GenericDictionaryField.pas',
  SampleCollection in 'SampleCollection.pas';

{$R *.res}

type
  TNeverFreedObject = class

  end;
begin
//  TNeverFreedObject.Create; // Make sure that fastmm leak detection is enabled.
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm56, Form56);
  Application.Run;
end.
