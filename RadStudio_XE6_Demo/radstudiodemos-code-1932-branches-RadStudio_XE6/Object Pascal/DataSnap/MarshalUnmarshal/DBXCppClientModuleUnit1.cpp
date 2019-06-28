
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
//----------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <tchar.h>
#include <stdio.h>
#include <memory>

#include "DBXCppClientModuleUnit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TDBXClientModule1 *DBXClientModule1;
//---------------------------------------------------------------------------
__fastcall TDBXClientModule1::TDBXClientModule1(TComponent* Owner)
	: TDataModule(Owner)
{
	FInstanceOwner = true;
}

__fastcall TDBXClientModule1::~TDBXClientModule1()
{
	delete FServerMethods2Client;
}

TServerMethods2Client* TDBXClientModule1::GetServerMethods2Client(void)
{
	if (FServerMethods2Client == NULL)
	{
		SQLConnection1->Open();
		FServerMethods2Client = new TServerMethods2Client(SQLConnection1->DBXConnection, FInstanceOwner);
	}
	return FServerMethods2Client;
};

