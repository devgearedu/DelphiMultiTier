#ifndef DBXCppClientClassesUnit1H
#define DBXCppClientClassesUnit1H

#include "DBXCommon.hpp"
#include "Classes.hpp"
#include "SysUtils.hpp"
#include "DB.hpp"
#include "SqlExpr.hpp"
#include "DBXDBReaders.hpp"

  class TServerMethods2Client : public TObject
  {
  private:
    TDBXConnection *FDBXConnection;
    bool FInstanceOwner;
    TDBXCommand *FEchoStringCommand;
    TDBXCommand *FReverseStringCommand;
    TDBXCommand *FGetPersonCommand;
    TDBXCommand *FGetPersonCollectionCommand;
    TDBXCommand *FGetPerson_AttributeCommand;
    TDBXCommand *FGetPerson_RegisterCommand;
    TDBXCommand *FGetClassWithTStrings_AttributeCommand;
    TDBXCommand *FGetClassWithTStrings_RegisterCommand;
    TDBXCommand *FGetGenericListFieldCommand;
    TDBXCommand *FGetGenericListField_RegisterCommand;
    TDBXCommand *FGetGenericDictionaryFieldCommand;
    TDBXCommand *FGetGenericDictionaryField_RegisterCommand;
    TDBXCommand *FGetUnsupportedFieldsCommand;
    TDBXCommand *FGetUnsupportedFields_RegisterCommand;
    TDBXCommand *FValidateClassWithTStrings_AttributeCommand;
    TDBXCommand *FValidateClassWithTStrings_RegisterCommand;
    TDBXCommand *FValidateGenericListFieldCommand;
    TDBXCommand *FValidateGenericListField_RegisterCommand;
    TDBXCommand *FValidateGenericDictionaryFieldCommand;
    TDBXCommand *FValidateGenericDictionaryField_RegisterCommand;
    TDBXCommand *FValidatePerson_RegisterCommand;
    TDBXCommand *FValidatePersonCommand;
    TDBXCommand *FValidatePerson_AttributeCommand;
    TDBXCommand *FValidatePersonCollectionCommand;
    TDBXCommand *FValidateUnsupportedFieldsCommand;
    TDBXCommand *FValidateUnsupportedFields_RegisterCommand;
    TDBXCommand *FProcessArrayCommand;
    TDBXCommand *FGetGenericDictionaryCommand;
    TDBXCommand *FValidateGenericDictionaryCommand;
    TDBXCommand *FGetGenericDictionaryPairsCommand;
    TDBXCommand *FValidateGenericDictionaryPairsCommand;
  public:
    __fastcall TServerMethods2Client::TServerMethods2Client(TDBXConnection *ADBXConnection);
    __fastcall TServerMethods2Client::TServerMethods2Client(TDBXConnection *ADBXConnection, bool AInstanceOwner);
    __fastcall TServerMethods2Client::~TServerMethods2Client();
    System::UnicodeString __fastcall EchoString(System::UnicodeString Value);
    System::UnicodeString __fastcall ReverseString(System::UnicodeString Value);
    TJSONObject* __fastcall GetPerson();
    TJSONObject* __fastcall GetPersonCollection();
    TJSONObject* __fastcall GetPerson_Attribute();
    TJSONObject* __fastcall GetPerson_Register();
    TJSONObject* __fastcall GetClassWithTStrings_Attribute();
    TJSONObject* __fastcall GetClassWithTStrings_Register();
    TJSONObject* __fastcall GetGenericListField();
    TJSONObject* __fastcall GetGenericListField_Register();
    TJSONObject* __fastcall GetGenericDictionaryField();
    TJSONObject* __fastcall GetGenericDictionaryField_Register();
    TJSONObject* __fastcall GetUnsupportedFields();
    TJSONObject* __fastcall GetUnsupportedFields_Register();
    bool __fastcall ValidateClassWithTStrings_Attribute(TJSONObject* AValue);
    bool __fastcall ValidateClassWithTStrings_Register(TJSONObject* AValue);
    bool __fastcall ValidateGenericListField(TJSONObject* AValue);
    bool __fastcall ValidateGenericListField_Register(TJSONObject* AValue);
    bool __fastcall ValidateGenericDictionaryField(TJSONObject* AValue);
    bool __fastcall ValidateGenericDictionaryField_Register(TJSONObject* AValue);
    bool __fastcall ValidatePerson_Register(TJSONObject* AValue);
    bool __fastcall ValidatePerson(TJSONObject* AValue);
    bool __fastcall ValidatePerson_Attribute(TJSONObject* AValue);
    bool __fastcall ValidatePersonCollection(TJSONObject* AValue);
    bool __fastcall ValidateUnsupportedFields(TJSONObject* AValue);
    bool __fastcall ValidateUnsupportedFields_Register(TJSONObject* AValue);
    bool __fastcall ProcessArray(TJSONValue* Value);
    TJSONObject* __fastcall GetGenericDictionary();
    bool __fastcall ValidateGenericDictionary(TJSONObject* AValue);
    TJSONObject* __fastcall GetGenericDictionaryPairs();
    bool __fastcall ValidateGenericDictionaryPairs(TJSONObject* AValue);
  };

#endif

