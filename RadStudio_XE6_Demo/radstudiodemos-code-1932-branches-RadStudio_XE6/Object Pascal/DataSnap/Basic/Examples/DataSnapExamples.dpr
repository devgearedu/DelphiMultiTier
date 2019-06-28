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

program DataSnapExamples;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Vcl.Forms,
  TextTestRunner,
  ClientTest in 'ClientTest.pas',
  DataSnapTestData in 'DataSnapTestData.pas',
  ClientTestClasses in 'ClientTestClasses.pas',
  TestServerContainer in 'TestServerContainer.pas' {DSServerContainer: TDataModule},
  TestServerModule in 'TestServerModule.pas' {SimpleServerModule: TDataModule};

begin
  Application.Initialize;
  Application.CreateForm(TDSServerContainer, DSServerContainer);
  Application.CreateForm(TSimpleServerModule, SimpleServerModule);
  TextTestRunner.RunRegisteredTests;
  DSServerContainer.DSServer1.Stop;
  Application.Terminate;
end.
