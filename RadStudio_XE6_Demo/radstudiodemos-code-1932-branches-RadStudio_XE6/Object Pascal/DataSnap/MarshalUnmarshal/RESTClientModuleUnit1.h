//----------------------------------------------------------------------------

#ifndef RESTClientModuleUnit1H
#define RESTClientModuleUnit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include "RESTClientClassesUnit1.h"
#include <DSClientRest.hpp>
//----------------------------------------------------------------------------
class TRESTClientModule1 : public TDataModule
{
__published:	// IDE-managed Components
	TDSRestConnection *DSRestConnection1;
private:	// User declarations
	bool FInstanceOwner;
	TServerMethods2Client* FServerMethods2Client;
	TServerMethods2Client* GetServerMethods2Client(void);
public:		// User declarations
	__fastcall TRESTClientModule1(TComponent* Owner);
	__fastcall ~TRESTClientModule1();
	__property bool InstanceOwner = {read=FInstanceOwner, write=FInstanceOwner};
	__property TServerMethods2Client* ServerMethods2Client = {read=GetServerMethods2Client, write=FServerMethods2Client};
};
//---------------------------------------------------------------------------
extern PACKAGE TRESTClientModule1 *RESTClientModule1;
//---------------------------------------------------------------------------
#endif
