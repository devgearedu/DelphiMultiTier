
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DBXFormUnit61;

// Test Marshalling/Unmarshalling of user types with a DBX client
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm61 = class(TForm)
    Memo1: TMemo;
    ButtonAll: TButton;
    ButtonGenericListFields: TButton;
    CheckBoxInstanceOwner: TCheckBox;
    Button1: TButton;
    ButtonUnsupportedFields: TButton;
    ButtonStringFieldsTests: TButton;
    ButtonPersonTests: TButton;
    CheckBoxRegistered: TCheckBox;
    CheckBoxAttributes: TCheckBox;
    ButtonGenericDictionaryTests: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ButtonAllClick(Sender: TObject);
    procedure ButtonGenericListFieldsClick(Sender: TObject);
    procedure ButtonPersonTestsClick(Sender: TObject);
    procedure ButtonStringFieldsTestsClick(Sender: TObject);
    procedure ButtonUnsupportedFieldsClick(Sender: TObject);
    procedure CheckBoxInstanceOwnerClick(Sender: TObject);
    procedure ButtonGenericDictionaryTestsClick(Sender: TObject);
  private
    function GetInstanceOwner: Boolean;
    function TestRegistered: Boolean;
    function TestAttributes: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form61: TForm61;

implementation

{$R *.dfm}

uses DBXClientModuleUnit9, 
Person1, PersonISODate, DSClientRest,
  StringsField, MarshalUnsupportedFields, GenericListField, GenericDictionaryField,
  Generics.Collections;


procedure LogLine(const AValue: string);
begin
  Form61.Memo1.Lines.Add(AValue);
end;

procedure TForm61.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
end;

function TForm61.GetInstanceOwner: Boolean;
begin
  Result := CheckBoxInstanceOwner.Checked;
end;

function TForm61.TestRegistered: Boolean;
begin
  Result := CheckBoxRegistered.Checked;
end;

function TForm61.TestAttributes: Boolean;
begin
  Result := CheckBoxAttributes.Checked;
end;

procedure TForm61.ButtonAllClick(Sender: TObject);
begin
  ButtonPersonTestsClick(Self);
  ButtonStringFieldsTestsClick(Self);
  ButtonUnsupportedFieldsClick(Self);
  ButtonGenericListFieldsClick(Self);
  ButtonGenericDictionaryTestsClick(Self);
end;

procedure TForm61.ButtonGenericDictionaryTestsClick(Sender: TObject);
var
  LClassWithGenericDictionaryField: TClassWithGenericDictionaryField;
  LClassWithGenericDictionaryField_Register: TClassWithGenericDictionaryField_Register;
  LMyDictionary: TMyDictionary;
  LMyDictionary2: TMyDictionary;
  LMyDictionaryPairs: TMyDictionaryPairs;
  LMyPair: TPair<string, TMyDictionaryItem>;
