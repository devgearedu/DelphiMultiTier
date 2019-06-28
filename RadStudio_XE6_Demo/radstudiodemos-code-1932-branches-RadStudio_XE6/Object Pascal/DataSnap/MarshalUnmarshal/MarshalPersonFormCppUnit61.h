//---------------------------------------------------------------------------

#ifndef MarshalPersonFormCppUnit61H
#define MarshalPersonFormCppUnit61H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <DBXJson.hpp>
//---------------------------------------------------------------------------
class TForm61 : public TForm
{
__published:	// IDE-managed Components
	TGroupBox *GroupBox1;
	TLabel *Label1;
	TLabel *Label2;
	TEdit *EditFirstName;
	TEdit *EditLastName;
	TButton *ButtonClear;
	TGroupBox *GroupBox2;
	TListBox *ListBox1;
	TButton *ButtonGet;
	void __fastcall ButtonClearClick(TObject *Sender);
	void __fastcall ButtonGetClick(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
        void displayPerson(TJSONObject * APerson);
        void displayPersonCollection(TJSONObject * TJSONObject);
public:		// User declarations
	__fastcall TForm61(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm61 *Form61;
//---------------------------------------------------------------------------
#endif
