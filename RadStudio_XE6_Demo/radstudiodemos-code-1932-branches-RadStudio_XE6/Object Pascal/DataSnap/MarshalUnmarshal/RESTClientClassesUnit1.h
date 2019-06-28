#ifndef RESTClientClassesUnit1H
#define RESTClientClassesUnit1H

#include "DBXCommon.hpp"
#include "Classes.hpp"
#include "SysUtils.hpp"
#include "DB.hpp"
#include "SqlExpr.hpp"
#include "DBXDBReaders.hpp"
#include "DSProxyRest.hpp"

  class TServerMethods2Client : public TDSAdminRestClient
  {
  private:
    TDSRestCommand *FEchoStringCommand;
    TDSRestCommand *FReverseStringCommand;
    TDSRestCommand *FGetPersonCommand;
    TDSRestCommand *FGetPersonCommand_Cache;
    TDSRestCommand *FGetPersonCollectionCommand;
    TDSRestCommand *FGetPersonCollectionCommand_Cache;
    TDSRestCommand *FGetPerson_AttributeCommand;
    TDSRestCommand *FGetPerson_AttributeCommand_Cache;
    TDSRestCommand *FGetPerson_RegisterCommand;
    TDSRestCommand *FGetPerson_RegisterCommand_Cache;
    TDSRestCommand *FGetClassWithTStrings_AttributeCommand;
    TDSRestCommand *FGetClassWithTStrings_AttributeCommand_Cache;
    TDSRestCommand *FGetClassWithTStrings_RegisterCommand;
    TDSRestCommand *FGetClassWithTStrings_RegisterCommand_Cache;
    TDSRestCommand *FGetGenericListFieldCommand;
    TDSRestCommand *FGetGenericListFieldCommand_Cache;
    TDSRestCommand *FGetGenericListField_RegisterCommand;
    TDSRestCommand *FGetGenericListField_RegisterCommand_Cache;
    TDSRestCommand *FGetGenericDictionaryFieldCommand;
    TDSRestCommand *FGetGenericDictionaryFieldCommand_Cache;
    TDSRestCommand *FGetGenericDictionaryField_RegisterCommand;
    TDSRestCommand *FGetGenericDictionaryField_RegisterCommand_Cache;
    TDSRestCommand *FGetUnsupportedFieldsCommand;
    TDSRestCommand *FGetUnsupportedFieldsCommand_Cache;
    TDSRestCommand *FGetUnsupportedFields_RegisterCommand;
    TDSRestCommand *FGetUnsupportedFields_RegisterCommand_Cache;
    TDSRestCommand *FValidateClassWithTStrings_AttributeCommand;
    TDSRestCommand *FValidateClassWithTStrings_RegisterCommand;
    TDSRestCommand *FValidateGenericListFieldCommand;
    TDSRestCommand *FValidateGenericListField_RegisterCommand;
    TDSRestCommand *FValidateGenericDictionaryFieldCommand;
    TDSRestCommand *FValidateGenericDictionaryField_RegisterCommand;
    TDSRestCommand *FValidatePerson_RegisterCommand;
    TDSRestCommand *FValidatePersonCommand;
    TDSRestCommand *FValidatePerson_AttributeCommand;
    TDSRestCommand *FValidatePersonCollectionCommand;
    TDSRestCommand *FValidateUnsupportedFieldsCommand;
    TDSRestCommand *FValidateUnsupportedFields_RegisterCommand;
    TDSRestCommand *FProcessArrayCommand;
    TDSRestCommand *FGetGenericDictionaryCommand;
    TDSRestCommand *FGetGenericDictionaryCommand_Cache;
    TDSRestCommand *FValidateGenericDictionaryCommand;
    TDSRestCommand *FGetGenericDictionaryPairsCommand;
    TDSRestCommand *FGetGenericDictionaryPairsCommand_Cache;
    TDSRestCommand *FValidateGenericDictionaryPairsCommand;
  public:
    __fastcall TServerMethods2Client::TServerMethods2Client(TDSRestConnection *ARestConnection);
    __fastcall TServerMethods2Client::TServerMethods2Client(TDSRestConnection *ADBXConnection, bool AInstanceOwner);
    __fastcall TServerMethods2Client::~TServerMethods2Client();
    System::UnicodeString __fastcall EchoString(System::UnicodeString Value, const String& ARequestFilter = String());
    System::UnicodeString __fastcall ReverseString(System::UnicodeString Value, const String& ARequestFilter = String());
    TJSONObject* __fastcall GetPerson(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetPerson_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetPersonCollection(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetPersonCollection_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetPerson_Attribute(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetPerson_Attribute_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetPerson_Register(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetPerson_Register_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetClassWithTStrings_Attribute(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetClassWithTStrings_Attribute_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetClassWithTStrings_Register(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetClassWithTStrings_Register_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetGenericListField(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetGenericListField_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetGenericListField_Register(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetGenericListField_Register_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetGenericDictionaryField(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetGenericDictionaryField_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetGenericDictionaryField_Register(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetGenericDictionaryField_Register_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetUnsupportedFields(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetUnsupportedFields_Cache(const String& ARequestFilter = String());
    TJSONObject* __fastcall GetUnsupportedFields_Register(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetUnsupportedFields_Register_Cache(const String& ARequestFilter = String());
    bool __fastcall ValidateClassWithTStrings_Attribute(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidateClassWithTStrings_Register(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidateGenericListField(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidateGenericListField_Register(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidateGenericDictionaryField(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidateGenericDictionaryField_Register(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidatePerson_Register(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidatePerson(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidatePerson_Attribute(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidatePersonCollection(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidateUnsupportedFields(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ValidateUnsupportedFields_Register(TJSONObject* AValue, const String& ARequestFilter = String());
    bool __fastcall ProcessArray(TJSONValue* Value, const String& ARequestFilter = String());
    TJSONObject* __fastcall GetGenericDictionary(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetGenericDictionary_Cache(const String& ARequestFilter = String());
    bool __fastcall ValidateGenericDictionary(TJSONObject* AValue, const String& ARequestFilter = String());
    TJSONObject* __fastcall GetGenericDictionaryPairs(const String& ARequestFilter = String());
    _di_IDSRestCachedJSONObject __fastcall GetGenericDictionaryPairs_Cache(const String& ARequestFilter = String());
    bool __fastcall ValidateGenericDictionaryPairs(TJSONObject* AValue, const String& ARequestFilter = String());
  };

#endif
