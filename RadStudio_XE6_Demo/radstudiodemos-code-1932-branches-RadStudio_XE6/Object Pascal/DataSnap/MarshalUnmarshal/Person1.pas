
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Person1;

interface

type
  TPhoneType1 = (phHome, phWork, phMobile);
  TAddressType1 = (addHome, addWork);
  TParentType1 = (parFather, parMother);
  TGenderType1 = (geMale, geFemale);
  TChildType1 = (chSon, chDaughter);
  TPerson1 = class;

  TAddress1 = record
    AddressType: TAddressType1;
    Street: string;
    City: string;
    State: string;
    Zip: string;
  end;

  TPhone1 = record
    Number: string;
    PhoneType: TPhoneType1;
  end;

  TParent1 = record
    Person: TPerson1;
    ParentType: TParentType1;
  end;

  TChild1 = record
    Person: TPerson1;
    ChildType: TChildType1;
  end;

  TPerson1 = class
  private
    FFirstName: string;
    FLastName: string;
    FWeightLb: Integer;
    FHeightIn: Single;
    FDateOfBirth: TDate;
    FAddresses: TArray<TAddress1>;
    FPhones: TArray<TPhone1>;
  public
    property FirstName: string read FFirstName;
    property LastName: string read FLastName;
  end;


  TPerson1Collection = class
  private
    FPersons: TArray<TPerson1>;
  public
    destructor Destroy; override;
    property Persons: TArray<TPerson1> read FPersons;
  end;

  procedure LoadPerson1SampleData(APerson: TPerson1); overload;
  procedure ValidatePerson1SampleData(APerson: TPerson1); overload;
  procedure LoadPerson1CollectionSampleData(APersons: TPerson1Collection); overload;
  procedure ValidatePerson1CollectionSampleData(APersons: TPerson1Collection); overload;

  procedure LoadPerson1SampleData(APerson: TPerson1; const APrefix: string); overload;
  procedure ValidatePerson1SampleData(APerson: TPerson1; const APrefix: string); overload;
  procedure LoadPerson1CollectionSampleData(APersons: TPerson1Collection; const APrefix: string); overload;
  procedure ValidatePerson1CollectionSampleData(APersons: TPerson1Collection; const APrefix: string); overload;
implementation

uses DateUtils;

procedure LoadPerson1SampleData(APerson: TPerson1);
begin
  LoadPerson1SampleData(APerson, 'a');
end;

procedure LoadPerson1SampleData(APerson: TPerson1; const APrefix: string);
begin
  APerson.FFirstName := APrefix + 'SampleFirst';
  APerson.FLastName := APrefix + 'SampleLast';
  APerson.FWeightLb := 160;
  APerson.FHeightIn := 70.5;
  APerson.FDateOfBirth :=
    EncodeDateTime(1960, 12, 11, 0, 0, 0, 0);
  SetLength(APerson.FAddresses, 2);
  with APerson.FAddresses[0] do
  begin
    AddressType := addHome;
    Street := APrefix + 'SampleHomeStreet';
    City := APrefix + 'SampleHomeCity';
    State := APrefix + 'SampleHomeState';
    Zip := APrefix + 'SampleHomeZip';
  end;
  with APerson.FAddresses[1] do
  begin
    AddressType := addWork;
    Street := APrefix + 'SampleWorkStreet';
    City := APrefix + 'SampleWorkCity';
    State := APrefix + 'SampleWorkState';
    Zip := APrefix + 'SampleWorkZip';
  end;

  SetLength(APerson.FPhones, 3);
  with APerson.FPhones[0] do
  begin
    PhoneType := phMobile;
    Number := APrefix + 'SampleMobileNumber';
  end;
  with APerson.FPhones[1] do
  begin
    PhoneType := phWork;
    Number := APrefix + 'SampleWorkNumber';
  end;
  with APerson.FPhones[2] do
  begin
    PhoneType := phHome;
    Number := APrefix + 'SampleHomeNumber';
  end;
end;

procedure ValidatePerson1SampleData(APerson: TPerson1);
begin
  ValidatePerson1SampleData(APerson, 'a');
end;

procedure ValidatePerson1SampleData(APerson: TPerson1; const APrefix: string);
begin
  Assert(APerson <> nil);
  Assert(APerson.FFirstName = APrefix + 'SampleFirst');
  Assert(APerson.FLastName = APrefix + 'SampleLast');
  Assert(APerson.FWeightLb = 160);
  Assert(APerson.FHeightIn = 70.5);

  Assert(YearOf(APerson.FDateOfBirth) = 1960);
  Assert(MonthOf(APerson.FDateOfBirth) = 12);
  Assert(DayOf(APerson.FDateOfBirth) = 11);

  Assert(Length(APerson.FAddresses) = 2);
  with APerson.FAddresses[0] do
  begin
    Assert(AddressType = addHome);
    Assert(Street = APrefix + 'SampleHomeStreet');
    Assert(City = APrefix + 'SampleHomeCity');
    Assert(State = APrefix + 'SampleHomeState');
    Assert(Zip = APrefix + 'SampleHomeZip');
  end;
  with APerson.FAddresses[1] do
  begin
    Assert(AddressType = addWork);
    Assert(Street = APrefix + 'SampleWorkStreet');
    Assert(City = APrefix + 'SampleWorkCity');
    Assert(State = APrefix + 'SampleWorkState');
    Assert(Zip = APrefix + 'SampleWorkZip');
  end;

  Assert(Length(APerson.FPhones) = 3);
  with APerson.FPhones[0] do
  begin
    Assert(PhoneType = phMobile);
    Assert(Number = APrefix + 'SampleMobileNumber');
  end;
  with APerson.FPhones[1] do
  begin
    Assert(PhoneType = phWork);
    Assert(Number = APrefix + 'SampleWorkNumber');
  end;
  with APerson.FPhones[2] do
  begin
    Assert(PhoneType = phHome);
    Assert(Number = APrefix + 'SampleHomeNumber');
  end;
end;

procedure LoadPerson1CollectionSampleData(APersons: TPerson1Collection);
begin
  LoadPerson1CollectionSampleData(APersons, 'a');
end;

procedure LoadPerson1CollectionSampleData(APersons: TPerson1Collection; const APrefix: string);
begin
  SetLength(APersons.FPersons, 3);
  APersons.FPersons[0] := TPerson1.Create;
  LoadPerson1SampleData(APersons.FPersons[0],
    'a' + APrefix);
  APersons.FPersons[1] := TPerson1.Create;
  LoadPerson1SampleData(APersons.FPersons[1],
    'b' + APrefix);
  APersons.FPersons[2] := TPerson1.Create;
  LoadPerson1SampleData(APersons.FPersons[2],
    'c' + APrefix);
end;

procedure ValidatePerson1CollectionSampleData(APersons: TPerson1Collection);
begin
  ValidatePerson1CollectionSampleData(APersons, 'a');
end;


procedure ValidatePerson1CollectionSampleData(APersons: TPerson1Collection; const APrefix: string);
begin
  Assert(APersons <> nil);
  Assert(Length(APersons.FPersons)=3);
  ValidatePerson1SampleData(APersons.FPersons[0],
    'a' + APrefix);
  ValidatePerson1SampleData(APersons.FPersons[1],
    'b' + APrefix);
  ValidatePerson1SampleData(APersons.FPersons[2],
    'c' + APrefix);
end;

{ TPerson1Collection }

destructor TPerson1Collection.Destroy;
var
  LPerson: TPerson1;
begin
  for LPerson in FPersons do
    LPerson.Free;
  inherited;
end;

end.
