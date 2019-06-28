
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
// 10/19/2010 9:20:36 AM
//

#include "DBXCppClientClassesUnit1.h"

System::UnicodeString __fastcall TServerMethods2Client::EchoString(System::UnicodeString Value)
{
  if (FEchoStringCommand == NULL)
  {
    FEchoStringCommand = FDBXConnection->CreateCommand();
    FEchoStringCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FEchoStringCommand->Text = "TServerMethods2.EchoString";
    FEchoStringCommand->Prepare();
  }
  FEchoStringCommand->Parameters->Parameter[0]->Value->SetWideString(Value);
  FEchoStringCommand->ExecuteUpdate();
  System::UnicodeString result = FEchoStringCommand->Parameters->Parameter[1]->Value->GetWideString();
  return result;
}

System::UnicodeString __fastcall TServerMethods2Client::ReverseString(System::UnicodeString Value)
{
  if (FReverseStringCommand == NULL)
  {
    FReverseStringCommand = FDBXConnection->CreateCommand();
    FReverseStringCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FReverseStringCommand->Text = "TServerMethods2.ReverseString";
    FReverseStringCommand->Prepare();
  }
  FReverseStringCommand->Parameters->Parameter[0]->Value->SetWideString(Value);
  FReverseStringCommand->ExecuteUpdate();
  System::UnicodeString result = FReverseStringCommand->Parameters->Parameter[1]->Value->GetWideString();
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetPerson()
{
  if (FGetPersonCommand == NULL)
  {
    FGetPersonCommand = FDBXConnection->CreateCommand();
    FGetPersonCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetPersonCommand->Text = "TServerMethods2.GetPerson";
    FGetPersonCommand->Prepare();
  }
  FGetPersonCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetPersonCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetPersonCollection()
{
  if (FGetPersonCollectionCommand == NULL)
  {
    FGetPersonCollectionCommand = FDBXConnection->CreateCommand();
    FGetPersonCollectionCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetPersonCollectionCommand->Text = "TServerMethods2.GetPersonCollection";
    FGetPersonCollectionCommand->Prepare();
  }
  FGetPersonCollectionCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetPersonCollectionCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetPerson_Attribute()
{
  if (FGetPerson_AttributeCommand == NULL)
  {
    FGetPerson_AttributeCommand = FDBXConnection->CreateCommand();
    FGetPerson_AttributeCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetPerson_AttributeCommand->Text = "TServerMethods2.GetPerson_Attribute";
    FGetPerson_AttributeCommand->Prepare();
  }
  FGetPerson_AttributeCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetPerson_AttributeCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetPerson_Register()
{
  if (FGetPerson_RegisterCommand == NULL)
  {
    FGetPerson_RegisterCommand = FDBXConnection->CreateCommand();
    FGetPerson_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetPerson_RegisterCommand->Text = "TServerMethods2.GetPerson_Register";
    FGetPerson_RegisterCommand->Prepare();
  }
  FGetPerson_RegisterCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetPerson_RegisterCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetClassWithTStrings_Attribute()
{
  if (FGetClassWithTStrings_AttributeCommand == NULL)
  {
    FGetClassWithTStrings_AttributeCommand = FDBXConnection->CreateCommand();
    FGetClassWithTStrings_AttributeCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetClassWithTStrings_AttributeCommand->Text = "TServerMethods2.GetClassWithTStrings_Attribute";
    FGetClassWithTStrings_AttributeCommand->Prepare();
  }
  FGetClassWithTStrings_AttributeCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetClassWithTStrings_AttributeCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetClassWithTStrings_Register()
{
  if (FGetClassWithTStrings_RegisterCommand == NULL)
  {
    FGetClassWithTStrings_RegisterCommand = FDBXConnection->CreateCommand();
    FGetClassWithTStrings_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetClassWithTStrings_RegisterCommand->Text = "TServerMethods2.GetClassWithTStrings_Register";
    FGetClassWithTStrings_RegisterCommand->Prepare();
  }
  FGetClassWithTStrings_RegisterCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetClassWithTStrings_RegisterCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetGenericListField()
{
  if (FGetGenericListFieldCommand == NULL)
  {
    FGetGenericListFieldCommand = FDBXConnection->CreateCommand();
    FGetGenericListFieldCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetGenericListFieldCommand->Text = "TServerMethods2.GetGenericListField";
    FGetGenericListFieldCommand->Prepare();
  }
  FGetGenericListFieldCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetGenericListFieldCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetGenericListField_Register()
{
  if (FGetGenericListField_RegisterCommand == NULL)
  {
    FGetGenericListField_RegisterCommand = FDBXConnection->CreateCommand();
    FGetGenericListField_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetGenericListField_RegisterCommand->Text = "TServerMethods2.GetGenericListField_Register";
    FGetGenericListField_RegisterCommand->Prepare();
  }
  FGetGenericListField_RegisterCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetGenericListField_RegisterCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetGenericDictionaryField()
{
  if (FGetGenericDictionaryFieldCommand == NULL)
  {
    FGetGenericDictionaryFieldCommand = FDBXConnection->CreateCommand();
    FGetGenericDictionaryFieldCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetGenericDictionaryFieldCommand->Text = "TServerMethods2.GetGenericDictionaryField";
    FGetGenericDictionaryFieldCommand->Prepare();
  }
  FGetGenericDictionaryFieldCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetGenericDictionaryFieldCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetGenericDictionaryField_Register()
{
  if (FGetGenericDictionaryField_RegisterCommand == NULL)
  {
    FGetGenericDictionaryField_RegisterCommand = FDBXConnection->CreateCommand();
    FGetGenericDictionaryField_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetGenericDictionaryField_RegisterCommand->Text = "TServerMethods2.GetGenericDictionaryField_Register";
    FGetGenericDictionaryField_RegisterCommand->Prepare();
  }
  FGetGenericDictionaryField_RegisterCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetGenericDictionaryField_RegisterCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetUnsupportedFields()
{
  if (FGetUnsupportedFieldsCommand == NULL)
  {
    FGetUnsupportedFieldsCommand = FDBXConnection->CreateCommand();
    FGetUnsupportedFieldsCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetUnsupportedFieldsCommand->Text = "TServerMethods2.GetUnsupportedFields";
    FGetUnsupportedFieldsCommand->Prepare();
  }
  FGetUnsupportedFieldsCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetUnsupportedFieldsCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetUnsupportedFields_Register()
{
  if (FGetUnsupportedFields_RegisterCommand == NULL)
  {
    FGetUnsupportedFields_RegisterCommand = FDBXConnection->CreateCommand();
    FGetUnsupportedFields_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetUnsupportedFields_RegisterCommand->Text = "TServerMethods2.GetUnsupportedFields_Register";
    FGetUnsupportedFields_RegisterCommand->Prepare();
  }
  FGetUnsupportedFields_RegisterCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetUnsupportedFields_RegisterCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

bool __fastcall TServerMethods2Client::ValidateClassWithTStrings_Attribute(TJSONObject* AValue)
{
  if (FValidateClassWithTStrings_AttributeCommand == NULL)
  {
    FValidateClassWithTStrings_AttributeCommand = FDBXConnection->CreateCommand();
    FValidateClassWithTStrings_AttributeCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateClassWithTStrings_AttributeCommand->Text = "TServerMethods2.ValidateClassWithTStrings_Attribute";
    FValidateClassWithTStrings_AttributeCommand->Prepare();
  }
  FValidateClassWithTStrings_AttributeCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateClassWithTStrings_AttributeCommand->ExecuteUpdate();
  bool result = FValidateClassWithTStrings_AttributeCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidateClassWithTStrings_Register(TJSONObject* AValue)
{
  if (FValidateClassWithTStrings_RegisterCommand == NULL)
  {
    FValidateClassWithTStrings_RegisterCommand = FDBXConnection->CreateCommand();
    FValidateClassWithTStrings_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateClassWithTStrings_RegisterCommand->Text = "TServerMethods2.ValidateClassWithTStrings_Register";
    FValidateClassWithTStrings_RegisterCommand->Prepare();
  }
  FValidateClassWithTStrings_RegisterCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateClassWithTStrings_RegisterCommand->ExecuteUpdate();
  bool result = FValidateClassWithTStrings_RegisterCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidateGenericListField(TJSONObject* AValue)
{
  if (FValidateGenericListFieldCommand == NULL)
  {
    FValidateGenericListFieldCommand = FDBXConnection->CreateCommand();
    FValidateGenericListFieldCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateGenericListFieldCommand->Text = "TServerMethods2.ValidateGenericListField";
    FValidateGenericListFieldCommand->Prepare();
  }
  FValidateGenericListFieldCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateGenericListFieldCommand->ExecuteUpdate();
  bool result = FValidateGenericListFieldCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidateGenericListField_Register(TJSONObject* AValue)
{
  if (FValidateGenericListField_RegisterCommand == NULL)
  {
    FValidateGenericListField_RegisterCommand = FDBXConnection->CreateCommand();
    FValidateGenericListField_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateGenericListField_RegisterCommand->Text = "TServerMethods2.ValidateGenericListField_Register";
    FValidateGenericListField_RegisterCommand->Prepare();
  }
  FValidateGenericListField_RegisterCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateGenericListField_RegisterCommand->ExecuteUpdate();
  bool result = FValidateGenericListField_RegisterCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidateGenericDictionaryField(TJSONObject* AValue)
{
  if (FValidateGenericDictionaryFieldCommand == NULL)
  {
    FValidateGenericDictionaryFieldCommand = FDBXConnection->CreateCommand();
    FValidateGenericDictionaryFieldCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateGenericDictionaryFieldCommand->Text = "TServerMethods2.ValidateGenericDictionaryField";
    FValidateGenericDictionaryFieldCommand->Prepare();
  }
  FValidateGenericDictionaryFieldCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateGenericDictionaryFieldCommand->ExecuteUpdate();
  bool result = FValidateGenericDictionaryFieldCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidateGenericDictionaryField_Register(TJSONObject* AValue)
{
  if (FValidateGenericDictionaryField_RegisterCommand == NULL)
  {
    FValidateGenericDictionaryField_RegisterCommand = FDBXConnection->CreateCommand();
    FValidateGenericDictionaryField_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateGenericDictionaryField_RegisterCommand->Text = "TServerMethods2.ValidateGenericDictionaryField_Register";
    FValidateGenericDictionaryField_RegisterCommand->Prepare();
  }
  FValidateGenericDictionaryField_RegisterCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateGenericDictionaryField_RegisterCommand->ExecuteUpdate();
  bool result = FValidateGenericDictionaryField_RegisterCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidatePerson_Register(TJSONObject* AValue)
{
  if (FValidatePerson_RegisterCommand == NULL)
  {
    FValidatePerson_RegisterCommand = FDBXConnection->CreateCommand();
    FValidatePerson_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidatePerson_RegisterCommand->Text = "TServerMethods2.ValidatePerson_Register";
    FValidatePerson_RegisterCommand->Prepare();
  }
  FValidatePerson_RegisterCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidatePerson_RegisterCommand->ExecuteUpdate();
  bool result = FValidatePerson_RegisterCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidatePerson(TJSONObject* AValue)
{
  if (FValidatePersonCommand == NULL)
  {
    FValidatePersonCommand = FDBXConnection->CreateCommand();
    FValidatePersonCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidatePersonCommand->Text = "TServerMethods2.ValidatePerson";
    FValidatePersonCommand->Prepare();
  }
  FValidatePersonCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidatePersonCommand->ExecuteUpdate();
  bool result = FValidatePersonCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidatePerson_Attribute(TJSONObject* AValue)
{
  if (FValidatePerson_AttributeCommand == NULL)
  {
    FValidatePerson_AttributeCommand = FDBXConnection->CreateCommand();
    FValidatePerson_AttributeCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidatePerson_AttributeCommand->Text = "TServerMethods2.ValidatePerson_Attribute";
    FValidatePerson_AttributeCommand->Prepare();
  }
  FValidatePerson_AttributeCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidatePerson_AttributeCommand->ExecuteUpdate();
  bool result = FValidatePerson_AttributeCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidatePersonCollection(TJSONObject* AValue)
{
  if (FValidatePersonCollectionCommand == NULL)
  {
    FValidatePersonCollectionCommand = FDBXConnection->CreateCommand();
    FValidatePersonCollectionCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidatePersonCollectionCommand->Text = "TServerMethods2.ValidatePersonCollection";
    FValidatePersonCollectionCommand->Prepare();
  }
  FValidatePersonCollectionCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidatePersonCollectionCommand->ExecuteUpdate();
  bool result = FValidatePersonCollectionCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidateUnsupportedFields(TJSONObject* AValue)
{
  if (FValidateUnsupportedFieldsCommand == NULL)
  {
    FValidateUnsupportedFieldsCommand = FDBXConnection->CreateCommand();
    FValidateUnsupportedFieldsCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateUnsupportedFieldsCommand->Text = "TServerMethods2.ValidateUnsupportedFields";
    FValidateUnsupportedFieldsCommand->Prepare();
  }
  FValidateUnsupportedFieldsCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateUnsupportedFieldsCommand->ExecuteUpdate();
  bool result = FValidateUnsupportedFieldsCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ValidateUnsupportedFields_Register(TJSONObject* AValue)
{
  if (FValidateUnsupportedFields_RegisterCommand == NULL)
  {
    FValidateUnsupportedFields_RegisterCommand = FDBXConnection->CreateCommand();
    FValidateUnsupportedFields_RegisterCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateUnsupportedFields_RegisterCommand->Text = "TServerMethods2.ValidateUnsupportedFields_Register";
    FValidateUnsupportedFields_RegisterCommand->Prepare();
  }
  FValidateUnsupportedFields_RegisterCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateUnsupportedFields_RegisterCommand->ExecuteUpdate();
  bool result = FValidateUnsupportedFields_RegisterCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

bool __fastcall TServerMethods2Client::ProcessArray(TJSONValue* Value)
{
  if (FProcessArrayCommand == NULL)
  {
    FProcessArrayCommand = FDBXConnection->CreateCommand();
    FProcessArrayCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FProcessArrayCommand->Text = "TServerMethods2.ProcessArray";
    FProcessArrayCommand->Prepare();
  }
  FProcessArrayCommand->Parameters->Parameter[0]->Value->SetJSONValue(Value, FInstanceOwner);
  FProcessArrayCommand->ExecuteUpdate();
  bool result = FProcessArrayCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetGenericDictionary()
{
  if (FGetGenericDictionaryCommand == NULL)
  {
    FGetGenericDictionaryCommand = FDBXConnection->CreateCommand();
    FGetGenericDictionaryCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetGenericDictionaryCommand->Text = "TServerMethods2.GetGenericDictionary";
    FGetGenericDictionaryCommand->Prepare();
  }
  FGetGenericDictionaryCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetGenericDictionaryCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

bool __fastcall TServerMethods2Client::ValidateGenericDictionary(TJSONObject* AValue)
{
  if (FValidateGenericDictionaryCommand == NULL)
  {
    FValidateGenericDictionaryCommand = FDBXConnection->CreateCommand();
    FValidateGenericDictionaryCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateGenericDictionaryCommand->Text = "TServerMethods2.ValidateGenericDictionary";
    FValidateGenericDictionaryCommand->Prepare();
  }
  FValidateGenericDictionaryCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateGenericDictionaryCommand->ExecuteUpdate();
  bool result = FValidateGenericDictionaryCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetGenericDictionaryPairs()
{
  if (FGetGenericDictionaryPairsCommand == NULL)
  {
    FGetGenericDictionaryPairsCommand = FDBXConnection->CreateCommand();
    FGetGenericDictionaryPairsCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetGenericDictionaryPairsCommand->Text = "TServerMethods2.GetGenericDictionaryPairs";
    FGetGenericDictionaryPairsCommand->Prepare();
  }
  FGetGenericDictionaryPairsCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetGenericDictionaryPairsCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

bool __fastcall TServerMethods2Client::ValidateGenericDictionaryPairs(TJSONObject* AValue)
{
  if (FValidateGenericDictionaryPairsCommand == NULL)
  {
    FValidateGenericDictionaryPairsCommand = FDBXConnection->CreateCommand();
    FValidateGenericDictionaryPairsCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidateGenericDictionaryPairsCommand->Text = "TServerMethods2.ValidateGenericDictionaryPairs";
    FValidateGenericDictionaryPairsCommand->Prepare();
  }
  FValidateGenericDictionaryPairsCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidateGenericDictionaryPairsCommand->ExecuteUpdate();
  bool result = FValidateGenericDictionaryPairsCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}


__fastcall  TServerMethods2Client::TServerMethods2Client(TDBXConnection *ADBXConnection)
{
  if (ADBXConnection == NULL)
    throw EInvalidOperation("Connection cannot be nil.  Make sure the connection has been opened.");
  FDBXConnection = ADBXConnection;
  FInstanceOwner = True;
}


__fastcall  TServerMethods2Client::TServerMethods2Client(TDBXConnection *ADBXConnection, bool AInstanceOwner)
{
  if (ADBXConnection == NULL)
    throw EInvalidOperation("Connection cannot be nil.  Make sure the connection has been opened.");
  FDBXConnection = ADBXConnection;
  FInstanceOwner = AInstanceOwner;
}


__fastcall  TServerMethods2Client::~TServerMethods2Client()
{
  delete FEchoStringCommand;
  delete FReverseStringCommand;
  delete FGetPersonCommand;
  delete FGetPersonCollectionCommand;
  delete FGetPerson_AttributeCommand;
  delete FGetPerson_RegisterCommand;
  delete FGetClassWithTStrings_AttributeCommand;
  delete FGetClassWithTStrings_RegisterCommand;
  delete FGetGenericListFieldCommand;
  delete FGetGenericListField_RegisterCommand;
  delete FGetGenericDictionaryFieldCommand;
  delete FGetGenericDictionaryField_RegisterCommand;
  delete FGetUnsupportedFieldsCommand;
  delete FGetUnsupportedFields_RegisterCommand;
  delete FValidateClassWithTStrings_AttributeCommand;
  delete FValidateClassWithTStrings_RegisterCommand;
  delete FValidateGenericListFieldCommand;
  delete FValidateGenericListField_RegisterCommand;
  delete FValidateGenericDictionaryFieldCommand;
  delete FValidateGenericDictionaryField_RegisterCommand;
  delete FValidatePerson_RegisterCommand;
  delete FValidatePersonCommand;
  delete FValidatePerson_AttributeCommand;
  delete FValidatePersonCollectionCommand;
  delete FValidateUnsupportedFieldsCommand;
  delete FValidateUnsupportedFields_RegisterCommand;
  delete FProcessArrayCommand;
  delete FGetGenericDictionaryCommand;
  delete FValidateGenericDictionaryCommand;
  delete FGetGenericDictionaryPairsCommand;
  delete FValidateGenericDictionaryPairsCommand;
}


