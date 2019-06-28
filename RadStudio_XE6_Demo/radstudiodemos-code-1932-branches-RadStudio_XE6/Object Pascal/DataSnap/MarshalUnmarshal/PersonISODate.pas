
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit PersonISODate;

interface

uses Person1, MarshallingUtils, DBXJSonReflect;

type

  // use attribute to specify conversion
  TPersonISODate_Attribute = class
  private
    FFirstName: string;
    FLastName: string;
    FWeightLb: Integer;
    FHeightIn: Single;
    // Render Date as string
    [JSONReflect(ctString, rtString,
       TISODateTimeInterceptor, nil,true)]
    FDateOfBirth: TDate;
    FAddresses: TArray<TAddress1>;
    FPhones: TArray<TPhone1>;
  end;

  // converter registered in initialization section
  TPersonISODate_Register = class
  private
    FFirstName: string;
    FLastName: string;
    FWeightLb: Integer;
    FHeightIn: Single;
    FDateOfBirth: TDate;
    FAddresses: TArray<TAddress1>;
    FPhones: TArray<TPhone1>;
  end;


  procedure LoadPersonISODateSampleData(APerson: TPersonISODate_Attribute; const APrefix: string); overload;
  procedure ValidatePersonISODateSampleData(APerson: TPersonISODate_Attribute; const APrefix: string); overload;
  procedure LoadPersonISODateSampleData(APerson: TPersonISODate_Register; const APrefix: string); overload;
  procedure ValidatePersonISODateSampleData(APerson: TPersonISODate_Register; const APrefix: string); overload;
  procedure LoadPersonISODateSampleData(APerson: TPersonISODate_Attribute); overload;
  procedure ValidatePersonISODateSampleData(APerson: TPersonISODate_Attribute); overload;
  procedure LoadPersonISODateSampleData(APerson: TPersonISODate_Register); overload;
  procedure ValidatePersonISODateSampleData(APerson: TPersonISODate_Register); overload;

implementation

uses DateUtils;

procedure LoadPersonISODateSampleData(APerson: TPersonISODate_Attribute);
begin
  LoadPersonISODateSampleData(APerson,'a');
end;

procedure LoadPersonISODateSampleData(APerson: TPersonISODate_Attribute; const APrefix: string);
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

procedure LoadPersonISODateSampleData(APerson: TPersonISODate_Register);
begin
  LoadPersonISODateSampleData(APerson, 'a');
end;

procedure LoadPersonISODateSampleData(APerson: TPersonISODate_Register; const APrefix: string);
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

procedure ValidatePersonISODateSampleData(APerson: TPersonISODate_Attribute);
begin
  ValidatePersonISODateSampleData(APerson, 'a');
end;

procedure ValidatePersonISODateSampleData(APerson: TPersonISODate_Attribute; const APrefix: string);
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

procedure ValidatePersonISODateSampleData(APerson: TPersonISODate_Register);
begin
  ValidatePersonISODateSampleData(APerson, 'a');
end;

procedure ValidatePersonISODateSampleData(APerson: TPersonISODate_Register; const APrefix: string);
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


procedure RegisterReverterConverters;
var
  LReverter: TReverterEvent;
  LConverter: TConverterEvent;
begin
  LReverter := TReverterEvent.Create(TPersonISODate_Register, 'FDateOfBirth');
  LReverter.StringReverter := ISODateTimeReverter;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TPersonISODate_Register, 'FDateOfBirth');
  LConverter.StringConverter := ISODateTimeConverter;
  TJSONConverters.AddConverter(LConverter);

end;

initialization
  RegisterReverterConverters;
end.
