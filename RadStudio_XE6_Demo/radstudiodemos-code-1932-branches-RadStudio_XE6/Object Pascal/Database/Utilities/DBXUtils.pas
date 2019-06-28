
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
{          Delphi DBX Framework Utilities               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DBXUtils;

interface

uses Classes, DBXCommon, DBXMetaDataProvider, DBXMetaDataReader,
  DBXMetaDataWriter, DBXCommonTable, DBXTypedTableStorage, SysUtils,
  DB, SqlExpr, DBClient, Rtti, Generics.Collections,
  DBUtils, IniFiles;

type
  EDBXUtils = class(Exception);
  EDBXMigrator = class(Exception);

  TObjectClass = class of TObject;
  /// <remarks>
  /// Candidate for replacing with a generic collection
  /// </remarks>
  TStringArray = array of string;
  /// <summary>
  /// Used for storing type information encoded as integer from metadata calls
  ///  into a collection
  /// </summary>
  TDBXIntObj = class
  private
    FValue: Integer;
  public
    property Value: Integer read FValue write FValue;
    constructor Create(AValue: Integer);
  end;

  ///	<summary>
  ///	  Class containing generic utility methods for various common dbExpress
  ///	  data access tasks operating on TObject descendants
  ///	</summary>
  TDBXUtils<T: constructor, class> = class(TDBUtils<T>)
  public

    ///	<summary>
    ///	  Returns a <c>TObjectList</c> populated with instances of the specified type,
    ///	  using the specified SQL statement.
    ///	</summary>
    ///	<param name="AConnection">
    ///	  <c>TSQLConnection</c> to use for the database connection
    ///	</param>
    ///	<param name="ASQL">
    ///	  The SQL statement to execute
    ///	</param>
    ///	<param name="AUseSmartID">
    ///	  Optional. Indicates whether there will be smart mapping between the
    ///	  database primary key field and the property representing this data.
    ///	  For example, TCustomer.ID would be populated from the 'CUSTOMER_ID'
    ///	  field. Defaults to <c>True</c>.
    ///	</param>
    ///	<param name="AParams">
    ///	  Optional. The list of <c>TParams</c> to use with the constructed SQL
    ///	  command Defaults to nil.
    ///	</param>
    ///	<param name="AFreeParams">
    ///	  Optional. Use <c>True</c> if <c>AParams</c> is created in the
    ///	  invoker, or <c>False</c> if the caller manages the lifetime of
    ///	  <c>AParams</c>. Defaults to <c>True</c>.
    ///	</param>
    ///	<returns>
    ///	  Returns a populated <c>TObjectList</c> list with instances resolved from each row
    ///	  in the specified SQL statement.
    ///	</returns>
    class function ListFromSQL(AConnection: TSQLConnection;
      ASQL: string; AUseSmartID: Boolean = True; AParams: TParams = nil;
      AFreeParams: Boolean = True): TObjectList<T>;
 end;

  TDBXUtils = class(TDBUtils<TSQLConnection, TSQLDataSet, TParams, TParam, TSQLDataSet>)
  private
    class procedure CheckCollection(const AObject: TObject;
      const ADesiredType: TObjectClass; const ADesc: string);
    class procedure WriteIniSection(AIni: TIniFile; ASection: string;
      AValues: TStrings);

    class function AddParam(AParams: TParams; const AName: string;
      ADataType: TFieldType; AValue: Variant; AParamType: TParamType;
      ASize: Integer): TParam;
  public
    class function DBXGetConnectionFile(ACreateIfMissing: boolean = False): string;
    class function DBXGetConnectionList: TStrings;
    class procedure DBXCreateConnection(const AConnectionName: string;
      const AProperties: string); overload;
    class procedure DBXCreateConnection(AConnectionName: string;
      AProperties: TStrings); overload;
    class function DBXConnectionExists(const AConnectionName: string): boolean;
    class function DBXRemoveConnection(AConnectionName: string): boolean;
    class function DBXGetValueAsString(AValue: TDBXValue): string;
    class function DBXGetCollectionCount(const ACollection: TDBXTable): integer;
    class function DBXGetTableCount(const AProvider: TDBXMetaDataProvider): integer;
    class function DBXGetTableList(const AConnectionName: string;
      ATableType : string = ''): TStrings; overload;
    class function DBXGetTableList(const AConnection: TDBXConnection;
      ATableType : string = ''): TStrings; overload;
    class function DBXGetTableList(const AProvider: TDBXMetaDataProvider;
      ATableType : string = ''): TStrings; overload;
    //class function DBXGetTableList(const AProvider: TDBXMetaDataProvider;
    //  ATableType: string = ''): TStringArray; overload;
    class function DBXTableExists(const AProvider: TDBXMetaDataProvider;
      const ATableName: string): Boolean;
    class function DBXProcedureExists(const AProvider: TDBXMetaDataProvider;
      const AProcedureName: string): Boolean;
    class function DBXGetHostName(const AConnection: TDBXConnection): string; overload;
    class function DBXGetHostName(const AConnectionName: string): string; overload;
    class function DBXGetDataBaseName(const AConnection: TDBXConnection): string; overload;
    class function DBXGetDataBaseName(const AConnectionName: string): string; overload;
    class function DBXGetConnectionName(const AConnection: TDBXConnection): string;
    class function DBXGetRowCount(const AConnection: TDBXConnection;
      const ATableName: string): int64;
    class function DBXGetConnection(const AConnectionName: string;
      const AUserName : string = ''; const APassword: string = '')
      : TDBXConnection;
    class function DBXGetMetaProvider(const AConnection: TDBXConnection):
      TDBXMetaDataProvider;
    class function DBXSchemaToString(const AConnectionName: string): string;
    class function DBXGetProcedureSource(const AConnection: TDBXConnection;
      AProcedure: string) : string;

    // No overloads based on connection or connectionstring are available for these
    // routines because the provider must still be instantiated, so no
    // freeing can be done on the provider while the collection is being
    // iterated.
    { TODO :
    Make a version of these methods that will load the results into
    memory structure so they can be overloaded for connections
    and connection names }

    class function DBXGetTables(const AProvider: TDBXMetaDataProvider):
      TDBXTablesTableStorage;
    class function DBXGetProcedures(const AProvider: TDBXMetaDataProvider):
      TDBXProceduresTableStorage;
    class function DBXGetProcedureSources(const AProvider: TDBXMetaDataProvider):
      TDBXProcedureSourcesTableStorage;
    class function DBXGetProcedureParameters(const AProvider: TDBXMetaDataProvider;
      const AProcName: string): TDBXProcedureParametersTableStorage;
    class function DBXGetIndexes(const AProvider: TDBXMetaDataProvider;
      const ATableName: string): TDBXIndexesTableStorage;
    class function DBXGetIndexColumns(const AProvider: TDBXMetaDataProvider;
      const ATableName, AIndexName: string ): TDBXIndexColumnsTableStorage;
    class function DBXGetColumns(const AProvider: TDBXMetaDataProvider;
      const ATableName: string): TDBXColumnsTableStorage;
    class function DBXGetColumnConstraints(const AProvider: TDBXMetaDataProvider;
      const ATableName, AColumnName: string): TDBXColumnConstraintsTableStorage;
    class function DBXGetDataTypes(const AConnection: TDBXConnection): TStrings;
    class function DBXGetTypeFromName(ATypes: TStrings; AName: string): TDBXType;

    ///  <summary>
    ///  Create and open a <c>TSQLConnection</c> with the specified connection name
    ///  trying to open it a) first by trying application.ini then b) by
    ///  reading dbxconnections.ini if a) fails
    ///  </summary>
    ///  <param name="AName">Name of connection to open</param>
    ///  <param name="AIniFile">Optional. Name of the Ini file.
    ///  Defaults to the application name + '.ini'</param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class function CreateConnection(const AName: string;
      AIniFile: string = ''): TSQLConnection;

    ///  <summary>
    ///  Create and open a <c>TSQLConnection</c> with the specified connection name
    ///  for dbxconnections.ini
    ///  </summary>
    ///  <param name="AName">Name of connection to open</param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class function CreateConnectionName(const AName: string): TSQLConnection;

    ///  <summary>
    ///  Create and open a <c>TSQLConnection</c> with properties read from the
    ///  application ini
    ///  </summary>
    ///  <param name="AIniSection">Name of the Ini section to read</param>
    ///  <param name="AIniFile">Optional. Name of the Ini file.
    ///  Defaults to the application name + '.ini'
    ///  </param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class function CreateConnectionIni(const AIniSection: string;
      AIniFile: string = ''): TSQLConnection;

    ///  <summary>
    ///  Create and open a <c>TSQLConnection</c> with the specified connection properties
    ///  </summary>
    ///  <param name="ADatabase">Name of the database to open</param>
    ///  <param name="AUserName">Database user name</param>
    ///  <param name="APassword">Password for <c>AUserName</c></param>
    ///  <param name="ADriverName">Optional. Defaults to 'INTERBASE'</param>
    ///  <param name="AExtra">Optional. Extra properties to set for the connection.
    ///  Defaults to ''.</param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class function CreateConnectionProps(
      const ADatabase, AUserName, APassword: string;
      const ADriverName: string = 'INTERBASE';
      const AExtra: string = ''): TSQLConnection;

    ///  <summary>
    ///  Initialize and open a <c>TSQLConnection</c> with the specified connection name
    ///  trying to open it a) first by trying application.ini then b) by
    ///  reading dbxconnections.ini if a) fails
    ///  </summary>
    ///  <param name="AConnection">The TSQLConnection instance to initialize</param>
    ///  <param name="AName">Name of connection to open</param>
    ///  <param name="AIniFile">Optional. Name of the Ini file.
    ///  Defaults to the application name + '.ini'</param>
    class procedure InitConnection(AConnection: TSQLConnection; const AName: string;
      AIniFile: string = '');

    ///  <summary>
    ///  Intializes and opens a <c>TSQLConnection</c> with the specified connection name
    ///  for dbxconnections.ini
    ///  </summary>
    ///  <param name="AConnection">The TSQLConnection instance to initialize</param>
    ///  <param name="AName">Name of connection to open</param>
    class procedure InitConnectionName(AConnection: TSQLConnection; const AName: string);

    ///  <summary>
    ///  Initializes and opens a <c>TSQLConnection</c> with properties read from the
    ///  application ini
    ///  </summary>
    ///  <param name="AConnection">The TSQLConnection instance to initialize</param>
    ///  <param name="AIniSection">Name of the Ini section to read</param>
    ///  <param name="AIniFile">Optional. Name of the Ini file.
    ///  Defaults to the application name + '.ini'
    ///  </param>
    class procedure InitConnectionIni(AConnection: TSQLConnection;
      const AIniSection: string; AIniFile: string = '');

    ///  <summary>
    ///  Initializes and opens a <c>TSQLConnection</c> with the specified connection properties
    ///  </summary>
    ///  <param name="AConnection">The TSQLConnection instance to initialize</param>
    ///  <param name="ADatabase">Name of the database to open</param>
    ///  <param name="AUserName">Database user name</param>
    ///  <param name="APassword">Password for <c>AUserName</c></param>
    ///  <param name="ADriverName">Optional. Defaults to 'INTERBASE'</param>
    ///  <param name="AExtra">Optional. Extra properties to set for the connection.
    class procedure InitConnectionProps(
      AConnection: TSQLConnection;
      const ADatabase, AUserName, APassword: string;
      const ADriverName: string = 'INTERBASE';
      const AExtra: string = '');

    ///  <summary>
    ///  Creates a <c>TSQLDataSet</c> for the specified connection and SQL statement
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection" type="TSQLConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ASQL" type="string">SQL select statement to use</param>
    ///  <param name="ACommandType">Optional. <c>TSQLCommandType</c> to use.
    ///  Defaults to <c>ctQuery</c></param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AOwner" type="TComponent">
    ///  Component owner to use for the returned DataSet
    ///  </param>
    ///  <param name="AParamCheck" type="boolean">
    ///  Sets the ParamCheck property of the returned <c>TSQLDataSet</c> instance. Defaults to true.
    ///  </param>
    ///  <returns>The created <c>TSQLDataSet</c></returns>
    class function CreateDataSet(AConnection: TSQLConnection; ASQL: string = '';
      ACommandType: TSQLCommandType = ctQuery; AParams: TParams = nil; AOwner: TComponent = nil; AParamCheck: Boolean = True): TSQLDataSet;

    ///  <summary>
    ///  Creates a <c>TSQLDataSet</c> for a query the specified connection and SQL statement
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection" type="TSQLConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ASQL" type="string">SQL select statement to use</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AOwner" type="TComponent">
    ///  Component owner to use for the returned DataSet
    ///  </param>
    ///  <returns>The created <c>TSQLDataSet</c></returns>
    class function CreateQuery(AConnection: TSQLConnection; ASQL: string = '';
      AParams: TParams = nil; AOwner: TComponent = nil): TSQLDataSet; static;

    ///  <summary>
    ///  Creates a <c>TSQLStoredProc</c> for the specified connection and stored procedure name
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection" type="TSQLConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AProcName" type="string">Stored procedure to execute</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AOwner" type="TComponent">
    ///  Component owner to use for the returned DataSet
    ///  </param>
    ///  <returns>The created <c>TSQLStoredProc</c></returns>
    class function CreateStoredProc(AConnection: TSQLConnection;
      AProcName: string = ''; AParams: TParams = nil; AOwner: TComponent = nil; AParamCheck: Boolean = True): TSQLDataSet;


    ///  <summary>
    ///  Retrieve the count of rows matching the specified query
    ///  </summary>
    ///  <remarks>
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>An <c>int64</c> value for the number of rows matching the query,
    ///  or -1 if the query fails</returns>
    class function GetCount(AConnection: TSQLConnection; const ATable: string;
      const AWhere: string = ''; AParams: TParams = nil;
      AFreeParams: Boolean = True): int64;

    ///  <summary>
    ///  Retrieve the value of column in a data table
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller.
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AFieldOrSQL">
    ///  The name of the column to retrieve. Alternatively this can be used to pass
    ///  a full SQL statement. If doing so, then ATable should be an empty string.
    ///  </param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails to locate any rows</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>Variant</c> representing the value of <c>AField</c>, or
    ///  <c>ADefault</c> if the retrieval fails</returns>
    class function GetValue(AConnection: TSQLConnection; const AFieldOrSQL, ATable: string;
      ADefault: Variant; const AWhere: string = ''; AParams: TParams = nil;
      AFreeParams: Boolean = True): Variant;

    ///  <summary>
    ///  Retrieve the value of column in a data table
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller.
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AFieldOrSQL">
    ///  The name of the column to retrieve. Alternatively this can be used to pass
    ///  a full SQL statement. If doing so, then ATable should be an empty string.</param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails to locate any rows</param>
    ///  <param name="ANullDefault">The default value of the return value if retrieval returns a null value</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>Variant</c> representing the value of <c>AField</c>, or
    ///  <c>ADefault</c> if the retrieval fails</returns>
    class function GetValueNullDefault(AConnection: TSQLConnection; const AFieldOrSQL, ATable: string;
      ADefault, ANullDefault: Variant; const AWhere: string = ''; AParams: TParams = nil;
      AFreeParams: Boolean = True): Variant;

    ///  <summary>
    ///  Retrieve the value of column in a data table from a specified SQL statement
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller.
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">
    ///  The SQL statement to retrieve. The value of the first field in the dataset will be returned</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails to locate any rows</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>Variant</c> representing the value of the first field, or
    ///  <c>ADefault</c> if the retrieval fails</returns>
    class function QueryValue(AConnection: TSQLConnection; const ASQL: string;
      ADefault: Variant; AParams: TParams = nil;
      AFreeParams: Boolean = True): Variant;

    ///  <summary>
    ///  Retrieve the value of column in a data table from a specified SQL statement
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller.
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">
    ///  The SQL statement to retrieve. The value of the first field in the dataset will be returned</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails to locate any rows</param>
    ///  <param name="ANullDefault">The default value of the return value if retrieval returns a null value</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>Variant</c> representing the value of the first field, or
    ///  <c>ADefault</c> if the retrieval fails</returns>
    class function QueryValueNullDefault(AConnection: TSQLConnection; const ASQL: string;
      ADefault, ANullDefault: Variant; AParams: TParams = nil;
      AFreeParams: Boolean = True): Variant;


    ///  <summary>
    ///  Retrieve a <c>TBytes</c> array from a column in a data table
    ///  </summary>
    ///  <remarks>
    ///  This object will need to be freed in the client code.
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AField">The name of the column to retrieve</param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails to locate any rows</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>TBytes</c> object representing <c>AField</c>, or
    ///  <c>ADefault</c> if retrieval fails</returns>
    class function GetBytes(AConnection: TSQLConnection; const AField, ATable: string;
      ADefault: TBytes; const AWhere: string = ''; AParams: TParams = nil;
      AFreeParams: Boolean = True): TBytes;

    ///  <summary>
    ///  Retrieve a <c>string</c> from a column in a data table
    ///  </summary>
    ///  <remarks>
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AField">The name of the column to retrieve</param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>TBytes</c> object representing <c>AField</c>, or
    ///  <c>ADefault</c> if retrieval fails</returns>
    class function GetMemo(AConnection: TSQLConnection; const AField, ATable: string;
      ADefault: string = ''; const AWhere: string = ''; AParams: TParams = nil;
      AFreeParams: Boolean = True): string; overload;

      ///  <summary>
    ///  Retrieve a <c>string</c> from a column in a data table
    ///  </summary>
    ///  <remarks>
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AField">The name of the column to retrieve</param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="AEncoding">
    ///  The <c>TEncoding</c> to use when constructing the string from the bytes
    ///  stored in the Memo field.
    ///  </param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>TBytes</c> object representing <c>AField</c>, or
    ///  <c>ADefault</c> if retrieval fails</returns>
    class function GetMemo(AConnection: TSQLConnection; const AField, ATable: string;
      AEncoding: TEncoding; ADefault: string = ''; const AWhere: string = '';
      AParams: TParams = nil; AFreeParams: Boolean = True): string; overload;

    ///  <summary>
    ///  Execute the specified query on the <c>AConnection</c>
    ///  </summary>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">SQL command to execute</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>The number of rows affected by the command</returns>
    class function ExecNoQuery(AConnection: TSQLConnection; const ASQL: string;
      AParams: TParams = nil; AFreeParams: Boolean = True): Integer;

    ///  <summary>
    ///  Open a <c>TSQLDataSet</c> from its connection and SQL statement
    ///  </summary>
    ///  <remarks>
    ///
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AProcName">Name of class procedure to execute</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <param name="AReturnParamName">Name of class procedure return value</param>
    ///  <returns>A <c>Variant</c> with the result of the class procedure call
    ///  if <c>AReturnParamName</c> is defined and found</returns>
    class function ExecProc(AConnection: TSQLConnection; const AProcName: string;
      AParams: TParams = nil; AFreeParams: Boolean = True;
      AReturnParamName: string = 'RETURN_VALUE'; AParamCheck: Boolean = True): Variant;

    ///  <summary>
    ///  Creates an open <c>TSQLDataSet</c> for the specified connection and SQL statement
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">SQL select statement to execute</param>
    /// <param name="AOwner" type="TComponent">
    /// Component owner to use for the returned DataSet
    /// </param>
    ///  <param name="AGetMetaData">
    ///  Indicates whether the underlying metadata for the result set should also
    ///  be fetched. This may be required for some index or update operations.
    ///  </param>

    ///  <returns>The created and opened <c>TSQLDataSet</c></returns>
    class function GetDataSet(AConnection: TSQLConnection; const ASQL: string;
      AParams: TParams = nil; AFreeParams: Boolean = True;
      AOwner: TComponent = nil; AGetMetadata: Boolean = True): TSQLDataSet; overload;

    ///  <summary>
    ///  Creates an open <c>TSQLDataSet</c> for the specified connection and using
    ///  specified criteria to built up the SQL statement to execute
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AFields">The list of fields to return</param>
    ///  <param name="AFrom">The table to return the fields from</param>
    ///  <param name="AWhere">Optional where clause to apply when executing the SQL</param>
    ///  <param name="AOwner" type="TComponent">
    /// Component owner to use for the returned DataSet
    ///  </param>
    ///  <param name="AGetMetaData">
    ///  Indicates whether the underlying metadata for the result set should also
    ///  be fetched. This may be required for some index or update operations.
    ///  </param>
    ///  <returns>The created and opened <c>TSQLDataSet</c></returns>
    class function GetDataSet(AConnection: TSQLConnection; const AFields, ATable: string;
      AWhere: string = ''; AParams: TParams = nil; AFreeParams: Boolean = True;
      AOwner: TComponent = nil; AGetMetadata: Boolean = True): TSQLDataSet; overload;

    ///  <summary>
    ///  Checks to see if at least one record matches the specified query
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">SQL select statement to execute</param>
    ///  <returns><c>True</c> if the query is successful</returns>
    class function RecordExists(AConnection: TSQLConnection; const ASQL: string;
      AParams: TParams = nil; AFreeParams: Boolean = True): boolean; overload;

    ///  <summary>
    ///  Checks to see if at least one record matches the specified query
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AFields">The list of fields to return</param>
    ///  <param name="AFrom">The table to return the fields from</param>
    ///  <param name="AWhere">Optional where clause to apply when executing the SQL</param>
    ///  <returns><c>True</c> if the query is successful</returns>
    class function RecordExists(AConnection: TSQLConnection; const AFields, ATable: string;
      AWhere: string = ''; AParams: TParams = nil;
      AFreeParams: Boolean = True): boolean; overload;

    /// <summary>
    /// Creates a <c>TClientDataSet</c> populated from the specified <c>TSQLDataSet</c>
    /// </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="ADataSet">The <c>TSQLDataSet</c> to use to populate the <c>TClientDataSet</c></param>
    ///  <returns>The populated <c>TClientDataSet</c><</returns>
    class function DataSetToCDS(ADataSet: TSQLDataSet): TClientDataSet;

    ///  <summary>
    ///  Creates an open <c>TClientDataSet</c> for the specified connection and SQL statement
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">SQL select statement to execute</param>
    ///  <param name="AGetMetaData">
    ///  Indicates whether the underlying metadata for the result set should also
    ///  be fetched. This may be required for some index or update operations.
    ///  </param>
    ///  <returns>The populated <c>TClientDataSet</c></returns>
    class function GetClientDataSet(AConnection: TSQLConnection; const ASQL: string;
      AParams: TParams = nil; AFreeParams: Boolean = True; AGetMetaData: Boolean = True): TClientDataSet; overload;

    ///  <summary>
    ///  Creates an open <c>TClientDataSet</c> for the specified connection and using
    ///  specified criteria to built up the SQL statement to execute
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AFields">The list of fields to return</param>
    ///  <param name="AFrom">The table to return the fields from</param>
    ///  <param name="AWhere">Optional where clause to apply when executing the SQL</param>
    ///  <param name="AGetMetaData">
    ///  Indicates whether the underlying metadata for the result set should also
    ///  be fetched. This may be required for some index or update operations.
    ///  </param>
    ///  <returns>The populated <c>TClientDataSet</c></returns>
    class function GetClientDataSet(AConnection: TSQLConnection; const AFields, ATable: string;
      AWhere: string = ''; AParams: TParams = nil; AFreeParams: Boolean = True;
      AGetMetaData: Boolean = True): TClientDataSet; overload;

    ///  <summary>
    ///  Creates an updateable, open <c>TClientDataSet</c> for the specified connection
    ///  and using specified criteria to built up the SQL statement to execute
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">SQL select statement to execute</param>
    ///  <returns>The populated <c>TClientDataSet</c></returns>
    class function GetUpdateSet(AConnection: TSQLConnection; const ASQL: string;
      AParams: TParams = nil; AFreeParams: Boolean = True): TClientDataSet; overload;

    ///  <summary>
    ///  Creates an updateable, open <c>TClientDataSet</c> for the specified connection
    ///  and using specified criteria to built up the SQL statement to execute
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
    ///  <param name="AFields">The list of fields to return</param>
    ///  <param name="AFrom">The table to return the fields from</param>
    ///  <param name="AWhere">Optional where clause to apply when executing the SQL</param>
    ///  <returns>The populated <c>TClientDataSet</c></returns>
    class function GetUpdateSet(AConnection: TSQLConnection; const AFields, ATable: string;
      AWhere: string = ''; AParams: TParams = nil; AFreeParams: Boolean = True): TClientDataSet; overload;

    ///  <summary>
    ///  Creates a <c>TParams</c> and adds one initialized <c>TParam</c> to it
    ///  </summary>
    ///  <remarks>
    ///  This object will need to be freed in the client code
    ///  </remarks>
    ///  <param name="AName">Name of the parameter to create</param>
    ///  <param name="ADataType"><c>TFieldType</c> to use as the DataType for the
    ///  <c>TParam</c></param>
    ///  <param name="AValue">Value to assign to the <c>TParam</c></param>
    ///  <param name="AParamType">Optional <c>TParamType</c> for the <c>TParam</c>.
    ///  Defaults to <c>ptInput</c></param>
    ///  <param name="ASize">Optional <c>Integer</c> to use as the Size. Defaults to 0,
    ///  but it must be set for some data types.</param>
    ///  <returns>The initialized <c>TParams</c> collection</returns>
    class function MakeParamList(const AName: string; ADataType: TFieldType; AValue: Variant;
      AParamType: TParamType = ptInput; ASize: Integer = 0): TParams; overload;

    ///  <summary>
    ///  Creates a <c>TParams</c> and adds one initialized <c>TParam</c> to it
    ///  </summary>
    ///  <remarks>
    ///  This object will need to be freed in the client code
    ///  </remarks>
    ///  <param name="AParams">array of initialized <c>TParam</c> objects</param>
    ///  <returns>The initialized <c>TParams</c> collection</returns>
    class function MakeParamList(AParams: array of TParam): TParams; overload;

    /// <summary>
    ///   Provides a safe way to set the value of a string parameter, ensuring the
    ///   length of the string used does not exceed the value of TParam.Size
    /// </summary>
    /// <param name="AParam">
    ///    The TParam instance to set the value of
    /// </param>
    /// <param name="AValue">
    ///    The value to set the TParam instance to
    /// </param>
    class procedure SetParameterValue(AParam: TParam; AValue: string);

    ///  <summary>
    ///  Retreive the value for the specified parameter for the specified
    ///  <c>TSQLDataSet</c> instance.
    ///  </summary>
    ///  <param name="ADataSet">The <c>TSQLDataSet</c> instance to query.</param>
    ///  <param name="AParamName">The name of the parameter to query.</param>
    ///  <returns>A <c>Variant</c> with the value of the specified parameter, if
    ///  <c>AParamName</c> is defined and found.
    class function GetParamValue(AStoredProc: TSQLDataSet;
      const AParamName: string): Variant; static;
  end;