begin
  ClientModule9.InstanceOwner := GetInstanceOwner;
  try
    if TestAttributes then
    begin
      LClassWithGenericDictionaryField := ClientModule9.ServerMethods2Client.GetGenericDictionaryField;
      try
        ValidateClassWithGenericDictionaryField(LClassWithGenericDictionaryField);
        LogLine('GetGenericDictionaryField');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           LClassWithGenericDictionaryField := TClassWithGenericDictionaryField.Create;
           LoadClassWithGenericDictionaryField(LClassWithGenericDictionaryField);
        end;
        if not ClientModule9.ServerMethods2Client.ValidateGenericDictionaryField (LClassWithGenericDictionaryField) then
          raise Exception.Create('ValidateGenericDictionaryField');
        LogLine('ValidateGenericDictionaryField');
      finally
        if not ClientModule9.InstanceOwner then
          LClassWithGenericDictionaryField.Free;
      end;
    end;
    if TestRegistered then
    begin
      LClassWithGenericDictionaryField_Register := ClientModule9.ServerMethods2Client.GetGenericDictionaryField_Register;
      try
        ValidateClassWithGenericDictionaryField(LClassWithGenericDictionaryField_Register);
        LogLine('GetGenericDictionaryField_Register');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           LClassWithGenericDictionaryField_Register := TClassWithGenericDictionaryField_Register.Create;
           LoadClassWithGenericDictionaryField(LClassWithGenericDictionaryField_Register);
        end;
        if not ClientModule9.ServerMethods2Client.ValidateGenericDictionaryField_Register (LClassWithGenericDictionaryField_Register) then
          raise Exception.Create('ValidateGenericDictionaryField_Register');
        LogLine('ValidateGenericDictionaryField_Register');
      finally
        if not ClientModule9.InstanceOwner then
          LClassWithGenericDictionaryField_Register.Free;
      end;
    end;
    if True then // Test marshalling/unmarshalling a dictionary
    begin
      LMyDictionary := ClientModule9.ServerMethods2Client.GetGenericDictionary;
      try
        ValidateGenericDictionary(LMyDictionary);
        LogLine('GetGenericDictionary');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           LMyDictionary := TMyDictionary.Create;
           LoadGenericDictionary(LMyDictionary);
        end;
        if not ClientModule9.ServerMethods2Client.ValidateGenericDictionary (LMyDictionary) then
          raise Exception.Create('ValidateGenericDictionary');
        LogLine('ValidateGenericDictionary');
      finally
        if not ClientModule9.InstanceOwner then
          LMyDictionary.Free;
      end;
    end;
    if True then // Test marshalling/unmarshalling just pairs
    begin
      LMyDictionaryPairs := ClientModule9.ServerMethods2Client.GetGenericDictionaryPairs;
      try
        LMyDictionary := TMyDictionary.Create;
        try
          for LMyPair in LMyDictionaryPairs.Pairs do
            // Load pairs intoa dictionary
            LMyDictionary.Add(LMyPair.Key, LMyPair.Value);
          ValidateGenericDictionary(LMyDictionary);
          LogLine('GetGenericDictionaryPairs');
          if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
          begin
            LMyDictionary2 := TMyDictionary.Create;
            try
              LoadGenericDictionary(LMyDictionary2);
              LMyDictionaryPairs := TMyDictionaryPairs.Create(LMyDictionary2.ToArray);
              if not ClientModule9.ServerMethods2Client.ValidateGenericDictionaryPairs(LMyDictionaryPairs) then
                raise Exception.Create('ValidateGenericDictionaryPairs');
            finally
              LMyDictionary2.Free;
            end;
          end
          else
            if not ClientModule9.ServerMethods2Client.ValidateGenericDictionaryPairs(LMyDictionaryPairs) then
              raise Exception.Create('ValidateGenericDictionaryPairs');
        finally
          LMyDictionary.Free;
        end;
        LogLine('ValidateGenericDictionaryPairs');
      finally
        if not ClientModule9.InstanceOwner then
          LMyDictionaryPairs.Free;
      end;
    end;
    LogLine('GenericDictionary OK'#13#10);
  except
    on E: TDSRestProtocolException do
      ShowMessage(Format('%s: %s, %s', [E.ClassName, E.Message, E.ResponseText]));
    on E: Exception do
      ShowMessage(Format('%s: %s', [E.ClassName, E.Message]));

  end;
end;

procedure TForm61.ButtonGenericListFieldsClick(Sender: TObject);
var
  LClassWithGenericListField: TClassWithGenericListField;
  LClassWithGenericListField_Register: TClassWithGenericListField_Register;
  LNothingToDo: Boolean;
begin
  LNothingToDo := True;
  ClientModule9.InstanceOwner := GetInstanceOwner;
  try
    if TestAttributes then
    begin
      LNothingToDo := False;
      LClassWithGenericListField := ClientModule9.ServerMethods2Client.GetGenericListField;
      try
        ValidateClassWithGenericListField(LClassWithGenericListField);
        LogLine('GetGenericListField');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           LClassWithGenericListField := TClassWithGenericListField.Create;
           LoadClassWithGenericListField(LClassWithGenericListField);
        end;
        if not ClientModule9.ServerMethods2Client.ValidateGenericListField (LClassWithGenericListField) then
          raise Exception.Create('ValidateGenericListField');
        LogLine('ValidateGenericListField');
      finally
        if not ClientModule9.InstanceOwner then
          LClassWithGenericListField.Free;
      end;
    end;
    if TestRegistered then
    begin
      LNothingToDo := False;
      LClassWithGenericListField_Register := ClientModule9.ServerMethods2Client.GetGenericListField_Register;
      try
        ValidateClassWithGenericListField(LClassWithGenericListField_Register);
        LogLine('GetGenericListField_Register');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           LClassWithGenericListField_Register := TClassWithGenericListField_Register.Create;
           LoadClassWithGenericListField(LClassWithGenericListField_Register);
        end;
        if not ClientModule9.ServerMethods2Client.ValidateGenericListField_Register (LClassWithGenericListField_Register) then
          raise Exception.Create('ValidateGenericListField_Register');
        LogLine('ValidateGenericListField_Register');
      finally
        if not ClientModule9.InstanceOwner then
          LClassWithGenericListField_Register.Free;
      end;
    end;
    if LNothingToDo then
      LogLine('GenericListField nothing to do'#13#10)
    else
      LogLine('GenericListField OK'#13#10);
  except
    on E: TDSRestProtocolException do
      ShowMessage(Format('%s: %s, %s', [E.ClassName, E.Message, E.ResponseText]));
    on E: Exception do
      ShowMessage(Format('%s: %s', [E.ClassName, E.Message]));

  end;
end;

procedure TForm61.ButtonPersonTestsClick(Sender: TObject);
var
  Person1: TPerson1;
  PersonsCollection: TPerson1Collection;
  PersonISODate_Attribute: TPersonISODate_Attribute;
  PersonISODate_Register: TPersonISODate_Register;
begin
  ClientModule9.InstanceOwner := GetInstanceOwner;
  try
    Person1 := ClientModule9.ServerMethods2Client.GetPerson;
    try
      ValidatePerson1SampleData(Person1);
      LogLine('GetPerson');
      if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
      begin
         Person1 := TPerson1.Create;
         LoadPerson1SampleData(Person1);
      end;
      if not ClientModule9.ServerMethods2Client.ValidatePerson(Person1) then
        raise Exception.Create('ValidatePerson');
      LogLine('ValidatePerson');
    finally
      if not ClientModule9.InstanceOwner then
        Person1.Free;
    end;
    PersonsCollection := ClientModule9.ServerMethods2Client.GetPersonCollection;
    try
      ValidatePerson1CollectionSampleData(PersonsCollection);
      LogLine('GetPersonCollection');
      if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
      begin
         PersonsCollection := TPerson1Collection.Create;
         LoadPerson1CollectionSampleData(PersonsCollection);
      end;
      if not ClientModule9.ServerMethods2Client.ValidatePersonCollection(PersonsCollection) then
        raise Exception.Create('ValidatePerson');
      LogLine('ValidatePerson');
    finally
      if not ClientModule9.InstanceOwner then
        PersonsCollection.Free;
    end;
    if TestAttributes then
    begin
      PersonISODate_Attribute := ClientModule9.ServerMethods2Client.GetPerson_Attribute;
      try
        ValidatePersonISODateSampleData(PersonISODate_Attribute);
        LogLine('GetPerson_Attribute');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           PersonISODate_Attribute := TPersonISODate_Attribute.Create;
           LoadPersonISODateSampleData(PersonISODate_Attribute);
        end;
        if not ClientModule9.ServerMethods2Client.ValidatePerson_Attribute(PersonISODate_Attribute) then
          raise Exception.Create('ValidatePerson_Attribute');
        LogLine('ValidatePerson_Attribute');
      finally
        if not ClientModule9.InstanceOwner then
          PersonISODate_Attribute.Free;
      end;
    end;
    if TestRegistered then
    begin
      PersonISODate_Register := ClientModule9.ServerMethods2Client.GetPerson_Register;
      try
        ValidatePersonISODateSampleData(PersonISODate_Register);
        LogLine('GetPerson_Register');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           PersonISODate_Register := TPersonISODate_Register.Create;
           LoadPersonISODateSampleData(PersonISODate_Register);
        end;
        if not ClientModule9.ServerMethods2Client.ValidatePerson_Register(PersonISODate_Register) then
          raise Exception.Create('ValidatePerson_Register');
        LogLine('ValidatePerson_Register');
      finally
        if not ClientModule9.InstanceOwner then
          PersonISODate_Register.Free;
      end;
    end;
    LogLine('Person OK'#13#10);
  except
    on E: TDSRestProtocolException do
      ShowMessage(Format('%s: %s, %s', [E.ClassName, E.Message, E.ResponseText]));
    on E: Exception do
      ShowMessage(Format('%s: %s', [E.ClassName, E.Message]));

  end;
end;

procedure TForm61.ButtonStringFieldsTestsClick(Sender: TObject);
var
  LClassWithStringsField_Attribute: TClassWithTStringsField_Attribute;
  LClassWithStringsField_Register: TClassWithTStringsField_Register;
  LNothingToDo: Boolean;
begin
  LNothingToDo := True;
  ClientModule9.InstanceOwner := GetInstanceOwner;
  try
    if TestAttributes then
    begin
      LNothingToDo := False;
      LClassWithStringsField_Attribute := ClientModule9.ServerMethods2Client.GetClassWithTStrings_Attribute;
      try
        ValidateClassWithTStringsSampleDate(LClassWithStringsField_Attribute);
        LogLine('GetClassWithTStrings_Attribute');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           LClassWithStringsField_Attribute := TClassWithTStringsField_Attribute.Create;
           LoadClassWithTStringsSampleDate(LClassWithStringsField_Attribute);
        end;
        if not ClientModule9.ServerMethods2Client.ValidateClassWithTStrings_Attribute (LClassWithStringsField_Attribute) then
          raise Exception.Create('LClassWithStringsField_Attribute');
        LogLine('ValidateClassWithTStrings_Attribute');
      finally
        if not ClientModule9.InstanceOwner then
          LClassWithStringsField_Attribute.Free;
      end;
    end;
    if TestRegistered then
    begin
      LNothingToDo := False;
      LClassWithStringsField_Register := ClientModule9.ServerMethods2Client.GetClassWithTStrings_Register;
      try
        ValidateClassWithTStringsSampleDate(LClassWithStringsField_Register);
        LogLine('GetClassWithTStrings_Register');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           LClassWithStringsField_Register := TClassWithTStringsField_Register.Create;
           LoadClassWithTStringsSampleDate(LClassWithStringsField_Register);
        end;
        if not ClientModule9.ServerMethods2Client.ValidateClassWithTStrings_Register(LClassWithStringsField_Register) then
          raise Exception.Create('LClassWithStringsField_Register');
        LogLine('ValidateClassWithTStrings_Register');
      finally
        if not ClientModule9.InstanceOwner then
          LClassWithStringsField_Register.Free;
      end;
    end;
    if LNothingToDo then
      LogLine('StringFields nothing to do'#13#10)
    else
      LogLine('StringFields OK'#13#10);
  except
    on E: TDSRestProtocolException do
      ShowMessage(Format('%s: %s, %s', [E.ClassName, E.Message, E.ResponseText]));
    on E: Exception do
      ShowMessage(Format('%s: %s', [E.ClassName, E.Message]));

  end;
end;

procedure TForm61.ButtonUnsupportedFieldsClick(Sender: TObject);
var
  LUnsupportedFields: TUnsupportedFieldsClass;
  LUnsupportedFields_Register: TUnsupportedFieldsClass_Register;
  LNothingToDo: Boolean;
begin
  LNothingToDo := True;
  ClientModule9.InstanceOwner := GetInstanceOwner;
  try
    if TestAttributes then
    begin
      LNothingToDo := False;
      LUnsupportedFields := ClientModule9.ServerMethods2Client.GetUnsupportedFields;
      try
        ValidateUnsupportedFieldsClass(LUnsupportedFields);
        LogLine('GetUnsupportedFields');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           LUnsupportedFields := TUnsupportedFieldsClass.Create;
           LoadUnsupportedFieldsClass(LUnsupportedFields);
        end;
        if not ClientModule9.ServerMethods2Client.ValidateUnsupportedFields (LUnsupportedFields) then
          raise Exception.Create('ValidateUnsupportedFieldsClass');
        LogLine('ValidateUnsupportedFields');
      finally
        if not ClientModule9.InstanceOwner then
          LUnsupportedFields.Free;
      end;
    end;
    if TestRegistered then
    begin
      LNothingToDo := False;
      LUnsupportedFields_Register := ClientModule9.ServerMethods2Client.GetUnsupportedFields_Register;
      try
        ValidateUnsupportedFieldsClass(LUnsupportedFields_Register);
        LogLine('GetUnsupportedFields_Register');
        if ClientModule9.InstanceOwner then // Need another instance because the other will be freed
        begin
           LUnsupportedFields_Register := TUnsupportedFieldsClass_Register.Create;
           LoadUnsupportedFieldsClass(LUnsupportedFields_Register);
        end;
        if not ClientModule9.ServerMethods2Client.ValidateUnsupportedFields_Register (LUnsupportedFields_Register) then
          raise Exception.Create('ValidateUnsupportedFieldsClass_Register');
        LogLine('ValidateUnsupportedFields_Register');
      finally
        if not ClientModule9.InstanceOwner then
          LUnsupportedFields_Register.Free;
      end;
    end;
    if LNothingToDo then
      LogLine('UnsupportedFields nothing to do'#13#10)
    else
      LogLine('UnsupportedFields OK'#13#10);
  except
    on E: TDSRestProtocolException do
      ShowMessage(Format('%s: %s, %s', [E.ClassName, E.Message, E.ResponseText]));
    on E: Exception do
      ShowMessage(Format('%s: %s', [E.ClassName, E.Message]));

  end;
end;

procedure TForm61.CheckBoxInstanceOwnerClick(Sender: TObject);
begin
  // InstanceOwner flag can't be changed after client is created
  ClientModule9.ServerMethods2Client.Free;
  ClientModule9.ServerMethods2Client := nil;
end;

end.
