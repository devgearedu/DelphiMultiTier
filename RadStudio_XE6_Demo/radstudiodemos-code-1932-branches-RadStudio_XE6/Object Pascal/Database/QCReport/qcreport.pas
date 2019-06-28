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

unit qcreport;
/// <summary>
///  The goal of this sample is to show how developers can efficiently provide
///  reproducible test cases of bugs and performance issues in our products.
///  There are three benefits to the approach illustrated in this sample.
///  1) Uses database related extensions to the dunit framework from the TDBXTestCase
///  that make it easier to specify connections and the execution of specific test
///  cases.
///  2) Provides an example of how to generically drop and create database
///  metadata for test cases using the metadata provider.
///  Note that the TDBXUnicodeVarCharColumn class used below inherits from TDBXMetaDataColumn in the
///  DBXMetaDataProvider.pas unit.  TDBXUnicodeVarCharColumn just sets default properties
///  for the TDBXMetaDataColumn base class.  If you need to be more specific about the type,
///  you can directly set properties in the TDBXMetaDataColumn base class.
///  3) Shows how to use the
///  TDBXDataGenerator class to generate data for test cases.  The data generators may not
///  be rich enough for your needs. You can create your own data generators if you like by
///  extending the TDBXDataGeneratorColumn class in DBXCustomDataGenerator.pas unit.
/// </summary>
interface


uses
  DBXTest, TestFramework,
  DBXCommon,
  DbxMetaDataProvider,
  DBXCustomDataGenerator,
  DBXDataGenerator
  ;

type
  TQCXXXTestCase = class(TDBXTestCase)
  published
    {$IFDEF CLR}[test]{$endif}
    procedure TestQCXXX;
  end;

implementation


{ TQCReportTestCase }

procedure TQCXXXTestCase.TestQCXXX;
const
  RowCount = 3;
var
  MetaDataTable: TDBXMetaDataTable;
  DataGenerator: TDbxDataGenerator;
  Command: TDBXCommand;
  Row: Integer;
  TableName: WideString;
  Transaction: TDBXTransaction;
  Reader: TDBXReader;
  CChar: TDBXAnsiCharColumn;
  CVarChar: TDBXAnsiVarCharColumn;
begin

  TableName := 'QCXXX_TABLE' + GetHostId;

  MetaDataProvider;
  Transaction := DbxConnection.BeginTransaction;
  DropTable(TableName);

  MetaDataTable := TDBXMetaDataTable.Create;
  FreeOnTearDown(MetaDataTable);
  MetaDataTable.TableName := TableName;
  MetaDataTable.AddColumn(TDBXInt32Column.Create('C1'));
  MetaDataTable.AddColumn(TDBXDecimalColumn.Create('C2', 10, 2));
  MetaDataTable.AddColumn(TDBXUnicodeVarCharColumn.Create('C3', 32));
  CChar := TDBXAnsiCharColumn.Create('C4', 20);
  CVarChar := TDBXAnsiVarCharColumn.Create('C5', 1000);
  MetaDataTable.AddColumn(CChar);
  MetaDataTable.AddColumn(CVarChar);

  MetaDataProvider.CreateTable(MetaDataTable);
  DbxConnection.CommitFreeAndNil(Transaction);
  CloseDbxConnection;

  DataGenerator := TDBXDataGenerator.Create;
  FreeOnTearDown(DataGenerator);

  DataGenerator.TableName := TableName;
  DataGenerator.MetaDataProvider := MetaDataProvider;
  DataGenerator.AddColumn(TDBXInt32SequenceGenerator.Create(MetaDataTable.getColumn(0)));
  DataGenerator.AddColumn(TDBXDecimalSequenceGenerator.Create(MetaDataTable.getColumn(1)));
  DataGenerator.AddColumn(TDBXAnsiStringSequenceGenerator.Create(MetaDataTable.getColumn(2)));

  Command := DbxConnection.CreateCommand;
  Command.Text := DataGenerator.CreateParameterizedInsertStatement;
  DataGenerator.AddParameters(Command);
  for Row := 0 to RowCount do
  begin
    DataGenerator.SetInsertParameters(Command, Row);
    Command.ExecuteUpdate;
  end;

  Command.Text := 'select * from '+TableName;
  Reader := Command.ExecuteQuery;
  for Row := 0 to RowCount do
  begin
    Check(Reader.Next);
    DataGenerator.ValidateRow(Reader, Row);
  end;
  Check(not Reader.Next);

end;

end.