resourcestring
  StrDbxConnectionNotFound = 'DBXGetConnection for "%s" failed.'#13
    + 'Please check for dbxconnections.ini and that dbExpress is installed';
  StrCollectionFailed = 'Failed to get collection of %s';
  StrCouldNotOpenConnection = 'Could not open connection %s via dbxconnectio' +
  'ns.ini (%s) or application.ini (%s)';
  StrAppIniMissing = 'Application.ini file %s does not exist';
  StrIniWasNotFound = '%s was not found';


const
  SDefaultDBXDriver = 'INTERBASE';
  
implementation

uses SqlTimSt, FmtBCD, DBXMetaDataNames, DBXDataExpressMetaDataProvider,
  {$IFDEF POSIX}
  Posix.Unistd,
  {$ELSE}
  Registry,
  Windows,
  {$ENDIF}
  SyncObjs, Provider, Character, TypInfo;

{ TDBXIntObj }

constructor TDBXIntObj.Create(AValue: Integer);
begin
  inherited Create;
  FValue := AValue;
end;

{ TDBXUtils<T> }

class function TDBXUtils<T>.ListFromSQL(AConnection: TSQLConnection; ASQL:
  string; AUseSmartID: Boolean = True; AParams: TParams = nil; AFreeParams: Boolean = True): TObjectList<T>;
