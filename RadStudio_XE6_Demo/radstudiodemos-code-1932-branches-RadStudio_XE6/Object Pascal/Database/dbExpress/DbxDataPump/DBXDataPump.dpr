
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2010 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}
program DBXDataPump;

uses
  Forms,
  DBLogDlg,
  DBPWDlg,
  GridNavFrame in 'GridNavFrame.pas' {GridFrame: TFrame},
  DBXPumpForm in 'DBXPumpForm.pas' {DataPumpForm},
  QueryForm in 'QueryForm.pas' {FormQuery},
  DBXUtils in '..\Utils\DBXUtils.pas',
  CommandParser in '..\Utils\CommandParser.pas',
  DBGridExts in '..\Utils\DBGridExts.pas',
  DBXMatch in '..\Utils\DBXMatch.pas',
  DBXMigrator in '..\Utils\DBXMigrator.pas',
  DBXPumpUtils in '..\Utils\DBXPumpUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'dbExpress Data Pump';
  Application.CreateForm(TDataPumpForm, DataPumpForm);
  Application.CreateForm(TDataPumpForm, DataPumpForm);
  Application.CreateForm(TFormQuery, FormQuery);
  Application.Run;
end.
