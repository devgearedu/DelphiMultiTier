
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MarshalPersonFormCppUnit61.h"
#ifdef REST
#include "RESTClientModuleUnit1.h";
#else
#include "DBXCppClientModuleUnit1.h";
#endif
#include <DBXJSon.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm61 *Form61;
//---------------------------------------------------------------------------
__fastcall TForm61::TForm61(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm61::ButtonClearClick(TObject *Sender)
{
  EditFirstName->Text = "";
  EditLastName->Text = "";
  ListBox1->Clear();
}

//---------------------------------------------------------------------------
void __fastcall TForm61::ButtonGetClick(TObject *Sender)
{
  TJSONObject * person;
  TJSONObject * personCollection;

  // call server method
#ifdef REST
  person = RESTClientModule1->ServerMethods2Client->GetPerson();
#else
  person = DBXClientModule1->ServerMethods2Client->GetPerson();
#endif
  // display object
  displayPerson(person);

  // call server method
#ifdef REST
  personCollection = RESTClientModule1->ServerMethods2Client->GetPersonCollection();
#else
  personCollection = DBXClientModule1->ServerMethods2Client->GetPersonCollection();
#endif
  // display obj3ect
  displayPersonCollection(personCollection);

}
//---------------------------------------------------------------------------
void TForm61::displayPerson(TJSONObject * person)
{
  TJSONObject * fields;
  fields = reinterpret_cast<TJSONObject*>(person->Get("fields")->JsonValue);
  EditFirstName->Text = fields->Get("FFirstName")->JsonValue->Value();
  EditLastName->Text = fields->Get("FLastName")->JsonValue->Value();
}

void TForm61::displayPersonCollection(TJSONObject *personCollection)
{
  ListBox1->Clear();
  TJSONObject * fields;
  fields = reinterpret_cast<TJSONObject*>(personCollection->Get("fields")->JsonValue);
  TJSONArray * persons;
  persons = reinterpret_cast<TJSONArray*>(fields->Get("FPersons")->JsonValue);
  for (int i = 0; i < persons->Size(); i++)
  {
    TJSONObject * person = reinterpret_cast<TJSONObject*>(persons->Get(i));
    fields = (TJSONObject*)(person->Get("fields")->JsonValue);
    ListBox1->Items->Add(
      "FirstName: " +
      fields->Get("FFirstName")->JsonValue->Value() + ", "
      "LastName: " +
      fields->Get("FLastName")->JsonValue->Value());
  }
}

void __fastcall TForm61::FormCreate(TObject *Sender)
{
#ifdef REST
  ButtonGet->Caption = "Get (REST)";
#else
  ButtonGet->Caption = "Get (DBX)";
#endif
}
//---------------------------------------------------------------------------