var
  lDS: TDataSet;
begin
  lDS := TDBXUtils.GetDataSet(AConnection, ASQL, AParams, AFreeParams);
  try
    Result := ListFromDataSet(lDS, AUseSmartID);
  finally
    lDS.Free;
  end;
end;

{ TDBXUtils }

class procedure TDBXUtils.CheckCollection(const AObject: TObject;
  const ADesiredType: TObjectClass; const ADesc: string);
begin
  if (not Assigned(AObject)) or (not (AObject is ADesiredType)) then
    Raise EDBXMigrator.CreateFmt(StrCollectionFailed,
      [ADesc]);
end;

class procedure TDBXUtils.WriteIniSection(AIni: TIniFile; ASection: string; AValues: TStrings);
var
  p: integer;
  s,k,v: string;
begin
  for s in AValues do
  begin
    p := pos('=',s);
    k := Copy(s, 1, p - 1);
    v := Copy(s, p + 1);
    AIni.WriteString(ASection, k, v);
  end;
end;

class function TDBXUtils.DBXGetConnectionList: TStrings;
begin
  // Populate list of available connections
  Result := TStringList.Create;
  TDBXConnectionFactory.GetConnectionFactory.GetConnectionItems(Result);
  (Result as TStringList).Sort;
end;

class function TDBXUtils.DBXConnectionExists(const AConnectionName: string): boolean;
var
  connections: TStrings;
  s: string;
