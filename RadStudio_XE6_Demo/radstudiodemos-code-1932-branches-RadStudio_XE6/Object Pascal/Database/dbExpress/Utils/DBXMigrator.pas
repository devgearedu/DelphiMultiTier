
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

unit DBXMigrator;

interface

uses
  Classes, SysUtils, DBXCommon, DBXMetaDataProvider, DBXTypedTableStorage,
  DBXMetaDataReader, DBXUtils, DB, SqlExpr, Generics.Collections;

const
  // Metadata column names
  // SDestDbxType = 'DestDbxType';
  DBXIdentifierLen = 128;
  SPumpConstraintName = 'ConstraintName';
  SPumpDestName = 'DestinationName';
  SPumpDestType = 'DestinationType';
  SPumpDestSize = 'DestinationSize';
  SPumpDestScale = 'DestinationScale';
  SPumpDestPrecision = 'DestinationPrecision';
  SPumpSelected = 'Selected';
  SPumpSourceCode = 'SourceCode';
  SPumpProcParams = 'Parameters';
  SPumpNullable = 'Nullable';
  SPumpFixedLength = 'FixedLength';
  SPumpUnicode = 'Unicode';
  SPumpLong = 'Long';
  SPumpUnsigned = 'Unsigned';
  SPumpTableSize = 'TableSize';
  SPumpRowSize = 'RowSize';
  SPumpRowCount = 'RowCount';
  SPumpColOrdinal = 'ColumnOrdinal';
  SPumpAutoIncrement = 'AutoIncrement';
  SPumpAscending = 'Ascending';
  SPumpColCount = 'ColCount';
  SPumpSubType = 'SubType';
  SPumpSize = 'Size';
  SPumpPrimary = 'Primary';
  SPumpUnique = 'Unique';
  SPumpValue = 'Value';
  SPumpIndexCols = 'IndexCols';
  SPumpStarted = 'Started';
  SPumpStopped = 'Stopped';
  SPumpRowsPerSec = 'RowsPerSec';
  SPumpTotalTime = 'TotalTime';
  SPumpColumns = 'Columns';
  SPumpIndexCount = 'IndexCount';
  SPumpIndexes = 'Indexes';
  SPumpDefaultCount = 'DefaultCount';
  SPumpProcedures = 'Procedures';
  SPumpParamCount = 'ParamCount';
  SPumpParameter = 'Parameter';
  SPumpTables = 'Tables';
  SPumpTableCount = 'TableCount';
  SPumpProcCount = 'ProcCount';
  SPumpProcType = 'ProcType';
  SPumpViewCount = 'ViewCount';
  SPumpUserCount = 'UserCount';
  SPumpDefaults = 'Defaults';
  SPumpDestination = 'Destination';
  SPumpDestConnection = 'DestConnection';
  SPumpDestProvider = 'DestProvider';
  SPumpSource = 'Source';
  SPumpProcScript = 'ProcScript';
  SPumpSourceConnection = 'SourceConnection';
  SPumpSourceProvider = 'SourceProvider';
  SPumpColumnName = 'ColName';
  SPumpTypeName = 'TypeName';
  SPumpPrecision = 'Precision';
  SPumpScale = 'Scale';
  SPumpDefaultValue = 'DefaultValue';
  SPumpMaxInline = 'MaxLine';
  SPumpTableName = 'TableName';
  SPumpIndexName = 'IndexName';
  SPumpParameterMode = 'ParamMode';
  SPumpProcName = 'ProcName';
  SPumpCatalogName = 'CatalogName';
  SPumpSchemaName = 'SchemaName';
  SPumpTableType = 'TableType';
  SPumpStandardTable = 'TABLE';

type
  TDBXMigratorEvent = procedure(ASender: TObject;
    ASourceName: UnicodeString; AItemIndex, AItemCount: Integer;
    var ACancel: boolean) of object;
  TDBXMigratorRowEvent = procedure(ASender: TObject; ATableName: UnicodeString;
    ARowIndex, ARowCount: Int64; var ACancel: boolean) of object;
  TDBXMigratorColumnWarningEvent = procedure(ASender: TObject;
    ATableName, AColumnName, AWarning: UnicodeString) of object;
  TDBXMigratorLogMessageEvent = procedure(ASender: TObject; AMessage: string)
    of object;

  EDBXMigrator = class(Exception);

  TDBXMigratorSchema = class
  private
    FProvider: TDBXMetaDataProvider;
    FCountRows: boolean;
    FConnection: TDBXConnection;
    FSchema: TDataSet;
    FDefaultSchema: TDataSet;
    FAllowAutoInc: boolean;
    FIgnoreDefaults: boolean;
    FOnLogMessage: TDBXMigratorLogMessageEvent;
    function GetProvider: TDBXMetaDataProvider;
    function QuoteIdentifier(AIdentifier: String): String;
    procedure DefineColumnSchema(const ADef: TFieldDef);
    procedure SetDefaultDef(const ADef: TFieldDef);
    procedure AddDefaultDef(const ATableName, AColumnName, ATypeName,
      AValue: UnicodeString);
    procedure DefineProcedureSchema(const ADef: TFieldDef);
    procedure DefineProcParamSchema(const ADef: TFieldDef);
    procedure DefineTableSchema(const ADef: TFieldDef);
    { TODO :
      Do we care about this ColConstraints for diagnostics?
      It seems to be only names. }
    // procedure SetColConstraintDef(const ADef: TFieldDef);
    procedure DefineIndexSchema(const ADef: TFieldDef);
    procedure DefineIndexColSchema(const ADef: TFieldDef);
    function LoadColumnSchema(const ATableName: string;
      const ATableType: string; const ADataSet: TDataSet;
      const AColumns: TDBXColumnsTableStorage; var RowSize: Int64;
      const ASchemaName: string = ''): Integer;
    function LoadIndexSchema(const ADataSet: TDataSet;
      const AIndexes: TDBXIndexesTableStorage): Integer;
    function LoadIndexColSchema(const ADataSet: TDataSet;
      const AIndexCols: TDBXIndexColumnsTableStorage): Integer;
    { TODO :
      Do we care about this ColConstraints for diagnostics?
      It seems to be only names. }
    // function LoadColConstraintsSchema(const ADataSet: TDataSet;
    // const AColConstraints: TDBXColumnConstraintsTableStorage): integer;
    function LoadTableSchema(const ADataSet: TDataSet;
      const ATables: TDBXTablesTableStorage): Integer;
    function LoadProcedureSchema(const ADataSet: TDataSet;
      const AProcs: TDBXProceduresTableStorage): Integer;
    function LoadProcParamSchema(const ADataSet: TDataSet;
      const AParams: TDBXProcedureParametersTableStorage): Integer;
    // This DataSet must be freed by the consumer
    function CreateSchema: TDataSet;
    procedure SetConnection(const Value: TDBXConnection);
    procedure SetTableCalcs(const ADef: TFieldDef);
    procedure SetProcCalcs(const ADef: TFieldDef);
    class function IndexSchema(ATableSchema: TDataSet): TDataSet; static;
  protected
    procedure AddFieldDefAttributes(const ADef: TFieldDefs;
      const Attributes: TFieldAttributes; Exclude1: string = '';
      Exclude2: string = ''; Exclude3: string = ''; Exclude4: string = '');
    procedure DoOnLogMessage(AMessage: string);
  public
    class procedure TableCalcs(DataSet: TDataSet); virtual;
    class function TableName(ATableSchema: TDataSet): string;
    class function ColumnName(AColumnSchema: TDataSet): string;
    class function ColumnSchema(ATableSchema: TDataSet): TDataSet;
    class function FindIdField(ATableSchema: TDataSet;
      var ADestIdField: string): string; overload; static;
    class function FindIdField(const AConnection: TSQLConnection;
      const ATableName: string): string; overload; static;
    property Provider: TDBXMetaDataProvider read GetProvider;
    property Connection: TDBXConnection read FConnection write SetConnection;
    property AllowAutoInc: boolean read FAllowAutoInc write FAllowAutoInc;
    property IgnoreDefaults: boolean read FIgnoreDefaults write FIgnoreDefaults;
    property CountRows: boolean read FCountRows write FCountRows;
    function GetSchema: TDataSet;
    constructor Create(const AConnection: TDBXConnection;
      const ACountRows: boolean = True);
    destructor Destroy; override;
  public
    // Used for reporting any messages to the UI
    property OnLogMessage : TDBXMigratorLogMessageEvent
      read FOnLogMessage write FOnLogMessage;
  end;

  TDBXMigrator = class
  private
    FSourceTypes,
    FDestTypes: TStrings;
    FSourceConnection: TDBXConnection;
    FSourceSQLConnection: TSQLConnection;
    FDestConnection: TDBXConnection;
    FDestSQLConnection: TSQLConnection;
    FSourceProvider: TDBXMetaDataProvider;
    FDestProvider: TDBXMetaDataProvider;
    FTableCount: Integer;
    FTableIndex: Integer;
    FProcCount: Integer;
    FProcIndex: Integer;
    FCancel: boolean;

    FOnMigrationStarted: TNotifyEvent;
    FOnMigrationStopped: TNotifyEvent;
    FOnTableMigrationStarted: TDBXMigratorEvent;
    FOnTableMigrationStopped: TDBXMigratorEvent;
    FOnRowCopied: TDBXMigratorRowEvent;
    FOnColumnWarning: TDBXMigratorColumnWarningEvent;
    FOnLogMessage: TDBXMigratorLogMessageEvent;
    FOnRowCountStarted: TDBXMigratorEvent;
    FOnRowCountStopped: TDBXMigratorEvent;
    FOnIndexingStopped: TDBXMigratorEvent;
    FOnIndexingStarted: TDBXMigratorEvent;

    FNormalizeIdentifiers: boolean;
    FMaxRows: Int64;
    FTransRows: Int64;
    FDestination: string;
    FSource: string;
    FManageSourceCxn: boolean;
    FManageDestCxn: boolean;
    FManageSourceProvider: boolean;
    FManageDestProvider: boolean;
    FOnlyRead: boolean;
    FCountRows: boolean;
    FOnProcMigrationStopped: TDBXMigratorEvent;
    FOnProcMigrationStarted: TDBXMigratorEvent;
    FSkipCreateTable: boolean;
    FWipeTable: boolean;
    FMigrateProcs: boolean;
    FChunkCopy: boolean;
    FChunkRows: integer;
    FOnlyNew: boolean;
    FFillById: boolean;

    procedure MissingProperty(const AProp1: string; AProp2: string = '';
      AProp3: string = '');

    procedure DoOnError(const AError: Exception);
    function TransformIdentifier(AIdentifier: String; AProvider: TDBXMetaDataProvider): String;

    procedure MigrateTables(ATables: TDBXTablesTableStorage;
      ADestProvider: TDBXMetaDataProvider = nil);
    procedure MigrateTable(ATableName: string;
      ADestProvider: TDBXMetaDataProvider = nil); overload;
    procedure MigrateTable(ATableSchema: TDataSet;
      ADestProvider: TDBXMetaDataProvider = nil); overload;
    procedure MigrateProcedure(AProcSchema: TDataSet;
      ADestProvider: TDBXMetaDataProvider = nil);
    procedure MigrateIndexes(Indexes: TDBXIndexesTableStorage);
    procedure MigrateIndex(Indexes: TDBXIndexesTableStorage);
    procedure MigrateIndexesFromSchema(AIndexes: TDataSet);
    procedure MigrateIndexFromSchema(AIndex: TDataSet);
    procedure DropTable(AProvider: TDBXMetaDataProvider; ATableName: String);
    procedure DropProcedure(AProcName: string);
    function CreateColumnMetaData(AColumn: TDBXColumnsTableStorage;
      DestTable: UnicodeString): TDBXMetaDataColumn; overload;
    function CreateColumnsMetaData(AColumns: TDBXColumnsTableStorage;
      ATableMeta: TDBXMetaDataTable; DestTable: UnicodeString): Integer;
      overload;
    function ColumnSchemaToMetaData(AColSchema: TDataSet;
      DestTable: UnicodeString): TDBXColumnsTableStorage;
    function CreateTableMetaData(ATableSchema: TDataSet;
      DestTable: UnicodeString): TDBXMetaDataTable;
    //function CreateProcedureMetaData(AProcSchema: TDataSet;
    //  DestProc: UnicodeString): TDBXMetaDataTable;
    class procedure TypeMatchOverride(ADbPlatform, AType: string;
      FldDestType, FldPrecision, FldDestPrecision, FldLong: TField;
      AColumn: TDBXColumnsTableStorage);

    procedure CopyTableData(ATableName: String; ARowCount: Int64); overload;
    procedure CopyTableData(ATableSchema: TDataSet; ARowCount: Int64); overload;
    procedure ClearTable(ATableName: string);
    procedure CopyBlob(ATableName: string; Parameter: TDBXParameter; SourceValue: TDBXValue);
    procedure MapSourceTypeToDestType(ATableName: string; Parameter: TDBXParameter;
      SourceValue: TDBXValue);
    //procedure DropAllIndexesOnTable(AProvider: TDBXMetaDataProvider;
    //  ATableName: String);
    function IsSourceMsSqlEmptyString(AValue: TDBXValue): boolean;
    function GetDestConnection: TDBXConnection;
    function GetDestination: string;
    function GetDestProvider: TDBXMetaDataProvider;
    function GetSource: string;
    function GetSourceConnection: TDBXConnection;
    function GetSourceProvider: TDBXMetaDataProvider;
    procedure SetDestConnection(const Value: TDBXConnection);
    procedure SetDestination(const Value: string);
    procedure SetSource(const Value: string);
    procedure SetSourceConnection(const Value: TDBXConnection);
    procedure SetDestProvider(const Value: TDBXMetaDataProvider);
    procedure SetSourceProvider(const Value: TDBXMetaDataProvider);
    procedure MigrateTablesFromSchema(const ASchema: TDataSet);
    procedure MigrateProceduresFromSchema(const ASchema: TDataSet);
    function GetDestTypes: TStrings;
    function GetSourceTypes: TStrings;
    procedure SetDestSQLConnection;
    function GetDestSQLConnection: TSQLConnection;
    function OpenSQLConnection(AConnectionName: string): TSQLConnection;
    function GetSourceSQLConnection: TSQLConnection;
    procedure SetChunkCopy(const Value: boolean);
    procedure SetOnlyNew(const Value: boolean);
    procedure SetOnlyRead(const Value: boolean);
    procedure SetWipeTable(const Value: boolean);
    procedure SetFillById(const Value: boolean);
    function QuoteIdentifier(AIdentifier: String): String;
  protected
    procedure DoOnMigrationStarted; virtual;
    procedure DoOnMigrationStopped; virtual;
    procedure DoOnTableMigrationStarted(ATableName: String;
      ATableIndex, ATableCount: Integer; var ACancel: boolean); virtual;
    procedure DoOnProcMigrationStarted(AProcName: String;
      AProcIndex, AProcCount: Integer; var ACancel: boolean); virtual;
    procedure DoOnRowCountStarted(ATableName: String;
      ATableIndex, ATableCount: Integer; var ACancel: boolean); virtual;
    procedure DoOnRowCountStopped(ATableName: String;
      ATableIndex, ATableCount: Integer; var ACancel: boolean); virtual;
    procedure DoOnIndexingStarted(ATableName: String;
      ATableIndex, ATableCount: Integer; var ACancel: boolean); virtual;
    procedure DoOnIndexingStopped(ATableName: String;
      ATableIndex, ATableCount: Integer; var ACancel: boolean); virtual;
    procedure DoOnTableMigrationStopped(ATableName: String;
      ATableIndex, ATableCount: Integer; var ACancel: boolean); virtual;
    procedure DoOnProcMigrationStopped(AProcName: String;
      AProcIndex, AProcCount: Integer; var ACancel: boolean); virtual;
    procedure DoOnRowCopied(ATableName: String; ARowIndex, ARowCount: Int64;
      var ACancel: boolean); virtual;
    procedure DoOnColumnWarning(ATableName, AColumnName, AWarning: String);
      virtual;
    procedure LogMessage(AMessage: string); virtual;

    function BuildMigrationCommand(ATableName: string;
      AConnection: TDBXConnection; DestTypesReader: TDBXReader): TDBXCommand;
    function BuildMigrationCommands(ATableSchema: TDataSet; ASourceConnection,
      ADestConnection: TDBXConnection; var ASourceCmd: TDBXCommand)
      : TDBXCommand;
  public
    class function ProcedureScript(AVendor: string; AProcSchema: TDataSet): string;
    property SourceProvider: TDBXMetaDataProvider read GetSourceProvider write
      SetSourceProvider;
    property DestProvider: TDBXMetaDataProvider read GetDestProvider write
      SetDestProvider;
    property SourceConnection: TDBXConnection read GetSourceConnection write
      SetSourceConnection;
    property DestConnection: TDBXConnection read GetDestConnection write
      SetDestConnection;
    property DestSQLConnection: TSQLConnection read GetDestSQLConnection;
    property SourceSQLConnection: TSQLConnection read GetSourceSQLConnection;
    property Source: string read GetSource write SetSource;
    property Destination: string read GetDestination write SetDestination;
    property ChunkCopy: boolean read FChunkCopy write SetChunkCopy default False;
    property ChunkRows: integer read FChunkRows write FChunkRows default 0;
    property OnlyRead: boolean read FOnlyRead write SetOnlyRead default False;
    property OnlyNew: boolean read FOnlyNew write SetOnlyNew default False;
    property FillById: boolean read FFillById write SetFillById default False;
    property CountRows: boolean read FCountRows write FCountRows;
    property SourceTypes: TStrings read GetSourceTypes;
    property DestTypes: TStrings read GetDestTypes;
    property SkipCreateTable: boolean read FSkipCreateTable write FSkipCreateTable;
    property WipeTable: boolean read FWipeTable write SetWipeTable;
    property MigrateProcs: boolean read FMigrateProcs write FMigrateProcs;

    constructor Create; overload;
    destructor Destroy; override;
    constructor Create(const ASource: string; ADestination: string = '';
      ACountRows: boolean = True); overload;
    constructor Create(const ASourceConnection: TDBXConnection;
      ADestConnection: TDBXConnection = nil; ACountRows: boolean = True);
      overload;
    function GetParameterFromValueType(ACommand: TDBXCommand;
      AValueType: TDBXValueType; AName: string): TDBXParameter;
    function GetParameterFromColSchema(ACommand: TDBXCommand;
      AColSchema: TDataSet): TDBXParameter;
    function DestTypeFromName(AName: string): TDBXType;
    function SourceTypeFromName(AName: string): TDBXType;

    procedure Migrate(ASourceConnection: TDBXConnection = nil;
      ADestConnection: TDBXConnection = nil); overload;
    procedure Migrate(const ATables: TStringArray;
      ASourceConnection: TDBXConnection = nil;
      ADestConnection: TDBXConnection = nil); overload;
    procedure Migrate(const ASchema: TDataSet;
      ASourceConnection: TDBXConnection = nil;
      ADestConnection: TDBXConnection = nil); overload;

    // Maximum number of rows to copy from each table - mainly for testing
    property MaxRows: Int64 read FMaxRows write FMaxRows;

    // Number of rows to copy per transaction
    property TransRows: Int64 read FTransRows write FTransRows;

    // This property specifies whether the SQL identifiers should be converted
    // to match the destination database case requirements.
    property NormalizeIdentifiers
      : boolean read FNormalizeIdentifiers write FNormalizeIdentifiers;

    // This event is called just before the migration actually starts.
    property OnMigrationStarted
      : TNotifyEvent read FOnMigrationStarted write FOnMigrationStarted;

    // This event is called after the migration completes.
    property OnMigrationStopped
      : TNotifyEvent read FOnMigrationStopped write FOnMigrationStopped;

    // This event is called when a table's rows are being counted.
    property OnRowCountStarted
      : TDBXMigratorEvent read FOnRowCountStarted write FOnRowCountStarted;

    // This event is called when a table's rows are being counted.
    property OnRowCountStopped
      : TDBXMigratorEvent read FOnRowCountStopped write FOnRowCountStopped;

    // This event is called when a table is about to be migrated.
    property OnTableMigrationStarted
      : TDBXMigratorEvent read FOnTableMigrationStarted write
      FOnTableMigrationStarted;

    // This event is called when a table has been migrated.
    property OnTableMigrationStopped
      : TDBXMigratorEvent read FOnTableMigrationStopped write
      FOnTableMigrationStopped;

    // This event is called when a procedure is about to be migrated.
    property OnProcMigrationStarted
      : TDBXMigratorEvent read FOnProcMigrationStarted write
      FOnProcMigrationStarted;

    // This event is called when a procedure has been migrated.
    property OnProcMigrationStopped
      : TDBXMigratorEvent read FOnProcMigrationStopped write
      FOnProcMigrationStopped;

    // This event is called for each row in the table, as it is being copied.
    property OnRowCopied
      : TDBXMigratorRowEvent read FOnRowCopied write FOnRowCopied;

    // This event is called when a table's indexing starts
    property OnIndexingStarted
      : TDBXMigratorEvent read FOnIndexingStarted write FOnIndexingStarted;

    // This event is called when a table's indexing completes
    property OnIndexingStopped
      : TDBXMigratorEvent read FOnIndexingStopped write FOnIndexingStopped;

    // This event is called when a non-critical warning is generated when
    // a column definition is copied
    property OnColumnWarning
      : TDBXMigratorColumnWarningEvent read FOnColumnWarning write
      FOnColumnWarning;

    // This event is used to report miscellaneous bits of information
    property OnLogMessage : TDBXMigratorLogMessageEvent
      read FOnLogMessage write FOnLogMessage;
  end;

