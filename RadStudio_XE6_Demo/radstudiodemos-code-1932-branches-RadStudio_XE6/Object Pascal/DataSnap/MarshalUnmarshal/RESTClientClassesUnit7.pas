
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
//
// Created by the DataSnap proxy generator.
// 10/19/2010 5:49:45 AM
//

unit RESTClientClassesUnit7;

interface

uses DSProxyRest, DSClientRest, DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Person1, PersonISODate, StringsField, GenericListField, GenericDictionaryField, MarshalUnsupportedFields, DBXJSONReflect;

type

  IDSRestCachedTPerson1 = interface;
  IDSRestCachedTUnsupportedFieldsClass = interface;
  IDSRestCachedTPerson1Collection = interface;
  IDSRestCachedTPersonISODate_Register = interface;
  IDSRestCachedTClassWithGenericListField_Register = interface;
  IDSRestCachedTClassWithGenericDictionaryField_Register = interface;
  IDSRestCachedTMyDictionaryPairs = interface;
  IDSRestCachedTUnsupportedFieldsClass_Register = interface;
  IDSRestCachedTClassWithTStringsField_Register = interface;
  IDSRestCachedTPersonISODate_Attribute = interface;
  IDSRestCachedTClassWithGenericDictionaryField = interface;
  IDSRestCachedTClassWithTStringsField_Attribute = interface;
  IDSRestCachedTClassWithGenericListField = interface;
  IDSRestCachedTMyDictionary = interface;

  TServerMethods2Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetPersonCommand: TDSRestCommand;
    FGetPersonCommand_Cache: TDSRestCommand;
    FGetPersonCollectionCommand: TDSRestCommand;
    FGetPersonCollectionCommand_Cache: TDSRestCommand;
    FGetPerson_AttributeCommand: TDSRestCommand;
    FGetPerson_AttributeCommand_Cache: TDSRestCommand;
    FGetPerson_RegisterCommand: TDSRestCommand;
    FGetPerson_RegisterCommand_Cache: TDSRestCommand;
    FGetClassWithTStrings_AttributeCommand: TDSRestCommand;
    FGetClassWithTStrings_AttributeCommand_Cache: TDSRestCommand;
    FGetClassWithTStrings_RegisterCommand: TDSRestCommand;
    FGetClassWithTStrings_RegisterCommand_Cache: TDSRestCommand;
    FGetGenericListFieldCommand: TDSRestCommand;
    FGetGenericListFieldCommand_Cache: TDSRestCommand;
    FGetGenericListField_RegisterCommand: TDSRestCommand;
    FGetGenericListField_RegisterCommand_Cache: TDSRestCommand;
    FGetGenericDictionaryFieldCommand: TDSRestCommand;
    FGetGenericDictionaryFieldCommand_Cache: TDSRestCommand;
    FGetGenericDictionaryField_RegisterCommand: TDSRestCommand;
    FGetGenericDictionaryField_RegisterCommand_Cache: TDSRestCommand;
    FGetUnsupportedFieldsCommand: TDSRestCommand;
    FGetUnsupportedFieldsCommand_Cache: TDSRestCommand;
    FGetUnsupportedFields_RegisterCommand: TDSRestCommand;
    FGetUnsupportedFields_RegisterCommand_Cache: TDSRestCommand;
    FValidateClassWithTStrings_AttributeCommand: TDSRestCommand;
    FValidateClassWithTStrings_RegisterCommand: TDSRestCommand;
    FValidateGenericListFieldCommand: TDSRestCommand;
    FValidateGenericListField_RegisterCommand: TDSRestCommand;
    FValidateGenericDictionaryFieldCommand: TDSRestCommand;
    FValidateGenericDictionaryField_RegisterCommand: TDSRestCommand;
    FValidatePerson_RegisterCommand: TDSRestCommand;
    FValidatePersonCommand: TDSRestCommand;
    FValidatePerson_AttributeCommand: TDSRestCommand;
    FValidatePersonCollectionCommand: TDSRestCommand;
    FValidateUnsupportedFieldsCommand: TDSRestCommand;
    FValidateUnsupportedFields_RegisterCommand: TDSRestCommand;
    FProcessArrayCommand: TDSRestCommand;
    FGetGenericDictionaryCommand: TDSRestCommand;
    FGetGenericDictionaryCommand_Cache: TDSRestCommand;
    FValidateGenericDictionaryCommand: TDSRestCommand;
    FGetGenericDictionaryPairsCommand: TDSRestCommand;
    FGetGenericDictionaryPairsCommand_Cache: TDSRestCommand;
    FValidateGenericDictionaryPairsCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetPerson(const ARequestFilter: string = ''): TPerson1;
    function GetPerson_Cache(const ARequestFilter: string = ''): IDSRestCachedTPerson1;
    function GetPersonCollection(const ARequestFilter: string = ''): TPerson1Collection;
    function GetPersonCollection_Cache(const ARequestFilter: string = ''): IDSRestCachedTPerson1Collection;
    function GetPerson_Attribute(const ARequestFilter: string = ''): TPersonISODate_Attribute;
    function GetPerson_Attribute_Cache(const ARequestFilter: string = ''): IDSRestCachedTPersonISODate_Attribute;
    function GetPerson_Register(const ARequestFilter: string = ''): TPersonISODate_Register;
    function GetPerson_Register_Cache(const ARequestFilter: string = ''): IDSRestCachedTPersonISODate_Register;
    function GetClassWithTStrings_Attribute(const ARequestFilter: string = ''): TClassWithTStringsField_Attribute;
    function GetClassWithTStrings_Attribute_Cache(const ARequestFilter: string = ''): IDSRestCachedTClassWithTStringsField_Attribute;
    function GetClassWithTStrings_Register(const ARequestFilter: string = ''): TClassWithTStringsField_Register;
    function GetClassWithTStrings_Register_Cache(const ARequestFilter: string = ''): IDSRestCachedTClassWithTStringsField_Register;
    function GetGenericListField(const ARequestFilter: string = ''): TClassWithGenericListField;
    function GetGenericListField_Cache(const ARequestFilter: string = ''): IDSRestCachedTClassWithGenericListField;
    function GetGenericListField_Register(const ARequestFilter: string = ''): TClassWithGenericListField_Register;
    function GetGenericListField_Register_Cache(const ARequestFilter: string = ''): IDSRestCachedTClassWithGenericListField_Register;
    function GetGenericDictionaryField(const ARequestFilter: string = ''): TClassWithGenericDictionaryField;
    function GetGenericDictionaryField_Cache(const ARequestFilter: string = ''): IDSRestCachedTClassWithGenericDictionaryField;
    function GetGenericDictionaryField_Register(const ARequestFilter: string = ''): TClassWithGenericDictionaryField_Register;
    function GetGenericDictionaryField_Register_Cache(const ARequestFilter: string = ''): IDSRestCachedTClassWithGenericDictionaryField_Register;
    function GetUnsupportedFields(const ARequestFilter: string = ''): TUnsupportedFieldsClass;
    function GetUnsupportedFields_Cache(const ARequestFilter: string = ''): IDSRestCachedTUnsupportedFieldsClass;
    function GetUnsupportedFields_Register(const ARequestFilter: string = ''): TUnsupportedFieldsClass_Register;
    function GetUnsupportedFields_Register_Cache(const ARequestFilter: string = ''): IDSRestCachedTUnsupportedFieldsClass_Register;
    function ValidateClassWithTStrings_Attribute(AValue: TClassWithTStringsField_Attribute; const ARequestFilter: string = ''): Boolean;
    function ValidateClassWithTStrings_Register(AValue: TClassWithTStringsField_Register; const ARequestFilter: string = ''): Boolean;
    function ValidateGenericListField(AValue: TClassWithGenericListField; const ARequestFilter: string = ''): Boolean;
    function ValidateGenericListField_Register(AValue: TClassWithGenericListField_Register; const ARequestFilter: string = ''): Boolean;
    function ValidateGenericDictionaryField(AValue: TClassWithGenericDictionaryField; const ARequestFilter: string = ''): Boolean;
    function ValidateGenericDictionaryField_Register(AValue: TClassWithGenericDictionaryField_Register; const ARequestFilter: string = ''): Boolean;
    function ValidatePerson_Register(AValue: TPersonISODate_Register; const ARequestFilter: string = ''): Boolean;
    function ValidatePerson(AValue: TPerson1; const ARequestFilter: string = ''): Boolean;
    function ValidatePerson_Attribute(AValue: TPersonISODate_Attribute; const ARequestFilter: string = ''): Boolean;
    function ValidatePersonCollection(AValue: TPerson1Collection; const ARequestFilter: string = ''): Boolean;
    function ValidateUnsupportedFields(AValue: TUnsupportedFieldsClass; const ARequestFilter: string = ''): Boolean;
    function ValidateUnsupportedFields_Register(AValue: TUnsupportedFieldsClass_Register; const ARequestFilter: string = ''): Boolean;
    function ProcessArray(Value: TJSONValue; const ARequestFilter: string = ''): Boolean;
    function GetGenericDictionary(const ARequestFilter: string = ''): TMyDictionary;
    function GetGenericDictionary_Cache(const ARequestFilter: string = ''): IDSRestCachedTMyDictionary;
    function ValidateGenericDictionary(AValue: TMyDictionary; const ARequestFilter: string = ''): Boolean;
    function GetGenericDictionaryPairs(const ARequestFilter: string = ''): TMyDictionaryPairs;
    function GetGenericDictionaryPairs_Cache(const ARequestFilter: string = ''): IDSRestCachedTMyDictionaryPairs;
    function ValidateGenericDictionaryPairs(AValue: TMyDictionaryPairs; const ARequestFilter: string = ''): Boolean;
  end;

  IDSRestCachedTPerson1 = interface(IDSRestCachedObject<TPerson1>)
  end;

  TDSRestCachedTPerson1 = class(TDSRestCachedObject<TPerson1>, IDSRestCachedTPerson1, IDSRestCachedCommand)
  end;
  IDSRestCachedTUnsupportedFieldsClass = interface(IDSRestCachedObject<TUnsupportedFieldsClass>)
  end;

  TDSRestCachedTUnsupportedFieldsClass = class(TDSRestCachedObject<TUnsupportedFieldsClass>, IDSRestCachedTUnsupportedFieldsClass, IDSRestCachedCommand)
  end;
  IDSRestCachedTPerson1Collection = interface(IDSRestCachedObject<TPerson1Collection>)
  end;

  TDSRestCachedTPerson1Collection = class(TDSRestCachedObject<TPerson1Collection>, IDSRestCachedTPerson1Collection, IDSRestCachedCommand)
  end;
  IDSRestCachedTPersonISODate_Register = interface(IDSRestCachedObject<TPersonISODate_Register>)
  end;

  TDSRestCachedTPersonISODate_Register = class(TDSRestCachedObject<TPersonISODate_Register>, IDSRestCachedTPersonISODate_Register, IDSRestCachedCommand)
  end;
  IDSRestCachedTClassWithGenericListField_Register = interface(IDSRestCachedObject<TClassWithGenericListField_Register>)
  end;

  TDSRestCachedTClassWithGenericListField_Register = class(TDSRestCachedObject<TClassWithGenericListField_Register>, IDSRestCachedTClassWithGenericListField_Register, IDSRestCachedCommand)
  end;
  IDSRestCachedTClassWithGenericDictionaryField_Register = interface(IDSRestCachedObject<TClassWithGenericDictionaryField_Register>)
  end;

  TDSRestCachedTClassWithGenericDictionaryField_Register = class(TDSRestCachedObject<TClassWithGenericDictionaryField_Register>, IDSRestCachedTClassWithGenericDictionaryField_Register, IDSRestCachedCommand)
  end;
  IDSRestCachedTMyDictionaryPairs = interface(IDSRestCachedObject<TMyDictionaryPairs>)
  end;

  TDSRestCachedTMyDictionaryPairs = class(TDSRestCachedObject<TMyDictionaryPairs>, IDSRestCachedTMyDictionaryPairs, IDSRestCachedCommand)
  end;
  IDSRestCachedTUnsupportedFieldsClass_Register = interface(IDSRestCachedObject<TUnsupportedFieldsClass_Register>)
  end;

  TDSRestCachedTUnsupportedFieldsClass_Register = class(TDSRestCachedObject<TUnsupportedFieldsClass_Register>, IDSRestCachedTUnsupportedFieldsClass_Register, IDSRestCachedCommand)
  end;
  IDSRestCachedTClassWithTStringsField_Register = interface(IDSRestCachedObject<TClassWithTStringsField_Register>)
  end;

  TDSRestCachedTClassWithTStringsField_Register = class(TDSRestCachedObject<TClassWithTStringsField_Register>, IDSRestCachedTClassWithTStringsField_Register, IDSRestCachedCommand)
  end;
  IDSRestCachedTPersonISODate_Attribute = interface(IDSRestCachedObject<TPersonISODate_Attribute>)
  end;

  TDSRestCachedTPersonISODate_Attribute = class(TDSRestCachedObject<TPersonISODate_Attribute>, IDSRestCachedTPersonISODate_Attribute, IDSRestCachedCommand)
  end;
  IDSRestCachedTClassWithGenericDictionaryField = interface(IDSRestCachedObject<TClassWithGenericDictionaryField>)
  end;

  TDSRestCachedTClassWithGenericDictionaryField = class(TDSRestCachedObject<TClassWithGenericDictionaryField>, IDSRestCachedTClassWithGenericDictionaryField, IDSRestCachedCommand)
  end;
  IDSRestCachedTClassWithTStringsField_Attribute = interface(IDSRestCachedObject<TClassWithTStringsField_Attribute>)
  end;

  TDSRestCachedTClassWithTStringsField_Attribute = class(TDSRestCachedObject<TClassWithTStringsField_Attribute>, IDSRestCachedTClassWithTStringsField_Attribute, IDSRestCachedCommand)
  end;
  IDSRestCachedTClassWithGenericListField = interface(IDSRestCachedObject<TClassWithGenericListField>)
  end;

  TDSRestCachedTClassWithGenericListField = class(TDSRestCachedObject<TClassWithGenericListField>, IDSRestCachedTClassWithGenericListField, IDSRestCachedCommand)
  end;
  IDSRestCachedTMyDictionary = interface(IDSRestCachedObject<TMyDictionary>)
  end;

  TDSRestCachedTMyDictionary = class(TDSRestCachedObject<TMyDictionary>, IDSRestCachedTMyDictionary, IDSRestCachedCommand)
  end;

