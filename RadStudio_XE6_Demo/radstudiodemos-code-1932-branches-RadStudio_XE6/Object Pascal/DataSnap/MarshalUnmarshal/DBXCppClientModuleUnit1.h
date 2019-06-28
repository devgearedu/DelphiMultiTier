//----------------------------------------------------------------------------

#ifndef DBXCppClientModuleUnit1H
#define DBXCppClientModuleUnit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include "DBXCppClientClassesUnit1.h"
#include <DB.hpp>
#include <DBXCommon.hpp>
#include <DbxDataSnap.hpp>
#include <DSHTTPLayer.hpp>
#include <SqlExpr.hpp>
#include <IndyPeerImpl.hpp>
#include <IPPeerClient.hpp>
//----------------------------------------------------------------------------
class TDBXClientModule1 : public TDataModule
{
__published:	// IDE-managed Components
	TSQLConnection *SQLConnection1;
private:	// User declarations
	bool FInstanceOwner;
	TServerMethods2Client* FServerMethods2Client;
	TServerMethods2Client* GetServerMethods2Client(void);
public:		// User declarations
	__fastcall TDBXClientModule1(TComponent* Owner);
	__fastcall ~TDBXClientModule1();
	__property bool InstanceOwner = {read=FInstanceOwner, write=FInstanceOwner};
	__property TServerMethods2Client* ServerMethods2Client = {read=GetServerMethods2Client, write=FServerMethods2Client};
};
//---------------------------------------------------------------------------
extern PACKAGE TDBXClientModule1 *DBXClientModule1;
//---------------------------------------------------------------------------
#endif
