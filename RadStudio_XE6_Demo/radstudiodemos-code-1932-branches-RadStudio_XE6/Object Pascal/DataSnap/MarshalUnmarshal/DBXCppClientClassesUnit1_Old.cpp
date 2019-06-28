
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
// 10/1/2010 10:22:12 PM
//

#include "DBXCppClientClassesUnit1_Old.h"

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

TJSONObject* __fastcall TServerMethods2Client::GetPersons()
{
  if (FGetPersonsCommand == NULL)
  {
    FGetPersonsCommand = FDBXConnection->CreateCommand();
    FGetPersonsCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetPersonsCommand->Text = "TServerMethods2.GetPersons";
    FGetPersonsCommand->Prepare();
  }
  FGetPersonsCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetPersonsCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
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

bool __fastcall TServerMethods2Client::ValidatePersons(TJSONObject* AValue)
{
  if (FValidatePersonsCommand == NULL)
  {
    FValidatePersonsCommand = FDBXConnection->CreateCommand();
    FValidatePersonsCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FValidatePersonsCommand->Text = "TServerMethods2.ValidatePersons";
    FValidatePersonsCommand->Prepare();
  }
  FValidatePersonsCommand->Parameters->Parameter[0]->Value->SetJSONValue(AValue, FInstanceOwner);
  FValidatePersonsCommand->ExecuteUpdate();
  bool result = FValidatePersonsCommand->Parameters->Parameter[1]->Value->GetBoolean();
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetPersonJSON()
{
  if (FGetPersonJSONCommand == NULL)
  {
    FGetPersonJSONCommand = FDBXConnection->CreateCommand();
    FGetPersonJSONCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetPersonJSONCommand->Text = "TServerMethods2.GetPersonJSON";
    FGetPersonJSONCommand->Prepare();
  }
  FGetPersonJSONCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetPersonJSONCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
  return result;
}

TJSONObject* __fastcall TServerMethods2Client::GetPersonsJSON()
{
  if (FGetPersonsJSONCommand == NULL)
  {
    FGetPersonsJSONCommand = FDBXConnection->CreateCommand();
    FGetPersonsJSONCommand->CommandType = TDBXCommandTypes_DSServerMethod;
    FGetPersonsJSONCommand->Text = "TServerMethods2.GetPersonsJSON";
    FGetPersonsJSONCommand->Prepare();
  }
  FGetPersonsJSONCommand->ExecuteUpdate();
  TJSONObject* result = (TJSONObject*)FGetPersonsJSONCommand->Parameters->Parameter[0]->Value->GetJSONValue(FInstanceOwner);
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
  delete FGetPersonsCommand;
  delete FValidatePersonCommand;
  delete FValidatePersonsCommand;
  delete FGetPersonJSONCommand;
  delete FGetPersonsJSONCommand;
}


