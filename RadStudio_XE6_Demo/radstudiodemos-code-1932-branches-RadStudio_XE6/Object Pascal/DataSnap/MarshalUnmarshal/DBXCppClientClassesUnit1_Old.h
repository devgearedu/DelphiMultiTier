#ifndef DBXCppClientClassesUnit1_OldH
#define DBXCppClientClassesUnit1_OldH

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
    TDBXCommand *FGetPersonsCommand;
    TDBXCommand *FValidatePersonCommand;
    TDBXCommand *FValidatePersonsCommand;
    TDBXCommand *FGetPersonJSONCommand;
    TDBXCommand *FGetPersonsJSONCommand;
  public:
    __fastcall TServerMethods2Client::TServerMethods2Client(TDBXConnection *ADBXConnection);
    __fastcall TServerMethods2Client::TServerMethods2Client(TDBXConnection *ADBXConnection, bool AInstanceOwner);
    __fastcall TServerMethods2Client::~TServerMethods2Client();
    System::UnicodeString __fastcall EchoString(System::UnicodeString Value);
    System::UnicodeString __fastcall ReverseString(System::UnicodeString Value);
    TJSONObject* __fastcall GetPerson();
    TJSONObject* __fastcall GetPersons();
    bool __fastcall ValidatePerson(TJSONObject* AValue);
    bool __fastcall ValidatePersons(TJSONObject* AValue);
    TJSONObject* __fastcall GetPersonJSON();
    TJSONObject* __fastcall GetPersonsJSON();
  };

#endif