const
  TServerMethods2_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods2_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods2_GetPerson: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TPerson1')
  );

  TServerMethods2_GetPerson_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetPersonCollection: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TPerson1Collection')
  );

  TServerMethods2_GetPersonCollection_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetPerson_Attribute: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TPersonISODate_Attribute')
  );

  TServerMethods2_GetPerson_Attribute_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetPerson_Register: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TPersonISODate_Register')
  );

  TServerMethods2_GetPerson_Register_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetClassWithTStrings_Attribute: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TClassWithTStringsField_Attribute')
  );

  TServerMethods2_GetClassWithTStrings_Attribute_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetClassWithTStrings_Register: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TClassWithTStringsField_Register')
  );

  TServerMethods2_GetClassWithTStrings_Register_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetGenericListField: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TClassWithGenericListField')
  );

  TServerMethods2_GetGenericListField_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetGenericListField_Register: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TClassWithGenericListField_Register')
  );

  TServerMethods2_GetGenericListField_Register_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetGenericDictionaryField: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TClassWithGenericDictionaryField')
  );

  TServerMethods2_GetGenericDictionaryField_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetGenericDictionaryField_Register: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TClassWithGenericDictionaryField_Register')
  );

  TServerMethods2_GetGenericDictionaryField_Register_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetUnsupportedFields: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TUnsupportedFieldsClass')
  );

  TServerMethods2_GetUnsupportedFields_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_GetUnsupportedFields_Register: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TUnsupportedFieldsClass_Register')
  );

  TServerMethods2_GetUnsupportedFields_Register_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_ValidateClassWithTStrings_Attribute: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TClassWithTStringsField_Attribute'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidateClassWithTStrings_Register: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TClassWithTStringsField_Register'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidateGenericListField: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TClassWithGenericListField'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidateGenericListField_Register: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TClassWithGenericListField_Register'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidateGenericDictionaryField: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TClassWithGenericDictionaryField'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidateGenericDictionaryField_Register: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TClassWithGenericDictionaryField_Register'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidatePerson_Register: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TPersonISODate_Register'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidatePerson: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TPerson1'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidatePerson_Attribute: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TPersonISODate_Attribute'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidatePersonCollection: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TPerson1Collection'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidateUnsupportedFields: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TUnsupportedFieldsClass'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ValidateUnsupportedFields_Register: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TUnsupportedFieldsClass_Register'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_ProcessArray: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_GetGenericDictionary: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TMyDictionary')
  );

  TServerMethods2_GetGenericDictionary_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_ValidateGenericDictionary: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TMyDictionary'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods2_GetGenericDictionaryPairs: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TMyDictionaryPairs')
  );

  TServerMethods2_GetGenericDictionaryPairs_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods2_ValidateGenericDictionaryPairs: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AValue'; Direction: 1; DBXType: 37; TypeName: 'TMyDictionaryPairs'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