begin
  Result := False;
  connections := TStringList.Create;
  try
    TDBXConnectionFactory.GetConnectionFactory.GetConnectionItems(connections);
    for s in connections do
    begin
      if SameText(s, AConnectionName) then
      begin
        Result := True;
        break;
      end;
    end;
  finally
    connections.Free;
  end;
end;

class function TDBXUtils.DBXGetConnectionFile(ACreateIfMissing: boolean = False): string;
// nested routines copied from DBXCommon.pas since they are not in scope from
// class function TDBXConnectionFactory.GetConnectionFactory: TDBXConnectionFactory;

var
  DriverFileName,
  ConnectionFileName,
  AppDir: string;
  Handle: integer;

  function ConfigFilesFound: Boolean;
  begin
    // Modified to use ConnectionFileName rather than DriverFileName
    Result := (ConnectionFileName <> '') and FileExists(ConnectionFileName);
  end;

  {$IFDEF WINDOWS}
  function GetConnectionFromRegistry(const RegRootKey: HKEY): Boolean;
  var
    Registry: TRegistry;
  begin
    Registry := TRegistry.Create;
    try
      Registry.RootKey := RegRootKey;
      if Registry.OpenKeyReadOnly(TDBXRegistryKey) then
      begin
        DriverFileName      := Registry.ReadString(TDBXRegistryDriverValue);
        ConnectionFileName  := Registry.ReadString(TDBXRegistryConnectionValue);
      end;
    finally
      Registry.Destroy;
    end;
    Result := ConfigFilesFound;
  end;
  {$ENDIF}

  function GetConnectionFromExeDirectory: Boolean;
  var
    AppName: string;
  begin
    AppName := ParamStr(0);
    if AppName <> '' then
    begin
      AppDir := ExtractFileDir(AppName);
      DriverFileName :=  AppDir+'/'+TDBXDriverFile;
      ConnectionFileName := AppDir+'/'+TDBXConnectionFile;
    end;
    Result := ConfigFilesFound;
  end;

  function GetConnectionFromAppDomainAppPath: Boolean;
  begin
    Result := False;
    {$IF DEFINED(CLR)}
    if HostingEnvironment.IsHosted then
    begin
      AppDir := HttpRuntime.AppDomainAppPath;
      DriverFileName :=  AppDir+'/'+TDBXDriverFile;
      ConnectionFileName := AppDir+'/'+TDBXConnectionFile;
      Result := ConfigFilesFound;
    end;
    {$IFEND}
  end;

begin
  if GetConnectionFromExeDirectory or
     GetConnectionFRomAppDomainAppPath
     {$IFDEF WINDOWS}
     or
     GetConnectionFromRegistry(HKEY_CURRENT_USER) or
     GetConnectionFromRegistry(HKEY_LOCAL_MACHINE)
     {$ENDIF}
     then
  begin
    Result := ConnectionFileName;
  end
  else
  begin
    if ACreateIfMissing then
    begin
      Result := ExtractFilePath(ParamStr(0)) + TDBXConnectionFile;
      Handle := -1;
      try
        Handle := FileCreate(Result, fmCreate or fmShareDenyNone);
      finally
        if Handle > -1 then
          FileClose(Handle);
      end;
    end
    else
      Result := '';
  end;
end;

class procedure TDBXUtils.DBXCreateConnection(const AConnectionName: string;
  const AProperties: string);
var
  props : TStrings;
begin
  props := TStringList.Create;
  try
    props.Delimiter := ';';
    props.DelimitedText := AProperties;
    DBXCreateConnection(AConnectionName, props);
  finally
    props.Free;
  end;
end;

class procedure TDBXUtils.DBXCreateConnection(AConnectionName: string;
  AProperties: TStrings);
var
  filename : string;
  ini: TIniFile;
begin
  filename := DBXGetConnectionFile;
  if Length(filename) = 0 then
    raise EDBXMigrator.Create('DBXCreateConnection: Could not find dbxconnections.ini');

  ThreadLock.Acquire;
  try
    ini := TIniFile.Create(filename);
    try
      AConnectionName := UpperCase(AConnectionName);
      if ini.SectionExists(AConnectionName) then
        raise EDBXMigrator.CreateFmt('Connection "%s" is already defined in "%s"',
          [AConnectionName, filename]);
      WriteIniSection(ini, AConnectionName, AProperties);
      // Reload the connection factory with INI changes
      TDBXConnectionFactory.GetConnectionFactory.Close;
      TDBXConnectionFactory.GetConnectionFactory.Open;
    finally
      ini.Free;
    end;
  finally
    ThreadLock.Release;
  end;
end;

