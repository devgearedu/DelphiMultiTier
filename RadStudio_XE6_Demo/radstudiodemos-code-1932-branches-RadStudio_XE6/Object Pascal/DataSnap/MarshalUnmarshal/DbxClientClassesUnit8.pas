
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
// 10/18/2010 9:30:41 AM
//

unit DbxClientClassesUnit8;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Person1, PersonISODate, StringsField, GenericListField, GenericDictionaryField, MarshalUnsupportedFields, DBXJSONReflect;

type
  TServerMethods2Client = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
    FGetPersonCommand: TDBXCommand;
    FGetPersonCollectionCommand: TDBXCommand;
    FGetPerson_AttributeCommand: TDBXCommand;
    FGetPerson_RegisterCommand: TDBXCommand;
    FGetClassWithTStrings_AttributeCommand: TDBXCommand;
    FGetClassWithTStrings_RegisterCommand: TDBXCommand;
    FGetGenericListFieldCommand: TDBXCommand;
    FGetGenericListField_RegisterCommand: TDBXCommand;
    FGetGenericDictionaryFieldCommand: TDBXCommand;
    FGetGenericDictionaryField_RegisterCommand: TDBXCommand;
    FGetUnsupportedFieldsCommand: TDBXCommand;
    FGetUnsupportedFields_RegisterCommand: TDBXCommand;
    FValidateClassWithTStrings_AttributeCommand: TDBXCommand;
    FValidateClassWithTStrings_RegisterCommand: TDBXCommand;
    FValidateGenericListFieldCommand: TDBXCommand;
    FValidateGenericListField_RegisterCommand: TDBXCommand;
    FValidateGenericDictionaryFieldCommand: TDBXCommand;
    FValidateGenericDictionaryField_RegisterCommand: TDBXCommand;
    FValidatePerson_RegisterCommand: TDBXCommand;
    FValidatePersonCommand: TDBXCommand;
    FValidatePerson_AttributeCommand: TDBXCommand;
    FValidatePersonCollectionCommand: TDBXCommand;
    FValidateUnsupportedFieldsCommand: TDBXCommand;
    FValidateUnsupportedFields_RegisterCommand: TDBXCommand;
    FProcessArrayCommand: TDBXCommand;
    FGetGenericDictionaryCommand: TDBXCommand;
    FValidateGenericDictionaryCommand: TDBXCommand;
    FGetGenericDictionaryPairsCommand: TDBXCommand;
    FValidateGenericDictionaryPairsCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
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
    function ValidateClassWithTStrings_Attribute(AValue: TClassWithTStringsField_Attribute): Boolean;
    function ValidateClassWithTStrings_Register(AValue: TClassWithTStringsField_Register): Boolean;
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
    function ValidateGenericDictionaryPairs(AValue: TMyDictionaryPairs): Boolean;
  end;

implementation