function TServerMethods2Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods2.EchoString';
    FEchoStringCommand.Prepare(TServerMethods2_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods2Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods2.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods2_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods2Client.GetPerson(const ARequestFilter: string): TPerson1;
begin
  if FGetPersonCommand = nil then
  begin
    FGetPersonCommand := FConnection.CreateCommand;
    FGetPersonCommand.RequestType := 'GET';
    FGetPersonCommand.Text := 'TServerMethods2.GetPerson';
    FGetPersonCommand.Prepare(TServerMethods2_GetPerson);
  end;
  FGetPersonCommand.Execute(ARequestFilter);
  if not FGetPersonCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetPersonCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TPerson1(FUnMarshal.UnMarshal(FGetPersonCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetPersonCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetPerson_Cache(const ARequestFilter: string): IDSRestCachedTPerson1;
begin
  if FGetPersonCommand_Cache = nil then
  begin
    FGetPersonCommand_Cache := FConnection.CreateCommand;
    FGetPersonCommand_Cache.RequestType := 'GET';
    FGetPersonCommand_Cache.Text := 'TServerMethods2.GetPerson';
    FGetPersonCommand_Cache.Prepare(TServerMethods2_GetPerson_Cache);
  end;
  FGetPersonCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTPerson1.Create(FGetPersonCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetPersonCollection(const ARequestFilter: string): TPerson1Collection;
begin
  if FGetPersonCollectionCommand = nil then
  begin
    FGetPersonCollectionCommand := FConnection.CreateCommand;
    FGetPersonCollectionCommand.RequestType := 'GET';
    FGetPersonCollectionCommand.Text := 'TServerMethods2.GetPersonCollection';
    FGetPersonCollectionCommand.Prepare(TServerMethods2_GetPersonCollection);
  end;
  FGetPersonCollectionCommand.Execute(ARequestFilter);
  if not FGetPersonCollectionCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetPersonCollectionCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TPerson1Collection(FUnMarshal.UnMarshal(FGetPersonCollectionCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetPersonCollectionCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetPersonCollection_Cache(const ARequestFilter: string): IDSRestCachedTPerson1Collection;
begin
  if FGetPersonCollectionCommand_Cache = nil then
  begin
    FGetPersonCollectionCommand_Cache := FConnection.CreateCommand;
    FGetPersonCollectionCommand_Cache.RequestType := 'GET';
    FGetPersonCollectionCommand_Cache.Text := 'TServerMethods2.GetPersonCollection';
    FGetPersonCollectionCommand_Cache.Prepare(TServerMethods2_GetPersonCollection_Cache);
  end;
  FGetPersonCollectionCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTPerson1Collection.Create(FGetPersonCollectionCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetPerson_Attribute(const ARequestFilter: string): TPersonISODate_Attribute;
begin
  if FGetPerson_AttributeCommand = nil then
  begin
    FGetPerson_AttributeCommand := FConnection.CreateCommand;
    FGetPerson_AttributeCommand.RequestType := 'GET';
    FGetPerson_AttributeCommand.Text := 'TServerMethods2.GetPerson_Attribute';
    FGetPerson_AttributeCommand.Prepare(TServerMethods2_GetPerson_Attribute);
  end;
  FGetPerson_AttributeCommand.Execute(ARequestFilter);
  if not FGetPerson_AttributeCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetPerson_AttributeCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TPersonISODate_Attribute(FUnMarshal.UnMarshal(FGetPerson_AttributeCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetPerson_AttributeCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetPerson_Attribute_Cache(const ARequestFilter: string): IDSRestCachedTPersonISODate_Attribute;
begin
  if FGetPerson_AttributeCommand_Cache = nil then
  begin
    FGetPerson_AttributeCommand_Cache := FConnection.CreateCommand;
    FGetPerson_AttributeCommand_Cache.RequestType := 'GET';
    FGetPerson_AttributeCommand_Cache.Text := 'TServerMethods2.GetPerson_Attribute';
    FGetPerson_AttributeCommand_Cache.Prepare(TServerMethods2_GetPerson_Attribute_Cache);
  end;
  FGetPerson_AttributeCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTPersonISODate_Attribute.Create(FGetPerson_AttributeCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetPerson_Register(const ARequestFilter: string): TPersonISODate_Register;
begin
  if FGetPerson_RegisterCommand = nil then
  begin
    FGetPerson_RegisterCommand := FConnection.CreateCommand;
    FGetPerson_RegisterCommand.RequestType := 'GET';
    FGetPerson_RegisterCommand.Text := 'TServerMethods2.GetPerson_Register';
    FGetPerson_RegisterCommand.Prepare(TServerMethods2_GetPerson_Register);
  end;
  FGetPerson_RegisterCommand.Execute(ARequestFilter);
  if not FGetPerson_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetPerson_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TPersonISODate_Register(FUnMarshal.UnMarshal(FGetPerson_RegisterCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetPerson_RegisterCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetPerson_Register_Cache(const ARequestFilter: string): IDSRestCachedTPersonISODate_Register;
begin
  if FGetPerson_RegisterCommand_Cache = nil then
  begin
    FGetPerson_RegisterCommand_Cache := FConnection.CreateCommand;
    FGetPerson_RegisterCommand_Cache.RequestType := 'GET';
    FGetPerson_RegisterCommand_Cache.Text := 'TServerMethods2.GetPerson_Register';
    FGetPerson_RegisterCommand_Cache.Prepare(TServerMethods2_GetPerson_Register_Cache);
  end;
  FGetPerson_RegisterCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTPersonISODate_Register.Create(FGetPerson_RegisterCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetClassWithTStrings_Attribute(const ARequestFilter: string): TClassWithTStringsField_Attribute;
begin
  if FGetClassWithTStrings_AttributeCommand = nil then
  begin
    FGetClassWithTStrings_AttributeCommand := FConnection.CreateCommand;
    FGetClassWithTStrings_AttributeCommand.RequestType := 'GET';
    FGetClassWithTStrings_AttributeCommand.Text := 'TServerMethods2.GetClassWithTStrings_Attribute';
    FGetClassWithTStrings_AttributeCommand.Prepare(TServerMethods2_GetClassWithTStrings_Attribute);
  end;
  FGetClassWithTStrings_AttributeCommand.Execute(ARequestFilter);
  if not FGetClassWithTStrings_AttributeCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetClassWithTStrings_AttributeCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TClassWithTStringsField_Attribute(FUnMarshal.UnMarshal(FGetClassWithTStrings_AttributeCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetClassWithTStrings_AttributeCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetClassWithTStrings_Attribute_Cache(const ARequestFilter: string): IDSRestCachedTClassWithTStringsField_Attribute;
begin
  if FGetClassWithTStrings_AttributeCommand_Cache = nil then
  begin
    FGetClassWithTStrings_AttributeCommand_Cache := FConnection.CreateCommand;
    FGetClassWithTStrings_AttributeCommand_Cache.RequestType := 'GET';
    FGetClassWithTStrings_AttributeCommand_Cache.Text := 'TServerMethods2.GetClassWithTStrings_Attribute';
    FGetClassWithTStrings_AttributeCommand_Cache.Prepare(TServerMethods2_GetClassWithTStrings_Attribute_Cache);
  end;
  FGetClassWithTStrings_AttributeCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTClassWithTStringsField_Attribute.Create(FGetClassWithTStrings_AttributeCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetClassWithTStrings_Register(const ARequestFilter: string): TClassWithTStringsField_Register;
begin
  if FGetClassWithTStrings_RegisterCommand = nil then
  begin
    FGetClassWithTStrings_RegisterCommand := FConnection.CreateCommand;
    FGetClassWithTStrings_RegisterCommand.RequestType := 'GET';
    FGetClassWithTStrings_RegisterCommand.Text := 'TServerMethods2.GetClassWithTStrings_Register';
    FGetClassWithTStrings_RegisterCommand.Prepare(TServerMethods2_GetClassWithTStrings_Register);
  end;
  FGetClassWithTStrings_RegisterCommand.Execute(ARequestFilter);
  if not FGetClassWithTStrings_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetClassWithTStrings_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TClassWithTStringsField_Register(FUnMarshal.UnMarshal(FGetClassWithTStrings_RegisterCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetClassWithTStrings_RegisterCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetClassWithTStrings_Register_Cache(const ARequestFilter: string): IDSRestCachedTClassWithTStringsField_Register;
begin
  if FGetClassWithTStrings_RegisterCommand_Cache = nil then
  begin
    FGetClassWithTStrings_RegisterCommand_Cache := FConnection.CreateCommand;
    FGetClassWithTStrings_RegisterCommand_Cache.RequestType := 'GET';
    FGetClassWithTStrings_RegisterCommand_Cache.Text := 'TServerMethods2.GetClassWithTStrings_Register';
    FGetClassWithTStrings_RegisterCommand_Cache.Prepare(TServerMethods2_GetClassWithTStrings_Register_Cache);
  end;
  FGetClassWithTStrings_RegisterCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTClassWithTStringsField_Register.Create(FGetClassWithTStrings_RegisterCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetGenericListField(const ARequestFilter: string): TClassWithGenericListField;
begin
  if FGetGenericListFieldCommand = nil then
  begin
    FGetGenericListFieldCommand := FConnection.CreateCommand;
    FGetGenericListFieldCommand.RequestType := 'GET';
    FGetGenericListFieldCommand.Text := 'TServerMethods2.GetGenericListField';
    FGetGenericListFieldCommand.Prepare(TServerMethods2_GetGenericListField);
  end;
  FGetGenericListFieldCommand.Execute(ARequestFilter);
  if not FGetGenericListFieldCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetGenericListFieldCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TClassWithGenericListField(FUnMarshal.UnMarshal(FGetGenericListFieldCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetGenericListFieldCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetGenericListField_Cache(const ARequestFilter: string): IDSRestCachedTClassWithGenericListField;
begin
  if FGetGenericListFieldCommand_Cache = nil then
  begin
    FGetGenericListFieldCommand_Cache := FConnection.CreateCommand;
    FGetGenericListFieldCommand_Cache.RequestType := 'GET';
    FGetGenericListFieldCommand_Cache.Text := 'TServerMethods2.GetGenericListField';
    FGetGenericListFieldCommand_Cache.Prepare(TServerMethods2_GetGenericListField_Cache);
  end;
  FGetGenericListFieldCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTClassWithGenericListField.Create(FGetGenericListFieldCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetGenericListField_Register(const ARequestFilter: string): TClassWithGenericListField_Register;
begin
  if FGetGenericListField_RegisterCommand = nil then
  begin
    FGetGenericListField_RegisterCommand := FConnection.CreateCommand;
    FGetGenericListField_RegisterCommand.RequestType := 'GET';
    FGetGenericListField_RegisterCommand.Text := 'TServerMethods2.GetGenericListField_Register';
    FGetGenericListField_RegisterCommand.Prepare(TServerMethods2_GetGenericListField_Register);
  end;
  FGetGenericListField_RegisterCommand.Execute(ARequestFilter);
  if not FGetGenericListField_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetGenericListField_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TClassWithGenericListField_Register(FUnMarshal.UnMarshal(FGetGenericListField_RegisterCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetGenericListField_RegisterCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetGenericListField_Register_Cache(const ARequestFilter: string): IDSRestCachedTClassWithGenericListField_Register;
begin
  if FGetGenericListField_RegisterCommand_Cache = nil then
  begin
    FGetGenericListField_RegisterCommand_Cache := FConnection.CreateCommand;
    FGetGenericListField_RegisterCommand_Cache.RequestType := 'GET';
    FGetGenericListField_RegisterCommand_Cache.Text := 'TServerMethods2.GetGenericListField_Register';
    FGetGenericListField_RegisterCommand_Cache.Prepare(TServerMethods2_GetGenericListField_Register_Cache);
  end;
  FGetGenericListField_RegisterCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTClassWithGenericListField_Register.Create(FGetGenericListField_RegisterCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetGenericDictionaryField(const ARequestFilter: string): TClassWithGenericDictionaryField;
begin
  if FGetGenericDictionaryFieldCommand = nil then
  begin
    FGetGenericDictionaryFieldCommand := FConnection.CreateCommand;
    FGetGenericDictionaryFieldCommand.RequestType := 'GET';
    FGetGenericDictionaryFieldCommand.Text := 'TServerMethods2.GetGenericDictionaryField';
    FGetGenericDictionaryFieldCommand.Prepare(TServerMethods2_GetGenericDictionaryField);
  end;
  FGetGenericDictionaryFieldCommand.Execute(ARequestFilter);
  if not FGetGenericDictionaryFieldCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetGenericDictionaryFieldCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TClassWithGenericDictionaryField(FUnMarshal.UnMarshal(FGetGenericDictionaryFieldCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetGenericDictionaryFieldCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetGenericDictionaryField_Cache(const ARequestFilter: string): IDSRestCachedTClassWithGenericDictionaryField;
begin
  if FGetGenericDictionaryFieldCommand_Cache = nil then
  begin
    FGetGenericDictionaryFieldCommand_Cache := FConnection.CreateCommand;
    FGetGenericDictionaryFieldCommand_Cache.RequestType := 'GET';
    FGetGenericDictionaryFieldCommand_Cache.Text := 'TServerMethods2.GetGenericDictionaryField';
    FGetGenericDictionaryFieldCommand_Cache.Prepare(TServerMethods2_GetGenericDictionaryField_Cache);
  end;
  FGetGenericDictionaryFieldCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTClassWithGenericDictionaryField.Create(FGetGenericDictionaryFieldCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetGenericDictionaryField_Register(const ARequestFilter: string): TClassWithGenericDictionaryField_Register;
begin
  if FGetGenericDictionaryField_RegisterCommand = nil then
  begin
    FGetGenericDictionaryField_RegisterCommand := FConnection.CreateCommand;
    FGetGenericDictionaryField_RegisterCommand.RequestType := 'GET';
    FGetGenericDictionaryField_RegisterCommand.Text := 'TServerMethods2.GetGenericDictionaryField_Register';
    FGetGenericDictionaryField_RegisterCommand.Prepare(TServerMethods2_GetGenericDictionaryField_Register);
  end;
  FGetGenericDictionaryField_RegisterCommand.Execute(ARequestFilter);
  if not FGetGenericDictionaryField_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetGenericDictionaryField_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TClassWithGenericDictionaryField_Register(FUnMarshal.UnMarshal(FGetGenericDictionaryField_RegisterCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetGenericDictionaryField_RegisterCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetGenericDictionaryField_Register_Cache(const ARequestFilter: string): IDSRestCachedTClassWithGenericDictionaryField_Register;
begin
  if FGetGenericDictionaryField_RegisterCommand_Cache = nil then
  begin
    FGetGenericDictionaryField_RegisterCommand_Cache := FConnection.CreateCommand;
    FGetGenericDictionaryField_RegisterCommand_Cache.RequestType := 'GET';
    FGetGenericDictionaryField_RegisterCommand_Cache.Text := 'TServerMethods2.GetGenericDictionaryField_Register';
    FGetGenericDictionaryField_RegisterCommand_Cache.Prepare(TServerMethods2_GetGenericDictionaryField_Register_Cache);
  end;
  FGetGenericDictionaryField_RegisterCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTClassWithGenericDictionaryField_Register.Create(FGetGenericDictionaryField_RegisterCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetUnsupportedFields(const ARequestFilter: string): TUnsupportedFieldsClass;
begin
  if FGetUnsupportedFieldsCommand = nil then
  begin
    FGetUnsupportedFieldsCommand := FConnection.CreateCommand;
    FGetUnsupportedFieldsCommand.RequestType := 'GET';
    FGetUnsupportedFieldsCommand.Text := 'TServerMethods2.GetUnsupportedFields';
    FGetUnsupportedFieldsCommand.Prepare(TServerMethods2_GetUnsupportedFields);
  end;
  FGetUnsupportedFieldsCommand.Execute(ARequestFilter);
  if not FGetUnsupportedFieldsCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetUnsupportedFieldsCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TUnsupportedFieldsClass(FUnMarshal.UnMarshal(FGetUnsupportedFieldsCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetUnsupportedFieldsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetUnsupportedFields_Cache(const ARequestFilter: string): IDSRestCachedTUnsupportedFieldsClass;
begin
  if FGetUnsupportedFieldsCommand_Cache = nil then
  begin
    FGetUnsupportedFieldsCommand_Cache := FConnection.CreateCommand;
    FGetUnsupportedFieldsCommand_Cache.RequestType := 'GET';
    FGetUnsupportedFieldsCommand_Cache.Text := 'TServerMethods2.GetUnsupportedFields';
    FGetUnsupportedFieldsCommand_Cache.Prepare(TServerMethods2_GetUnsupportedFields_Cache);
  end;
  FGetUnsupportedFieldsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTUnsupportedFieldsClass.Create(FGetUnsupportedFieldsCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.GetUnsupportedFields_Register(const ARequestFilter: string): TUnsupportedFieldsClass_Register;
begin
  if FGetUnsupportedFields_RegisterCommand = nil then
  begin
    FGetUnsupportedFields_RegisterCommand := FConnection.CreateCommand;
    FGetUnsupportedFields_RegisterCommand.RequestType := 'GET';
    FGetUnsupportedFields_RegisterCommand.Text := 'TServerMethods2.GetUnsupportedFields_Register';
    FGetUnsupportedFields_RegisterCommand.Prepare(TServerMethods2_GetUnsupportedFields_Register);
  end;
  FGetUnsupportedFields_RegisterCommand.Execute(ARequestFilter);
  if not FGetUnsupportedFields_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetUnsupportedFields_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TUnsupportedFieldsClass_Register(FUnMarshal.UnMarshal(FGetUnsupportedFields_RegisterCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetUnsupportedFields_RegisterCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetUnsupportedFields_Register_Cache(const ARequestFilter: string): IDSRestCachedTUnsupportedFieldsClass_Register;
begin
  if FGetUnsupportedFields_RegisterCommand_Cache = nil then
  begin
    FGetUnsupportedFields_RegisterCommand_Cache := FConnection.CreateCommand;
    FGetUnsupportedFields_RegisterCommand_Cache.RequestType := 'GET';
    FGetUnsupportedFields_RegisterCommand_Cache.Text := 'TServerMethods2.GetUnsupportedFields_Register';
    FGetUnsupportedFields_RegisterCommand_Cache.Prepare(TServerMethods2_GetUnsupportedFields_Register_Cache);
  end;
  FGetUnsupportedFields_RegisterCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTUnsupportedFieldsClass_Register.Create(FGetUnsupportedFields_RegisterCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.ValidateClassWithTStrings_Attribute(AValue: TClassWithTStringsField_Attribute; const ARequestFilter: string): Boolean;
begin
  if FValidateClassWithTStrings_AttributeCommand = nil then
  begin
    FValidateClassWithTStrings_AttributeCommand := FConnection.CreateCommand;
    FValidateClassWithTStrings_AttributeCommand.RequestType := 'POST';
    FValidateClassWithTStrings_AttributeCommand.Text := 'TServerMethods2."ValidateClassWithTStrings_Attribute"';
    FValidateClassWithTStrings_AttributeCommand.Prepare(TServerMethods2_ValidateClassWithTStrings_Attribute);
  end;
  if not Assigned(AValue) then
    FValidateClassWithTStrings_AttributeCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateClassWithTStrings_AttributeCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateClassWithTStrings_AttributeCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateClassWithTStrings_AttributeCommand.Execute(ARequestFilter);
  Result := FValidateClassWithTStrings_AttributeCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateClassWithTStrings_Register(AValue: TClassWithTStringsField_Register; const ARequestFilter: string): Boolean;
begin
  if FValidateClassWithTStrings_RegisterCommand = nil then
  begin
    FValidateClassWithTStrings_RegisterCommand := FConnection.CreateCommand;
    FValidateClassWithTStrings_RegisterCommand.RequestType := 'POST';
    FValidateClassWithTStrings_RegisterCommand.Text := 'TServerMethods2."ValidateClassWithTStrings_Register"';
    FValidateClassWithTStrings_RegisterCommand.Prepare(TServerMethods2_ValidateClassWithTStrings_Register);
  end;
  if not Assigned(AValue) then
    FValidateClassWithTStrings_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateClassWithTStrings_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateClassWithTStrings_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateClassWithTStrings_RegisterCommand.Execute(ARequestFilter);
  Result := FValidateClassWithTStrings_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateGenericListField(AValue: TClassWithGenericListField; const ARequestFilter: string): Boolean;
begin
  if FValidateGenericListFieldCommand = nil then
  begin
    FValidateGenericListFieldCommand := FConnection.CreateCommand;
    FValidateGenericListFieldCommand.RequestType := 'POST';
    FValidateGenericListFieldCommand.Text := 'TServerMethods2."ValidateGenericListField"';
    FValidateGenericListFieldCommand.Prepare(TServerMethods2_ValidateGenericListField);
  end;
  if not Assigned(AValue) then
    FValidateGenericListFieldCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateGenericListFieldCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericListFieldCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericListFieldCommand.Execute(ARequestFilter);
  Result := FValidateGenericListFieldCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateGenericListField_Register(AValue: TClassWithGenericListField_Register; const ARequestFilter: string): Boolean;
begin
  if FValidateGenericListField_RegisterCommand = nil then
  begin
    FValidateGenericListField_RegisterCommand := FConnection.CreateCommand;
    FValidateGenericListField_RegisterCommand.RequestType := 'POST';
    FValidateGenericListField_RegisterCommand.Text := 'TServerMethods2."ValidateGenericListField_Register"';
    FValidateGenericListField_RegisterCommand.Prepare(TServerMethods2_ValidateGenericListField_Register);
  end;
  if not Assigned(AValue) then
    FValidateGenericListField_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateGenericListField_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericListField_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericListField_RegisterCommand.Execute(ARequestFilter);
  Result := FValidateGenericListField_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateGenericDictionaryField(AValue: TClassWithGenericDictionaryField; const ARequestFilter: string): Boolean;
begin
  if FValidateGenericDictionaryFieldCommand = nil then
  begin
    FValidateGenericDictionaryFieldCommand := FConnection.CreateCommand;
    FValidateGenericDictionaryFieldCommand.RequestType := 'POST';
    FValidateGenericDictionaryFieldCommand.Text := 'TServerMethods2."ValidateGenericDictionaryField"';
    FValidateGenericDictionaryFieldCommand.Prepare(TServerMethods2_ValidateGenericDictionaryField);
  end;
  if not Assigned(AValue) then
    FValidateGenericDictionaryFieldCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateGenericDictionaryFieldCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericDictionaryFieldCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericDictionaryFieldCommand.Execute(ARequestFilter);
  Result := FValidateGenericDictionaryFieldCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateGenericDictionaryField_Register(AValue: TClassWithGenericDictionaryField_Register; const ARequestFilter: string): Boolean;
begin
  if FValidateGenericDictionaryField_RegisterCommand = nil then
  begin
    FValidateGenericDictionaryField_RegisterCommand := FConnection.CreateCommand;
    FValidateGenericDictionaryField_RegisterCommand.RequestType := 'POST';
    FValidateGenericDictionaryField_RegisterCommand.Text := 'TServerMethods2."ValidateGenericDictionaryField_Register"';
    FValidateGenericDictionaryField_RegisterCommand.Prepare(TServerMethods2_ValidateGenericDictionaryField_Register);
  end;
  if not Assigned(AValue) then
    FValidateGenericDictionaryField_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateGenericDictionaryField_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericDictionaryField_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericDictionaryField_RegisterCommand.Execute(ARequestFilter);
  Result := FValidateGenericDictionaryField_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidatePerson_Register(AValue: TPersonISODate_Register; const ARequestFilter: string): Boolean;
begin
  if FValidatePerson_RegisterCommand = nil then
  begin
    FValidatePerson_RegisterCommand := FConnection.CreateCommand;
    FValidatePerson_RegisterCommand.RequestType := 'POST';
    FValidatePerson_RegisterCommand.Text := 'TServerMethods2."ValidatePerson_Register"';
    FValidatePerson_RegisterCommand.Prepare(TServerMethods2_ValidatePerson_Register);
  end;
  if not Assigned(AValue) then
    FValidatePerson_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidatePerson_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidatePerson_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidatePerson_RegisterCommand.Execute(ARequestFilter);
  Result := FValidatePerson_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidatePerson(AValue: TPerson1; const ARequestFilter: string): Boolean;
begin
  if FValidatePersonCommand = nil then
  begin
    FValidatePersonCommand := FConnection.CreateCommand;
    FValidatePersonCommand.RequestType := 'POST';
    FValidatePersonCommand.Text := 'TServerMethods2."ValidatePerson"';
    FValidatePersonCommand.Prepare(TServerMethods2_ValidatePerson);
  end;
  if not Assigned(AValue) then
    FValidatePersonCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidatePersonCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidatePersonCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidatePersonCommand.Execute(ARequestFilter);
  Result := FValidatePersonCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidatePerson_Attribute(AValue: TPersonISODate_Attribute; const ARequestFilter: string): Boolean;
begin
  if FValidatePerson_AttributeCommand = nil then
  begin
    FValidatePerson_AttributeCommand := FConnection.CreateCommand;
    FValidatePerson_AttributeCommand.RequestType := 'POST';
    FValidatePerson_AttributeCommand.Text := 'TServerMethods2."ValidatePerson_Attribute"';
    FValidatePerson_AttributeCommand.Prepare(TServerMethods2_ValidatePerson_Attribute);
  end;
  if not Assigned(AValue) then
    FValidatePerson_AttributeCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidatePerson_AttributeCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidatePerson_AttributeCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidatePerson_AttributeCommand.Execute(ARequestFilter);
  Result := FValidatePerson_AttributeCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidatePersonCollection(AValue: TPerson1Collection; const ARequestFilter: string): Boolean;
begin
  if FValidatePersonCollectionCommand = nil then
  begin
    FValidatePersonCollectionCommand := FConnection.CreateCommand;
    FValidatePersonCollectionCommand.RequestType := 'POST';
    FValidatePersonCollectionCommand.Text := 'TServerMethods2."ValidatePersonCollection"';
    FValidatePersonCollectionCommand.Prepare(TServerMethods2_ValidatePersonCollection);
  end;
  if not Assigned(AValue) then
    FValidatePersonCollectionCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidatePersonCollectionCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidatePersonCollectionCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidatePersonCollectionCommand.Execute(ARequestFilter);
  Result := FValidatePersonCollectionCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateUnsupportedFields(AValue: TUnsupportedFieldsClass; const ARequestFilter: string): Boolean;
begin
  if FValidateUnsupportedFieldsCommand = nil then
  begin
    FValidateUnsupportedFieldsCommand := FConnection.CreateCommand;
    FValidateUnsupportedFieldsCommand.RequestType := 'POST';
    FValidateUnsupportedFieldsCommand.Text := 'TServerMethods2."ValidateUnsupportedFields"';
    FValidateUnsupportedFieldsCommand.Prepare(TServerMethods2_ValidateUnsupportedFields);
  end;
  if not Assigned(AValue) then
    FValidateUnsupportedFieldsCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateUnsupportedFieldsCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateUnsupportedFieldsCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateUnsupportedFieldsCommand.Execute(ARequestFilter);
  Result := FValidateUnsupportedFieldsCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateUnsupportedFields_Register(AValue: TUnsupportedFieldsClass_Register; const ARequestFilter: string): Boolean;
begin
  if FValidateUnsupportedFields_RegisterCommand = nil then
  begin
    FValidateUnsupportedFields_RegisterCommand := FConnection.CreateCommand;
    FValidateUnsupportedFields_RegisterCommand.RequestType := 'POST';
    FValidateUnsupportedFields_RegisterCommand.Text := 'TServerMethods2."ValidateUnsupportedFields_Register"';
    FValidateUnsupportedFields_RegisterCommand.Prepare(TServerMethods2_ValidateUnsupportedFields_Register);
  end;
  if not Assigned(AValue) then
    FValidateUnsupportedFields_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateUnsupportedFields_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateUnsupportedFields_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateUnsupportedFields_RegisterCommand.Execute(ARequestFilter);
  Result := FValidateUnsupportedFields_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ProcessArray(Value: TJSONValue; const ARequestFilter: string): Boolean;
begin
  if FProcessArrayCommand = nil then
  begin
    FProcessArrayCommand := FConnection.CreateCommand;
    FProcessArrayCommand.RequestType := 'POST';
    FProcessArrayCommand.Text := 'TServerMethods2."ProcessArray"';
    FProcessArrayCommand.Prepare(TServerMethods2_ProcessArray);
  end;
  FProcessArrayCommand.Parameters[0].Value.SetJSONValue(Value, FInstanceOwner);
  FProcessArrayCommand.Execute(ARequestFilter);
  Result := FProcessArrayCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.GetGenericDictionary(const ARequestFilter: string): TMyDictionary;
begin
  if FGetGenericDictionaryCommand = nil then
  begin
    FGetGenericDictionaryCommand := FConnection.CreateCommand;
    FGetGenericDictionaryCommand.RequestType := 'GET';
    FGetGenericDictionaryCommand.Text := 'TServerMethods2.GetGenericDictionary';
    FGetGenericDictionaryCommand.Prepare(TServerMethods2_GetGenericDictionary);
  end;
  FGetGenericDictionaryCommand.Execute(ARequestFilter);
  if not FGetGenericDictionaryCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetGenericDictionaryCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TMyDictionary(FUnMarshal.UnMarshal(FGetGenericDictionaryCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetGenericDictionaryCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetGenericDictionary_Cache(const ARequestFilter: string): IDSRestCachedTMyDictionary;
begin
  if FGetGenericDictionaryCommand_Cache = nil then
  begin
    FGetGenericDictionaryCommand_Cache := FConnection.CreateCommand;
    FGetGenericDictionaryCommand_Cache.RequestType := 'GET';
    FGetGenericDictionaryCommand_Cache.Text := 'TServerMethods2.GetGenericDictionary';
    FGetGenericDictionaryCommand_Cache.Prepare(TServerMethods2_GetGenericDictionary_Cache);
  end;
  FGetGenericDictionaryCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTMyDictionary.Create(FGetGenericDictionaryCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.ValidateGenericDictionary(AValue: TMyDictionary; const ARequestFilter: string): Boolean;
begin
  if FValidateGenericDictionaryCommand = nil then
  begin
    FValidateGenericDictionaryCommand := FConnection.CreateCommand;
    FValidateGenericDictionaryCommand.RequestType := 'POST';
    FValidateGenericDictionaryCommand.Text := 'TServerMethods2."ValidateGenericDictionary"';
    FValidateGenericDictionaryCommand.Prepare(TServerMethods2_ValidateGenericDictionary);
  end;
  if not Assigned(AValue) then
    FValidateGenericDictionaryCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateGenericDictionaryCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericDictionaryCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericDictionaryCommand.Execute(ARequestFilter);
  Result := FValidateGenericDictionaryCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.GetGenericDictionaryPairs(const ARequestFilter: string): TMyDictionaryPairs;
begin
  if FGetGenericDictionaryPairsCommand = nil then
  begin
    FGetGenericDictionaryPairsCommand := FConnection.CreateCommand;
    FGetGenericDictionaryPairsCommand.RequestType := 'GET';
    FGetGenericDictionaryPairsCommand.Text := 'TServerMethods2.GetGenericDictionaryPairs';
    FGetGenericDictionaryPairsCommand.Prepare(TServerMethods2_GetGenericDictionaryPairs);
  end;
  FGetGenericDictionaryPairsCommand.Execute(ARequestFilter);
  if not FGetGenericDictionaryPairsCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetGenericDictionaryPairsCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TMyDictionaryPairs(FUnMarshal.UnMarshal(FGetGenericDictionaryPairsCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetGenericDictionaryPairsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods2Client.GetGenericDictionaryPairs_Cache(const ARequestFilter: string): IDSRestCachedTMyDictionaryPairs;
begin
  if FGetGenericDictionaryPairsCommand_Cache = nil then
  begin
    FGetGenericDictionaryPairsCommand_Cache := FConnection.CreateCommand;
    FGetGenericDictionaryPairsCommand_Cache.RequestType := 'GET';
    FGetGenericDictionaryPairsCommand_Cache.Text := 'TServerMethods2.GetGenericDictionaryPairs';
    FGetGenericDictionaryPairsCommand_Cache.Prepare(TServerMethods2_GetGenericDictionaryPairs_Cache);
  end;
  FGetGenericDictionaryPairsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTMyDictionaryPairs.Create(FGetGenericDictionaryPairsCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods2Client.ValidateGenericDictionaryPairs(AValue: TMyDictionaryPairs; const ARequestFilter: string): Boolean;
begin
  if FValidateGenericDictionaryPairsCommand = nil then
  begin
    FValidateGenericDictionaryPairsCommand := FConnection.CreateCommand;
    FValidateGenericDictionaryPairsCommand.RequestType := 'POST';
    FValidateGenericDictionaryPairsCommand.Text := 'TServerMethods2."ValidateGenericDictionaryPairs"';
    FValidateGenericDictionaryPairsCommand.Prepare(TServerMethods2_ValidateGenericDictionaryPairs);
  end;
  if not Assigned(AValue) then
    FValidateGenericDictionaryPairsCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FValidateGenericDictionaryPairsCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericDictionaryPairsCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericDictionaryPairsCommand.Execute(ARequestFilter);
  Result := FValidateGenericDictionaryPairsCommand.Parameters[1].Value.GetBoolean;
end;

constructor TServerMethods2Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods2Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods2Client.Destroy;
begin
  FreeAndNil(FEchoStringCommand);
  FreeAndNil(FReverseStringCommand);
  FreeAndNil(FGetPersonCommand);
  FreeAndNil(FGetPersonCommand_Cache);
  FreeAndNil(FGetPersonCollectionCommand);
  FreeAndNil(FGetPersonCollectionCommand_Cache);
  FreeAndNil(FGetPerson_AttributeCommand);
  FreeAndNil(FGetPerson_AttributeCommand_Cache);
  FreeAndNil(FGetPerson_RegisterCommand);
  FreeAndNil(FGetPerson_RegisterCommand_Cache);
  FreeAndNil(FGetClassWithTStrings_AttributeCommand);
  FreeAndNil(FGetClassWithTStrings_AttributeCommand_Cache);
  FreeAndNil(FGetClassWithTStrings_RegisterCommand);
  FreeAndNil(FGetClassWithTStrings_RegisterCommand_Cache);
  FreeAndNil(FGetGenericListFieldCommand);
  FreeAndNil(FGetGenericListFieldCommand_Cache);
  FreeAndNil(FGetGenericListField_RegisterCommand);
  FreeAndNil(FGetGenericListField_RegisterCommand_Cache);
  FreeAndNil(FGetGenericDictionaryFieldCommand);
  FreeAndNil(FGetGenericDictionaryFieldCommand_Cache);
  FreeAndNil(FGetGenericDictionaryField_RegisterCommand);
  FreeAndNil(FGetGenericDictionaryField_RegisterCommand_Cache);
  FreeAndNil(FGetUnsupportedFieldsCommand);
  FreeAndNil(FGetUnsupportedFieldsCommand_Cache);
  FreeAndNil(FGetUnsupportedFields_RegisterCommand);
  FreeAndNil(FGetUnsupportedFields_RegisterCommand_Cache);
  FreeAndNil(FValidateClassWithTStrings_AttributeCommand);
  FreeAndNil(FValidateClassWithTStrings_RegisterCommand);
  FreeAndNil(FValidateGenericListFieldCommand);
  FreeAndNil(FValidateGenericListField_RegisterCommand);
  FreeAndNil(FValidateGenericDictionaryFieldCommand);
  FreeAndNil(FValidateGenericDictionaryField_RegisterCommand);
  FreeAndNil(FValidatePerson_RegisterCommand);
  FreeAndNil(FValidatePersonCommand);
  FreeAndNil(FValidatePerson_AttributeCommand);
  FreeAndNil(FValidatePersonCollectionCommand);
  FreeAndNil(FValidateUnsupportedFieldsCommand);
  FreeAndNil(FValidateUnsupportedFields_RegisterCommand);
  FreeAndNil(FProcessArrayCommand);
  FreeAndNil(FGetGenericDictionaryCommand);
  FreeAndNil(FGetGenericDictionaryCommand_Cache);
  FreeAndNil(FValidateGenericDictionaryCommand);
  FreeAndNil(FGetGenericDictionaryPairsCommand);
  FreeAndNil(FGetGenericDictionaryPairsCommand_Cache);
  FreeAndNil(FValidateGenericDictionaryPairsCommand);
  inherited;
end;

end.