class function TDBXUtils.DBXRemoveConnection(AConnectionName: string): boolean;
var
  filename: string;
  ini: TIniFile;
begin
  filename := DBXGetConnectionFile;
  if Length(filename) = 0 then
    raise EDBXMigrator.Create('DBXRemoveConnection: Could not find dbxconnections.ini');
  ThreadLock.Acquire;
  try
    ini := TIniFile.Create(filename);
    try
      AConnectionName := UpperCase(AConnectionName);
      if ini.SectionExists(AConnectionName) then
      begin
        ini.EraseSection(AConnectionName);
        Result := True;
        // Reload the connection factory with INI changes
        TDBXConnectionFactory.GetConnectionFactory.Close;
        TDBXConnectionFactory.GetConnectionFactory.Open;
      end
      else
        Result := False;
    finally
      ini.Free;
    end;
  finally
    ThreadLock.Release;
  end;
end;

class function TDBXUtils.DBXSchemaToString(const AConnectionName: string): string;
const
  NL = #13#10;
var
  Cxn: TDBXConnection;
  Provider: TDBXMetaDataProvider;
  Tables: TDBXTablesTableStorage;
  Cols: TDBXColumnsTableStorage;
  ColCount: integer;
  Indexes: TDBXIndexesTableStorage;
  IndexCount: integer;
begin
  Cxn := DBXGetConnection(AConnectionName);
  try
    Provider := DBXGetMetaProvider(Cxn);
    try
      Tables := DBXGetTables(Provider);
      try
        while Tables.InBounds do
        begin
          Result := Result + Tables.TableName + NL;
          Cols := DBXGetColumns(Provider, Tables.TableName);
          try
            ColCount := 0;
            while Cols.InBounds do
            begin
              Inc(ColCount);
              Result := Result + 'Col:' + Cols.ColumnName + NL;
              Cols.Next;
            end;
          finally
            FreeAndNil(Cols);
          end;
          Assert(ColCount > 0, 'Failed to retrieve columns for ' + Tables.TableName);
          Indexes := DBXGetIndexes(Provider, Tables.TableName);
          try
            IndexCount := 0;
            while Indexes.InBounds do
            begin
              Inc(IndexCount);
              Result := Result + 'Idx:' + Indexes.IndexName + NL;
              Indexes.Next;
            end;
          finally
            FreeAndNil(Indexes);
          end;
          Assert(IndexCount > 0, 'Failed to retrieve indexes for ' + Tables.TableName);
          Tables.Next;
        end;
      finally
        FreeAndNil(Tables);
      end;
    finally
      FreeAndNil(Provider);
    end;
  finally
    FreeAndNil(Cxn);
  end;
end;

class function TDBXUtils.DBXGetProcedures(const AProvider: TDBXMetaDataProvider):
  TDBXProceduresTableStorage;
var
  Coll: TDBXTable;
begin
  // Retrieve a collection of all the procedure sources in the database.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetProcedures);
  CheckCollection(Coll, TDBXProceduresTableStorage, 'procedures');
  Result := Coll as TDBXProceduresTableStorage;
end;

class function TDBXUtils.DBXGetProcedureSources(const AProvider: TDBXMetaDataProvider):
  TDBXProcedureSourcesTableStorage;
var
  Coll: TDBXTable;
begin
  // Retrieve a collection of all the procedure sources in the database.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetProcedures);
  CheckCollection(Coll, TDBXProcedureSourcesTableStorage, 'procedures');
  Result := Coll as TDBXProcedureSourcesTableStorage;
end;

class function TDBXUtils.DBXGetTables(const AProvider: TDBXMetaDataProvider):
  TDBXTablesTableStorage;
var
  Coll: TDBXTable;
begin
  // Retrieve a collection of all the tables in the database.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetTables);
  CheckCollection(Coll, TDBXTablesTableStorage, 'tables');
  Result := Coll as TDBXTablesTableStorage;
end;

// This function retrieves a list of columns in a table from the metadata
// provider.
class function TDBXUtils.DBXGetColumns(const AProvider: TDBXMetaDataProvider;
  const ATableName: string): TDBXColumnsTableStorage;
var
  Coll: TDBXTable;
begin
  // Retrieve a collection of all the columns in this table.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetColumns
    + ' ' + AProvider.QuoteIdentifierIfNeeded(ATableName));
  CheckCollection(Coll, TDBXColumnsTableStorage, 'columns for table '
        + ATableName);
  Result := Coll as TDBXColumnsTableStorage;
end;

class function TDBXUtils.DBXGetColumnConstraints(const AProvider: TDBXMetaDataProvider;
  const ATableName, AColumnName: string): TDBXColumnConstraintsTableStorage;
var
  Coll:  TDBXTable;

begin
  // Retrieve a collection of the columns associated with an index in this table.
  Coll := AProvider.GetCollection(
    TDBXMetaDataCommands.GetIndexColumns + ' '
    + AProvider.QuoteIdentifierIfNeeded(ATableName) + ' '
    + AProvider.QuoteIdentifierIfNeeded(AColumnName));
  CheckCollection(Coll, TDBXColumnConstraintsTableStorage,
    'column constraints for column ' + AColumnName + ' in table ' + ATableName);
  Result := Coll as TDBXColumnConstraintsTableStorage;
end;

class function TDBXUtils.DBXGetProcedureParameters(const AProvider: TDBXMetaDataProvider;
  const AProcName: string): TDBXProcedureParametersTableStorage;
var
  Coll: TDBXTable;
begin
  // Retrieve a collection of all the indexes in this table.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetProcedureParameters
    + ' ' + AProvider.QuoteIdentifierIfNeeded(AProcName));
  CheckCollection(Coll, TDBXProcedureParametersTableStorage,
    'parameters for procedure ' + AProcName);
  Result := Coll as TDBXProcedureParametersTableStorage;
end;

// This function retrieves a list of indexes in a table from the metadata
// provider.
class function TDBXUtils.DBXGetIndexes(const AProvider: TDBXMetaDataProvider;
  const ATableName: string): TDBXIndexesTableStorage;
var
  Coll: TDBXTable;
begin
  // Retrieve a collection of all the indexes in this table.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetIndexes
    + ' ' + AProvider.QuoteIdentifierIfNeeded(ATableName));
  CheckCollection(Coll, TDBXIndexesTableStorage,
    'indexes for table ' + ATableName);
  Result := Coll as TDBXIndexesTableStorage;
end;

class function TDBXUtils.DBXGetIndexColumns(const AProvider: TDBXMetaDataProvider;
  const ATableName, AIndexName: string ): TDBXIndexColumnsTableStorage;
var
  Coll:  TDBXTable;

begin
  // Retrieve a collection of the columns associated with an index in this table.
  Coll := AProvider.GetCollection(
    TDBXMetaDataCommands.GetIndexColumns + ' '
      + AProvider.QuoteIdentifierIfNeeded(ATableName)
      + ' ' +  AProvider.QuoteIdentifierIfNeeded(AIndexName));
  CheckCollection(Coll, TDBXIndexColumnsTableStorage,
    'index columns for index ' + AIndexName + ' in table ' + ATableName);
  Result := Coll as TDBXIndexColumnsTableStorage;
end;

class function TDBXUtils.DBXGetCollectionCount(const ACollection: TDBXTable): integer;
begin
  Result := 0;
//  ACollection.First;
  while ACollection.InBounds do
  begin
    Inc(Result);
    ACollection.Next;
  end;
end;

// This function retrieves the total number of user tables in the database.
class function TDBXUtils.DBXGetTableCount(const AProvider: TDBXMetaDataProvider): Integer;
var
  Tables: TDBXTablesTableStorage;

begin
  Result := 0;

  Tables := DBXGetTables(AProvider);
  try
    // Because DBX doesn't support querying the database for the number of
    // tables, we have to use a manual approach.
    while Tables.InBounds do
    begin
    // We only want user tables, no system tables, so we exclude anything but
      // user tables.
      if Tables.TableType = TDBXTableType.Table then
        Inc(Result);
      Tables.Next;
    end;

  finally
    FreeAndNil(Tables);

  end;

end;

class function TDBXUtils.DBXGetTableList(const AConnectionName: string;
  ATableType: string = ''): TStrings;
var
  Conn : TDBXConnection;
begin
  Conn := DBXGetConnection(AConnectionName);
  try
    Result := DBXGetTableList(Conn, ATableType);
  finally
    FreeAndNil(Conn);
  end;
end;

class function TDBXUtils.DBXGetTableList(const AConnection: TDBXConnection;
  ATableType: string = ''): TStrings;
var
  Prov: TDBXMetaDataProvider;
