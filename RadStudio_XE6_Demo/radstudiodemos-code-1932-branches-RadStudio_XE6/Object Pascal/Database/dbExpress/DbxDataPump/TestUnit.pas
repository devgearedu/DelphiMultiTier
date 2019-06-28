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

unit TestUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, StdCtrls, DB, SqlExpr, DBXCommon, DBXMetaDataProvider,
  DBXTypedTableStorage;

type
  TForm24 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    function TableExists(AProvider: TDbxMetaDataProvider; ATableName: String): Boolean;

  public
    { Public declarations }
  end;

var
  Form24: TForm24;

implementation

uses
  Typinfo,
  DBXDataExpressMetaDataProvider, DBXCommonTable, DBXMetaDataReader, DBXMetaDataNames,
  DBXMigrator,

  // Include the metadata support for MS SQL Server
  DBXMsSqlMetaData,

  // Include the metadata support for BlackfishSQL
  DBXDataStoreMetaData
  ;

{$R *.dfm}

// Research function!!!
procedure TForm24.Button1Click(Sender: TObject);
var
  Connection:       TDbxConnection;
  Provider:         TDBXDataExpressMetaDataProvider;
  TableCollection:  TDBXTableStorage;
  Tables:           TDBXTablesTableStorage;
  ColumnCollection: TDBXTableStorage;
  Columns:          TDBXColumnsTableStorage;

begin
  Connection := TDBXConnectionFactory.GetConnectionFactory.GetConnection('TaskWrightDb','','');

  Provider := TDBXDataExpressMetaDataProvider.Create;
  try
    Provider.Connection := Connection;
    Provider.Open;

    TableCollection := Provider.GetCollection( TDBXMetaDataCommands.GetTables );
    try
      if (TableCollection = nil) or not (TableCollection is TDBXTablesTableStorage) then
        raise Exception.Create('Failed to get collection of tables');

      Tables := TDBXTablesTableStorage(TableCollection);

      while Tables.Next do
      begin
        if Tables.TableType <> TDBXTableType.Table then
          Continue;

        Memo1.Lines.Add( Tables.TableName );

        ColumnCollection := Provider.GetCollection( TDBXMetaDataCommands.GetColumns + ' ' + Tables.TableName );
        try
          if (ColumnCollection = nil) or not (ColumnCollection is TDBXColumnsTableStorage) then
            raise Exception.Create('Failed to get collection of columns');

          Columns := TDBXColumnsTableStorage(ColumnCollection);

          while Columns.Next do
          begin
            Memo1.Lines.Add( '- ' + Columns.ColumnName + ' ' + IntToStr( Columns.DbxDataType ) + ' ' + Columns.TypeName + ' ' + BoolToStr( Columns.FixedLength, True ) + ' ' + IntToStr( Columns.Precision ) );
          end;

        finally
          ColumnCollection.Free;

        end;
        
      end;

    finally
      TableCollection.Free;

    end;

  finally
    Provider.Free;

  end;

end;

// Research function!!!
procedure TForm24.Button2Click(Sender: TObject);
var
  Connection:       TDbxConnection;
  Provider:         TDBXDataExpressMetaDataProvider;
  TableMeta:        TDBXMetaDataTable;
  av:               TDBXAnsiVarCharColumn;

begin
  Connection := TDBXConnectionFactory.GetConnectionFactory.GetConnection('testbf','','');

  Provider := TDBXDataExpressMetaDataProvider.Create;
  try
    Provider.Connection := Connection;
    Provider.Open;

    if TableExists( Provider, 'testtable' ) then
      Provider.DropTable( 'testtable' );

    TableMeta := TDBXMetaDataTable.Create;
    TableMeta.TableName := 'testtable';

    TableMeta.AddColumn( TDBXAnsiVarCharColumn.Create('var100', 100 ) );

    av := TDBXAnsiVarCharColumn.Create('var_long', 100 );
    av.Long := True;
    TableMeta.AddColumn( av );

    TableMeta.AddColumn( TDBXAnsiLongColumn.Create('ansilong' ) );
    TableMeta.AddColumn( TDBXBinaryLongColumn.Create( 'binlong' ) );
    
    Provider.CreateTable(TableMeta);

  finally
    Provider.Free;

  end;

end;

// Research function!!!
procedure TForm24.Button3Click(Sender: TObject);
var
  Connection:       TDbxConnection;
  Cmd:              TDbxCommand;
  Reader:           TDBXReader;
  I:                Integer;

begin
  Connection := TDBXConnectionFactory.GetConnectionFactory.GetConnection('TaskWrightDb','','');

  Cmd := Connection.CreateCommand;
  Cmd.CommandType := TDBXCommandTypes.DbxTable;
  Cmd.Text := 'Tasks';

  Reader := Cmd.ExecuteQuery;

  while Reader.Next do
    begin
    I := Reader.GetOrdinal( 'Data' );

    Memo1.Lines.Add( IntToStr( Reader.ValueType[ I ].Size ) );

    end;

end;

// Research function!!!
procedure TForm24.Button4Click(Sender: TObject);
var
  SrcConnection:    TDbxConnection;
  DstConnection:    TDbxConnection;
  Migrator:         TDBXMigrator;

begin
  SrcConnection := TDBXConnectionFactory.GetConnectionFactory.GetConnection('TaskWrightDb','','');
  DstConnection := TDBXConnectionFactory.GetConnectionFactory.GetConnection('testbf','','');

  Migrator := TDBXMigrator.Create();
  try
    Migrator.MigrateFromConnection( SrcConnection, DstConnection );

  finally
    FreeAndNil(Migrator);

  end;

end;

procedure TForm24.Button5Click(Sender: TObject);
var
  Connection:       TDbxConnection;
  Cmd:              TDbxCommand;
  Param:            TDBXParameter;

begin
  Connection := TDBXConnectionFactory.GetConnectionFactory.GetConnection('testbf','','');

  Cmd := Connection.CreateCommand;
  Cmd.CommandType := TDBXCommandTypes.DbxSQL;

  Param := Cmd.CreateParameter;
  Cmd.Parameters.AddParameter( Param );

end;

function TForm24.TableExists(AProvider: TDbxMetaDataProvider; ATableName: String): Boolean;
var
  TableCollection:  TDBXTableStorage;
  
begin
  // Get a table collection from the provider that will contain the table if it does exist.
  TableCollection := AProvider.GetCollection(TDBXMetaDataCommands.GetTables + ' ' + ATableName + ' ' + TDBXTableType.Table);

  // GetCollection returns a class instance, whose type depends on the query passed.
  // So we double-check to make sure that we've been returned the type we want.
  if (TableCollection = nil) or not (TableCollection is TDBXTablesTableStorage) then
      raise Exception.Create('Failed to get collection of tables');
    
  // If there is a record for the desired table, Next will return true (the first row).
  // Otherwise it will return false.
  try
    Result := TableCollection.Next;

  finally
    TableCollection.Free;

  end;

end;

end.
