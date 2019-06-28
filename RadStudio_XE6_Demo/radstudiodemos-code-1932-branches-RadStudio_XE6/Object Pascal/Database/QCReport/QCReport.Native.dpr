{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
// Copyright (c) 1995-2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.
{                                                       }
{*******************************************************}

program QCReport.Native;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  TestFramework,
  DbxTest,
  qcreport in 'qcreport.pas';

begin
    RegisterTest(TQCXXXTestCase.Suite);
    RunRegisteredTests([]);
end.