function GetNestedDataSet(const AField: TField): TDataSet;

implementation

uses
  Windows, StrUtils,
  DBXDataExpressMetaDataProvider, DBXCommonTable, DBClient,
  DBXMetaDataWriter, DBXDynaLink, DBXMetaDataNames, DbxPlatform,
  DbxInterbase, DbxMySql, DbxSybaseASA, DbxSybaseASE, DbxMsSql,
  DbxDB2, DbxOracle, DbxFirebird,
  {$if CompilerVersion < 22.0}
  DbxBlackfishSQL,
  {$ifend}
  DBXPumpUtils, DBXCommonResStrs,

  // Functions for the GetValueAsString method.
  SqlTimSt, FMTBcd,

  // Include the metadata support for MS SQL Server
  DBXMsSqlMetaData,

  {$if CompilerVersion < 21}
  // Include the metadata support for BlackfishSQL in Delphi 2010 and below
  DBXDataStoreMetaData,
  {$ifend}

  DBXMatch;

resourcestring
  StrDefaultValueWarning =
    'The default value for the column ''%s'' in table '
    + '''%s'' (%s) appears to be a function, and was not converted';
  StrMigratingTable = 'Migrating table %s to %s';
  StrMigratingProcedure = 'Migrating procedure %s to %s';
  StrDroppingTable = 'Dropping existing table (%s)';
  StrCreatingTable = 'Creating table (%s)';
  StrCreatingProcedure = 'Creating procedure (%s) with script:%s';
  StrRunningQuery = 'Running query: %s';
  StrPreparingQuery = 'Preparing query: %s';
  StrExecutingRowQuery = 'Row #%d: Executing INSERT query';
  StrFailedToDropIndex = 'Failed to drop index %s from table %s';
  StrNoColumnsRetrieved = 'No columns were retrieved for %s';

type
  TDBXMetaDataProviderWithPublicWriter = class(TDBXMetaDataProvider)
  end;

  TDBXBaseMetaDataWriterWithPublicReader = class(TDBXBaseMetaDataWriter)
  end;

procedure DebugString(Str: String);
begin
{$IFDEF UseOutputDebugString}
  OutputDebugString(PChar(Str));
{$ENDIF}
end;


function SafeName(const Value: string): string;
const
  GoodChars = ['A'..'Z','a'..'z','0'..'9', '.', '_'];
  FixChar = '_';
var
  i, j, k: integer;

  procedure AddChar(const c: char);
  begin
    Inc(j);
    Result[j] := c;
  end;

begin
  k := Length(Value);
  j := 0;
  SetLength(Result, k);
  for i := 1 to Length(Value) do
  begin
    if CharInSet(Value[i], GoodChars) then
      AddChar(Value[i])
    else if (i = 1) or ((i > 1) and (Result[i-1] <> FixChar)) then
      AddChar(FixChar);
  end;
  if (j > 0) and (Result[j] = FixChar) then
    Dec(j);
  SetLength(Result, j);
end;

function DBXGetMetaWriter(const AProvider: TDBXMetaDataProvider)
  : TDBXBaseMetaDataWriterWithPublicReader;
var
  TempProvider: TDBXMetaDataProviderWithPublicWriter;
begin
  TempProvider := TDBXMetaDataProviderWithPublicWriter(AProvider);
  Result := TDBXBaseMetaDataWriterWithPublicReader(TempProvider.Writer);
end;

procedure AutoFree(const AManaged: boolean; var AObject: TObject); overload;
begin
  if AManaged then
    FreeAndNil(AObject);
end;

procedure AutoFree(const AManaged: boolean; var ASQLConnection: TSQLConnection); overload;
begin
  if AManaged then
    FreeAndNil(ASQLConnection);
end;

procedure AutoFree(const AManaged: boolean; var AConnection: TDBXConnection);
  overload;
begin
  if AManaged then
    FreeAndNil(AConnection);
end;

procedure AutoFree(const AManaged: boolean;
  var AProvider: TDBXMetaDataProvider); overload;
begin
  if AManaged then
    FreeAndNil(AProvider);
end;

function GetNestedDataSet(const AField: TField): TDataSet;
begin
  Result := TCustomClientDataSet((AField as TDataSetField).NestedDataSet);
end;

procedure SetDisplayWidths(const AFields: TFields);
const
  DISP_WIDTH = 15;
var
  F: TField;
begin
  for F in AFields do
    if (F.DataType in [ftString, ftWideString]) and
      (F.DisplayWidth > DISP_WIDTH) then
      F.DisplayWidth := DISP_WIDTH
    else if F.DataType = ftDataSet then
      SetDisplayWidths(GetNestedDataSet(F).Fields);
end;

{ TDBXMigratorSchema }

// function TDBXMigratorSchema.LoadColConstraintsSchema(const ADataSet: TDataSet;
// const AColConstraints: TDBXColumnConstraintsTableStorage): integer;
// begin
// Result := 0;
// while AColConstraints.InBounds do
// begin
// Inc(Result);
// ADataSet.Insert;
// ADataSet.FieldByName(SPumpSelected).Value := True;
// ADataSet.FieldByName(SPumpColumnName).Value := AColConstraints.ColumnName;
// ADataSet.FieldByName(SPumpConstraintName).Value := AColConstraints.ConstraintName;
// ADataSet.FieldByName(SPumpDestName).Value := AColConstraints.ConstraintName;
// ADataSet.Post;
// AColConstraints.Next;
// end;
// end;
//
// procedure TDBXMigratorSchema.SetColConstraintDef(const ADef: TFieldDef);
// begin
// ADef.Name := SPumpColConstraints;
// ADef.DataType := ftDataSet;
// ADef.ChildDefs.Add(SPumpSelected, ftBoolean);
// ADef.ChildDefs.Add(SPumpColumnName, ftWideString, DBXIdentifierLen, True);
// ADef.ChildDefs.Add(SPumpConstraintName, ftWideString, DBXIdentifierLen, True);
// ADef.ChildDefs.Add(SPumpDstName, ftWideString, DBXIdentifierLen, True);
// end;

type
  TDBXValueListAccess = class(TDBXValueList);

function TDBXMigratorSchema.LoadColumnSchema(const ATableName: string;
  const ATableType: string; const ADataSet: TDataSet;
  const AColumns: TDBXColumnsTableStorage; var RowSize: Int64;
  const ASchemaName: string = ''): Integer;
var
  MaxCols: integer;
  DbxName: string;
  DbxType: TDBXType;
  SourceCmd: TDBXCommand;
  SourceReader: TDBXReader;
  ValType: TDBXValueType;
  // Constraints: TDBXColumnConstraintsTableStorage;
begin
  Result := 0;
  RowSize := 0;
  SourceCmd := Connection.CreateCommand;
  try

    // Open the source table.
    SourceCmd.CommandType := TDBXCommandTypes.DbxSQL;
    if Length(ASchemaName) > 0 then
    begin
      SourceCmd.Text := 'SELECT * FROM ' + QuoteIdentifier(ASchemaName)
        + '.' + QuoteIdentifier(ATableName) + ' where 1=0';
    end
    else
    begin
      SourceCmd.Text := 'SELECT * FROM ' + QuoteIdentifier(ATableName)
        + ' where 1=0';
    end;
    SourceReader := SourceCmd.ExecuteQuery;
    try
      if Assigned(SourceReader) then
      begin
        // SourceReader.Next;
        MaxCols := TDBXValueListAccess(SourceReader).GetColumnCount;
        while AColumns.InBounds and (Result < MaxCols) do
        begin
          Inc(Result);
          ADataSet.Insert;
          if SameText(ATableType, TDBXMetaDataTableTypes.Table,
            TLocaleOptions.loInvariantLocale) then
          begin
            // SourceValue := SourceReader.Value[ Result - 1 ];
            ValType := SourceReader.ValueType[Result - 1];
            ADataSet.FieldByName(SPumpSubType).Value := ValType.SubType;
            ADataSet.FieldByName(SPumpSize).Value := ValType.Size;
            ADataSet.FieldByName(SPumpDestSize).Value := ValType.Size;
            DbxType := ValType.DataType;
          end
          else
            DbxType := AColumns.DbxDataType;
          DbxName := StripDbxType(TDBXValueType.DataTypeName(DbxType));
          ADataSet.FieldByName(SPumpSelected).Value := True;
          ADataSet.FieldByName(SPumpColumnName).Value := AColumns.ColumnName;
          ADataSet.FieldByName(SPumpDestName).Value := AColumns.ColumnName;
          ADataSet.FieldByName(SPumpTypeName).Value := DbxName;
          ADataSet.FieldByName(SDbxDataType).Value := DbxType;
          // AColumns.DbxDataType;
          ADataSet.FieldByName(SPumpDestType).Value := DbxName;
          ADataSet.FieldByName(SPumpPrecision).Value := AColumns.Precision;
          ADataSet.FieldByName(SPumpDestPrecision).Value := AColumns.Precision;
          ADataSet.FieldByName(SPumpScale).Value := AColumns.Scale;
          ADataSet.FieldByName(SPumpDestScale).Value := AColumns.Scale;
          Inc(RowSize, AColumns.Precision); // ? Is this "data size"?
          ADataSet.FieldByName(SPumpColOrdinal).Value := AColumns.ColumnOrdinal;
          if not FIgnoreDefaults then
          ADataSet.FieldByName(SPumpDefaultValue).Value :=
              AColumns.DefaultValue;
          if Length(AColumns.DefaultValue) > 0 then
            AddDefaultDef(AColumns.TableName, AColumns.ColumnName,
              AColumns.TypeName, AColumns.DefaultValue);
          ADataSet.FieldByName(SPumpNullable).Value := AColumns.Nullable;
          ADataSet.FieldByName(SPumpAutoIncrement).Value :=
            AllowAutoInc and AColumns.AutoIncrement;

          ADataSet.FieldByName(SPumpMaxInline).Value := AColumns.MaxInline;
          ADataSet.FieldByName(SPumpFixedLength).Value := AColumns.FixedLength;
          ADataSet.FieldByName(SPumpUnicode).Value := AColumns.Unicode;
          ADataSet.FieldByName(SPumpLong).Value := AColumns.Long;
          ADataSet.FieldByName(SPumpUnsigned).Value := AColumns.Unsigned;
          // Constraints := DBXGetColumnConstraints(Provider, AColumns.TableName,
          // AColumns.ColumnName);
          // try
          // ADataSet.FieldByName('ConstraintCount').Value := LoadColConstraintsSchema(
          // GetNestedDataSet(ADataSet.FieldByName('Constraints')), Constraints);
          // finally
          // FreeAndNil(Constraints);
          // end;
          ADataSet.Post;
          AColumns.DefaultValue := '';
          AColumns.Next;
        end;
      end;
    finally
      FreeAndNil(SourceReader);
    end;
  finally
    FreeAndNil(SourceCmd);
  end;

  // Set the majority of fields to read-only now that they are populated
  // AddFieldDefAttributes(ADataSet.FieldDefs, [faReadOnly ],
  // SPumpDestName, SDestDbxType, SPumpDestType, SPumpDestSize);

end;

procedure TDBXMigratorSchema.DefineColumnSchema(const ADef: TFieldDef);

begin
  ADef.Name := SPumpColumns;
  ADef.DataType := ftDataSet;
  ADef.ChildDefs.Add(SPumpSelected, ftBoolean);
  ADef.ChildDefs.Add(SPumpColumnName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpDestName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpTypeName, ftWideString, 32); // ?
  // Create Picklist recipient
  ADef.ChildDefs.Add(SPumpDestType, ftWideString, DBXIdentifierLen);

  ADef.ChildDefs.Add(SDbxDataType, ftInteger);

  ADef.ChildDefs.Add(SPumpSize, ftInteger);
  ADef.ChildDefs.Add(SPumpDestSize, ftInteger);
  ADef.ChildDefs.Add(SPumpPrecision, ftInteger);
  ADef.ChildDefs.Add(SPumpDestPrecision, ftInteger);
  ADef.ChildDefs.Add(SPumpScale, ftInteger);
  ADef.ChildDefs.Add(SPumpDestScale, ftInteger);
  ADef.ChildDefs.Add(SPumpColOrdinal, ftInteger);
  ADef.ChildDefs.Add(SPumpSubType, ftInteger);
  ADef.ChildDefs.Add(SPumpDefaultValue, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpNullable, ftBoolean);
  ADef.ChildDefs.Add(SPumpAutoIncrement, ftBoolean);
  ADef.ChildDefs.Add(SPumpMaxInline, ftInteger);
  ADef.ChildDefs.Add(SPumpFixedLength, ftBoolean);
  ADef.ChildDefs.Add(SPumpUnicode, ftBoolean);
  ADef.ChildDefs.Add(SPumpLong, ftBoolean);
  ADef.ChildDefs.Add(SPumpUnsigned, ftBoolean);

  // ADef.ChildDefs.Add('ConstraintCount', ftInteger);
  // SetColConsraintDef(ADef.ChildDefs.AddFieldDef);

end;

procedure TDBXMigratorSchema.SetConnection(const Value: TDBXConnection);
begin
  if FConnection <> Value then
  begin
    FreeAndNil(FProvider);
    FConnection := Value;
  end;
end;

procedure TDBXMigratorSchema.SetDefaultDef(const ADef: TFieldDef);
begin
  ADef.Name := SPumpDefaults;
  ADef.DataType := ftDataSet;
  ADef.ChildDefs.Add(SPumpSelected, ftBoolean);
  ADef.ChildDefs.Add(SPumpTableName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpColumnName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpTypeName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpValue, ftWideString, DBXIdentifierLen);
end;

procedure TDBXMigratorSchema.SetProcCalcs(const ADef: TFieldDef);
var
  ScriptCalc: TFieldDef;
begin
  ScriptCalc := ADef.ChildDefs.AddFieldDef;
  ScriptCalc.Name := SPumpProcScript;
  ScriptCalc.DataType := ftWideMemo;
  ScriptCalc.InternalCalcField := True;
end;

function TDBXMigratorSchema.LoadIndexSchema(const ADataSet: TDataSet;
  const AIndexes: TDBXIndexesTableStorage): Integer;
var
  Coll: TDBXIndexColumnsTableStorage;
begin
  Result := 0;
  while AIndexes.InBounds do
  begin
    Inc(Result);
    ADataSet.Insert;
    ADataSet.FieldByName(SPumpTableName).Value := AIndexes.TableName;
    ADataSet.FieldByName(SPumpIndexName).Value := AIndexes.IndexName;
    ADataSet.FieldByName(SPumpDestName).Value := SafeName(AIndexes.IndexName);
    ADataSet.FieldByName(SPumpConstraintName).Value := AIndexes.ConstraintName;
    ADataSet.FieldByName(SPumpPrimary).Value := AIndexes.Primary;
    ADataSet.FieldByName(SPumpUnique).Value := AIndexes.Unique;
    ADataSet.FieldByName(SPumpAscending).Value := AIndexes.Ascending;
    Coll := DBXGetIndexColumns(Provider, QuoteIdentifier(AIndexes.TableName),
      QuoteIdentifier(AIndexes.IndexName));
    try
      ADataSet.FieldByName(SPumpColCount).Value := LoadIndexColSchema
        (GetNestedDataSet(ADataSet.FieldByName(SPumpIndexCols)), Coll);
    finally
      FreeAndNil(Coll);
    end;
    ADataSet.FieldByName(SPumpSelected).Value := ADataSet.FieldByName(SPumpColCount).Value > 0;
    ADataSet.Post;
    AIndexes.Next;
  end;
end;

function TDBXMigratorSchema.LoadProcedureSchema(const ADataSet: TDataSet;
  const AProcs: TDBXProceduresTableStorage): Integer;
var
  Params: TDBXProcedureParametersTableStorage;
  sourcecode: string;
begin
  Result := 0;
  while AProcs.InBounds do
  begin
    Inc(Result);
    ADataSet.Insert;
    ADataSet.FieldByName(SPumpSelected).Value := True;
    ADataSet.FieldByName(SPumpProcName).Value := AProcs.ProcedureName;
    ADataSet.FieldByName(SPumpDestName).Value := AProcs.ProcedureName;
    ADataSet.FieldByName(SPumpCatalogName).Value := AProcs.CatalogName;
    ADataSet.FieldByName(SPumpSchemaName).Value := AProcs.SchemaName;
    ADataSet.FieldByName(SPumpProcType).Value := AProcs.ProcedureType;
    sourcecode := DBXGetProcedureSource(Connection, AProcs.ProcedureName);
    ADataSet.FieldByName(SPumpSourceCode).Value := sourcecode;
    // ADataSet.FieldByName('ExternalDefinition').Value := AProcs.ExternalDefinition;
    // ADataSet.FieldByName('Definition').Value := AProcs.Definition;

    Params := DBXGetProcedureParameters(Provider, AProcs.ProcedureName);
    try
      ADataSet.FieldByName(SPumpParamCount).Value := LoadProcParamSchema
        (GetNestedDataSet(ADataSet.FieldByName(SPumpProcParams)), Params);
    finally
      FreeAndNil(Params);
    end;
    ADataSet.Post;
    AProcs.Next;
  end;
end;

procedure TDBXMigratorSchema.DefineProcParamSchema(const ADef: TFieldDef);
begin
  ADef.Name := SPumpProcParams;
  ADef.DataType := ftDataSet;
  ADef.ChildDefs.Add(SPumpSelected, ftBoolean);
  ADef.ChildDefs.Add(SPumpParameter, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpDestName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpParameterMode, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpTypeName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpDestType, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpPrecision, ftInteger);
  ADef.ChildDefs.Add(SPumpDestPrecision, ftInteger);
  ADef.ChildDefs.Add(SPumpScale, ftInteger);
//  ADef.ChildDefs.Add(SPumpDestScale, ftInteger);
  ADef.ChildDefs.Add(SPumpColOrdinal, ftInteger);
  ADef.ChildDefs.Add(SPumpNullable, ftBoolean);
  ADef.ChildDefs.Add(SDbxDataType, ftInteger);
  ADef.ChildDefs.Add(SPumpFixedLength, ftBoolean);
  ADef.ChildDefs.Add(SPumpUnicode, ftBoolean);
  ADef.ChildDefs.Add(SPumpLong, ftBoolean);
  ADef.ChildDefs.Add(SPumpUnsigned, ftBoolean);
  ADef.ChildDefs.Add(SPumpProcName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpCatalogName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpSchemaName, ftWideString, DBXIdentifierLen, True);
end;

function TDBXMigratorSchema.LoadProcParamSchema(const ADataSet: TDataSet;
  const AParams: TDBXProcedureParametersTableStorage): Integer;
begin
  Result := 0;
  while AParams.InBounds do
  begin
    Inc(Result);
    ADataSet.Insert;
    ADataSet.FieldByName(SPumpSelected).Value := True;
    ADataSet.FieldByName(SPumpParameter).Value := AParams.ParameterName;
    ADataSet.FieldByName(SPumpDestName).Value := AParams.ParameterName;
    ADataSet.FieldByName(SPumpParameterMode).Value := AParams.ParameterMode;
    ADataSet.FieldByName(SPumpProcName).Value := AParams.ProcedureName;
    ADataSet.FieldByName(SPumpTypeName).Value := AParams.TypeName;
    ADataSet.FieldByName(SPumpDestType).Value := AParams.TypeName;
    ADataSet.FieldByName(SPumpCatalogName).Value := AParams.CatalogName;
    ADataSet.FieldByName(SPumpSchemaName).Value := AParams.SchemaName;
    ADataSet.FieldByName(SPumpPrecision).Value := AParams.Precision;
    ADataSet.FieldByName(SPumpDestPrecision).Value := AParams.Precision;
    ADataSet.FieldByName(SPumpScale).Value := AParams.Scale;
//    ADataSet.FieldByName(SPumpDestScale).Value := AParams.Scale;
    ADataSet.FieldByName(SPumpColOrdinal).Value := AParams.ColumnOrdinal;
    ADataSet.FieldByName(SPumpNullable).Value := AParams.Nullable;
    ADataSet.FieldByName(SDbxDataType).Value := AParams.DbxDataType;
    ADataSet.FieldByName(SPumpFixedLength).Value := AParams.FixedLength;
    ADataSet.FieldByName(SPumpUnicode).Value := AParams.Unicode;
    ADataSet.FieldByName(SPumpLong).Value := AParams.Long;
    ADataSet.FieldByName(SPumpUnsigned).Value := AParams.Unsigned;
    ADataSet.Post;
    AParams.Next;
  end;
end;

procedure TDBXMigratorSchema.DefineIndexSchema(const ADef: TFieldDef);
begin
  ADef.Name := SPumpIndexes;
  ADef.DataType := ftDataSet;
  ADef.ChildDefs.Add(SPumpSelected, ftBoolean);
  ADef.ChildDefs.Add(SPumpTableName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpIndexName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpDestName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpConstraintName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpPrimary, ftBoolean);
  ADef.ChildDefs.Add(SPumpUnique, ftBoolean);
  ADef.ChildDefs.Add(SPumpAscending, ftBoolean);
  ADef.ChildDefs.Add(SPumpColCount, ftInteger);
  // AddFieldDefAttributes(ADef.ChildDefs, [faReadOnly ], SPumpDestName);
  DefineIndexColSchema(ADef.ChildDefs.AddFieldDef);
end;

function TDBXMigratorSchema.LoadIndexColSchema(const ADataSet: TDataSet;
  const AIndexCols: TDBXIndexColumnsTableStorage): Integer;
begin
  Result := 0;
  while AIndexCols.InBounds do
  begin
    Inc(Result);
    ADataSet.Insert;
    ADataSet.FieldByName(SPumpSelected).Value := True;
    ADataSet.FieldByName(SPumpColumnName).Value := AIndexCols.ColumnName;
    ADataSet.FieldByName(SPumpDestName).Value := AIndexCols.ColumnName;
    ADataSet.FieldByName(SPumpColOrdinal).Value := AIndexCols.ColumnOrdinal;
    ADataSet.FieldByName(SPumpAscending).Value := AIndexCols.Ascending;
    ADataSet.Post;
    AIndexCols.Next;
  end;
end;

procedure TDBXMigratorSchema.DefineIndexColSchema(const ADef: TFieldDef);
begin
  ADef.Name := SPumpIndexCols;
  ADef.DataType := ftDataSet;
  ADef.ChildDefs.Add(SPumpSelected, ftBoolean);
  ADef.ChildDefs.Add(SPumpColumnName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpDestName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpColOrdinal, ftInteger);
  ADef.ChildDefs.Add(SPumpAscending, ftBoolean);
  // AddFieldDefAttributes(ADef.ChildDefs, [faReadOnly ], SPumpDestName);
end;

function TDBXMigratorSchema.LoadTableSchema(const ADataSet: TDataSet;
  const ATables: TDBXTablesTableStorage): Integer;
var
  Cols: TDBXColumnsTableStorage;
  Indexes: TDBXIndexesTableStorage;
  FldTableName: TField;
  RowCount, RowSize: Int64;
begin
  Result := 0;
  RowSize := 0;
  FldTableName := ADataSet.FieldByName(SPumpTableName);
  while (ATables.InBounds) and (Assigned(ATables)) do
  begin
    Inc(Result);
    if not SameText(ATables.TableType, 'SYSTEM VIEW', TLocaleOptions.loInvariantLocale) then
    begin
      try
        // DebugString(Format('Table %s, Type %s', [ATables.TableName, ATables.TableType]));
        ADataSet.Insert;
        ADataSet.FieldByName(SPumpSelected).Value := True;
        FldTableName.Value := ATables.TableName;
        ADataSet.FieldByName(SPumpDestName).Value := ATables.TableName;
        ADataSet.FieldByName(SPumpStarted).Value := MinDateTime;
        ADataSet.FieldByName(SPumpStopped).Value := MinDateTime;
        ADataSet.FieldByName(SPumpRowsPerSec).Value := 0;
        ADataSet.FieldByName(SPumpTotalTime).Value := 0;
        ADataSet.FieldByName(SPumpCatalogName).Value := ATables.CatalogName;
        ADataSet.FieldByName(SPumpSchemaName).Value := ATables.SchemaName;
        ADataSet.FieldByName(SPumpTableType).Value := ATables.TableType;
        Cols := DBXGetColumns(Provider, QuoteIdentifier(ATables.TableName));
        try
          ADataSet.FieldByName(SPumpColCount).Value := LoadColumnSchema
            (ATables.TableName, ATables.TableType, GetNestedDataSet
              (ADataSet.FieldByName(SPumpColumns)), Cols, RowSize,
            ATables.SchemaName);
        finally
          FreeAndNil(Cols);
        end;
        ADataSet.FieldByName(SPumpRowSize).Value := RowSize;
        if FCountRows and (UpperCase(ATables.TableType) = SPumpStandardTable) then
        begin
          RowCount := DBXGetRowCount(FConnection, ATables.TableName);
          ADataSet.FieldByName(SPumpRowCount).Value := RowCount;
          ADataSet.FieldByName(SPumpTableSize).Value := RowSize * RowCount;
        end;
        Indexes := DBXGetIndexes(Provider, QuoteIdentifier(ATables.TableName));
        try
          ADataSet.FieldByName(SPumpIndexCount).Value := LoadIndexSchema
            (GetNestedDataSet(ADataSet.FieldByName(SPumpIndexes)), Indexes);
        finally
          FreeAndNil(Indexes);
        end;
        ADataSet.Post;
      except
        on E: Exception do
        begin
          ADataSet.Cancel;
          DoOnLogMessage(E.Message);
        end;
      end;
    end;
    ATables.Next;
  end;
end;

procedure TDBXMigratorSchema.AddDefaultDef(const ATableName, AColumnName,
  ATypeName, AValue: UnicodeString);
begin
  FDefaultSchema.Insert;
  FDefaultSchema.FieldByName(SPumpSelected).Value := True;
  FDefaultSchema.FieldByName(SPumpTableName).Value := ATableName;
  FDefaultSchema.FieldByName(SPumpColumnName).Value := AColumnName;
  FDefaultSchema.FieldByName(SPumpTypeName).Value := ATypeName;
  FDefaultSchema.FieldByName(SPumpValue).Value := AValue;
  FDefaultSchema.Post;
  if not(FSchema.State in dsEditModes) then
    FSchema.Edit;
  FSchema.FieldByName(SPumpDefaultCount).asInteger := FSchema.FieldByName
    (SPumpDefaultCount).asInteger + 1;
end;

class function TDBXMigratorSchema.ColumnName(AColumnSchema: TDataSet): string;
begin
  Result := AColumnSchema.FieldByName(SPumpDestName).asString;
end;

class function TDBXMigratorSchema.ColumnSchema(ATableSchema: TDataSet)
  : TDataSet;
begin
  Result := GetNestedDataSet(ATableSchema.FieldByName(SPumpColumns));
end;

class function TDBXMigratorSchema.IndexSchema(ATableSchema: TDataSet)
  : TDataSet;
begin
  Result := GetNestedDataSet(ATableSchema.FieldByName(SPumpIndexes));
end;

class function TDBXMigratorSchema.FindIdField(ATableSchema: TDataSet;
  var ADestIdField: string) : string;
const
  SIntTypes = '|uint8|int8|int16|uint16|int32|uint32|int64|uint64|';

var
  TypeField,
  DestField,
  NameField: TField;
  IndexMark,
  ColMark : TBytes;
  Indices,
  IndexCols,
  Columns: TDataSet;
begin
  Result := '';
  Indices := IndexSchema(ATableSchema);
  Columns := ColumnSchema(ATableSchema);
  IndexMark := Indices.BookMark;
  ColMark := Columns.Bookmark;
  NameField := Columns.FieldByName(SPumpColumnName);
  DestField := Columns.FieldByName(SPumpDestName);
  TypeField := Columns.FieldByName(SPumpTypeName);
  Indices.DisableControls;
  Columns.DisableControls;
  try
    if (Indices.Locate(SPumpPrimary, true, []) or Indices.Locate(SPumpUnique, true, [])) then
    begin
      IndexCols := GetNestedDataSet(Indices.FieldByName(SPumpIndexCols));
      if IndexCols.RecordCount = 1 then
      begin
        Result := IndexCols.FieldByName(SPumpColumnName).AsString;
        if Columns.Locate(SPumpColumnName, Result, [ loCaseInsensitive ])
          and (Pos(LowerCase('|' + TypeField.AsString + '|'), SIntTypes) > 0) then
          ADestIdField := DestField.AsString
        else
        begin
          Result := '';
          ADestIdField := '';
        end;
      end;
    end;
    if Length(Result) = 0 then // no PK index of one field, try this way instead
    begin
      Columns.First;
      while not Columns.Eof do
      begin
        if (LowerCase(RightStr(NameField.AsString, 2)) = 'id')
          and (Pos(LowerCase('|' + TypeField.AsString + '|'), SIntTypes) > 0) then
        begin
          Result := NameField.AsString;
          ADestIdField := DestField.AsString;
          break;
        end;
        Columns.Next;
      end;
    end;
  finally
    Indices.BookMark := IndexMark;
    Columns.Bookmark := ColMark;
    Indices.EnableControls;
    Columns.EnableControls;
  end;
end;

class function TDBXMigratorSchema.FindIdField(const AConnection: TSQLConnection;
  const ATableName: string) : string;
var
  ds : TSQLDataSet;
  Fld : TField;
begin
  Result := '';
  ds := TSQLDataSet.Create(nil);
  try
    ds.SQLConnection := AConnection;
    ds.CommandType := ctQuery;
    ds.CommandText := Format('select * from %s where 0=1', [ATableName]);
    ds.Open;
    for Fld in ds.Fields do
      if (LowerCase(RightStr(Fld.FieldName,2)) = 'id') and
        (Fld.DataType in [ftSmallint, ftInteger, ftWord, ftLargeint, ftAutoInc,
          ftShortInt, ftLongWord]) then
      begin
        Result := Fld.FieldName;
        break;
      end;
  finally
    ds.Free;
  end;
end;

constructor TDBXMigratorSchema.Create(const AConnection: TDBXConnection;
  const ACountRows: boolean = True);
begin
  inherited Create;
  FCountRows := ACountRows;
  FAllowAutoInc := True;
  SetConnection(AConnection);
end;

procedure TDBXMigratorSchema.DefineProcedureSchema(const ADef: TFieldDef);
begin
  ADef.Name := SPumpProcedures;
  ADef.DataType := ftDataSet;
  ADef.ChildDefs.Add(SPumpSelected, ftBoolean);
  ADef.ChildDefs.Add(SPumpProcName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpDestName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpProcType, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpParamCount, ftInteger);
  ADef.ChildDefs.Add(SPumpSourceCode, ftWideMemo);
  ADef.ChildDefs.Add(SPumpCatalogName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpSchemaName, ftWideString, DBXIdentifierLen);
  SetProcCalcs(ADef);
  DefineProcParamSchema(ADef.ChildDefs.AddFieldDef);
end;

procedure TDBXMigratorSchema.DefineTableSchema(const ADef: TFieldDef);
begin
  ADef.Name := SPumpTables;
  ADef.DataType := ftDataSet;
  ADef.ChildDefs.Add(SPumpSelected, ftBoolean);
  ADef.ChildDefs.Add(SPumpTableName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpDestName, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpRowCount, ftLargeint);
  ADef.ChildDefs.Add(SPumpRowSize, ftLargeint);
  SetTableCalcs(ADef);
  // ADef.ChildDefs.Add(SPumpTableSize, ftLargeint);
  ADef.ChildDefs.Add(SPumpStarted, ftDateTime);
  ADef.ChildDefs.Add(SPumpStopped, ftDateTime);
  ADef.ChildDefs.Add(SPumpRowsPerSec, ftFloat);
  ADef.ChildDefs.Add(SPumpTotalTime, ftLargeint);
  ADef.ChildDefs.Add(SPumpTableType, ftWideString, DBXIdentifierLen, True);
  ADef.ChildDefs.Add(SPumpColCount, ftInteger);
  DefineColumnSchema(ADef.ChildDefs.AddFieldDef);
  ADef.ChildDefs.Add(SPumpIndexCount, ftInteger);
  DefineIndexSchema(ADef.ChildDefs.AddFieldDef);
  ADef.ChildDefs.Add(SPumpCatalogName, ftWideString, DBXIdentifierLen);
  ADef.ChildDefs.Add(SPumpSchemaName, ftWideString, DBXIdentifierLen);
  // AddFieldDefAttributes(ADef.ChildDefs, [faReadOnly ], SPumpDestName);
end;

class procedure TDBXMigratorSchema.TableCalcs(DataSet: TDataSet);
begin
  { TODO :
    Do we have asLargeInt,
    or an overload for .asInteger that returns a largeint? }
  DataSet.FieldByName(SPumpTableSize).Value := DataSet.FieldByName
    (SPumpRowCount).Value * DataSet.FieldByName(SPumpRowSize).Value;
end;

class function TDBXMigratorSchema.TableName(ATableSchema: TDataSet): string;
begin
  Result := ATableSchema.FieldByName(SPumpDestName).asString;
end;

function TDBXMigratorSchema.CreateSchema: TDataSet;
begin
  Result := TClientDataSet.Create(nil);
  Result.FieldDefs.Add(SPumpTableCount, ftLargeint);
  DefineTableSchema(Result.FieldDefs.AddFieldDef);
  Result.FieldDefs.Add(SPumpProcCount, ftLargeint);
  DefineProcedureSchema(Result.FieldDefs.AddFieldDef);
  Result.FieldDefs.Add(SPumpDefaultCount, ftLargeint);
  SetDefaultDef(Result.FieldDefs.AddFieldDef);
  Result.FieldDefs.Add(SPumpViewCount, ftLargeint);
  // SetViewDef(Result.FieldDefs.AddFieldDef);
  Result.FieldDefs.Add(SPumpUserCount, ftLargeint);
  // SetUserDef(Result.FieldDefs.AddFieldDef);
  (Result as TClientDataSet).CreateDataSet;
  (Result as TClientDataSet).LogChanges := False;
  SetDisplayWidths(Result.Fields);
end;

destructor TDBXMigratorSchema.Destroy;
begin
  FreeAndNil(FProvider);
  inherited;
end;

procedure TDBXMigratorSchema.DoOnLogMessage(AMessage: string);
begin
  if Assigned(FOnLogMessage) then
    FOnLogMessage(Self, AMessage);
  DebugString(AMessage);
end;

procedure TDBXMigratorSchema.AddFieldDefAttributes(const ADef: TFieldDefs;
  const Attributes: TFieldAttributes; Exclude1: string = '';
  Exclude2: string = ''; Exclude3: string = ''; Exclude4: string = '');
var
  def: TFieldDef;
  i: Integer;
begin
  for i := 0 to ADef.Count - 1 do
  begin
    def := ADef[i];
    if (def.Name <> Exclude1) and (def.Name <> Exclude2) and
      (def.Name <> Exclude3) and (def.Name <> Exclude4) then
      def.Attributes := def.Attributes + Attributes;
  end;
end;

procedure TDBXMigratorSchema.SetTableCalcs(const ADef: TFieldDef);
var
  SizeCalc: TFieldDef;
begin
  { TODO : Make DataSize a calcfield based on RowCount * RowSize
    Also make EstimatedCompletion and Percentage calc fields.
    Rows per sec can also be a calc field. May need Start and Stop ticks,
    which could be hidden by default from display grid. }
  SizeCalc := ADef.ChildDefs.AddFieldDef;
  SizeCalc.Name := SPumpTableSize;
  SizeCalc.DataType := ftLargeint;
  SizeCalc.InternalCalcField := True;
end;

function TDBXMigratorSchema.GetProvider: TDBXMetaDataProvider;
begin
  if not Assigned(FProvider) then
  begin
    if Assigned(FConnection) then
      FProvider := DBXGetMetaProvider(FConnection)
    else
      Raise EDBXMigrator.CreateFmt(
        '%s requires a valid connection to retrieve the metadata provider',
        [Self.ClassName]);
  end;
  Result := FProvider;
end;

function TDBXMigratorSchema.QuoteIdentifier(AIdentifier: String): String;
begin
  Result := FProvider.QuoteIdentifierIfNeeded(AIdentifier);
end;

function TDBXMigratorSchema.GetSchema: TDataSet;
var
  Tables: TDBXTablesTableStorage;
  TableSet: TDataSet;
  Procedures: TDBXProceduresTableStorage;
begin
  Result := CreateSchema;
  // (Result as TClientDataSet).SaveToFile('d:\schema.xml', dfXMLUTF8);
  FSchema := Result;
  FDefaultSchema := GetNestedDataSet(FSchema.FieldByName(SPumpDefaults));
  try
    Result.Insert;
    Procedures := DBXGetProcedures(Provider);
    try
      Result.FieldByName(SPumpProcCount).Value := LoadProcedureSchema
        (GetNestedDataSet(Result.FieldByName(SPumpProcedures)), Procedures);
    finally
      FreeAndNil(Procedures);
    end;
    Tables := DBXGetTables(Provider);
    // Tables := Provider.ToMemoryStorage(
    // Provider.GetCollection(TDBXMetaDataCommands.GetTables) as TDBXDelegateTable);
    try
      TableSet := GetNestedDataSet(Result.FieldByName(SPumpTables));
      TableSet.OnCalcFields := TableCalcs;
      Result.FieldByName(SPumpTableCount).Value := LoadTableSchema
        (TableSet, Tables);
    finally
      FreeAndNil(Tables);
    end;

    if Result.State in dsEditModes then
      Result.Post;
    FSchema := nil;
    FDefaultSchema := nil;
  except
    FreeAndNil(Result);
    FSchema := nil;
    FDefaultSchema := nil;
    Raise ;
  end;
end;

{ TDBXMigrator }
constructor TDBXMigrator.Create;
begin
  inherited;
  FMaxRows := $7FFFFFFFFFFFFFFF; // Default to max allowed rows
  FTransRows := 100000; // Default # of rows to copy per transaction
  FNormalizeIdentifiers := True;
  FOnlyRead := False;
end;

constructor TDBXMigrator.Create(const ASource: string;
  ADestination: string = ''; ACountRows: boolean = True);
begin
  Create;
  FCountRows := ACountRows;
  Source := ASource;
  Destination := ADestination;
end;

constructor TDBXMigrator.Create(const ASourceConnection: TDBXConnection;
  ADestConnection: TDBXConnection = nil; ACountRows: boolean = True);
begin
  Create;
  FCountRows := ACountRows;
  SourceConnection := ASourceConnection;
  if Assigned(ADestConnection) then
    DestConnection := ADestConnection;
end;

function TDBXMigrator.QuoteIdentifier(AIdentifier: String): String;
begin
  Result := SourceProvider.QuoteIdentifierIfNeeded(AIdentifier);
end;

// This function handles moving all the tables/indexes etc. from the source connection
// to the destination connection.
procedure TDBXMigrator.Migrate(ASourceConnection: TDBXConnection = nil;
  ADestConnection: TDBXConnection = nil);
var
  Tables: TDBXTablesTableStorage;

begin
  // Store the connections for later use when moving the table data.
  FCancel := False;
  if Assigned(ASourceConnection) then
    SourceConnection := ASourceConnection;
  if Assigned(ADestConnection) then
    DestConnection := ADestConnection;

  // Call the OnMigrationStarted event.
  DoOnMigrationStarted;

  // Get the source metadata provider.
  FTableCount := DBXGetTableCount(SourceProvider);

  Tables := DBXGetTables(SourceProvider);
  try
    // Migrate all the tables in the collection to the destination provider.
    MigrateTables(Tables, DestProvider);

  finally
    FreeAndNil(Tables);

  end;

  // Call the OnMigrationCompleted event.
  DoOnMigrationStopped;

end;

procedure TDBXMigrator.MigrateTable(ATableSchema: TDataSet;
  ADestProvider: TDBXMetaDataProvider);
var
  SourceTable, DestTable: UnicodeString;
  ColumnMeta : TDBXColumnsTableStorage;
  TableMeta: TDBXMetaDataTable;
  // Indexes:    TDataSet;
  Indexes: TDataSet;
  RowCount: Int64;
  exists: boolean;
begin

  RowCount := ATableSchema.FieldByName(SPumpRowCount).asInteger;
  SourceTable := ATableSchema.FieldByName(SPumpTableName).AsWideString;
  DestTable := ATableSchema.FieldByName(SPumpDestName).AsWideString;
  DoOnTableMigrationStarted(SourceTable, FTableIndex, FTableCount, FCancel);

  if not FCancel then
  begin

    if Assigned(ADestProvider) then
      DestProvider := ADestProvider;

//    DebugString(Format(StrMigratingTable, [SourceTable, DestTable]));

    exists := DBXTableExists(DestProvider, DestTable);
    if exists and (not FSkipCreateTable) then
    begin
      // Drop the table if it exists, first.
//      DebugString(Format(StrDroppingTable, [DestTable]));
      DropTable(DestProvider, DestTable);
      exists := False;
    end;

    if not exists then
    begin
      // We need to create this table in the destination provider.
      TableMeta := CreateTableMetaData(ATableSchema, DestTable);
      try
//        DebugString(Format(StrCreatingTable, [DestTable]));
        DestProvider.CreateTable(TableMeta);
      finally
        FreeAndNil(TableMeta);
      end;
    end
    else
    begin
      ColumnMeta := nil;
      try
        // load type overrides
        // TODO: extract this into a separate routine?
        ColumnMeta := ColumnSchemaToMetaData(
        TDBXMigratorSchema.ColumnSchema(ATableSchema), DestTable);
      finally
        FreeAndNil(ColumnMeta);
      end;
    end;


    // Now we copy the data from the source table to the destination table.
    if not FCancel then
        CopyTableData(ATableSchema, RowCount);

    if (not exists) or (not FSkipCreateTable) then
    begin
      if not FCancel then
        DoOnIndexingStarted(SourceTable, FTableIndex, FTableCount, FCancel);

      if not FCancel then
      begin
        // Migrate the table indexes.
        Indexes := GetNestedDataSet(ATableSchema.FieldByName(SPumpIndexes));
        try
          MigrateIndexesFromSchema(Indexes);
        finally
          FreeAndNil(Indexes);
        end;
        DoOnIndexingStopped(SourceTable, FTableIndex, FTableCount, FCancel);
      end;
    end;
  end;

  // Call the OnTableMigrationCompleted event.
  DoOnTableMigrationStopped(SourceTable, FTableIndex, FTableCount, FCancel);

end;

procedure TDBXMigrator.MigrateTables(ATables: TDBXTablesTableStorage;
  ADestProvider: TDBXMetaDataProvider = nil);
begin
  FTableIndex := 0;
  if Assigned(ADestProvider) then
    DestProvider := ADestProvider;

  // For each table in the collection, migrate it to the destination provider.
  while (not FCancel) and ATables.InBounds do
  begin
    // We only want user tables, no system tables, so we exclude anything but
    // user tables.
    if (ATables.TableType = TDBXTableType.Table) then
      MigrateTable(ATables.TableName, DestProvider);
    Inc(FTableIndex);
    ATables.Next;
  end;

end;

procedure TDBXMigrator.MissingProperty(const AProp1: string;
  AProp2: string = ''; AProp3: string = '');
begin
  if Length(AProp3) > 0 then
    Raise EDBXMigrator.CreateFmt(
      '%s: Property "%s", "%s", or "%s" must be assigned',
      [Self.ClassName, AProp1, AProp2, AProp3])
  else if Length(AProp2) > 0 then
    Raise EDBXMigrator.CreateFmt(
      '%s: Either property "%s" or "%s" must be assigned',
      [Self.ClassName, AProp1, AProp2])
  else
    Raise EDBXMigrator.CreateFmt('%s: Property "%s" must be assigned',
      [Self.ClassName, AProp1])
end;

class function TDBXMigrator.ProcedureScript(AVendor: string; AProcSchema: TDataSet): string;
const
  NL = #13#10;
  StrIBProcDeclaration =
    '/* Migrating %3:s "%0:s" */'
//    + NL + 'SET AUTODDL OFF;'
    + NL + 'CREATE %3:s "%0:s"'
    + NL + '%1:s'
    + NL + 'AS'
    + NL + 'BEGIN'
    + NL + '/* Source code migrated by DbxDataPump '
    + NL + '%2:s'
    + NL + '*/'
    + NL + '  EXIT; '
    + NL + 'END;'
//    + NL + 'SET AUTODDL ON;'
    ;
var
  FldParam,
  FldMode,
  FldDestPrecision,
  FldTypeName,
  FldDestType : TField;
  Mode,
  ParamList,
  InParams,
  OutParams: string;
  Params: TDataSet;
  Mark: TBookmark;
  IsIn,
  IsOut : boolean;

  procedure AddParam(var AList: string; AName, AType: string; APrecision: integer);
  begin
    if APrecision = -1 then
      APrecision := 128;
    AType := UpperCase(AType);
    if (Pos('VARCHAR', AType) = 1)
      or (Pos('CHAR',AType) = 1)
      or (Pos('BIT', AType) = 1)
      or (Pos('NVARCHAR', AType) = 1)
      or (Pos('BYTE', AType) = 1)
      or (Pos('NUMERIC', AType) = 1)
      or (Pos('DECIMAL', AType) = 1)
      or (Pos('NUMBER', AType) = 1)
      then
      AList := AList + Format('  "%s" %s(%d),' + NL, [AName, AType, APrecision])
    else
      AList := AList + Format('  "%s" %s,' + NL, [AName, AType]);

  end;

  function Fixup(const AList: string): string;
  begin
    Result := AList;
    if Length(Result) > 3 then
    begin
      SetLength(Result, Length(Result) - 3);
      Result := '(' + NL + Result + NL + ')';
    end;
  end;

begin
  Params := GetNestedDataSet(AProcSchema.FieldByName(SPumpProcParams));
  InParams := '';
  OutParams := '';
  Params.DisableControls;
  Mark := Params.Bookmark;
  try
    Params.First;
    FldParam := Params.FieldByName(SPumpDestName);
    FldMode := Params.FieldByName(SPumpParameterMode);
    FldTypeName := Params.FieldByName(SPumpTypeName);
    FldDestType := Params.FieldByName(SPumpDestType);
    FldDestPrecision := Params.FieldByName(SPumpDestPrecision);
    while not Params.Eof do
    begin
      TypeMatchOverride(AVendor, FldTypeName.asString,
        FldDestType, Params.FieldByName(SPumpPrecision), FldDestPrecision, nil, nil);
      Mode := UpperCase(FldMode.AsString);
      IsIn := (Mode = 'IN') or (Mode = 'INOUT');
      IsOut := (Mode = 'OUT') or (Mode = 'INOUT') or (Mode = 'RETURN');
      if IsIn then
        AddParam(InParams, FldParam.AsString, FldDestType.AsString,
          FldDestPrecision.AsInteger);
      if IsOut then
        AddParam(OutParams, FldParam.AsString, FldDestType.AsString,
          FldDestPrecision.AsInteger);
      Params.Next;
    end;
    InParams := Fixup(InParams);
    if Length(OutParams) > 0 then
      ParamList := InParams + NL + 'RETURNS' + NL + Fixup(OutParams)
    else
      ParamList := InParams;
    Result := Format(StrIBProcDeclaration, [
      AProcSchema.FieldByName(SPumpProcName).AsString,
      ParamList,
      AProcSchema.FieldByName(SPumpSourceCode).AsString,
      AProcSchema.FieldByName(SPumpProcType).AsString
      ]);
  finally
    Params.Bookmark := Mark;
    Params.EnableControls;
  end;
end;

procedure TDBXMigrator.SetChunkCopy(const Value: boolean);
begin
  FChunkCopy := Value;
  if FChunkCopy then
  begin
    FOnlyRead := False;
    FOnlyNew := False;
  end;
end;

procedure TDBXMigrator.SetDestConnection(const Value: TDBXConnection);
begin
  if FDestConnection <> Value then
  begin
    AutoFree(FManageDestCxn, FDestConnection);
    AutoFree(FManageDestProvider, FDestProvider);
    AutoFree(True, FDestSQLConnection);
  end;
  FManageDestCxn := False;
  FDestConnection := Value;
  if Assigned(FDestConnection) then
  begin
    FDestination := DBXGetConnectionName(FDestConnection);
    SetDestSQLConnection;
  end;
end;

procedure TDBXMigrator.SetDestination(const Value: string);
begin
  if Value <> FDestination then
  begin
    if Assigned(FDestConnection) and (DBXGetConnectionName(FDestConnection)
        <> Value) then
    begin
      AutoFree(FManageDestCxn, FDestConnection);
      AutoFree(FManageDestProvider, FDestProvider);
      AutoFree(True, FDestSQLConnection);
      FreeStringObjects(FDestTypes);
    end;
    FDestination := Value;
  end;
end;

procedure TDBXMigrator.SetDestProvider(const Value: TDBXMetaDataProvider);
begin
  if Value <> FDestProvider then
    AutoFree(FManageDestProvider, FDestProvider);
  FDestProvider := Value;
  FManageDestProvider := False;
end;

procedure TDBXMigrator.SetSource(const Value: string);
begin
  if Value <> FSource then
  begin
    if Assigned(FSourceConnection) and (DBXGetConnectionName(FSourceConnection)
        <> Value) then
    begin
      AutoFree(FManageSourceCxn, FSourceConnection);
      AutoFree(FManageSourceProvider, FSourceProvider);
    end;
    FSource := Value;
  end;
end;

procedure TDBXMigrator.SetSourceConnection(const Value: TDBXConnection);
begin
  if FSourceConnection <> Value then
  begin
    AutoFree(FManageSourceCxn, FSourceConnection);
    AutoFree(FManageSourceProvider, FSourceProvider);
  end;
  FManageSourceCxn := False;
  FSourceConnection := Value;
  if Assigned(FSourceConnection) then
    FSource := DBXGetConnectionName(FSourceConnection);
end;

procedure TDBXMigrator.SetSourceProvider(const Value: TDBXMetaDataProvider);
begin
  if Value <> FSourceProvider then
    AutoFree(FManageSourceProvider, FSourceProvider);
  FSourceProvider := Value;
  FManageSourceProvider := False;
end;

procedure TDBXMigrator.SetWipeTable(const Value: boolean);
begin
  FWipeTable := Value;
  if FWipeTable then
    FOnlyNew := False;
end;

function TDBXMigrator.SourceTypeFromName(AName: string): TDBXType;
begin
  Result := DBXGetTypeFromName(SourceTypes, AName);
end;

procedure TDBXMigrator.MigrateTable(ATableName: string;
  ADestProvider: TDBXMetaDataProvider);
var
  TableName: String;
  TableMeta: TDBXMetaDataTable;
  Columns: TDBXColumnsTableStorage;
  Indexes: TDBXIndexesTableStorage;
  RowCount: Int64;
  exists: boolean;
begin

  if FCountRows then
  begin
    DoOnRowCountStarted(ATableName, FTableIndex, FTableCount, FCancel);
    RowCount := DBXGetRowCount(SourceConnection, ATableName);
    DoOnRowCountStopped(ATableName, FTableIndex, FTableCount, FCancel);
  end
  else
    RowCount := -1;

  DoOnTableMigrationStarted(ATableName, FTableIndex, FTableCount, FCancel);

  if not FCancel then
  begin

    if Assigned(ADestProvider) then
      DestProvider := ADestProvider;

    TableName := { TransformIdentifier } (ATableName);
//    DebugString(Format(StrMigratingTable, [ATableName, TableName]));

    // First we need to create this table in the destination provider.
    // Drop the table if it exists, first.
    exists := DBXTableExists(DestProvider, TableName);
    if exists and (not FSkipCreateTable) then
    begin
//      DebugString(Format(StrDroppingTable, [TableName]));
      DropTable(DestProvider, TableName);
      exists := False;
    end;

    if not exists then
    begin
      // Now we start building the new metadata for the table.
      TableMeta := TDBXMetaDataTable.Create;
      try
        // Set the table name for the new table.
        TableMeta.TableName := TableName;

        // Now we migrate the columns over.
        // First we get a collection of all the columns in the table,
        // then create the metadata for each column.
        Columns := DBXGetColumns(SourceProvider, ATableName);
        try
          Assert(CreateColumnsMetaData(Columns, TableMeta, ATableName) > 0,
            'No columns were retrieved for ' + ATableName);

        finally
          FreeAndNil(Columns);

        end;

        // Now we create the table.
//        DebugString(Format(StrCreatingTable, [TableName]));
        DestProvider.CreateTable(TableMeta);

      finally
        FreeAndNil(TableMeta);
      end;
    end;

    // Now we copy the data from the source table to the destination table.
    if not FCancel then
        CopyTableData(ATableName, RowCount);

    if not FCancel then
      DoOnIndexingStarted(ATableName, FTableIndex, FTableCount, FCancel);

    if not FCancel then
    begin
      // Migrate the table indexes.
      Indexes := DBXGetIndexes(SourceProvider, ATableName);
      try
        MigrateIndexes(Indexes);
      finally
        FreeAndNil(Indexes);
      end;
      DoOnIndexingStopped(ATableName, FTableIndex, FTableCount, FCancel);
    end;
  end;

  // Call the OnTableMigrationCompleted event.
  DoOnTableMigrationStopped(ATableName, FTableIndex, FTableCount, FCancel);

end;

procedure TDBXMigrator.MigrateIndexesFromSchema(AIndexes: TDataSet);
var
  FldSelected: TField;
begin
  try
    AIndexes.DisableControls;
    AIndexes.First;
    FldSelected := AIndexes.FieldByName(SPumpSelected);
    while not AIndexes.Eof do
    begin
      if FldSelected.AsBoolean then
        MigrateIndexFromSchema(AIndexes);
      AIndexes.Next;
    end;
  finally
    AIndexes.EnableControls;
  end;
end;

procedure TDBXMigrator.MigrateIndexFromSchema(AIndex: TDataSet);
var
  IndexColumns: TDataSet;
  IndexMeta: TDBXMetaDataIndex;
  FldColName,
  FldSelected,
  FldAscending: TField;
  IndexType: string;
begin
  // First we create the index metadata.
  IndexMeta := TDBXMetaDataIndex.Create;

  // Then we initialize various index properties.
  IndexMeta.TableName := AIndex.FieldByName(SPumpTableName).AsString;
  IndexMeta.IndexName := AIndex.FieldByName(SPumpDestName).AsString;
  IndexMeta.Unique := AIndex.FieldByName(SPumpUnique).AsBoolean;
  IndexColumns := GetNestedDataSet(AIndex.FieldByName(SPumpIndexCols));

  try
    IndexColumns.DisableControls;
    IndexColumns.First;
    FldColName := IndexColumns.FieldByName(SPumpColumnName);
    FldAscending := IndexColumns.FieldByName(SPumpAscending);
    FldSelected := IndexColumns.FieldByName(SPumpSelected);
    while not IndexColumns.EOF do
    begin
      if FldSelected.AsBoolean then
        IndexMeta.AddColumn(FldColName.AsString, FldAscending.AsBoolean);
      IndexColumns.Next;
    end;

  finally
    IndexColumns.EnableControls;
  end;

  try
    // Finally, we add the index to the table.
    if IndexMeta.Unique then
    begin
      IndexType := 'Unique';
      DestProvider.CreateUniqueIndex(IndexMeta);
    end
    else if AIndex.FieldByName(SPumpPrimary).AsBoolean then
    begin
      IndexType := 'PrimaryKey';
      DestProvider.CreatePrimaryKey(IndexMeta);
    end
    else
    begin
      IndexType := 'Standard';
      DestProvider.CreateIndex(IndexMeta);
    end;
  except
    on E: Exception do
    begin
      LogMessage(Format('Error creating %s index %s.%s:%s. Contents: %s',
        [ IndexType, IndexMeta.TableName, IndexMeta.IndexName, E.Message,
          RecordToText(AIndex) ]));
    end;
  end;

end;

procedure TDBXMigrator.MigrateProcedure(AProcSchema: TDataSet;
  ADestProvider: TDBXMetaDataProvider);
var
  SourceProc, DestProc: UnicodeString;
  script: string;
  ScriptField: TField;
begin

  SourceProc := AProcSchema.FieldByName(SPumpProcName).AsWideString;
  DestProc := AProcSchema.FieldByName(SPumpDestName).AsWideString;
  ScriptField := AProcSchema.FieldByName(SPumpProcScript);

  if not FCancel then
  begin
    Script := ScriptField.AsString;
    if Length(Trim(Script)) = 0 then
    begin
      Script := ProcedureScript(DestConnection.ProductName, AProcSchema);
      if Length(Trim(Script)) = 0 then
        exit // No script to run
      else
      begin
        AProcSchema.Edit;
        ScriptField.Value := Script;
        AProcSchema.Post;
      end;
    end;

    if Assigned(ADestProvider) then
      DestProvider := ADestProvider;

    DebugString(Format(StrMigratingProcedure, [SourceProc, DestProc]));

    // Now we create the procedure
    DebugString(Format(StrCreatingProcedure, [DestProc, Script]));
    if DBXProcedureExists(DestProvider, DestProc) then
      DropProcedure(DestProc);
    DestSQLConnection.ExecuteDirect(Script);
  end;

end;

procedure TDBXMigrator.MigrateProceduresFromSchema(const ASchema: TDataSet);
var
  Mark: TBytes;
  Selected,
  Name: TField;
  Procs: TDataSet;
begin
  Procs := GetNestedDataSet(ASchema.FieldByName(SPumpProcedures));
  FProcCount := Procs.RecordCount;
  Mark := Procs.BookMark;
  Procs.DisableControls;
  try
    Selected := Procs.FieldByName(SPumpSelected);
    Name := Procs.FieldByName(SPumpDestName);
    Procs.First;
    FProcIndex := 0;
    while (not FCancel) and (not Procs.EOF) do
    begin
      if Selected.asBoolean then
        try
          DoOnProcMigrationStarted(Name.AsWideString, FProcIndex, FProcCount, FCancel);
          MigrateProcedure(Procs);
        finally
          DoOnProcMigrationStopped(Name.AsWideString, FProcIndex, FProcCount, FCancel);
        end;
      Inc(FProcIndex);
      Procs.Next;
    end;
  finally
    Procs.BookMark := Mark;
    Procs.EnableControls;
  end;
end;

// This function handles copying ALL the indexes from the source table to the destination table.
procedure TDBXMigrator.MigrateIndexes(Indexes: TDBXIndexesTableStorage);
begin
  // Loop through each index in the source table, migrating it to the destination table.
  while Indexes.InBounds do
  begin
    { TODO : Do notification events for each index? }
    MigrateIndex(Indexes);
    Indexes.Next;
  end;

end;

// This function handles migrating all tables to the destination without customized options.
procedure TDBXMigrator.Migrate(const ATables: TStringArray; ASourceConnection,
  ADestConnection: TDBXConnection);
var
  i: Integer;

begin
  // Store the connections for later use when moving the table data.
  FCancel := False;
  if Assigned(ASourceConnection) then
    SourceConnection := ASourceConnection;
  if Assigned(ADestConnection) then
    DestConnection := ADestConnection;

  // Call the OnMigrationStarted event.
  DoOnMigrationStarted;

  FTableCount := Length(ATables);

  for i := 0 to FTableCount - 1 do
  begin
    if FCancel then
      break;
    FTableIndex := i;
    MigrateTable(ATables[i]);
  end;

  // Call the OnMigrationStopped event.
  DoOnMigrationStopped;

end;

procedure TDBXMigrator.Migrate(const ASchema: TDataSet; ASourceConnection,
  ADestConnection: TDBXConnection);
begin
  // Store the connections for later use when moving the table data.
  FTableIndex := 0;
  FCancel := False;
  if Assigned(ASourceConnection) then
    SourceConnection := ASourceConnection;
  if Assigned(ADestConnection) then
    DestConnection := ADestConnection;

  // Call the OnMigrationStarted event.
  DoOnMigrationStarted;
  MigrateTablesFromSchema(ASchema);
  if MigrateProcs then
    MigrateProceduresFromSchema(ASchema);
  // Call the OnMigrationStopped event.
  DoOnMigrationStopped;
end;

procedure TDBXMigrator.DoOnError(const AError: Exception);
begin
  LogMessage(AError.Message);
  raise AError;
end;

function TDBXMigrator.OpenSQLConnection(AConnectionName: string): TSQLConnection;
begin
  Result := TSQLConnection.Create(nil);
  Result.ConnectionName := AConnectionName;
  Result.LoadParamsOnConnect := True;
  Result.LoginPrompt := False;
  Result.Open;
end;

procedure TDBXMigrator.SetDestSQLConnection;
begin
  FDestSQLConnection := OpenSQLConnection(FDestination);
end;

procedure TDBXMigrator.SetOnlyNew(const Value: boolean);
begin
  FOnlyNew := Value;
  if FOnlyNew then
  begin
    FOnlyRead := False;
    FChunkCopy := False;
    FWipeTable := False;
  end;
end;

procedure TDBXMigrator.SetOnlyRead(const Value: boolean);
begin
  FOnlyRead := Value;
end;

procedure TDBXMigrator.SetFillById(const Value: boolean);
begin
  FFillById := Value;
end;

procedure TDBXMigrator.MigrateTablesFromSchema(const ASchema: TDataSet);
var
  Mark: TBytes;
  Selected: TField;
  Tables: TDataSet;
begin
  { TODO : Update recordcount if it grows while migrating. }
  Tables := GetNestedDataSet(ASchema.FieldByName(SPumpTables));
  FTableCount := Tables.RecordCount;
  Mark := Tables.BookMark;
  Tables.DisableControls;
  try
    Selected := Tables.FieldByName(SPumpSelected);
    Tables.First;
    while (not FCancel) and (not Tables.EOF) do
    begin
      if Selected.asBoolean then
        MigrateTable(Tables);
      Inc(FTableIndex);
      Tables.Next;
    end;
  finally
    Tables.BookMark := Mark;
    Tables.EnableControls;
  end;
end;

procedure TDBXMigrator.MigrateIndex(Indexes: TDBXIndexesTableStorage);
var
  IndexColumns: TDBXIndexColumnsTableStorage;
  IndexMeta: TDBXMetaDataIndex;

begin
  // First we create the index metadata.
  IndexMeta := TDBXMetaDataIndex.Create;

  // Then we initialize various index properties.
  IndexMeta.TableName := Indexes.TableName;
  IndexMeta.IndexName := Indexes.IndexName;
  IndexMeta.Unique := Indexes.Unique;

  // Now we add the columns of the index to the metadata.
  IndexColumns := DBXGetIndexColumns(SourceProvider, Indexes.TableName,
    Indexes.IndexName);
  try
    while IndexColumns.InBounds do
    begin
      IndexMeta.AddColumn(IndexColumns.ColumnName, IndexColumns.Ascending);
      IndexColumns.Next;
    end;

  finally
    FreeAndNil(IndexColumns);

  end;

  // Finally, we add the index to the table.
  if Indexes.Unique then
    DestProvider.CreateUniqueIndex(IndexMeta)
  else if Indexes.Primary then
    DestProvider.CreatePrimaryKey(IndexMeta)
  else
    DestProvider.CreateIndex(IndexMeta);

end;

// This function handles dropping a table from a database.
procedure TDBXMigrator.DropTable(AProvider: TDBXMetaDataProvider;
  ATableName: String);
begin
  // Now we drop the table.
  if not AProvider.DropTable(ATableName) then
    raise EDBXMigrator.Create('Failed to drop table ' + ATableName);

end;

// This function creates column metadata for new tables from existing column metadata
function TDBXMigrator.CreateColumnsMetaData(AColumns: TDBXColumnsTableStorage;
  ATableMeta: TDBXMetaDataTable; DestTable: UnicodeString): Integer;
begin
  // For each column in the collection, create the new metadata for it, and add it to the
  // table metadata.
  Result := 0;
  AColumns.First;
  while AColumns.InBounds do
  begin
    Inc(Result);
    ATableMeta.AddColumn(CreateColumnMetaData(AColumns, DestTable));
    AColumns.Next;
  end;

end;

(*
function TDBXMigrator.CreateProcedureMetaData(AProcSchema: TDataSet;
  DestProc: UnicodeString): TDBXMetaDataTable;
//var
//  Columns: TDBXColumnsTableStorage;
begin
  Result := TDBXMetaDataTable.Create;
  Result.TableName := AProcSchema.FieldByName(SPumpDestName).AsWideString;
  { TODO : Implement this }
//  Columns := ColumnSchemaToMetaData
//    (TDBXMigratorSchema.ColumnSchema(AProcSchema), DestProc);
//  try
//    Assert(CreateColumnsMetaData(Columns, Result, DestProc) > 0,
//      'No columns were retrieved for ' + Result.TableName);
//  finally
//    FreeAndNil(Columns);
//  end;
end;
*)
function TDBXMigrator.CreateTableMetaData(ATableSchema: TDataSet;
  DestTable: UnicodeString): TDBXMetaDataTable;
var
  Columns: TDBXColumnsTableStorage;
begin
  Result := TDBXMetaDataTable.Create;
  Result.TableName := ATableSchema.FieldByName(SPumpDestName).AsWideString;
  Columns := ColumnSchemaToMetaData
    (TDBXMigratorSchema.ColumnSchema(ATableSchema), DestTable);
  try
    Assert(CreateColumnsMetaData(Columns, Result, DestTable) > 0,
      Format(StrNoColumnsRetrieved, [Result.TableName]));
  finally
    FreeAndNil(Columns);
  end;
end;

// This function creates a new column metadata for a column in the table.
function TDBXMigrator.CreateColumnMetaData(AColumn: TDBXColumnsTableStorage;
  DestTable: UnicodeString): TDBXMetaDataColumn;
var
  DecName, ColumnName: UnicodeString;
  Warning: UnicodeString;
  MetaWriter: TDBXBaseMetaDataWriterWithPublicReader;
  DefaultValue: string;

begin
  Result := nil;
  ColumnName := AColumn.ColumnName;

  // Map the DBX datatype to a column class.
  case AColumn.DbxDataType of
    TDBXDataTypes.AnsiStringType:
      begin
        if AColumn.FixedLength then
          Result := TDBXAnsiCharColumn.Create(ColumnName, AColumn.Precision)
        else
          Result := TDBXAnsiVarCharColumn.Create(ColumnName, AColumn.Precision);
      end;

    TDBXDataTypes.DateType:
      Result := TDBXDateColumn.Create(ColumnName);

    TDBXDataTypes.BlobType:
      Result := TDBXBinaryLongColumn.Create(ColumnName);

    TDBXDataTypes.BooleanType:
      Result := TDBXBooleanColumn.Create(ColumnName);

    TDBXDataTypes.Int16Type:
      Result := TDBXInt16Column.Create(ColumnName);

    TDBXDataTypes.Int32Type:
      Result := TDBXInt32Column.Create(ColumnName);

    TDBXDataTypes.DoubleType:
      Result := TDBXDoubleColumn.Create(ColumnName);

    TDBXDataTypes.BcdType:
      if AColumn.AutoIncrement then // Verify destination can handle bcd autoinc
      begin
        MetaWriter := DBXGetMetaWriter(DestProvider);
        DecName := MetaWriter.FindDecimalTypeName(AColumn, False);
        if DecName = NullString then // Change to Int64 for Autoinc
          Result := TDBXInt64Column.Create(ColumnName)
        else
          Result := TDBXDecimalColumn.Create(ColumnName, AColumn.Precision,
            AColumn.Scale);

      end
      else
        Result := TDBXDecimalColumn.Create(ColumnName, AColumn.Precision,
          AColumn.Scale);

    TDBXDataTypes.BytesType:
      Result := TDBXBinaryColumn.Create(ColumnName, AColumn.Precision);

    TDBXDataTypes.TimeType:
      Result := TDBXTimeColumn.Create(ColumnName);

    TDBXDataTypes.UInt16Type:
      Result := TDBXUInt16Column.Create(ColumnName);

    TDBXDataTypes.Uint32Type:
      Result := TDBXUInt32Column.Create(ColumnName);

    TDBXDataTypes.VarBytesType:
      Result := TDBXVarBinaryColumn.Create(ColumnName, AColumn.Precision);

    TDBXDataTypes.Int64Type:
      begin
        Result := TDBXInt64Column.Create(ColumnName);
        { TODO : Override precision with destination platform precision }
        Result.Precision := AColumn.Precision;
      end;

    TDBXDataTypes.Uint64Type:
      begin
        Result := TDBXUInt64Column.Create(ColumnName);
        { TODO : Override precision with destination platform precision }
        Result.Precision := AColumn.Precision;
      end;

    TDBXDataTypes.TimeStampType:
      Result := TDBXTimestampColumn.Create(ColumnName);

    TDBXDataTypes.WideStringType:
      begin
        if AColumn.FixedLength then
          Result := TDBXUnicodeCharColumn.Create(ColumnName, AColumn.Precision)
        else
          Result := TDBXUnicodeVarCharColumn.Create
            (ColumnName, AColumn.Precision);
      end;

    // Extended types.
    TDBXDataTypes.SingleType:
      Result := TDBXSingleColumn.Create(ColumnName);

    TDBXDataTypes.Int8Type:
      Result := TDBXInt8Column.Create(ColumnName);

    TDBXDataTypes.Uint8Type:
      Result := TDBXUInt8Column.Create(ColumnName);

  else
    DoOnError(EDBXMigrator.CreateFmt('Unknown column type %d: %s(%d)',
      [AColumn.DbxDataType, ColumnName, AColumn.Precision]));

  end;

  if Assigned(Result) then
  begin
    // We only want to set the default value if the default value has been set.
    // Copy type-independent field properties.
    Result.AutoIncrement := AColumn.AutoIncrement;
    Result.Long := AColumn.Long;
    Result.Nullable := AColumn.Nullable;

    if not AColumn.Value[TDBXColumnsIndex.DefaultValue].IsNull then
    begin
      DefaultValue := FixQuotes(AColumn.DefaultValue);
      if LooksLikeFunction(DefaultValue) then
      begin
        Warning := Format(StrDefaultValueWarning, [AColumn.ColumnName,
          AColumn.TableName, DefaultValue]);
        DoOnColumnWarning(AColumn.TableName, AColumn.ColumnName, Warning);
        DebugString(Warning);
      end
      else
        Result.DefaultValue := DefaultValue;
    end;
  end;
end;

function TDBXMigrator.BuildMigrationCommand(ATableName: string;
  AConnection: TDBXConnection; DestTypesReader: TDBXReader): TDBXCommand;
var
  QuoteChar,
  FieldList,
  CurrentName,
  ValueList: string;
  i: Integer;
  Parameter: TDBXParameter;
begin
  Result := AConnection.CreateCommand;
  QuoteChar := AConnection.DatabaseMetaData.QuoteChar;
  Result.CommandType := TDBXCommandTypes.DbxSQL;

  FieldList := '';
  ValueList := '';

  // Create the INSERT statement field and value lists, as well as
  // the query parameters.
  for i := 0 to DestTypesReader.ColumnCount - 1 do
  begin
    if i > 0 then
    begin
      FieldList := FieldList + ',';
      ValueList := ValueList + ',';
    end;

    CurrentName := DestTypesReader.ValueType[i].Name;
    FieldList := FieldList + TransformIdentifier(CurrentName, DestProvider);
    ValueList := ValueList + '?';

    // Create a parameter and copy the value type from the
    // destination table information.
    Parameter := GetParameterFromValueType
      (Result, DestTypesReader.ValueType[i], CurrentName);

    Result.Parameters.AddParameter(Parameter);
  end;

  // Assemble the INSERT statement.
  Result.Text := Format('INSERT INTO %s (%s) VALUES(%s)',
    // [ATableName, FieldList, ValueList]);
    [TransformIdentifier(ATableName, DestProvider), FieldList, ValueList]);

//  DebugString(Format(StrPreparingQuery, [Result.Text]));

end;

// This function copies the data from the source table to the destination table.
procedure TDBXMigrator.CopyTableData(ATableName: String; ARowCount: Int64);
var
  i: Integer;
  SourceCmd: TDBXCommand;
  SourceReader: TDBXReader;
  DestTypesCmd: TDBXCommand;
  DestTypesReader: TDBXReader;
  DestTransaction: TDBXTransaction;
  DestCmd: TDBXCommand;
  Parameter: TDBXParameter;
  SourceValue: TDBXValue;
  RowIndex: Int64;

begin
  // We copy the data using the following procedure:
  // Wipe the destination table if so requested
  // - Perform a SELECT * query on the source table so that we can iterate over all its records.
  // - Perform a SELECT * query on the destination table to retrieve the destination data types.
  // - Start a transaction on the destination table.
  // - Loop through each record in the source table, inserting it into the destination table
  // using parameterized queries, with the source and destination types mapped correctly.
  // - Commit the transaction on the destination table.
  SourceCmd := FSourceConnection.CreateCommand;
  if FWipeTable then
    ClearTable(ATableName);
  try

    // Open the source table.
    SourceCmd.CommandType := TDBXCommandTypes.DbxSQL;
    SourceCmd.Text := 'SELECT * FROM ' + ATableName;

    SourceReader := SourceCmd.ExecuteQuery;
    try
      // Get the destination data types. We issue a SELECT *, so that we can get
      // the ValueTypes array.
      DestTypesCmd := DestConnection.CreateCommand;
      try
        DestTypesCmd.CommandType := TDBXCommandTypes.DbxSQL;
        DestTypesCmd.Text := 'SELECT * FROM ' + ATableName;

        DestTypesReader := DestTypesCmd.ExecuteQuery;
        try
          // Basic check to see that the column counts are the same. They ought
          // to be as we've just created the destination table based on the
          // source table metadata.
          if SourceReader.ColumnCount <> DestTypesReader.ColumnCount then
            raise EDBXMigrator.CreateFmt(
              'Column count differs between the source (%d) ' +
                'and destination (%d) table.', [SourceReader.ColumnCount,
              DestTypesReader.ColumnCount]);

          // Start the destination transaction.
          if not FOnlyRead then
            DestTransaction := DestConnection.BeginTransaction;
          try
            // Now loop through the source records, inserting this via the
            // destination command we just created.
            RowIndex := 0;
            // Create a command to perform the INSERTs
            DestCmd := BuildMigrationCommand(ATableName, DestConnection,
              DestTypesReader);
            try
              while (RowIndex < FMaxRows) and (not FCancel)
                and SourceReader.Next do
              begin

                for i := 0 to SourceReader.ColumnCount - 1 do
                begin
                  // SourceFieldName := SourceReader.ValueType[I].Name;
                  // TargetFieldName := DestTypesReader.ValueType[I].Name;

                  SourceValue := SourceReader.Value[i];
                  Parameter := DestCmd.Parameters.Parameter[i];

                  // Check if the column value is null.
                  // if not IsSourceValueNull(SourceValue) then
                  if SourceValue.IsNull then
                    // The column value is null, so set the param value to null
                    Parameter.Value.SetNull
                  else
                  begin
                    // The column value is not null, so find the correct setter,
                    // and the set the parameter value to the value in the
                    // source column.
                    MapSourceTypeToDestType(ATableName, Parameter, SourceValue);
                  end;
                end;

                // Insert the new record into the destination table.
                // DebugString(Format(StrExecutingRowQuery, [RowIndex]));
                if not FOnlyRead then
                  DestCmd.ExecuteUpdate;

                Inc(RowIndex);
                if (FCountRows) and (RowIndex > ARowCount) then
                  // In case table has grown since migration started
                  ARowCount := RowIndex;

                // Call the OnRowCopied event.
                DoOnRowCopied(ATableName, RowIndex, ARowCount, FCancel);
                if (not FOnlyRead) and (RowIndex mod FTransRows = 0) then
                begin // New transaction
                  DestConnection.CommitFreeAndNil(DestTransaction);
                  DestTransaction := DestConnection.BeginTransaction;
                end;
              end;
            finally
              FreeAndNil(DestCmd);
            end;

          except
            // If an exception was raised while copying the data, rollback the
            // transaction.
            if not FOnlyRead then
              DestConnection.RollbackFreeAndNil(DestTransaction);
            raise ;

          end;

          // The copy process completed sucessfully, so commit the transaction.
          if not FOnlyRead then
            DestConnection.CommitFreeAndNil(DestTransaction);

        finally
          FreeAndNil(DestTypesReader);

        end;

      finally
        FreeAndNil(DestTypesCmd);

      end;

    finally
      FreeAndNil(SourceReader);

    end;

  finally
    FreeAndNil(SourceCmd);

  end;

end;

// This function takes care of mapping the source data in each column to the
// destination column data type.
procedure TDBXMigrator.MapSourceTypeToDestType(ATableName: string; Parameter: TDBXParameter;
  SourceValue: TDBXValue);
begin
  case Parameter.DataType of
    TDBXDataTypes.TimeStampType:
      Parameter.Value.SetTimeStamp(SourceValue.GetTimeStamp);

    TDBXDataTypes.BcdType:
      Parameter.Value.SetBcd(SourceValue.AsBcd);

    TDBXDataTypes.AnsiStringType:
      // if IsSourceMsSqlEmptyString(SourceValue) then
      // Parameter.Value.SetAnsiString('')
      // else
      begin
        //20120907 DC - Do we really want the implicit cast here?
        //if SourceValue.ValueType.DataType = TDBXDataTypes.WideStringType then
        //  Parameter.Value.SetAnsiString(SourceValue.GetWideString)
        //else
          Parameter.Value.SetAnsiString(SourceValue.GetAnsiString);
      end;

    TDBXDataTypes.BooleanType:
      Parameter.Value.SetBoolean(SourceValue.AsBoolean);

    TDBXDataTypes.DateType:
      Parameter.Value.SetDate(SourceValue.AsDate);

    TDBXDataTypes.TimeType:
      Parameter.Value.SetTime(SourceValue.AsTime);

    TDBXDataTypes.WideStringType:
      if IsSourceMsSqlEmptyString(SourceValue) then
        Parameter.Value.SetWideString('')
      else
      begin
        if SourceValue.ValueType.DataType = TDBXDataTypes.AnsiStringType then
          Parameter.Value.SetWideString(string(SourceValue.GetAnsiString))
        else
          Parameter.Value.SetWideString(SourceValue.GetWideString);
      end;

    TDBXDataTypes.Int8Type:
      Parameter.Value.SetInt8(SourceValue.AsInt8);

    TDBXDataTypes.Int16Type:
      Parameter.Value.SetInt16(SourceValue.AsInt16);

    TDBXDataTypes.Int32Type:
      Parameter.Value.SetInt32(SourceValue.AsInt32);

    TDBXDataTypes.Int64Type:
      Parameter.Value.SetInt64(SourceValue.AsInt64);
//      if SourceValue.ValueType.DataType = TDBXDataTypes.BcdType then
//        Parameter.Value.SetInt64(StrToInt64(BcdToStr(SourceValue.GetBcd)))
//      else
//        Parameter.Value.SetInt64(SourceValue.GetInt64);

    TDBXDataTypes.DoubleType:
      Parameter.Value.SetDouble(SourceValue.GetDouble);

    TDBXDataTypes.BlobType:
      CopyBlob(ATableName, Parameter, SourceValue);

  else
    raise EDBXMigrator.CreateFmt(
      'Destination table %s''s column %s data type %d doesn''t have setter.',
      [ATableName, Parameter.Name, Parameter.DataType]);

  end;
end;

class procedure TDBXMigrator.TypeMatchOverride(ADbPlatform, AType: string;
  FldDestType, FldPrecision, FldDestPrecision, FldLong: TField;
  AColumn: TDBXColumnsTableStorage);
var
  match: TDBXTypeMatch;
begin
  // check for destination type conversion overrides
  Assert(Length(AType) > 0, 'Type cannot be empty');
  match := DbxTypeConverter.FindMatch(ADbPlatform, AType);
  if Assigned(match) then
  begin
    // Update destination values for later use in schema as well
    FldDestType.DataSet.Edit;
    FldDestType.Value := match.TypeName;
    if Assigned(AColumn) then
      AColumn.TypeName := match.TypeName;
    if (match.Precision > 0) and (FldPrecision.Value = FldDestPrecision.Value) then
    begin
      if Assigned(AColumn) then
        AColumn.Precision := match.Precision;
      FldDestPrecision.Value := match.Precision;
    end;
    if (match.IsLong <> slSame) and (Assigned(FldLong)) then
    begin
      // override the value of "Long"
      FldLong.AsBoolean := match.IsLong = slTrue;
      if Assigned(AColumn) then
        AColumn.Long := FldLong.AsBoolean;
    end;
    FldDestType.DataSet.Post;
  end;
end;

// This function drops all indexes on a specified table.
{
procedure TDBXMigrator.DropAllIndexesOnTable(AProvider: TDBXMetaDataProvider;
  ATableName: String);
var
  Indexes: TDBXIndexesTableStorage;

begin
  // Retrieve all the indexs for the table.
  Indexes := DBXGetIndexes(AProvider, ATableName);
  try
    // Then loop through each index, dropping it.
    while Indexes.InBounds do
    begin
      if not AProvider.DropIndex(ATableName, Indexes.IndexName) then
        raise EDBXMigrator.CreateFmt
          (StrFailedToDropIndex, [Indexes.IndexName, ATableName]);
      Indexes.Next;
    end;

  finally
    FreeAndNil(Indexes);

  end;

end;
}
procedure TDBXMigrator.DropProcedure(AProcName: string);
begin
  // Now we drop the table.
  if DestSQLConnection.ExecuteDirect(Format('drop procedure "%s"', [AProcName])) < 0 then
    raise EDBXMigrator.Create('Failed to drop procedure ' + AProcName);
end;

// This function takes care of copying a blob type from the source value to the
// destination parameter.
function TDBXMigrator.BuildMigrationCommands(ATableSchema: TDataSet;
  ASourceConnection, ADestConnection: TDBXConnection;
  var ASourceCmd: TDBXCommand): TDBXCommand;
var
  SourceQuote, DestQuote, SourceFields, DestFields, TableName,
    ValueList: string;
  i: Integer;
  Parameter: TDBXParameter;
  Columns: TDataSet;
  FldSourceCol, FldDestCol, FldSelected: TField;
begin
  Result := ADestConnection.CreateCommand;
  ASourceCmd := ASourceConnection.CreateCommand;
  DestQuote := ADestConnection.DatabaseMetaData.QuoteChar;
  SourceQuote := ASourceConnection.DatabaseMetaData.QuoteChar;
  Result.CommandType := TDBXCommandTypes.DbxSQL;

  DestFields := '';
  ValueList := '';
  SourceFields := '';
  i := 0;
  Columns := TDBXMigratorSchema.ColumnSchema(ATableSchema);
  FldSelected := Columns.FieldByName(SPumpSelected);
  FldSourceCol := Columns.FieldByName(SPumpColumnName);
  FldDestCol := Columns.FieldByName(SPumpDestName);

  // Create the INSERT statement field and value lists, as well as
  // the query parameters.
  Columns.DisableControls;
  try
    Columns.First;
    while not Columns.EOF do
    begin
      if FldSelected.asBoolean then
      begin
        if i > 0 then
        begin
          DestFields := DestFields + ',';
          SourceFields := SourceFields + ',';
          ValueList := ValueList + ',';
        end;

        DestFields := DestFields + DestQuote + FldDestCol.Value + DestQuote;
        SourceFields := SourceFields + SourceQuote + FldSourceCol.Value +
          SourceQuote;
        ValueList := ValueList + '?';

        // Create a parameter and copy the value type from the
        // destination table information.
        Parameter := GetParameterFromColSchema(Result, Columns);

        Result.Parameters.AddParameter(Parameter);
      end;
      Inc(i);
      Columns.Next;
    end;
  finally
    Columns.EnableControls;
  end;

  // Assemble the INSERT statement.
  TableName := TransformIdentifier(TDBXMigratorSchema.TableName(ATableSchema), DestProvider);
  Result.Text := Format('INSERT INTO %s (%s) VALUES(%s)',
    [TableName, DestFields, ValueList]);

//  DebugString(Format(StrPreparingQuery, [Result.Text]));
  TableName := TransformIdentifier(TDBXMigratorSchema.TableName(ATableSchema), SourceProvider);
  ASourceCmd.Text := Format('SELECT %s FROM %s', [SourceFields, TableName]);

end;

procedure TDBXMigrator.ClearTable(ATableName: string);
var
  Cmd : TDBXCommand;
begin
  Cmd := DestConnection.CreateCommand;
  try
    Cmd.CommandType := TDBXCommandTypes.DbxSQL;
    Cmd.Text := Format('delete from %s', [ATableName]);
    Cmd.ExecuteUpdate;
  finally
    FreeAndNil(Cmd);
  end;
end;

function TDBXMigrator.ColumnSchemaToMetaData(AColSchema: TDataSet;
  DestTable: UnicodeString): TDBXColumnsTableStorage;
var
  // FldCatalogName,
  // FldSchemaName,
  // FldTableName,
  FldColumnName, FldTypeName, FldDestType,
  FldPrecision, FldDestPrecision, FldScale, FldColumnOrdinal,
  //FldSize,
  FldDefaultValue, FldNullable, FldAutoIncrement, FldMaxInline,
  FldFixedLength, FldUnicode, FldLong, FldUnsigned: TField;

begin
  FldColumnName := AColSchema.FieldByName(SPumpDestName);
  FldTypeName := AColSchema.FieldByName(SPumpTypeName);
  FldPrecision := AColSchema.FieldByName(SPumpPrecision);
  FldDestType := AColSchema.FieldByName(SPumpDestType);
  FldDestPrecision := AColSchema.FieldByName(SPumpDestPrecision);
  FldScale := AColSchema.FieldByName(SPumpDestScale);
  //FldSize := AColSchema.FieldByName(SPumpDestSize);
  FldColumnOrdinal := AColSchema.FieldByName(SPumpColOrdinal);
  FldDefaultValue := AColSchema.FieldByName(SPumpDefaultValue);
  FldNullable := AColSchema.FieldByName(SPumpNullable);
  FldAutoIncrement := AColSchema.FieldByName(SPumpAutoIncrement);
  FldMaxInline := AColSchema.FieldByName(SPumpMaxInline);
  // FldDbxDataType := AColSchema.FieldByName(SDestDbxType);
  FldFixedLength := AColSchema.FieldByName(SPumpFixedLength);
  FldUnicode := AColSchema.FieldByName(SPumpUnicode);
  FldLong := AColSchema.FieldByName(SPumpLong);
  FldUnsigned := AColSchema.FieldByName(SPumpUnsigned);
  Result := TDBXColumnsTableStorage.Create;
  AColSchema.DisableControls;
  try
    AColSchema.First;
    while not AColSchema.EOF do
    begin
      Result.Insert;
      // Result.CatalogName := FldCatalogName.Value;
      // Result.SchemaName := FldSchemaName.Value;
      // Result.TableName := FldTableName.Value;
      Result.ColumnName := FldColumnName.AsWideString;
      Result.Scale := FldScale.Value;
      Result.ColumnOrdinal := FldColumnOrdinal.Value;
      Result.DefaultValue := FldDefaultValue.AsWideString;
      Result.Nullable := FldNullable.Value;
      Result.AutoIncrement := FldAutoIncrement.Value;
      Result.MaxInline := FldMaxInline.Value;
      // Default type name and precision
      Result.TypeName := FldDestType.AsWideString;
      Result.Precision := FldDestPrecision.Value;
      Result.Long := FldLong.Value;
      if FldTypeName.AsWideString = FldDestType.AsWideString then
      begin
        TypeMatchOverride(DestConnection.ProductName, FldTypeName.AsWideString,
          FldDestType, FldPrecision, FldDestPrecision, FldLong, Result);
      end;
      Result.DbxDataType := DestTypeFromName(Result.TypeName);

      Result.FixedLength := FldFixedLength.Value;
      Result.Unicode := FldUnicode.Value;
      Result.Unsigned := FldUnsigned.Value;
      Result.TableName := DestTable;
      Result.Post;
      AColSchema.Next;
    end;
    Result.First;
  finally
    AColSchema.EnableControls;
  end;
end;

procedure TDBXMigrator.CopyBlob(ATableName: string; Parameter: TDBXParameter;
  SourceValue: TDBXValue);
const
  BufferSize = 262144;

var
  Buffer: TBytes;
  Len: Int64;
  SourceLength: Integer;
  TargetLength: Integer;
  Msg: string;

begin
  SourceLength := 0;
  TargetLength := 0;
  // First check what the blob sub-type is.
  // If it is a text-subtype, copy using the string getter/setter functions.
  if Parameter.SubType = TDBXDataTypes.MemoSubType then
  begin
    if IsSourceMsSqlEmptyString(SourceValue) then
    begin
      Parameter.Value.SetAnsiString('');
    end
    else
    begin
      // The destination type is a Ansi text blob, so we use the setter
      // SetAnsiString.
      // We check what the source data type is, and match accordingly.
      if (SourceValue.ValueType.DataType = TDBXDataTypes.WideStringType) or
        ((SourceValue.ValueType.DataType = TDBXDataTypes.BlobType) and
          (SourceValue.ValueType.SubType = TDBXDataTypes.WideMemoSubType)) then
      begin
        SourceLength := Length(SourceValue.GetWideString);
        //20120907 DC - Do we really want the implicit cast here?
        //SourceLength := Length(SourceValue.GetWideString);
        //Parameter.Value.SetAnsiString(SourceValue.GetWideString);
        SourceLength := Length(SourceValue.GetAnsiString);
        Parameter.Value.SetAnsiString(SourceValue.GetAnsiString);
      end
      else
      begin
        SourceLength := Length(SourceValue.GetAnsiString);
        Parameter.Value.SetAnsiString(SourceValue.GetAnsiString);
      end;
    end;
    TargetLength := Length(Parameter.Value.GetAnsiString);
  end
  else if Parameter.SubType = TDBXDataTypes.WideMemoSubType then
  begin
    if IsSourceMsSqlEmptyString(SourceValue) then
    begin
      Parameter.Value.SetAnsiString('');
    end
    else
    begin
      // The destination type is a Unicode text blob, so we use the setter
      // SetWideString.
      // We check what the source data type is, and match accordingly.
      if (SourceValue.ValueType.DataType = TDBXDataTypes.AnsiStringType) or
        ((SourceValue.ValueType.DataType = TDBXDataTypes.BlobType) and
          (SourceValue.ValueType.SubType = TDBXDataTypes.MemoSubType)) then
      begin
        SourceLength := Length(SourceValue.GetAnsiString);
        Parameter.Value.SetWideString(string(SourceValue.GetAnsiString));
      end
      else
      begin
        SourceLength := Length(SourceValue.GetWideString);
        Parameter.Value.SetWideString(SourceValue.GetWideString);
      end;
    end;
    TargetLength := Length(Parameter.Value.GetWideString);
  end
  else
  begin
    // The blob is a binary type, so copy using a binary method.
{$IFNDEF INCREMENTAL_BLOB}
    // Get the length of the blob. Dynalink drivers don't currently support
    // incremental read/write, so read the whole thing at once.
    Len := SourceValue.GetValueSize;
    if Len > 0 then
    begin
      SetLength(Buffer, Len + 1);
      Parameter.Value.SetDynamicBytes(0, Buffer, 0, Len);
      SourceLength := SourceValue.GetBytes(0, Buffer, 0, Len);
      TargetLength := SourceLength; // To avoid exception below in comparison
      if SourceLength <> Len then
      begin
        Msg := Format('Reading source blob for parameter "%s" may have failed. ' +
            'Requested %d bytes, got %d bytes',
            [Parameter.Name, Len, SourceLength]);
        if SourceLength > 0 then
        begin
          DoOnColumnWarning(ATableName, Parameter.Name, Msg);
          DebugString(Msg);
        end
        else
          Raise EDBXMigrator.Create(Msg);
      end;
    end
    else
      Parameter.Value.SetNull;
{$ELSE}
    // We use a 256KB buffer.
    SetLength(Buffer, BufferSize);

    // Now loop through the source value, copying the data to the destination
    // parameter.
    StartPos := 0;
    while True do
    begin
      Len := SourceValue.GetBytes(StartPos, Buffer, 0, BufferSize);
      if Len = 0 then
        break;

      Parameter.Value.SetDynamicBytes(StartPos, Buffer, 0, Len);

      { TODO : Support blob copying status event here, like rowcopy }
      Inc(StartPos, Len);
    end;
{$ENDIF}
  end;

  if SourceLength <> TargetLength then
  begin
    raise EDBXMigrator.Create(
      'Source and target fields have different lengths (' + IntToStr
        (SourceLength) + ' and ' + IntToStr(TargetLength) + ')');
  end;

end;

procedure TDBXMigrator.CopyTableData(ATableSchema: TDataSet; ARowCount: Int64);
var
  //ColSchema : TDataSet;
  IdFieldPos,
  ColCount,
  i: Integer;
  SourceCmd: TDBXCommand;
  IdReader,
  SourceReader: TDBXReader;
  DestTransaction: TDBXTransaction;
  IdCmd,
  DestCmd: TDBXCommand;
  Parameter: TDBXParameter;
  SourceValue: TDBXValue;
  MinId,
  MaxId,
  Id,
  LastId,
  NextId,
  ChunkStart,
  RowIndex: Int64;
  SelectId,
  DestIdField,
  DestTable,
  IdFieldName,
  RootSelect,
  TableName: string;

  function GetIdRange(AConnection: TSQLConnection; ATable, AIdName: string;
    var AMaxId: int64): int64;
  var
    ds: TSQLDataSet;
    MinId: int64;
  begin
    ds := TSQLDataSet.Create(nil);
    try
      ds.CommandText := Format('select min(%s) minid, max(%s) maxid from %s',
        [AIdName, AIdName, ATable]);
      ds.SQLConnection := AConnection;
      ds.Open;
      if ds.Eof then
      begin
        Result := -1;
        AMaxId := -1;
      end
      else
      begin
        MinId := ds.Fields[0].AsLargeInt;
        AMaxId := ds.Fields[1].AsLargeInt;
        if (MinId = 0) and (AMaxId = 0) then
        begin
          Result := -1;
          AMaxId := -1;
        end
        else
          Result := MinId;
      end;
    finally
      ds.Free;
    end;
  end;

begin
  if FMaxRows <= 0 then
    exit; // Just leave immediately

  // We copy the data using the following procedure:
  // - Wipe any existing data (or not) based on WipeData request
  // - Iterate through destination schema to create INSERT and params
  // - Start a transaction on the destination table.
  // - Loop through each record in the source table, inserting it into the
  // destination table using parameterized queries, with the source and
  // destination types mapped correctly.
  // - Commit the transaction on the destination table.

  TableName := TDBXMigratorSchema.TableName(ATableSchema);
  DestTable := ATableSchema.FieldByName(SPumpDestName).AsWideString;
  //ColSchema := TDBXMigratorSchema.ColumnSchema(ATableSchema);
  if FWipeTable then
    ClearTable(TableName);
  DestCmd := BuildMigrationCommands(ATableSchema, SourceConnection,
    DestConnection, SourceCmd);
  RootSelect := SourceCmd.Text;
  ChunkStart := 0;
  IdFieldName := '';
  IdFieldPos := -1;
  //MinId := -1;
  MaxId := -1;
  IdCmd := nil;

  if ChunkCopy then
  begin
    IdFieldName := TDBXMigratorSchema.FindIdField(ATableSchema, DestIdField);
    if Length(IdFieldName) > 0 then
    begin
      MinId := GetIdRange(SourceSQLConnection, TableName, IdFieldName, MaxId);
      ChunkStart := MinId;
    end;
  end
  else if OnlyNew then
  begin
    IdFieldName := TDBXMigratorSchema.FindIdField(ATableSchema, DestIdField);
    if Length(IdFieldName) = 0 then
    begin
      LogMessage( Format(
        'Skipping "Only New" copy for table %s because it has no ID field',
        [TableName]));
      exit;
    end;
    // Get last ID in destination table
    //MinId := GetIdRange(DestSQLConnection, DestTable, DestIdField, MaxId);
    SourceCmd.Text := RootSelect + Format(' where %s > %d',
      [QuoteIdentifier(IdFieldName), MaxId]);
    // IdFieldName := ''; // Remove "ChunkCopy" flag
  end
  else if FillById then
  begin
    IdFieldName := TDBXMigratorSchema.FindIdField(ATableSchema, DestIdField);
    if Length(IdFieldName) > 0 then
    begin
      SelectId := Format('select count(%s) from %s where %s=',
        [DestIdField, DestTable, DestIdField]);
      IdCmd := DestConnection.CreateCommand;
      DebugString(SelectId);
    end;
  end;

  RowIndex := 0;
  try
    if ChunkStart >= 0 then // Not chunk copy, or ChunkStart ID found
    begin
      repeat
        if ChunkCopy and (Length(IdFieldName) > 0) then
        begin // Set up chunked copy selection
          if Assigned(SourceCmd) then
          begin
            SourceCmd.Close;
            FreeAndNil(SourceCmd);
            SourceConnection.Close;
            FreeAndNil(FSourceConnection);
            SourceCmd := SourceConnection.CreateCommand;
          end;
          SourceCmd.Text := RootSelect
            + Format(' where %s >= %d and %s <= %d order by %s',
                [ QuoteIdentifier(IdFieldName),
                  ChunkStart,
                  QuoteIdentifier(IdFieldName),
                  ChunkStart + ChunkRows,
                  QuoteIdentifier(IdFieldName)
                ]);
          //DebugString(SourceCmd.Text);
        end;
        SourceReader := SourceCmd.ExecuteQuery;
        ColCount := SourceReader.ColumnCount - 1;
        if (Length(IdFieldName) > 0) and (IdFieldPos < 0) then
        begin
          IdFieldPos := SourceReader.GetOrdinal(IdFieldName);
          //LastId := -1;
        end;
        try
          // Start the destination transaction.
          if not FOnlyRead then
            DestTransaction := DestConnection.BeginTransaction;
          try
            NextId := 0;
            // Now loop through the source records, inserting via the
            // destination command we just created.
            try
              while (RowIndex < FMaxRows)
                and (not FCancel)
                and SourceReader.Next
//                and ((IdFieldPos < 0) or (CopyCount < ChunkRows))
              do
              begin

                Inc(RowIndex);
                if (FCountRows) and (RowIndex > ARowCount) then
                  // In case table has grown since migration started
                  ARowCount := RowIndex;

                if IdFieldPos >= 0 then
                begin
                  Id := SourceReader.Value[IdFieldPos].AsInt64;
//                  if FillById and (Id = LastId) then
//                  begin
//                    LogMessage(Format('Skipped copying duplicate %s=%d in table %s',
//                      [ IdFieldName, Id, TableName ]));
                  if FillById then
                  begin
                    IdCmd.Text := SelectId + IntToStr(Id);
                    IdReader := IdCmd.ExecuteQuery;
                    try
                      if (IdReader.Next) and (IdReader.Value[0].AsInt64 > 0) then
                      begin
                        // Call the OnRowCopied event to update UI counters
                        DoOnRowCopied(TableName, RowIndex, ARowCount, FCancel);
                        continue; // This Id already exists
                      end;
                    finally
                      FreeAndNil(IdReader);
                    end;
                  end;
                  //LastId := Id;
                  // set next id, may be last chunk record
                   NextId := Id + 1;
                end;

                for i := 0 to ColCount do
                begin
                  // SourceFieldName := SourceReader.ValueType[I].Name;
                  // TargetFieldName := DestTypesReader.ValueType[I].Name;
                  SourceValue := SourceReader.Value[i];
                  Parameter := DestCmd.Parameters.Parameter[i];

                  // Check if the column value is null.
                  // if not IsSourceValueNull(SourceValue) then
                  if SourceValue.IsNull then
                    // The column value is null, so set the param value to null
                    Parameter.Value.SetNull
                  else
                  begin
                    // The column value is not null, so find the correct setter,
                    // and the set the parameter value to the value in the
                    // source column.
                    MapSourceTypeToDestType(TableName, Parameter, SourceValue);
                  end;
                end;

                // Insert the new record into the destination table.
                // DebugString(Format(StrExecutingRowQuery, [RowIndex]));
                if not FOnlyRead then
                  DestCmd.ExecuteUpdate;

                // Call the OnRowCopied event.
                DoOnRowCopied(TableName, RowIndex, ARowCount, FCancel);
                if (not FOnlyRead) and (RowIndex mod FTransRows = 0) then
                begin // New transaction
                  DestConnection.CommitFreeAndNil(DestTransaction);
                  DestTransaction := DestConnection.BeginTransaction;
                end;
              end;

            except
              // If an exception was raised while copying the data, rollback the
              // transaction.
              if not FOnlyRead then
                DestConnection.RollbackFreeAndNil(DestTransaction);
              raise ;
            end;

            // The copy process completed sucessfully, so commit the transaction.
            if not FOnlyRead then
              DestConnection.CommitFreeAndNil(DestTransaction);
          finally
            if not FOnlyRead then
              FreeAndNil(DestTransaction);
          end;
        finally
          FreeAndNil(SourceReader);

        end;
        if (ChunkCopy and (IdFieldPos >= 0)) then
        begin
          if NextId = 0 then // this range may have had no results
            ChunkStart := ChunkStart + ChunkRows + 1
          else
            ChunkStart := NextId;
          DebugString(Format('ChunkStart:%d NextId:%d MaxId:%d ChunkRows:%d',
            [ChunkStart, NextId, MaxId, ChunkRows]));
        end;

      until (IdFieldPos < 0)
        or FillById
        // ((IdFieldPos < 0) and (CopyCount = 0))
        or ((ChunkCopy) and (IdFieldPos >= 0) and (ChunkStart > MaxId));
    end;

  finally
    FreeAndNil(SourceCmd);
    FreeAndNil(DestCmd);

  end;

end;

function TDBXMigrator.GetDestConnection: TDBXConnection;
begin
  if not Assigned(FDestConnection) then
  begin
    if Length(FDestination) = 0 then
      MissingProperty(SPumpDestination, SPumpDestConnection);
    SetDestSQLConnection;
    FDestConnection := FDestSQLConnection.DBXConnection;
//    FDestConnection := TDBXConnectionFactory.GetConnectionFactory.GetConnection
//      (FDestination, '', '');
    FManageDestCxn := True;
  end;
  Result := FDestConnection;

end;

function TDBXMigrator.GetDestination: string;
begin
  if Length(FDestination) = 0 then
  begin
    if Assigned(FDestConnection) then
      FDestination := DBXGetConnectionName(FDestConnection);
  end;
  Result := FDestination;
end;

function TDBXMigrator.GetDestProvider: TDBXMetaDataProvider;
begin
  if (not Assigned(FDestProvider)) then // and (not FOnlyRead) then
  begin
    if (Length(FDestination) > 0) or Assigned(FDestConnection) then
      FDestProvider := DBXGetMetaProvider(DestConnection)
    else
      MissingProperty(SPumpDestination, SPumpDestConnection, SPumpDestProvider);
    FManageDestProvider := True;
  end;
  Result := FDestProvider;
end;

function TDBXMigrator.GetDestSQLConnection: TSQLConnection;
begin
  if not Assigned(FDestSQLConnection) then
  begin
    if Length(FDestination) > 0 then
      SetDestSQLConnection
  end;
  Result := FDestSQLConnection;
end;

function TDBXMigrator.GetDestTypes: TStrings;
begin
  if not Assigned(FDestTypes) then
    FDestTypes := DBXGetDataTypes(DestConnection);
  Result := FDestTypes;
end;

// This function creates a parameter based on the metadata provided by a value
// type.
function TDBXMigrator.GetParameterFromColSchema(ACommand: TDBXCommand;
  AColSchema: TDataSet): TDBXParameter;
begin
  Result := ACommand.CreateParameter;
  Result.DataType := DestTypeFromName(AColSchema.FieldByName(SPumpDestType).AsWideString);
  Result.Ordinal := AColSchema.FieldByName(SPumpColOrdinal).Value;
  // SubType could be issue if SPumpDestType changes from original type
  Result.SubType := FldSubTypeMap[AColSchema.FieldByName(SPumpSubType)
    .DataType];
  Result.Precision := AColSchema.FieldByName(SPumpDestPrecision).Value;
  Result.Scale := AColSchema.FieldByName(SPumpDestScale).Value;
  Result.Size := AColSchema.FieldByName(SPumpDestSize).Value;
  Result.Nullable := AColSchema.FieldByName(SPumpNullable).Value;
  Result.Name := AColSchema.FieldByName(SPumpDestName).AsWideString;
end;

function TDBXMigrator.GetParameterFromValueType(ACommand: TDBXCommand;
  AValueType: TDBXValueType; AName: string): TDBXParameter;
begin
  Result := ACommand.CreateParameter;
  Result.DataType := AValueType.DataType;
  Result.Ordinal := AValueType.Ordinal;
  Result.SubType := AValueType.SubType;
  Result.Precision := AValueType.Precision;
  Result.Scale := AValueType.Scale;
  Result.Size := AValueType.Size;
  Result.Nullable := AValueType.Nullable;
  Result.Name := AName;
end;

function TDBXMigrator.GetSource: string;
begin
  if Length(FSource) = 0 then
  begin
    if Assigned(FSourceConnection) then
      FSource := DBXGetConnectionName(FSourceConnection);
  end;
  Result := FSource;
end;

function TDBXMigrator.GetSourceConnection: TDBXConnection;
begin
  if not Assigned(FSourceConnection) then
  begin
    if Length(FSource) = 0 then
      MissingProperty(SPumpSource, SPumpSourceConnection);
    FSourceConnection :=
      TDBXConnectionFactory.GetConnectionFactory.GetConnection(FSource, '', '');
    FManageSourceCxn := True;
  end;
  Result := FSourceConnection;
end;

function TDBXMigrator.GetSourceProvider: TDBXMetaDataProvider;
begin
  if not Assigned(FSourceProvider) then
  begin
    if (Length(FSource) > 0) or Assigned(FSourceConnection) then
      FSourceProvider := DBXGetMetaProvider(SourceConnection)
    else
      MissingProperty(SPumpSource, SPumpSourceConnection, SPumpSourceProvider);
    FManageSourceProvider := True;
  end;
  Result := FSourceProvider;
end;

function TDBXMigrator.GetSourceSQLConnection: TSQLConnection;
begin
  if not Assigned(FSourceSQLConnection) then
  begin
    if Length(FSource) > 0 then
      FSourceSQLConnection := OpenSQLConnection(FSource);
  end;
  Result := FSourceSQLConnection;
end;

function TDBXMigrator.GetSourceTypes: TStrings;
begin
  if not Assigned(FSourceTypes) then
    FSourceTypes := DBXGetDataTypes(SourceConnection);
  Result := FSourceTypes;
end;

function TDBXMigrator.IsSourceMsSqlEmptyString(AValue: TDBXValue): boolean;
begin
  // Workaround for RAID #257439: Cannot get a string column value from mssql
  // driver if the value is not null but has a length of 0.  You will get an
  // "InvalidParameter" error.

  Result := False;
  if (SourceProvider.DatabaseProduct = 'Microsoft SQL Server') then
  begin
    if (AValue.ValueType.DataType = TDBXDataTypes.WideStringType) or
      (AValue.ValueType.DataType = TDBXDataTypes.AnsiStringType) or
      ((AValue.ValueType.DataType = TDBXDataTypes.BlobType) and
        ((AValue.ValueType.SubType = TDBXDataTypes.MemoSubType) or
          (AValue.ValueType.SubType = TDBXDataTypes.WideMemoSubType))) then
      try
        AValue.IsNull;
      except
        on E: TDBXError do
        begin
          // Handle error code 9 (invalid parameter) if the source database
          // is MS-SQL
          if E.ErrorCode = 9 then
          begin
            Result := True;
          end
          else
            raise ;
        end;
      end;
  end;
end;

// This function takes care of transforming the SQL identifier to a valid format for the destination database.
function TDBXMigrator.TransformIdentifier(AIdentifier: String;
  AProvider: TDBXMetaDataProvider): String;
var
  TempWriter: TDBXBaseMetaDataWriterWithPublicReader;
  // TempReader:         TDBXBaseMetaDataReader;
  buf: TStringBuilder;

begin
  // If the migrator was not set to transform the identifiers, exit returning the original value.
  if not FNormalizeIdentifiers then
  begin
    Result := AIdentifier;
    Exit;
  end;

  TempWriter := DBXGetMetaWriter(AProvider);
  buf := TStringBuilder.Create;
  try
    TempWriter.MakeSqlIdentifier(buf, AIdentifier);
    Result := buf.ToString;
  finally
    FreeAndNil(buf);
  end;
  (*
    TempReader := TempWriter.FReader;

    // If only upper-case identifiers are supported, then return an upper-case version of the identifier.
    if TempReader.UpperCaseIdentifiersSupported and not TempReader.LowerCaseIdentifiersSupported then
    Result := UpperCase(AIdentifier)
    // If only lower-case identifiers are supported, then return a lower-case version of the identifier.
    else if not TempReader.UpperCaseIdentifiersSupported and TempReader.LowerCaseIdentifiersSupported then
    Result := LowerCase(AIdentifier)
    // Otherwise, return the original value.
    else
    Result := AIdentifier;
  *)
end;

procedure TDBXMigrator.DoOnMigrationStarted;
begin
  if Assigned(FOnMigrationStarted) then
    FOnMigrationStarted(Self);

end;

destructor TDBXMigrator.Destroy;
begin
  if FDestConnection = FDestSQLConnection.DBXConnection then
    AutoFree(True, FDestSQLConnection)
  else
  begin
    AutoFree(FManageDestCxn, FDestConnection);
    AutoFree(True, FDestSQLConnection);
  end;
  AutoFree(FManageSourceCxn, FSourceConnection);
  AutoFree(FManageSourceProvider, FSourceProvider);
  AutoFree(FManageDestProvider, FDestProvider);
  FreeStringObjects(FDestTypes);
  FreeStringObjects(FSourceTypes);
  inherited;
end;

function TDBXMigrator.DestTypeFromName(AName: string): TDBXType;
begin
  Result := DBXGetTypeFromName(DestTypes, AName);
end;

procedure TDBXMigrator.DoOnColumnWarning
  (ATableName, AColumnName, AWarning: String);
begin
  if Assigned(FOnColumnWarning) then
    FOnColumnWarning(Self, ATableName, AColumnName, AWarning);
end;

procedure TDBXMigrator.LogMessage(AMessage: string);
begin
  if Assigned(FOnLogMessage) then
    FOnLogMessage(Self, AMessage);
  DebugString(AMessage);
end;

procedure TDBXMigrator.DoOnIndexingStopped(ATableName: String;
  ATableIndex, ATableCount: Integer; var ACancel: boolean);
begin
  if Assigned(FOnIndexingStopped) then
    FOnIndexingStopped(Self, ATableName, ATableIndex, ATableCount, ACancel);
end;

procedure TDBXMigrator.DoOnIndexingStarted(ATableName: String;
  ATableIndex, ATableCount: Integer; var ACancel: boolean);
begin
  if Assigned(FOnIndexingStarted) then
    FOnIndexingStarted(Self, ATableName, ATableIndex, ATableCount, ACancel);
end;

procedure TDBXMigrator.DoOnMigrationStopped;
begin
  if Assigned(FOnMigrationStopped) then
    FOnMigrationStopped(Self);
end;

procedure TDBXMigrator.DoOnProcMigrationStopped(AProcName: String; AProcIndex,
  AProcCount: Integer; var ACancel: boolean);
begin
  if Assigned(FOnProcMigrationStopped) then
    FOnProcMigrationStopped(Self, AProcName, AProcIndex, AProcCount,
      ACancel);
end;

procedure TDBXMigrator.DoOnProcMigrationStarted(AProcName: String; AProcIndex,
  AProcCount: Integer; var ACancel: boolean);
begin
  if Assigned(FOnProcMigrationStarted) then
    FOnProcMigrationStarted(Self, AProcName, AProcIndex, AProcCount,
      ACancel);
end;

procedure TDBXMigrator.DoOnTableMigrationStarted(ATableName: String;
  ATableIndex, ATableCount: Integer; var ACancel: boolean);
begin
  if Assigned(FOnTableMigrationStarted) then
    FOnTableMigrationStarted(Self, ATableName, ATableIndex, ATableCount,
      ACancel);
end;

procedure TDBXMigrator.DoOnTableMigrationStopped(ATableName: String;
  ATableIndex, ATableCount: Integer; var ACancel: boolean);
begin
  if Assigned(FOnTableMigrationStopped) then
    FOnTableMigrationStopped(Self, ATableName, ATableIndex, ATableCount,
      ACancel);
end;

procedure TDBXMigrator.DoOnRowCopied(ATableName: String;
  ARowIndex, ARowCount: Int64; var ACancel: boolean);
begin
  if Assigned(FOnRowCopied) then
    FOnRowCopied(Self, ATableName, ARowIndex, ARowCount, ACancel);
end;

procedure TDBXMigrator.DoOnRowCountStopped(ATableName: String;
  ATableIndex, ATableCount: Integer; var ACancel: boolean);
begin
  if Assigned(FOnRowCountStopped) then
    FOnRowCountStopped(Self, ATableName, ATableIndex, ATableCount, ACancel);

end;

procedure TDBXMigrator.DoOnRowCountStarted(ATableName: String;
  ATableIndex, ATableCount: Integer; var ACancel: boolean);
begin
  if Assigned(FOnRowCountStarted) then
    FOnRowCountStarted(Self, ATableName, ATableIndex, ATableCount, ACancel);

end;
end.
