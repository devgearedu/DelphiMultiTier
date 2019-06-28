
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// Register type factories for TPerson
unit PersonFactories;

interface

uses  SysUtils, Classes, DBXJSON, Generics.Collections,
  StrUtils, RTTI, DBXJSONReflect;

implementation

uses Person1, PersonISODate, TestTypeFactory;

type
  TPerson1TypeFactory = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;

  TPerson1CollectionTypeFactory = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;

  TPersonISODateAttributeTypeFactory = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;

  TPersonISODateRegisterTypeFactory = class(TTypeFactory)
    function TypeDescription: string; override;
    function CreateClass: TObject; override;
    procedure ValidateClass(AObject: TObject); override;
  end;

{ TPerson1TypeFactory }

function TPerson1TypeFactory.CreateClass: TObject;
var
  LPerson: TPerson1;
begin
  LPerson := TPerson1.Create;
  LoadPerson1SampleData(LPerson);
  Result := LPerson;
end;

function TPerson1TypeFactory.TypeDescription: string;
begin
  Result := TPerson1.ClassName;
end;

procedure TPerson1TypeFactory.ValidateClass(AObject: TObject);
begin
  ValidatePerson1SampleData(TPerson1(AObject));
end;

{ TPerson2TypeFactory }

function TPersonISODateAttributeTypeFactory.CreateClass: TObject;
var
  LPerson: TPersonISODate_Attribute;
begin
  LPerson := TPersonISODate_Attribute.Create;
  LoadPersonISODateSampleData(LPerson);
  Result := LPerson;
end;

function TPersonISODateAttributeTypeFactory.TypeDescription: string;
begin
  Result := 'TPersonISODate (attr)';
end;

procedure TPersonISODateAttributeTypeFactory.ValidateClass(AObject: TObject);
begin
  ValidatePersonISODateSampleData(TPersonISODate_Attribute(AObject));
end;

{ TPersonISODateRegisterTypeFactory }

function TPersonISODateRegisterTypeFactory.CreateClass: TObject;
var
  LPerson: TPersonISODate_Register;
begin
  LPerson := TPersonISODate_Register.Create;
  LoadPersonISODateSampleData(LPerson, 'b');
  Result := LPerson;
end;

function TPersonISODateRegisterTypeFactory.TypeDescription: string;
begin
  Result := 'TPersonISODate (reg)';
end;

procedure TPersonISODateRegisterTypeFactory.ValidateClass(AObject: TObject);
begin
  ValidatePersonISODateSampleData(TPersonISODate_Register(AObject), 'b');
end;

{ TPerson1CollectionTypeFactory }

function TPerson1CollectionTypeFactory.CreateClass: TObject;
var
  LPersons: TPerson1Collection;
begin
  LPersons := TPerson1Collection.Create;
  LoadPerson1CollectionSampleData(LPersons, 'a');
  Result := LPersons;
end;

function TPerson1CollectionTypeFactory.TypeDescription: string;
begin
  Result := TPerson1Collection.ClassName;
end;

procedure TPerson1CollectionTypeFactory.ValidateClass(AObject: TObject);
begin
  ValidatePerson1CollectionSampleData(TPerson1Collection(AObject), 'a');
end;

initialization
  TestTypeFactory.RegisterTypeFactory(TPerson1TypeFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TPerson1CollectionTypeFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TPersonISODateAttributeTypeFactory.Create);
  TestTypeFactory.RegisterTypeFactory(TPersonISODateRegisterTypeFactory.Create);

end.
