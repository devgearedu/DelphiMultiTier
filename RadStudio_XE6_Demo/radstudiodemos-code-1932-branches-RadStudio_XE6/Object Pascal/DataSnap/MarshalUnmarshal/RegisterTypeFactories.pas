
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit RegisterTypeFactories;

interface

implementation

uses MarshalUnsupportedFields, TestTypeFactory, GenericListField, GenericDictionaryField, StringsField,
  Generics.Collections, SampleCollection;

type
  TUnsupportedFieldsClassFactory = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;

{ TPersonTypeFactory }

function TUnsupportedFieldsClassFactory.CreateClass: TObject;
var
  LObject: TUnsupportedFieldsClass;
begin
  LObject := nil;
  try
    // Set some sample values
    LObject := TUnsupportedFieldsClass.Create;
    LoadUnsupportedFieldsClass(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TUnsupportedFieldsClassFactory.TypeDescription: string;
begin
  Result := 'TUnsupportedFieldsClass (attr)';
end;

procedure TUnsupportedFieldsClassFactory.ValidateClass(AObject: TObject);
var
  LObject: TUnsupportedFieldsClass;
begin
  Assert(AObject is TUnsupportedFieldsClass);
  LObject := TUnsupportedFieldsClass(AObject);
  ValidateUnsupportedFieldsClass(LObject);
end;

type
  TUnsupportedFieldsClassFactory_Register = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;

{ TPersonTypeFactory }

function TUnsupportedFieldsClassFactory_Register.CreateClass: TObject;
var
  LObject: TUnsupportedFieldsClass_Register;
begin
  LObject := nil;
  try
    // Set some sample values
    LObject := TUnsupportedFieldsClass_Register.Create;
    LoadUnsupportedFieldsClass(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TUnsupportedFieldsClassFactory_Register.TypeDescription: string;
begin
  Result := 'TUnsupportedFieldsClass (reg)';
end;

procedure TUnsupportedFieldsClassFactory_Register.ValidateClass(AObject: TObject);
var
  LObject: TUnsupportedFieldsClass_Register;
begin
  Assert(AObject is TUnsupportedFieldsClass_Register);
  LObject := TUnsupportedFieldsClass_Register(AObject);
  ValidateUnsupportedFieldsClass(LObject);
end;

type
  TClassWithGenericListFieldFactory = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;


{ TClassWithGenericListFieldFactory }

function TClassWithGenericListFieldFactory.CreateClass: TObject;
var
  LObject: TClassWithGenericListField;
begin
  LObject := nil;
  try
    LObject := TClassWithGenericListField.Create;
    LoadClassWithGenericListField(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TClassWithGenericListFieldFactory.TypeDescription: string;
begin
  Result := 'GenericList Field (attr)';
end;

procedure TClassWithGenericListFieldFactory.ValidateClass(AObject: TObject);
var
  LObject: TClassWithGenericListField;
begin
  Assert(AObject is TClassWithGenericListField);
  LObject := TClassWithGenericListField(AObject);
  ValidateClassWithGenericListField(LObject);
end;

type
  TClassWithGenericListFieldFactory_Register = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;


{ TClassWithGenericListFieldFactory_Register }

function TClassWithGenericListFieldFactory_Register.CreateClass: TObject;
var
  LObject: TClassWithGenericListField_Register;
begin
  LObject := nil;
  try
    LObject := TClassWithGenericListField_Register.Create;
    LoadClassWithGenericListField(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TClassWithGenericListFieldFactory_Register.TypeDescription: string;
begin
  Result := 'GenericList Field (reg)';
end;

procedure TClassWithGenericListFieldFactory_Register.ValidateClass(AObject: TObject);
var
  LObject: TClassWithGenericListField_Register;
begin
  Assert(AObject is TClassWithGenericListField_Register);
  LObject := TClassWithGenericListField_Register(AObject);
  ValidateClassWithGenericListField(LObject);
end;

type
  TClassWithGenericDictionaryFieldFactory = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;


{ TClassWithGenericDictionaryFieldFactory }

function TClassWithGenericDictionaryFieldFactory.CreateClass: TObject;
var
  LObject: TClassWithGenericDictionaryField;
begin
  LObject := nil;
  try
    LObject := TClassWithGenericDictionaryField.Create;
    LoadClassWithGenericDictionaryField(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TClassWithGenericDictionaryFieldFactory.TypeDescription: string;
begin
  Result := 'GenericDictionary Field (attr)';
end;

procedure TClassWithGenericDictionaryFieldFactory.ValidateClass(AObject: TObject);
var
  LObject: TClassWithGenericDictionaryField;
begin
  Assert(AObject is TClassWithGenericDictionaryField);
  LObject := TClassWithGenericDictionaryField(AObject);
  ValidateClassWithGenericDictionaryField(LObject);
end;

type
  TClassWithGenericDictionaryFieldFactory_Register = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;


{ TClassWithGenericDictionaryFieldFactory_Register }

function TClassWithGenericDictionaryFieldFactory_Register.CreateClass: TObject;
var
  LObject: TClassWithGenericDictionaryField_Register;
begin
  LObject := nil;
  try
    LObject := TClassWithGenericDictionaryField_Register.Create;
    LoadClassWithGenericDictionaryField(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TClassWithGenericDictionaryFieldFactory_Register.TypeDescription: string;
begin
  Result := 'GenericDictionary Field (reg)';
end;

procedure TClassWithGenericDictionaryFieldFactory_Register.ValidateClass(AObject: TObject);
var
  LObject: TClassWithGenericDictionaryField_Register;
begin
  Assert(AObject is TClassWithGenericDictionaryField_Register);
  LObject := TClassWithGenericDictionaryField_Register(AObject);
  ValidateClassWithGenericDictionaryField(LObject);
end;

type
  TClassWithTStringsFieldFactory_Attribute = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;

  TClassWithTStringsFieldFactory_Register = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;


{ TClassWithTStringsFieldFactory_Attribute }

function TClassWithTStringsFieldFactory_Attribute.CreateClass: TObject;
var
  LObject: TClassWithTStringsField_Attribute;
begin
  LObject := nil;
  try
    LObject := TClassWithTStringsField_Attribute.Create;
    LoadClassWithTStringsSampleDate(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TClassWithTStringsFieldFactory_Attribute.TypeDescription: string;
begin
  Result := 'TStringList Field (attr)';
end;

procedure TClassWithTStringsFieldFactory_Attribute.ValidateClass(AObject: TObject);
var
  LObject: TClassWithTStringsField_Attribute;
begin
  Assert(AObject is TClassWithTStringsField_Attribute);
  LObject := TClassWithTStringsField_Attribute(AObject);
  ValidateClassWithTStringsSampleDate(LObject);
end;

{ TClassWithTStringsFieldFactory_Register }

function TClassWithTStringsFieldFactory_Register.CreateClass: TObject;
var
  LObject: TClassWithTStringsField_Register;
begin
  LObject := nil;
  try
    LObject := TClassWithTStringsField_Register.Create;
    LoadClassWithTStringsSampleDate(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TClassWithTStringsFieldFactory_Register.TypeDescription: string;
begin
  Result := 'TStringList Field (reg)';
end;

procedure TClassWithTStringsFieldFactory_Register.ValidateClass(AObject: TObject);
var
  LObject: TClassWithTStringsField_Register;
begin
  Assert(AObject is TClassWithTStringsField_Register);
  LObject := TClassWithTStringsField_Register(AObject);
  ValidateClassWithTStringsSampleDate(LObject);
end;

type
  TGenericListFactory = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;


{ TGenericListFieldFactory }

function TGenericListFactory.CreateClass: TObject;
var
  LObject: TList<TMyListItem>;
begin
  LObject := nil;
  try
    LObject := TList<TMyListItem>.Create;
    LoadGenericList(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TGenericListFactory.TypeDescription: string;
begin
  Result := 'GenericList';
end;

procedure TGenericListFactory.ValidateClass(AObject: TObject);
var
  LObject: TList<TMyListItem>;
begin
  Assert(AObject is TList<TMyListItem>);
  LObject := TList<TMyListItem>(AObject);
  ValidateGenericList(LObject);
end;

type
  TGenericDictionaryFactory = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;


{ TGenericDictionaryFactory }

function TGenericDictionaryFactory.CreateClass: TObject;
var
  LObject: TMyDictionary;
begin
  LObject := nil;
  try
    LObject := TMyDictionary.Create;
    LoadGenericDictionary(LObject);
  except
    LObject.Free;
    raise;
  end;
  Result := LObject;
end;

function TGenericDictionaryFactory.TypeDescription: string;
begin
  Result := 'GenericDictionary';
end;

procedure TGenericDictionaryFactory.ValidateClass(AObject: TObject);
var
  LObject: TMyDictionary;
begin
  Assert(AObject is TMyDictionary);
  LObject := TMyDictionary(AObject);
  ValidateGenericDictionary(LObject);
end;


type
  TGenericDictionaryPairsFactory = class(TTypeFactory)
  private
    FObjectsToFree: TObjectList<TObject>;
  public
    constructor Create;
    destructor Destroy; override;
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;


{ TGenericDictionaryPairs }


constructor TGenericDictionaryPairsFactory.Create;
begin
  FObjectsToFree := TObjectList<TObject>.Create(True);
end;

function TGenericDictionaryPairsFactory.CreateClass: TObject;
var
  LDictionary: TMyDictionary;
  LPairs: TMyDictionaryPairs;
begin
  LDictionary := nil;
  LPairs := nil;
  try
    LDictionary := TMyDictionary.Create;
    LoadGenericDictionary(LDictionary);
    LPairs := TMyDictionaryPairs.Create(LDictionary.ToArray);
    FObjectsToFree.Add(LDictionary);
    LDictionary := nil;
    Result := LPairs;
  except
    LDictionary.Free;
    LPairs.Free;
    raise;
  end;
end;

destructor TGenericDictionaryPairsFactory.Destroy;
begin
  FObjectsToFree.Free;
  inherited;
end;

function TGenericDictionaryPairsFactory.TypeDescription: string;
begin
  Result := 'GenericDictionaryPairs';
end;

procedure TGenericDictionaryPairsFactory.ValidateClass(AObject: TObject);
var
  LPairs: TMyDictionaryPairs;
  LObject: TMyDictionary;
  LPair: TPair<string, TMyDictionaryItem>;
begin
  Assert(AObject is TMyDictionaryPairs);
  LPairs := TMyDictionaryPairs(AObject);
  LObject := TMyDictionary.Create;
  for LPair in LPairs.Pairs do
    LObject.AddOrSetValue(LPair.Key, LPair.Value);
  try
    ValidateGenericDictionary(LObject);
  finally
    LObject.Free;
  end;
end;

{ TSampleCollectionFieldFactory }

type
  TSampleCollectionFieldFactory = class(TTypeFactory)
  public
    constructor Create;
    function TypeName: string; override;
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;

constructor TSampleCollectionFieldFactory.Create;
begin
end;

function TSampleCollectionFieldFactory.CreateClass: TObject;
var
  LObject: TSampleCollectionField;
begin
  LObject := TSampleCollectionField.Create;
  try
    LoadSampleCollectionField(LObject);
    Result := LObject;
  except
    LObject.Free;
    raise;
  end;
end;


function TSampleCollectionFieldFactory.TypeDescription: string;
begin
  Result := 'SampleCollectionField (attr)';
end;

procedure TSampleCollectionFieldFactory.ValidateClass(AObject: TObject);
var
  LObject: TSampleCollectionField;
begin
  Assert(AObject is TSampleCollectionField);
  LObject := TSampleCollectionField(AObject);
  ValidateSampleCollectionField(LObject);
end;

function TSampleCollectionFieldFactory.TypeName: string;
begin
  Result := TSampleCollectionField.ClassName;
end;

{ TSampleCollectionFieldFactory_Register }

type
  TSampleCollectionFieldFactory_Register = class(TTypeFactory)
  public
    constructor Create;
    function TypeName: string; override;
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;

constructor TSampleCollectionFieldFactory_Register.Create;
begin
end;

function TSampleCollectionFieldFactory_Register.CreateClass: TObject;
var
  LObject: TSampleCollectionField_Register;
begin
  LObject := TSampleCollectionField_Register.Create;
  try
    LoadSampleCollectionField(LObject);
    Result := LObject;
  except
    LObject.Free;
    raise;
  end;
end;


function TSampleCollectionFieldFactory_Register.TypeDescription: string;
begin
  Result := 'SampleCollectionField (reg)';
end;

procedure TSampleCollectionFieldFactory_Register.ValidateClass(AObject: TObject);
var
  LObject: TSampleCollectionField_Register;
begin
  Assert(AObject is TSampleCollectionField_Register);
  LObject := TSampleCollectionField_Register(AObject);
  ValidateSampleCollectionField(LObject);
end;

function TSampleCollectionFieldFactory_Register.TypeName: string;
begin
  Result := TSampleCollectionField_Register.ClassName;
end;


initialization
  TestTypeFactory.RegisterTypeFactory(TUnsupportedFieldsClassFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TUnsupportedFieldsClassFactory_Register.Create);
  TestTypeFactory.RegisterTypeFactory(TClassWithGenericListFieldFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TGenericListFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TGenericDictionaryFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TGenericDictionaryPairsFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TClassWithGenericListFieldFactory_Register.Create);
  TestTypeFactory.RegisterTypeFactory(TClassWithGenericDictionaryFieldFactory_Register.Create);
  TestTypeFactory.RegisterTypeFactory(TClassWithGenericDictionaryFieldFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TClassWithTStringsFieldFactory_Attribute.Create);
  TestTypeFactory.RegisterTypeFactory(TClassWithTStringsFieldFactory_Register.Create);
  TestTypeFactory.RegisterTypeFactory(TSampleCollectionFieldFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TSampleCollectionFieldFactory_Register.Create);
end.
