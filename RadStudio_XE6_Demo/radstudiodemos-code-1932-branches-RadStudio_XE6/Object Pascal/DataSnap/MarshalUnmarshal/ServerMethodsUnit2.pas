
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// Server methods to test marshalling user types.
// "Get" methods test returning a user type
// "Validate" methods test passing a user type from client to server
unit ServerMethodsUnit2;

interface

uses
  SysUtils, Classes, DSServer, Person1, MarshalUnsupportedFields,
  GenericListField, GenericDictionaryField, StringsField, PersonISODate, DBXJson,
  System.JSON,
  Generics.Collections;

type
{$METHODINFO ON}
  TServerMethods2 = class(TComponent)
  private
    FObjectsToFree: TObjectList<TObject>;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetPerson: TPerson1;
    function GetPersonCollection: TPerson1Collection;
    function GetPerson_Attribute: TPersonISODate_Attribute;
    function GetPerson_Register: TPersonISODate_Register;
    function GetClassWithTStrings_Attribute: TClassWithTStringsField_Attribute;
    function GetClassWithTStrings_Register: TClassWithTStringsField_Register;
    function GetGenericListField: TClassWithGenericListField;
    function GetGenericListField_Register: TClassWithGenericListField_Register;
    function GetGenericDictionaryField: TClassWithGenericDictionaryField;
    function GetGenericDictionaryField_Register: TClassWithGenericDictionaryField_Register;
    function GetUnsupportedFields: TUnsupportedFieldsClass;
    function GetUnsupportedFields_Register: TUnsupportedFieldsClass_Register;
    function ValidateClassWithTStrings_Attribute(
      AValue: TClassWithTStringsField_Attribute): Boolean;
    function ValidateClassWithTStrings_Register(
      AValue: TClassWithTStringsField_Register): Boolean;
    function ValidateGenericListField(AValue: TClassWithGenericListField): Boolean;
    function ValidateGenericListField_Register(AValue: TClassWithGenericListField_Register): Boolean;
    function ValidateGenericDictionaryField(AValue: TClassWithGenericDictionaryField): Boolean;
    function ValidateGenericDictionaryField_Register(AValue: TClassWithGenericDictionaryField_Register): Boolean;
    function ValidatePerson_Register(AValue: TPersonISODate_Register): Boolean;
    function ValidatePerson(AValue: TPerson1): Boolean;
    function ValidatePerson_Attribute(AValue: TPersonISODate_Attribute): Boolean;
    function ValidatePersonCollection(AValue: TPerson1Collection): Boolean;
    function ValidateUnsupportedFields(AValue: TUnsupportedFieldsClass): Boolean;
    function ValidateUnsupportedFields_Register(AValue: TUnsupportedFieldsClass_Register): Boolean;
    function ProcessArray(Value: TJSONValue): Boolean;
    function GetGenericDictionary: TMyDictionary;
    function ValidateGenericDictionary(AValue: TMyDictionary): Boolean;
    function GetGenericDictionaryPairs: TMyDictionaryPairs;
    function  ValidateGenericDictionaryPairs(AValue: TMyDictionaryPairs): Boolean;
  end;
{$METHODINFO OFF}

implementation


uses StrUtils;

constructor TServerMethods2.Create(AOwner: TComponent);
begin
  inherited;
  FObjectsToFree := TObjectList<TObject>.Create(True);
end;

destructor TServerMethods2.Destroy;
begin
  FObjectsToFree.Free;
  inherited;
end;

function TServerMethods2.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods2.GetClassWithTStrings_Attribute: TClassWithTStringsField_Attribute;
begin
  Result := TClassWithTStringsField_Attribute.Create;
  LoadClassWithTStringsSampleDate(Result);
end;