begin
  Prov := DBXGetMetaProvider(AConnection);
  try
    Result := DBXGetTableList(Prov, ATableType);
  finally
    FreeAndNil(Prov);
  end;
end;

class function TDBXUtils.DBXGetTableList(const AProvider: TDBXMetaDataProvider;
  ATableType: string = ''): TStrings;
var
  Tables: TDBXTablesTableStorage;
begin
  Result := TStringList.Create;
  Tables := DBXGetTables(AProvider);
  try
    while Tables.InBounds do
    begin
      if (Length(ATableType) = 0)
        or SameText(Tables.TableType, ATableType,
            TLocaleOptions.loInvariantLocale) then
      begin
        Result.Add(Tables.TableName);
      end;
      Tables.Next;
    end;

  finally
    FreeAndNil(Tables);
  end;
end;

//function DBXGetTableList(const AProvider: TDBXMetaDataProvider;
//  ATableType: string = ''): TStringArray;
//var
//  Tables: TDBXTablesTableStorage;
//  TableCount: Integer;
//
//begin
//  TableCount := 0;
//  Result := TStringList.Create;
//
//  Tables := DBXGetTables(AProvider);
//  try
//    // Because DBX doesn't support querying the database for the number of
//    // tables, we have to use a manual approach.
//    while Tables.InBounds do
//    begin
//      // We only want user tables, no system tables, so we exclude anything but
//      // user tables.
//      if (Length(ATableType) = 0) or (Tables.TableType = ATableType) then
//      begin
//        Inc(TableCount);
//        SetLength(Result, TableCount);
//        Result[TableCount - 1] := Tables.TableName;
//      end;
//      Tables.Next;
//    end;
//
//  finally
//    FreeAndNil(Tables);
//  end;
//end;

// This function retrieves the string representation of a TDBXValue.
class function TDBXUtils.DBXGetValueAsString(AValue: TDBXValue): string;
begin
  if AValue.IsNull then
  begin
    Result := 'NULL';
    Exit;
  end;

  case AValue.ValueType.DataType of
    TDBXDataTypes.TimeStampType:
      Result := SQLTimeStampToStr('c', AValue.GetTimeStamp);

    TDBXDataTypes.BcdType:
      Result := BcdToStr(AValue.GetBcd);

    {$IFDEF WINDOWS}
    TDBXDataTypes.AnsiStringType:
      Result := string(AValue.GetAnsiString);
    {$ELSE}
    TDBXDataTypes.AnsiStringType:
      Result := string(AValue.GetString);
    {$ENDIF}

    TDBXDataTypes.BooleanType:
      Result := BoolToStr(AValue.GetBoolean, True);

    TDBXDataTypes.DateType:
      Result := IntToStr(AValue.GetDate);

    TDBXDataTypes.TimeType:
      Result := IntToStr(AValue.GetTime);

    TDBXDataTypes.WideStringType:
      Result := AValue.GetWideString;

    TDBXDataTypes.Int16Type:
      Result := IntToStr(AValue.GetInt16);

    TDBXDataTypes.Int32Type:
      Result := IntToStr(AValue.GetInt32);

    TDBXDataTypes.Int64Type:
      Result := IntToStr(AValue.GetInt64);

    TDBXDataTypes.DoubleType:
      Result := FloatToStr(AValue.GetDouble);

    TDBXDataTypes.BlobType:
      Result := '(Blob)';

    else
      Result := '(Unknown type)';

  end;

end;

// This function checks whether a given table exists in the database.
class function TDBXUtils.DBXTableExists(const AProvider: TDBXMetaDataProvider;
  const ATableName: string): Boolean;
var
  Coll:  TDBXTable;

begin
  // Get a table collection from the provider that will contain the table
  // if it does exist.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetTables + ' '
    + AProvider.QuoteIdentifierIfNeeded(ATableName) + ' ' + TDBXTableType.Table);

  CheckCollection(Coll, TDBXTablesTableStorage, 'tables');

  // If there is a record for the desired table, Next will return true
  // (the first row). Otherwise it will return false.
  try
    Result := Coll.Next;

  finally
    Coll.Free;

  end;

end;

// This function checks whether a given procedure exists in the database.
class function TDBXUtils.DBXProcedureExists(const AProvider: TDBXMetaDataProvider;
  const AProcedureName: string): Boolean;
var
  Coll:  TDBXTable;

begin
  // Get a table collection from the provider that will contain the table
  // if it does exist.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetProcedures + ' '
    + AProvider.QuoteIdentifierIfNeeded(AProcedureName) );

  CheckCollection(Coll, TDBXProceduresTableStorage, 'procedures');

  // If there is a record for the desired table, Next will return true
  // (the first row). Otherwise it will return false.
  try
    Result := Coll.Next;

  finally
    Coll.Free;

  end;

end;

class function TDBXUtils.DBXGetHostName(const AConnection: TDBXConnection): string;
begin
  Result := AConnection.ConnectionProperties.Values[TDBXPropertyNames.HostName];
end;

class function TDBXUtils.DBXGetHostName(const AConnectionName: string): string;
var
  Connection: TDBXConnection;
begin
  Connection := DBXGetConnection(AConnectionName, '', '');
  try
    if Assigned(Connection) then
      DBXGetHostName(Connection)
    else
      Result := '';
  finally
    FreeAndNil(Connection);
  end;
end;

class function TDBXUtils.DBXGetDataBaseName(const AConnection: TDBXConnection): string;
begin
  Result := AConnection.ConnectionProperties.Values[TDBXPropertyNames.Database];
end;

class function TDBXUtils.DBXGetDataBaseName(const AConnectionName: string): string;
var
  Connection: TDBXConnection;
begin
  Connection := DBXGetConnection(AConnectionName, '', '');
  try
    if Assigned(Connection) then
      DBXGetDataBaseName(Connection)
    else
      Result := '';
  finally
    FreeAndNil(Connection);
  end;
end;

class function TDBXUtils.DBXGetConnectionName(const AConnection: TDBXConnection): string;
begin
  Result := AConnection.ConnectionProperties.Values[
    TDBXPropertyNames.ConnectionName ];
end;

class function TDBXUtils.DBXGetProcedureSource(const AConnection: TDBXConnection;
  AProcedure: string) : string;
var
  Cmd: TDBXCommand;
  Reader: TDBXReader;
begin
  Result := '';
  Cmd := AConnection.CreateCommand;
  try
    Cmd.CommandType := TDBXCommandTypes.DbxMetaData;
    Cmd.Text := TDBXMetaDataCommands.GetProcedureSources + ' ' + AProcedure;
    Reader := Cmd.ExecuteQuery;
    try
      if Reader.Next then
      begin
        try
          Result := Reader.Value['Definition'].GetWideString;
          // TODO: find a way to determine whether 'Definition' is defined w/o trapping the exception
        except
          // Can't retrieve source code
        end;
      end;
    finally
      FreeAndNil(Reader);
    end;
  finally
    FreeAndNil(Cmd);
  end;
end;

class function TDBXUtils.DBXGetRowCount(const AConnection: TDBXConnection;
  const ATableName: string): int64;
var
  Cmd : TDBXCommand;
  Reader: TDBXReader;
  Prv: TDBXMetaDataProvider;
begin
  Cmd := AConnection.CreateCommand;
  try
    Cmd.CommandType := TDBXCommandTypes.DbxSQL;
    Prv := DBXGetMetaProvider(AConnection);
    try
      Cmd.Text := 'SELECT COUNT(*) FROM ' + Prv.QuoteIdentifierIfNeeded(ATableName);
    finally
      FreeAndNil(Prv);
    end;

    Reader := Cmd.ExecuteQuery;
    try
      // Retrieve the value of the COUNT(*) column.
      if Reader.Next then
      begin
        // Not sure if all RDBMs return COUNT(*) as a 64bit integer.
        if Reader.ValueType[0].DataType = TDBXDataTypes.Int64Type then
          Result := Reader.Value[0].GetInt64
        else
          Result := Reader.Value[0].GetInt32;
      end
      else
        Result := -1;

    finally
      FreeAndNil(Reader);

    end;
  finally
    FreeAndNil(Cmd);
  end;
end;

class function TDBXUtils.DBXGetConnection(const AConnectionName: string;
  const AUserName : string = ''; const APassword: string = '')
  : TDBXConnection;
begin
  Result :=  TDBXConnectionFactory.GetConnectionFactory.GetConnection(
    AConnectionName, AUserName, APassword);
  if not Assigned(Result) then
    Raise EDBXMigrator.CreateFmt(StrDbxConnectionNotFound,
      [AConnectionName]);
end;