function TServerMethods2Client.EchoString(Value: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TServerMethods2.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.ExecuteUpdate;
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods2Client.ReverseString(Value: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TServerMethods2.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods2Client.GetPerson: TPerson1;
begin
  if FGetPersonCommand = nil then
  begin
    FGetPersonCommand := FDBXConnection.CreateCommand;
    FGetPersonCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetPersonCommand.Text := 'TServerMethods2.GetPerson';
    FGetPersonCommand.Prepare;
  end;
  FGetPersonCommand.ExecuteUpdate;
  if not FGetPersonCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetPersonCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetPersonCollection: TPerson1Collection;
begin
  if FGetPersonCollectionCommand = nil then
  begin
    FGetPersonCollectionCommand := FDBXConnection.CreateCommand;
    FGetPersonCollectionCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetPersonCollectionCommand.Text := 'TServerMethods2.GetPersonCollection';
    FGetPersonCollectionCommand.Prepare;
  end;
  FGetPersonCollectionCommand.ExecuteUpdate;
  if not FGetPersonCollectionCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetPersonCollectionCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetPerson_Attribute: TPersonISODate_Attribute;
begin
  if FGetPerson_AttributeCommand = nil then
  begin
    FGetPerson_AttributeCommand := FDBXConnection.CreateCommand;
    FGetPerson_AttributeCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetPerson_AttributeCommand.Text := 'TServerMethods2.GetPerson_Attribute';
    FGetPerson_AttributeCommand.Prepare;
  end;
  FGetPerson_AttributeCommand.ExecuteUpdate;
  if not FGetPerson_AttributeCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetPerson_AttributeCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetPerson_Register: TPersonISODate_Register;
begin
  if FGetPerson_RegisterCommand = nil then
  begin
    FGetPerson_RegisterCommand := FDBXConnection.CreateCommand;
    FGetPerson_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetPerson_RegisterCommand.Text := 'TServerMethods2.GetPerson_Register';
    FGetPerson_RegisterCommand.Prepare;
  end;
  FGetPerson_RegisterCommand.ExecuteUpdate;
  if not FGetPerson_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetPerson_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetClassWithTStrings_Attribute: TClassWithTStringsField_Attribute;
begin
  if FGetClassWithTStrings_AttributeCommand = nil then
  begin
    FGetClassWithTStrings_AttributeCommand := FDBXConnection.CreateCommand;
    FGetClassWithTStrings_AttributeCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetClassWithTStrings_AttributeCommand.Text := 'TServerMethods2.GetClassWithTStrings_Attribute';
    FGetClassWithTStrings_AttributeCommand.Prepare;
  end;
  FGetClassWithTStrings_AttributeCommand.ExecuteUpdate;
  if not FGetClassWithTStrings_AttributeCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetClassWithTStrings_AttributeCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetClassWithTStrings_Register: TClassWithTStringsField_Register;
begin
  if FGetClassWithTStrings_RegisterCommand = nil then
  begin
    FGetClassWithTStrings_RegisterCommand := FDBXConnection.CreateCommand;
    FGetClassWithTStrings_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetClassWithTStrings_RegisterCommand.Text := 'TServerMethods2.GetClassWithTStrings_Register';
    FGetClassWithTStrings_RegisterCommand.Prepare;
  end;
  FGetClassWithTStrings_RegisterCommand.ExecuteUpdate;
  if not FGetClassWithTStrings_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetClassWithTStrings_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetGenericListField: TClassWithGenericListField;
begin
  if FGetGenericListFieldCommand = nil then
  begin
    FGetGenericListFieldCommand := FDBXConnection.CreateCommand;
    FGetGenericListFieldCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetGenericListFieldCommand.Text := 'TServerMethods2.GetGenericListField';
    FGetGenericListFieldCommand.Prepare;
  end;
  FGetGenericListFieldCommand.ExecuteUpdate;
  if not FGetGenericListFieldCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetGenericListFieldCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetGenericListField_Register: TClassWithGenericListField_Register;
begin
  if FGetGenericListField_RegisterCommand = nil then
  begin
    FGetGenericListField_RegisterCommand := FDBXConnection.CreateCommand;
    FGetGenericListField_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetGenericListField_RegisterCommand.Text := 'TServerMethods2.GetGenericListField_Register';
    FGetGenericListField_RegisterCommand.Prepare;
  end;
  FGetGenericListField_RegisterCommand.ExecuteUpdate;
  if not FGetGenericListField_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetGenericListField_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetGenericDictionaryField: TClassWithGenericDictionaryField;
begin
  if FGetGenericDictionaryFieldCommand = nil then
  begin
    FGetGenericDictionaryFieldCommand := FDBXConnection.CreateCommand;
    FGetGenericDictionaryFieldCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetGenericDictionaryFieldCommand.Text := 'TServerMethods2.GetGenericDictionaryField';
    FGetGenericDictionaryFieldCommand.Prepare;
  end;
  FGetGenericDictionaryFieldCommand.ExecuteUpdate;
  if not FGetGenericDictionaryFieldCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetGenericDictionaryFieldCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetGenericDictionaryField_Register: TClassWithGenericDictionaryField_Register;
begin
  if FGetGenericDictionaryField_RegisterCommand = nil then
  begin
    FGetGenericDictionaryField_RegisterCommand := FDBXConnection.CreateCommand;
    FGetGenericDictionaryField_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetGenericDictionaryField_RegisterCommand.Text := 'TServerMethods2.GetGenericDictionaryField_Register';
    FGetGenericDictionaryField_RegisterCommand.Prepare;
  end;
  FGetGenericDictionaryField_RegisterCommand.ExecuteUpdate;
  if not FGetGenericDictionaryField_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetGenericDictionaryField_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetUnsupportedFields: TUnsupportedFieldsClass;
begin
  if FGetUnsupportedFieldsCommand = nil then
  begin
    FGetUnsupportedFieldsCommand := FDBXConnection.CreateCommand;
    FGetUnsupportedFieldsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetUnsupportedFieldsCommand.Text := 'TServerMethods2.GetUnsupportedFields';
    FGetUnsupportedFieldsCommand.Prepare;
  end;
  FGetUnsupportedFieldsCommand.ExecuteUpdate;
  if not FGetUnsupportedFieldsCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetUnsupportedFieldsCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.GetUnsupportedFields_Register: TUnsupportedFieldsClass_Register;
begin
  if FGetUnsupportedFields_RegisterCommand = nil then
  begin
    FGetUnsupportedFields_RegisterCommand := FDBXConnection.CreateCommand;
    FGetUnsupportedFields_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetUnsupportedFields_RegisterCommand.Text := 'TServerMethods2.GetUnsupportedFields_Register';
    FGetUnsupportedFields_RegisterCommand.Prepare;
  end;
  FGetUnsupportedFields_RegisterCommand.ExecuteUpdate;
  if not FGetUnsupportedFields_RegisterCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetUnsupportedFields_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.ValidateClassWithTStrings_Attribute(AValue: TClassWithTStringsField_Attribute): Boolean;
begin
  if FValidateClassWithTStrings_AttributeCommand = nil then
  begin
    FValidateClassWithTStrings_AttributeCommand := FDBXConnection.CreateCommand;
    FValidateClassWithTStrings_AttributeCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateClassWithTStrings_AttributeCommand.Text := 'TServerMethods2.ValidateClassWithTStrings_Attribute';
    FValidateClassWithTStrings_AttributeCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateClassWithTStrings_AttributeCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateClassWithTStrings_AttributeCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateClassWithTStrings_AttributeCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateClassWithTStrings_AttributeCommand.ExecuteUpdate;
  Result := FValidateClassWithTStrings_AttributeCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateClassWithTStrings_Register(AValue: TClassWithTStringsField_Register): Boolean;
begin
  if FValidateClassWithTStrings_RegisterCommand = nil then
  begin
    FValidateClassWithTStrings_RegisterCommand := FDBXConnection.CreateCommand;
    FValidateClassWithTStrings_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateClassWithTStrings_RegisterCommand.Text := 'TServerMethods2.ValidateClassWithTStrings_Register';
    FValidateClassWithTStrings_RegisterCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateClassWithTStrings_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateClassWithTStrings_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateClassWithTStrings_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateClassWithTStrings_RegisterCommand.ExecuteUpdate;
  Result := FValidateClassWithTStrings_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateGenericListField(AValue: TClassWithGenericListField): Boolean;
begin
  if FValidateGenericListFieldCommand = nil then
  begin
    FValidateGenericListFieldCommand := FDBXConnection.CreateCommand;
    FValidateGenericListFieldCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateGenericListFieldCommand.Text := 'TServerMethods2.ValidateGenericListField';
    FValidateGenericListFieldCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateGenericListFieldCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateGenericListFieldCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericListFieldCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericListFieldCommand.ExecuteUpdate;
  Result := FValidateGenericListFieldCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateGenericListField_Register(AValue: TClassWithGenericListField_Register): Boolean;
begin
  if FValidateGenericListField_RegisterCommand = nil then
  begin
    FValidateGenericListField_RegisterCommand := FDBXConnection.CreateCommand;
    FValidateGenericListField_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateGenericListField_RegisterCommand.Text := 'TServerMethods2.ValidateGenericListField_Register';
    FValidateGenericListField_RegisterCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateGenericListField_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateGenericListField_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericListField_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericListField_RegisterCommand.ExecuteUpdate;
  Result := FValidateGenericListField_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateGenericDictionaryField(AValue: TClassWithGenericDictionaryField): Boolean;
begin
  if FValidateGenericDictionaryFieldCommand = nil then
  begin
    FValidateGenericDictionaryFieldCommand := FDBXConnection.CreateCommand;
    FValidateGenericDictionaryFieldCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateGenericDictionaryFieldCommand.Text := 'TServerMethods2.ValidateGenericDictionaryField';
    FValidateGenericDictionaryFieldCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateGenericDictionaryFieldCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateGenericDictionaryFieldCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericDictionaryFieldCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericDictionaryFieldCommand.ExecuteUpdate;
  Result := FValidateGenericDictionaryFieldCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateGenericDictionaryField_Register(AValue: TClassWithGenericDictionaryField_Register): Boolean;
begin
  if FValidateGenericDictionaryField_RegisterCommand = nil then
  begin
    FValidateGenericDictionaryField_RegisterCommand := FDBXConnection.CreateCommand;
    FValidateGenericDictionaryField_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateGenericDictionaryField_RegisterCommand.Text := 'TServerMethods2.ValidateGenericDictionaryField_Register';
    FValidateGenericDictionaryField_RegisterCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateGenericDictionaryField_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateGenericDictionaryField_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericDictionaryField_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericDictionaryField_RegisterCommand.ExecuteUpdate;
  Result := FValidateGenericDictionaryField_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidatePerson_Register(AValue: TPersonISODate_Register): Boolean;
begin
  if FValidatePerson_RegisterCommand = nil then
  begin
    FValidatePerson_RegisterCommand := FDBXConnection.CreateCommand;
    FValidatePerson_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidatePerson_RegisterCommand.Text := 'TServerMethods2.ValidatePerson_Register';
    FValidatePerson_RegisterCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidatePerson_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidatePerson_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidatePerson_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidatePerson_RegisterCommand.ExecuteUpdate;
  Result := FValidatePerson_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidatePerson(AValue: TPerson1): Boolean;
begin
  if FValidatePersonCommand = nil then
  begin
    FValidatePersonCommand := FDBXConnection.CreateCommand;
    FValidatePersonCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidatePersonCommand.Text := 'TServerMethods2.ValidatePerson';
    FValidatePersonCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidatePersonCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidatePersonCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidatePersonCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidatePersonCommand.ExecuteUpdate;
  Result := FValidatePersonCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidatePerson_Attribute(AValue: TPersonISODate_Attribute): Boolean;
begin
  if FValidatePerson_AttributeCommand = nil then
  begin
    FValidatePerson_AttributeCommand := FDBXConnection.CreateCommand;
    FValidatePerson_AttributeCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidatePerson_AttributeCommand.Text := 'TServerMethods2.ValidatePerson_Attribute';
    FValidatePerson_AttributeCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidatePerson_AttributeCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidatePerson_AttributeCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidatePerson_AttributeCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidatePerson_AttributeCommand.ExecuteUpdate;
  Result := FValidatePerson_AttributeCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidatePersonCollection(AValue: TPerson1Collection): Boolean;
begin
  if FValidatePersonCollectionCommand = nil then
  begin
    FValidatePersonCollectionCommand := FDBXConnection.CreateCommand;
    FValidatePersonCollectionCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidatePersonCollectionCommand.Text := 'TServerMethods2.ValidatePersonCollection';
    FValidatePersonCollectionCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidatePersonCollectionCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidatePersonCollectionCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidatePersonCollectionCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidatePersonCollectionCommand.ExecuteUpdate;
  Result := FValidatePersonCollectionCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateUnsupportedFields(AValue: TUnsupportedFieldsClass): Boolean;
begin
  if FValidateUnsupportedFieldsCommand = nil then
  begin
    FValidateUnsupportedFieldsCommand := FDBXConnection.CreateCommand;
    FValidateUnsupportedFieldsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateUnsupportedFieldsCommand.Text := 'TServerMethods2.ValidateUnsupportedFields';
    FValidateUnsupportedFieldsCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateUnsupportedFieldsCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateUnsupportedFieldsCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateUnsupportedFieldsCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateUnsupportedFieldsCommand.ExecuteUpdate;
  Result := FValidateUnsupportedFieldsCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ValidateUnsupportedFields_Register(AValue: TUnsupportedFieldsClass_Register): Boolean;
begin
  if FValidateUnsupportedFields_RegisterCommand = nil then
  begin
    FValidateUnsupportedFields_RegisterCommand := FDBXConnection.CreateCommand;
    FValidateUnsupportedFields_RegisterCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateUnsupportedFields_RegisterCommand.Text := 'TServerMethods2.ValidateUnsupportedFields_Register';
    FValidateUnsupportedFields_RegisterCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateUnsupportedFields_RegisterCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateUnsupportedFields_RegisterCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateUnsupportedFields_RegisterCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateUnsupportedFields_RegisterCommand.ExecuteUpdate;
  Result := FValidateUnsupportedFields_RegisterCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.ProcessArray(Value: TJSONValue): Boolean;
begin
  if FProcessArrayCommand = nil then
  begin
    FProcessArrayCommand := FDBXConnection.CreateCommand;
    FProcessArrayCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FProcessArrayCommand.Text := 'TServerMethods2.ProcessArray';
    FProcessArrayCommand.Prepare;
  end;
  FProcessArrayCommand.Parameters[0].Value.SetJSONValue(Value, FInstanceOwner);
  FProcessArrayCommand.ExecuteUpdate;
  Result := FProcessArrayCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.GetGenericDictionary: TMyDictionary;
begin
  if FGetGenericDictionaryCommand = nil then
  begin
    FGetGenericDictionaryCommand := FDBXConnection.CreateCommand;
    FGetGenericDictionaryCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetGenericDictionaryCommand.Text := 'TServerMethods2.GetGenericDictionary';
    FGetGenericDictionaryCommand.Prepare;
  end;
  FGetGenericDictionaryCommand.ExecuteUpdate;
  if not FGetGenericDictionaryCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetGenericDictionaryCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.ValidateGenericDictionary(AValue: TMyDictionary): Boolean;
begin
  if FValidateGenericDictionaryCommand = nil then
  begin
    FValidateGenericDictionaryCommand := FDBXConnection.CreateCommand;
    FValidateGenericDictionaryCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateGenericDictionaryCommand.Text := 'TServerMethods2.ValidateGenericDictionary';
    FValidateGenericDictionaryCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateGenericDictionaryCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateGenericDictionaryCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericDictionaryCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericDictionaryCommand.ExecuteUpdate;
  Result := FValidateGenericDictionaryCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods2Client.GetGenericDictionaryPairs: TMyDictionaryPairs;
begin
  if FGetGenericDictionaryPairsCommand = nil then
  begin
    FGetGenericDictionaryPairsCommand := FDBXConnection.CreateCommand;
    FGetGenericDictionaryPairsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetGenericDictionaryPairsCommand.Text := 'TServerMethods2.GetGenericDictionaryPairs';
    FGetGenericDictionaryPairsCommand.Prepare;
  end;
  FGetGenericDictionaryPairsCommand.ExecuteUpdate;
  if not FGetGenericDictionaryPairsCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetGenericDictionaryPairsCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
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

function TServerMethods2Client.ValidateGenericDictionaryPairs(AValue: TMyDictionaryPairs): Boolean;
begin
  if FValidateGenericDictionaryPairsCommand = nil then
  begin
    FValidateGenericDictionaryPairsCommand := FDBXConnection.CreateCommand;
    FValidateGenericDictionaryPairsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FValidateGenericDictionaryPairsCommand.Text := 'TServerMethods2.ValidateGenericDictionaryPairs';
    FValidateGenericDictionaryPairsCommand.Prepare;
  end;
  if not Assigned(AValue) then
    FValidateGenericDictionaryPairsCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FValidateGenericDictionaryPairsCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FValidateGenericDictionaryPairsCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AValue), True);
      if FInstanceOwner then
        AValue.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FValidateGenericDictionaryPairsCommand.ExecuteUpdate;
  Result := FValidateGenericDictionaryPairsCommand.Parameters[1].Value.GetBoolean;
end;


constructor TServerMethods2Client.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TServerMethods2Client.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TServerMethods2Client.Destroy;
begin
  FreeAndNil(FEchoStringCommand);
  FreeAndNil(FReverseStringCommand);
  FreeAndNil(FGetPersonCommand);
  FreeAndNil(FGetPersonCollectionCommand);
  FreeAndNil(FGetPerson_AttributeCommand);
  FreeAndNil(FGetPerson_RegisterCommand);
  FreeAndNil(FGetClassWithTStrings_AttributeCommand);
  FreeAndNil(FGetClassWithTStrings_RegisterCommand);
  FreeAndNil(FGetGenericListFieldCommand);
  FreeAndNil(FGetGenericListField_RegisterCommand);
  FreeAndNil(FGetGenericDictionaryFieldCommand);
  FreeAndNil(FGetGenericDictionaryField_RegisterCommand);
  FreeAndNil(FGetUnsupportedFieldsCommand);
  FreeAndNil(FGetUnsupportedFields_RegisterCommand);
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
  FreeAndNil(FValidateGenericDictionaryCommand);
  FreeAndNil(FGetGenericDictionaryPairsCommand);
  FreeAndNil(FValidateGenericDictionaryPairsCommand);
  inherited;
end;

end.