function TServerMethods2.ValidateClassWithTStrings_Attribute(AValue: TClassWithTStringsField_Attribute): Boolean;
begin
  try
    ValidateClassWithTStringsSampleDate(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.GetClassWithTStrings_Register: TClassWithTStringsField_Register;
begin
  Result := TClassWithTStringsField_Register.Create;
  LoadClassWithTStringsSampleDate(Result);
end;

function TServerMethods2.ValidateClassWithTStrings_Register(AValue: TClassWithTStringsField_Register): Boolean;
begin
  try
    ValidateClassWithTStringsSampleDate(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.GetGenericListField_Register: TClassWithGenericListField_Register;
begin
  Result := TClassWithGenericListField_Register.Create;
  LoadClassWithGenericListField(Result);
end;

function TServerMethods2.GetGenericListField: TClassWithGenericListField;
begin
  Result := TClassWithGenericListField.Create;
  LoadClassWithGenericListField(Result);
end;

function TServerMethods2.ValidateGenericListField(AValue: TClassWithGenericListField): Boolean;
begin
  try
    GenericListField.ValidateClassWithGenericListField(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.ValidateGenericListField_Register(AValue: TClassWithGenericListField_Register): Boolean;
begin
  try
    GenericListField.ValidateClassWithGenericListField(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.GetGenericDictionaryField_Register: TClassWithGenericDictionaryField_Register;
begin
  Result := TClassWithGenericDictionaryField_Register.Create;
  LoadClassWithGenericDictionaryField(Result);
end;

function TServerMethods2.GetGenericDictionary: TMyDictionary;
begin
  Result := TMyDictionary.Create;
  LoadGenericDictionary(Result);
end;

function TServerMethods2.GetGenericDictionaryPairs: TMyDictionaryPairs;
var
  LDictionary: TMyDictionary;
begin
  LDictionary := TMyDictionary.Create;
  FObjectsToFree.Clear;
  // Keep track of the dictionary so that it will be freed later, sometime after this
  // server method returns.
  FObjectsToFree.Add(LDictionary);
  LoadGenericDictionary(LDictionary);
  Result := TMyDictionaryPairs.Create(LDictionary.ToArray);
end;

function TServerMethods2.GetGenericDictionaryField: TClassWithGenericDictionaryField;
begin
  Result := TClassWithGenericDictionaryField.Create;
  LoadClassWithGenericDictionaryField(Result);
end;

function TServerMethods2.ValidateGenericDictionary(
  AValue: TMyDictionary): Boolean;
begin
  try
    GenericDictionaryField.ValidateGenericDictionary(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.ValidateGenericDictionaryPairs(
  AValue: TMyDictionaryPairs): Boolean;
var
  LPair: TPair<string, TMyDictionaryItem>;
  LDictionary: TMyDictionary;
begin
  LDictionary := TMyDictionary.Create;
  try
    // Load pairs into a dictionary
    for LPair in AValue.Pairs do
      LDictionary.Add(LPair.Key, LPair.Value);
    try
      GenericDictionaryField.ValidateGenericDictionary(LDictionary);
      Result := True;
    except
      Result := False;
    end;
  finally
    LDictionary.Free;
  end;
end;

function TServerMethods2.ValidateGenericDictionaryField(AValue: TClassWithGenericDictionaryField): Boolean;
begin
  try
    GenericDictionaryField.ValidateClassWithGenericDictionaryField(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.ValidateGenericDictionaryField_Register(AValue: TClassWithGenericDictionaryField_Register): Boolean;
begin
  try
    GenericDictionaryField.ValidateClassWithGenericDictionaryField(AValue);
    Result := True;
  except
    Result := False;
  end;
end;


function TServerMethods2.GetPerson: TPerson1;
begin
  Result := TPerson1.Create;
  LoadPerson1SampleData(Result);
end;

function TServerMethods2.ValidatePerson(AValue: TPerson1): Boolean;
begin
  try
    ValidatePerson1SampleData(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.GetPersonCollection: TPerson1Collection;
begin
  Result := TPerson1Collection.Create;
  LoadPerson1CollectionSampleData(Result);
end;

function TServerMethods2.ValidatePersonCollection(AValue: TPerson1Collection): Boolean;
begin
  try
    ValidatePerson1CollectionSampleData(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.GetPerson_Attribute: TPersonISODate_Attribute;
begin
  Result := TPersonISODate_Attribute.Create;
  LoadPersonISODateSampleData(Result);
end;

function TServerMethods2.ValidatePerson_Attribute(AValue: TPersonISODate_Attribute): Boolean;
begin
  try
    ValidatePersonISODateSampleData(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.GetPerson_Register: TPersonISODate_Register;
begin
  Result := TPersonISODate_Register.Create;
  LoadPersonISODateSampleData(Result);
end;

function TServerMethods2.ValidatePerson_Register(AValue: TPersonISODate_Register): Boolean;
begin
  try
    ValidatePersonISODateSampleData(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.GetUnsupportedFields: TUnsupportedFieldsClass;
begin
  Result := TUnsupportedFieldsClass.Create;
  LoadUnsupportedFieldsClass(Result);
end;

function TServerMethods2.GetUnsupportedFields_Register: TUnsupportedFieldsClass_Register;
begin
  Result := TUnsupportedFieldsClass_Register.Create;
  LoadUnsupportedFieldsClass(Result);
end;

function TServerMethods2.ValidateUnsupportedFields(AValue: TUnsupportedFieldsClass): Boolean;
begin
  try
    MarshalUnsupportedFields.ValidateUnsupportedFieldsClass(AValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TServerMethods2.ValidateUnsupportedFields_Register(AValue: TUnsupportedFieldsClass_Register): Boolean;
begin
  try
    MarshalUnsupportedFields.ValidateUnsupportedFieldsClass(AValue);
    Result := True;
  except
    Result := False;
  end;
end;


function TServerMethods2.ReverseString(Value: string): string;
begin
  Result := StrUtils.ReverseString(Value);
end;

function TServerMethods2.ProcessArray(Value: TJSONValue): Boolean;
begin
  Result := (Value is TJSONArray) and (TJSONArray(Value).Size > 0);

end;

end.

