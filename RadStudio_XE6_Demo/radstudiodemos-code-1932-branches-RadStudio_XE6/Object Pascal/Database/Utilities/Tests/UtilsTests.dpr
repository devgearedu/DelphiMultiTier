program UtilsTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  {$IFDEF MEM_CHECK}
  FastMM4,
  {$ENDIF}
  DUnitTestRunner,
  Forms,
  GUITestRunner,
  Data.DBXCommon,
  FDUtilsTests in 'FDUtilsTests.pas',
  DBUtils in '..\DBUtils.pas',
  FDUtils in '..\FDUtils.pas',
  DBUtilsTests in 'DBUtilsTests.pas',
  TestBase in 'TestBase.pas',
  DBXUtils in '..\DBXUtils.pas',
  DBXUtilsTests in 'DBXUtilsTests.pas',
  RestUtils in '..\RestUtils.pas',
  RestUtilsTests in 'RestUtilsTests.pas';

{$R *.RES}

begin
  {$IFDEF MEM_CHECK}
  // DBExpress will leak a bit if you specify an invalid driver name
  RegisterExpectedMemoryLeak(TDBXContext, 1);
  RegisterExpectedMemoryLeak(12, 1); // TDBXClosedByteReader
  {$ENDIF}
  DUnitTestRunner.RunRegisteredTests;
end.