// This function retrieves a metadata provider for the specified connection.
class function TDBXUtils.DBXGetMetaProvider(const AConnection: TDBXConnection):
  TDBXMetaDataProvider;
var
  Provider: TDBXDataExpressMetaDataProvider;

begin
  Provider := TDBXDataExpressMetaDataProvider.Create;
  try
    Provider.Connection := AConnection;
    Provider.Open;

  except
    FreeAndNil(Provider);
    raise;

  end;
  Result := Provider;
end;

class function TDBXUtils.DBXGetDataTypes(const AConnection: TDBXConnection): TStrings;
var
  MetaDataCommand: TDBXCommand;
  Reader: TDBXReader;
  Name: string;
begin
  MetaDataCommand := AConnection.CreateCommand;
  try
    MetaDataCommand.CommandType := TDBXCommandTypes.DbxMetaData;
    MetaDataCommand.Text := TDBXMetaDataCommands.GetDataTypes;
    Result := TStringList.Create;
    Reader := MetaDataCommand.ExecuteQuery;
    try
      while Reader.Next do
      begin
        Name := Reader.Value[TDBXColumnsColumns.TypeName].GetWideString;
        Result.AddObject(Name, TDBXIntObj.Create(Reader.Value[TDBXColumnsColumns.DbxDataType].AsInt32));
      end;
      (Result as TStringList).Sort;
    finally
      Reader.Free;
    end;
  finally
    MetaDataCommand.Free;
  end;
end;

class function TDBXUtils.DBXGetTypeFromName(ATypes: TStrings; AName: string): TDBXType;
var
  i: integer;
begin
  i := ATypes.IndexOf(AName);
  if i >= 0 then
  begin
    Result := TDBXType((ATypes.Objects[i] as TDBXIntObj).Value);
  end
  else
    Result := TDBXDataTypes.UnknownType;
end;

class function TDBXUtils.CreateConnection(const AName: string;
  AIniFile: string = ''): TSQLConnection;
begin
  Result := DoCreateConnection(TSQLConnection,
    procedure(AConnection: TSQLConnection)
    begin
      InitConnection(AConnection, AName, AIniFile);
    end);
end;

class function TDBXUtils.CreateConnectionName(const AName: string): TSQLConnection;
begin
  Result := DoCreateConnection(TSQLConnection,
    procedure(AConnection: TSQLConnection)
    begin
      InitConnectionName(AConnection, AName);
    end);
end;

class function TDBXUtils.CreateConnectionIni(const AIniSection: string;
  AIniFile: string = ''): TSQLConnection;
begin
  Result := DoCreateConnection(TSQLConnection,
    procedure(AConnection: TSQLConnection)
    begin
      InitConnectionIni(AConnection, AIniSection, AIniFile);
    end);
end;

class function TDBXUtils.CreateConnectionProps(
  const ADatabase, AUserName, APassword: string;
  const ADriverName: string = 'INTERBASE';
  const AExtra: string = '') : TSQLConnection;
begin
  Result := DoCreateConnection(TSQLConnection,
    procedure(AConnection: TSQLConnection)
    begin
      InitConnectionProps(AConnection, ADatabase, AUserName, APassword, ADriverName, AExtra);
    end);
end;

class procedure TDBXUtils.InitConnection(AConnection: TSQLConnection; const AName: string;
  AIniFile: string = '');
begin
  DoInitConnection(AConnection, AName,
    procedure (AConnection: TSQLConnection; const AServer, ADatabase, AUserName, APassword, ADriver, AExtra: string)
    begin
      InitConnectionProps(AConnection, ADatabase, AUserName, APassword, ADriver, AExtra);
    end,
    InitConnectionName, AIniFile, SDefaultDBXDriver);
end;

class procedure TDBXUtils.InitConnectionName(AConnection: TSQLConnection; const AName: string);
begin
  AConnection.ConnectionName := AName;
  AConnection.LoadParamsOnConnect := True;
  AConnection.Open;
end;

class procedure TDBXUtils.InitConnectionIni(AConnection: TSQLConnection;
  const AIniSection: string; AIniFile: string = '');
begin
  DoInitConnectionIni(AConnection, AIniSection,
    procedure (AConnection: TSQLConnection; const AServer, ADatabase, AUserName, APassword, ADriver, AExtra: string)
    begin
      InitConnectionProps(AConnection, ADatabase, AUserName, APassword, ADriver, AExtra);
    end, AIniFile, SDefaultDBXDriver);
end;

class procedure TDBXUtils.InitConnectionProps(
  AConnection: TSQLConnection;
  const ADatabase, AUserName, APassword: string;
  const ADriverName: string = 'INTERBASE';
  const AExtra: string = '');
const
  SCxnParams = 'Database=%s'#13
    + 'User_name=%s'#13
    + 'Password=%s'#13
    + 'Driver_name=%s'#13'%s';
begin
  AConnection.DriverName := ADriverName;
  AConnection.LoadParamsOnConnect := False;
  AConnection.Params.Text := Format(SCxnParams,
    [ADatabase, AUserName, APassword, ADriverName, AExtra]);
  AConnection.Open;
end;

class function TDBXUtils.CreateDataSet(AConnection: TSQLConnection; ASQL: string = '';
  ACommandType: TSQLCommandType = ctQuery; AParams: TParams = nil; AOwner: TComponent = nil; AParamCheck: Boolean = True): TSQLDataSet;
begin
  Result := TSQLDataSet.Create(AOwner);
  Result.ParamCheck := AParamCheck;
  Result.SQLConnection := AConnection;
  Result.CommandType := ACommandType;
  Result.CommandText := ASQL;

  if Assigned(AParams) then
    DoCloneParameters(TParam, AParams, Result.Params);
end;

class function TDBXUtils.CreateQuery(AConnection: TSQLConnection; ASQL: string = '';
  AParams: TParams = nil; AOwner: TComponent = nil): TSQLDataSet;
begin
  Result := CreateDataSet(AConnection, ASQL, ctQuery, AParams, AOwner);
end;

class function TDBXUtils.CreateStoredProc(AConnection: TSQLConnection; AProcName: string = '';
  AParams: TParams = nil; AOwner: TComponent = nil; AParamCheck: Boolean = True): TSQLDataSet;
begin
  Result := CreateDataSet(AConnection, AProcName, ctStoredProc, AParams, AOwner, AParamCheck);
end;

class function TDBXUtils.GetCount(AConnection: TSQLConnection; const ATable: string;
  const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): int64;
begin
  Result := DoGetCount(AConnection, CreateQuery, ATable, AWhere, AParams, AFreeParams);
end;

class function TDBXUtils.GetValue(AConnection: TSQLConnection; const AFieldOrSQL, ATable: string;
  ADefault: Variant; const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := DoGetValue(AConnection, CreateQuery, AFieldOrSql, ATable, ADefault,
    AWhere, AParams, AFreeParams);
end;

class function TDBXUtils.QueryValue(AConnection: TSQLConnection; const ASQL: string;
  ADefault: Variant; AParams: TParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := DoQueryValue(AConnection, CreateQuery, ASQL, ADefault, AParams, AFreeParams);
end;

class function TDBXUtils.QueryValueNullDefault(AConnection: TSQLConnection; const ASQL: string;
  ADefault, ANullDefault: Variant; AParams: TParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := DoQueryValueNullDefault(AConnection, CreateQuery, ASQL, ADefault,
    ANullDefault, AParams, AFreeParams);
end;

class function TDBXUtils.GetValueNullDefault(AConnection: TSQLConnection; const AFieldOrSQL, ATable: string;
  ADefault, ANullDefault: Variant; const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := DoGetValueNullDefault(AConnection, CreateQuery, AFieldOrSQL, ATable,
    ADefault, ANullDefault, AWhere, AParams, AFreeParams);
end;

class function TDBXUtils.GetBytes(AConnection: TSQLConnection; const AField, ATable: string;
  ADefault: TBytes; const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): TBytes;
begin
  Result := DoGetBytes(AConnection, CreateQuery, AField, ATable, ADefault, AWhere,
    AParams, AFreeParams);
end;

class function TDBXUtils.GetMemo(AConnection: TSQLConnection; const AField,
  ATable: string; ADefault: string = ''; const AWhere: string = '';
  AParams: TParams = nil; AFreeParams: Boolean = True): string;
begin
  Result := GetMemo(AConnection, AField, ATable, TEncoding.UTF8, ADefault, AWhere,
    AParams, AFreeParams);
end;

class function TDBXUtils.GetMemo(AConnection: TSQLConnection; const AField,
  ATable: string; AEncoding: TEncoding; ADefault: string = '';
  const AWhere: string = ''; AParams: TParams = nil; AFreeParams: Boolean = True): string;
begin
  Result := DoGetMemo(AConnection, CreateQuery, AField, ATable, ADefault, AWhere,
    AParams, AFreeParams, AEncoding);
end;

class function TDBXUtils.ExecNoQuery(AConnection: TSQLConnection; const ASQL: string;
  AParams: TParams = nil; AFreeParams: Boolean = True): Integer;
begin
  Result := DoExecNoQuery(AConnection, CreateQuery, function(AQuery: TSQLDataSet): Integer
    begin
      Result := AQuery.ExecSQL;
    end,
    ASQL, AParams, AFreeParams);
end;

class function TDBXUtils.ExecProc(AConnection: TSQLConnection; const AProcName: string;
  AParams: TParams = nil; AFreeParams: Boolean = True;
  AReturnParamName: string = 'RETURN_VALUE'; AParamCheck: Boolean = True): Variant;
begin
  Result := DoExecProc(AConnection,
    function (AConnection: TSQLConnection; AProcName: string; AParams: TParams; AOwner: TComponent): TSQLDataSet
    begin
      Result := CreateStoredProc(AConnection, AProcName, AParams, AOwner, AParamCheck);
    end,
    procedure(AProc: TSQLDataSet)
    begin
      AProc.ExecSQL;
    end,
    GetParamValue, AProcName, AParams, AFreeParams, AReturnParamName);
end;

class function TDBXUtils.GetParamValue(AStoredProc: TSQLDataSet; const AParamName: string): Variant;
var
  lParam: TParam;
begin
  lParam := AStoredProc.Params.FindParam(AParamName);
  if Assigned(lParam) then
    Result := lParam.Value;
end;

class function TDBXUtils.GetDataSet(AConnection: TSQLConnection; const AFields, ATable: string;
  AWhere: string = ''; AParams: TParams = nil; AFreeParams: Boolean = True;
  AOwner: TComponent = nil; AGetMetadata: Boolean = True): TSQLDataSet;
begin
  Result := DoGetDataSet(AConnection,
    function(AConnection: TSQLConnection; ASQL: string; AParams: TParams; AOwner: TComponent): TSQLDataSet
    begin
      Result := CreateQuery(AConnection, ASQL, AParams, AOwner);
      Result.GetMetadata := AGetMetadata;
    end,
    AFields, ATable, AWhere, AParams, AFreeParams);
end;

class function TDBXUtils.GetDataSet(AConnection: TSQLConnection; const ASQL: string;
  AParams: TParams = nil; AFreeParams: Boolean = True;
  AOwner: TComponent = nil; AGetMetadata: Boolean = True): TSQLDataSet;
begin
  Result := DoGetDataSet(AConnection,
    function(AConnection: TSQLConnection; ASQL: string; AParams: TParams; AOwner: TComponent): TSQLDataSet
    begin
      Result := CreateQuery(AConnection, ASQL, AParams, AOwner);
      Result.GetMetadata := AGetMetadata;
    end,
    ASQL, AParams, AFreeParams, AOwner);
end;

class function TDBXUtils.RecordExists(AConnection: TSQLConnection; const AFields, ATable: string;
  AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): boolean;
var
  ds: TDataSet;
begin
  ds := GetDataSet(AConnection, AFields, ATable, AWhere, AParams, AFreeParams);
  try
    Result := not ds.IsEmpty;
  finally
    FreeAndNil(ds);
  end;
end;

class function TDBXUtils.RecordExists(AConnection: TSQLConnection; const ASQL: string;
  AParams: TParams = nil; AFreeParams: Boolean = True): boolean;
var
  ds: TDataSet;
begin
  ds := GetDataSet(AConnection, ASQL, AParams, AFreeParams);
  try
    Result := not ds.IsEmpty;
  finally
    FreeAndNil(ds);
  end;
end;

class function TDBXUtils.DataSetToCDS(ADataSet: TSQLDataSet): TClientDataSet;
var
  I: integer;
begin
  Result := TClientDataSet.Create(nil);

  Result.FieldDefs.Clear;
  ADataSet.Open;
  for I := 0 to ADataSet.FieldCount - 1 do
    Result.FieldDefs.Add(ADataSet.FieldDefs[I].Name,
      ADataSet.FieldDefs[I].DataType, ADataSet.FieldDefs[I].Size,
      ADataSet.FieldDefs[I].Required);
  for I := 0 to ADataSet.IndexDefs.Count - 1 do
    Result.IndexDefs.Add(ADataSet.IndexDefs[I].Name,
      ADataSet.IndexDefs[I].Fields, ADataSet.IndexDefs[I].Options);
  Result.CreateDataSet;
  Result.LogChanges := False;
  ADataSet.First;
  while not ADataSet.Eof do
  begin
    Result.Append;
    for I := 0 to ADataSet.FieldCount - 1 do
      Result.Fields[I].Value := ADataSet.Fields[I].Value;
    Result.Post;
    ADataSet.Next;
  end;
  Result.Open;
  Result.LogChanges := True;
  Result.First;
end;

class function TDBXUtils.GetClientDataSet(AConnection: TSQLConnection; const ASQL: string;
  AParams: TParams = nil; AFreeParams: Boolean = True; AGetMetaData: Boolean = True): TClientDataSet;
var
  lDataSet: TSQLDataSet;
begin
  lDataSet := GetDataSet(AConnection, ASQL, AParams, AFreeParams, nil, AGetMetaData);
  try
    Result := DataSetToCDS(lDataSet);
  finally
    lDataSet.Free;
  end;
end;

class function TDBXUtils.GetClientDataSet(AConnection: TSQLConnection; const AFields, ATable: string;
  AWhere: string = ''; AParams: TParams = nil; AFreeParams: Boolean = True;
    AGetMetaData: Boolean = True): TClientDataSet;
var
  lDataSet: TSQLDataSet;
begin
  lDataSet := GetDataSet(AConnection, AFields, ATable, AWhere, AParams, AFreeParams, nil, AGetMetaData);
  try
    Result := DataSetToCDS(lDataSet);
  finally
    lDataSet.Free;
  end;
end;

class function TDBXUtils.GetUpdateSet(AConnection: TSQLConnection; const ASQL: string;
  AParams: TParams = nil; AFreeParams: Boolean = True): TClientDataSet;
var
  lDataSet: TSQLDataSet;
  lProv: TDataSetProvider;
begin
  Result := TClientDataSet.Create(nil);
  try
    lDataSet := GetDataSet(AConnection, ASQL, AParams, AFreeParams, Result);
    lProv := TDataSetProvider.Create(Result);
    lProv.DataSet := lDataSet;
    Result.SetProvider(lProv);
    Result.Open;
  except
    FreeAndNil(Result);
    FreeAndNil(lDataSet);
    FreeAndNil(lProv);
  end;
end;

class function TDBXUtils.GetUpdateSet(AConnection: TSQLConnection; const AFields, ATable: string;
  AWhere: string = ''; AParams: TParams = nil; AFreeParams: Boolean = True): TClientDataSet;
var
  lDataSet: TSQLDataSet;
  lProv: TDataSetProvider;
begin
  Result := TClientDataSet.Create(nil);
  try
    lDataSet := GetDataSet(AConnection, AFields, ATable, AWhere, AParams,
      AFreeParams, Result);
    lProv := TDataSetProvider.Create(Result);
    lProv.DataSet := lDataSet;
    Result.SetProvider(lProv);
    Result.Open;
  except
    FreeAndNil(Result);
    FreeAndNil(lDataSet);
    FreeAndNil(lProv);
  end;
end;

class function TDBXUtils.MakeParamList(const AName: string; ADataType: TFieldType; AValue: Variant;
  AParamType: TParamType = ptInput; ASize: Integer = 0): TParams;
begin
  Result := DoMakeParamList(TParams, TParam, AddParam, AName, ADataType, AValue, AParamType, ASize);
end;

class function TDBXUtils.AddParam(AParams: TParams; const AName: string;
  ADataType: TFieldType; AValue: Variant; AParamType: TParamType;
  ASize: Integer): TParam;
begin
  Result := MakeParam(AName, ADataType, AValue, AParamType, ASize);
  AParams.AddParam(Result);
end;

class function TDBXUtils.MakeParamList(AParams: array of TParam): TParams;
var
  lParam: TParam;
begin
  Result := TParams.Create();
  for lParam in AParams do
    Result.AddParam(lParam);
end;

class procedure TDBXUtils.SetParameterValue(AParam: TParam; AValue: string);
begin
  if (AParam.Size > 0) and (Length(AValue) > AParam.Size) then
    AParam.AsString := Copy(AValue, 1, AParam.Size)
  else
    AParam.AsString := AValue;
end;


end.

