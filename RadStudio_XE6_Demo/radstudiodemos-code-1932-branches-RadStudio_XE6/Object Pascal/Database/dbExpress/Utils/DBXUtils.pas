
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc.@scottbartley @KFCNZ
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

unit DBXUtils;

interface

uses Classes, DBXCommon, DBXMetaDataProvider, DBXMetaDataReader,
  DBXMetaDataWriter, DBXCommonTable, DBXTypedTableStorage, SysUtils,
  DB, SqlExpr, DBClient, Rtti, Generics.Collections, Datasnap.DSClientRest;

type
  EDBXUtils = class(Exception);
  EDBXMigrator = class(Exception);
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
  TDBXUtils<T: constructor, class> = class
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

    ///	<summary>
    ///	  Returns a <c>TObjectList</c> populated with instances of the specified type,
    ///	  using the specified <c>TDataSet</c>.
    ///	</summary>
    ///	<param name="ADataSet">
    ///	  The <c>TDataSet</c> to populate the <c>TObjectList</c> instance from.
    ///	</param>
    ///	<param name="AUseSmartID">
    ///	  Optional. Indicates whether there will be smart mapping between the
    ///	  database primary key field and the property representing this data.
    ///	  For example, TCustomer.ID would be populated from the 'CUSTOMER_ID'
    ///	  field. Defaults to <c>True</c>.
    ///	</param>
    ///	<returns>
    ///	  Returns a populated <c>TObjectList</c> list with instances resolved from each row
    ///	  in the specified <c>TDataSet</c>.
    ///	</returns>
    class function ListFromDataSet(ADataSet: TDataSet; AUseSmartID: Boolean = True): TObjectList<T>;

    ///	<summary>
    ///	  Returns a <c>TObject</c> descendant populated using the specified
    ///   <c>TDataSet</c>.
    ///	</summary>
    ///	<param name="ADataSet">
    ///	  The <c>TDataSet</c> to populate the <c>TObjectList</c> instance from.
    ///	</param>
    ///	<param name="AUseSmartID">
    ///	  Optional. Indicates whether there will be smart mapping between the
    ///	  database primary key field and the property representing this data.
    ///	  For example, TCustomer.ID would be populated from the 'CUSTOMER_ID'
    ///	  field. Defaults to <c>True</c>.
    ///	</param>
    ///	<returns>
    ///	  Returns a populated <c>TObject</c> populated using the specified <c>TDataSet</c>.
    ///	</returns>
    class function ObjectFromDataSet(ADataSet: TDataSet; AUseSmartID: Boolean = True): T;

     ///	<summary>
    ///	  Populates a <c>TObject</c> descendant from the current record in the
    //    the specified <c>TDataSet</c>.
    ///	</summary>
    ///	<param name="ADataSet">
    ///	  The <c>TDataSet</c> to populate the <c>TObjectList</c> instance from.
    ///	</param>
    ///	<param name="AUseSmartID">
    ///	  Optional. Indicates whether there will be smart mapping between the
    ///	  database primary key field and the property representing this data.
    ///	  For example, TCustomer.ID would be populated from the 'CUSTOMER_ID'
    ///	  field. Defaults to <c>True</c>.
    ///	</param>
    class procedure PopulateFromDataSet(AObject: T; ADataSet: TDataSet;
      AUseSmartID: Boolean = True);

    /// <summary>
    ///  Saves the specified <c>TObjectList</c> instance to a comma seperated file,
    /// </summary>
    /// <param name="AObjects">
    ///   The <c>TObjectList</c> instance to save to file.
    /// </param>
    /// <param name="AFileName">
    ///   The name of the file to save the specified <c>TObjectList</c> to.
    /// </param>
    /// <param name="ADelimeter">
    ///   Optional. A delimeter to use for string fields. Defaults to "
    /// <param>
    /// <param name="AReplDelimeter">
    ///   Optional. If a delimeter is specified, this is used to replace all
    ///   instances of the delimeter in the data. Defaults to ''''
    /// </param>
    class procedure SaveToCSV(AObjects: TObjectList<T>; AFileName: string; ADelimeter: string = '"'; AReplDelimeter: string = ''''); static;
  end;

function DBXGetConnectionFile(ACreateIfMissing: boolean = False): string;
function DBXGetConnectionList: TStrings;
procedure DBXCreateConnection(const AConnectionName: string;
  const AProperties: string); overload;
procedure DBXCreateConnection(AConnectionName: string;
  AProperties: TStrings); overload;
function DBXConnectionExists(const AConnectionName: string): boolean;
function DBXRemoveConnection(AConnectionName: string): boolean;
function DBXGetValueAsString(AValue: TDBXValue): string;
function DBXGetCollectionCount(const ACollection: TDBXTable): integer;
function DBXGetTableCount(const AProvider: TDBXMetaDataProvider): integer;
function DBXGetTableList(const AConnectionName: string;
  ATableType : string = ''): TStrings; overload;
function DBXGetTableList(const AConnection: TDBXConnection;
  ATableType : string = ''): TStrings; overload;
function DBXGetTableList(const AProvider: TDBXMetaDataProvider;
  ATableType : string = ''): TStrings; overload;
//function DBXGetTableList(const AProvider: TDBXMetaDataProvider;
//  ATableType: string = ''): TStringArray; overload;
function DBXTableExists(const AProvider: TDBXMetaDataProvider;
  const ATableName: string): Boolean;
function DBXProcedureExists(const AProvider: TDBXMetaDataProvider;
  const AProcedureName: string): Boolean;
function DBXGetHostName(const AConnection: TDBXConnection): string; overload;
function DBXGetHostName(const AConnectionName: string): string; overload;
function DBXGetDataBaseName(const AConnection: TDBXConnection): string; overload;
function DBXGetDataBaseName(const AConnectionName: string): string; overload;
function DBXGetConnectionName(const AConnection: TDBXConnection): string;
function DBXGetRowCount(const AConnection: TDBXConnection;
  const ATableName: string): int64;
function DBXGetConnection(const AConnectionName: string;
  const AUserName : string = ''; const APassword: string = '')
  : TDBXConnection;
function DBXGetMetaProvider(const AConnection: TDBXConnection):
  TDBXMetaDataProvider;
function DBXSchemaToString(const AConnectionName: string): string;
function DBXGetProcedureSource(const AConnection: TDBXConnection;
  AProcedure: string) : string;

// No overloads based on connection or connectionstring are available for these
// routines because the provider must still be instantiated, so no
// freeing can be done on the provider while the collection is being
// iterated.
{ TODO :
Make a version of these methods that will load the results into
memory structure so they can be overloaded for connections
and connection names }

function DBXGetTables(const AProvider: TDBXMetaDataProvider):
  TDBXTablesTableStorage;
function DBXGetProcedures(const AProvider: TDBXMetaDataProvider):
  TDBXProceduresTableStorage;
function DBXGetProcedureSources(const AProvider: TDBXMetaDataProvider):
  TDBXProcedureSourcesTableStorage;
function DBXGetProcedureParameters(const AProvider: TDBXMetaDataProvider;
  const AProcName: string): TDBXProcedureParametersTableStorage;
function DBXGetIndexes(const AProvider: TDBXMetaDataProvider;
  const ATableName: string): TDBXIndexesTableStorage;
function DBXGetIndexColumns(const AProvider: TDBXMetaDataProvider;
  const ATableName, AIndexName: string ): TDBXIndexColumnsTableStorage;
function DBXGetColumns(const AProvider: TDBXMetaDataProvider;
  const ATableName: string): TDBXColumnsTableStorage;
function DBXGetColumnConstraints(const AProvider: TDBXMetaDataProvider;
  const ATableName, AColumnName: string): TDBXColumnConstraintsTableStorage;
function DBXGetDataTypes(const AConnection: TDBXConnection): TStrings;
function DBXGetTypeFromName(ATypes: TStrings; AName: string): TDBXType;

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
function CreateConnection(const AName: string;
  AIniFile: string = ''): TSQLConnection;

///  <summary>
///  Create a <c>TDSRestConnection</c> with the specified connection name
///  using the configuration parameters specified in application.ini
///  </summary>
///  <param name="AName">Name of connection to open</param>
///  <param name="AIniFile">Optional. Name of the Ini file.
///  Defaults to the application name + '.ini'</param>
///  <remarks>
///  The object returned will need to be freed in the caller
///  </remarks>
function CreateRestConnection(const AName: string;
  AIniFile: string = ''): TDSRestConnection;

///  <summary>
///  Create and open a <c>TSQLConnection</c> with the specified connection name
///  for dbxconnections.ini
///  </summary>
///  <param name="AName">Name of connection to open</param>
///  <remarks>
///  The object returned will need to be freed in the caller
///  </remarks>
function CreateConnectionName(const AName: string): TSQLConnection;

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
function CreateConnectionIni(const AIniSection: string;
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
function CreateConnectionProps(
  const ADatabase, AUserName, APassword: string;
  const ADriverName: string = 'INTERBASE';
  const AExtra: string = ''): TSQLConnection;

///  <summary>
///  Create a <c>TDSRestConnection</c> with the specified connection properties
///  </summary>
///  <param name="AHost">Name of the host where the REST server resides</param>
///  <param name="AUrlPath">URL path of the REST server. Defaults to ''</param>
///  <param name="APort">Port that the REST server is listening on. Defaults to 8080</param>
///  <param name="AProtocol">Protocol to use when communicating with the REST server. Defaults to 'http'</param>
///  <param name="AContext">Context of the REST server. Defaults to 'datasnap/'</param>
///  <param name="AUserName">REST user name</param>
///  <param name="APassword">Password for <c>AUserName</c></param>
///  <param name="AProxyHost">Name of the proxy server to use. If an empty string is specified, no proxy server is used. Defaults to ''</param>
///  <param name="AProxyPort">Port of the proxy server. Defaults to 8888 (default port for Fiddler) </param>
///  <param name="AProxyUserName">Proxy server user name. Defaults to ''</param>
///  <param name="AProxyPassword">Password for <c>AProxyUserName</c>. Defaults to ''</param>
///  <remarks>
///  The object returned will need to be freed in the caller
///  </remarks>
function CreateRestConnectionProps(
  const AHost: string; const AUrlPath: string = ''; const APort: Integer = 8080;
  const AProtocol: string = 'http'; AContext: string = 'datasnap/';
  AUserName: string = ''; APassword: string = ''; AProxyHost: string = '';
  AProxyPort: Integer = 8888; AProxyUserName: string = ''; AProxyPassword: string = ''): TDSRestConnection;

///  <summary>
///  Initialize and open a <c>TSQLConnection</c> with the specified connection name
///  trying to open it a) first by trying application.ini then b) by
///  reading dbxconnections.ini if a) fails
///  </summary>
///  <param name="AConnection">The TSQLConnection instance to initialize</param>
///  <param name="AName">Name of connection to open</param>
///  <param name="AIniFile">Optional. Name of the Ini file.
///  Defaults to the application name + '.ini'</param>
procedure InitConnection(AConnection: TSQLConnection; const AName: string;
  AIniFile: string = '');

//  <summary>
///  Initialize a <c>TDSRestConnection</c> with the specified connection name
///  using the configuration specified in application.ini
///  </summary>
///  <param name="AConnection">The TDSRestConnection instance to initialize</param>
///  <param name="AName">Name of connection to open</param>
///  <param name="AIniFile">Optional. Name of the Ini file.
///  Defaults to the application name + '.ini'</param>
procedure InitRestConnection(AConnection: TDSRestConnection; const AName: string;
  AIniFile: string = '');

///  <summary>
///  Intializes and opens a <c>TSQLConnection</c> with the specified connection name
///  for dbxconnections.ini
///  </summary>
///  <param name="AConnection">The TSQLConnection instance to initialize</param>
///  <param name="AName">Name of connection to open</param>
procedure InitConnectionName(AConnection: TSQLConnection; const AName: string);

///  <summary>
///  Initializes and opens a <c>TSQLConnection</c> with properties read from the
///  application ini
///  </summary>
///  <param name="AConnection">The TSQLConnection instance to initialize</param>
///  <param name="AIniSection">Name of the Ini section to read</param>
///  <param name="AIniFile">Optional. Name of the Ini file.
///  Defaults to the application name + '.ini'
///  </param>
procedure InitConnectionIni(AConnection: TSQLConnection;
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
procedure InitConnectionProps(
  AConnection: TSQLConnection;
  const ADatabase, AUserName, APassword: string;
  const ADriverName: string = 'INTERBASE';
  const AExtra: string = '');

///  <summary>
///  Initializes a <c>TDSRestConnection</c> with the specified connection properties
///  </summary>
///  <param name="AConnection". The TDSRestConnection instance to intialize</param>
///  <param name="AHost">Name of the host where the REST server resides</param>
///  <param name="AUrlPath">URL path of the REST server. Defaults to ''</param>
///  <param name="APort">Port that the REST server is listening on. Defaults to 8080</param>
///  <param name="AProtocol">Protocol to use when communicating with the REST server. Defaults to 'http'</param>
///  <param name="AContext">Context of the REST server. Defaults to 'datasnap/'</param>
///  <param name="AUserName">REST user name</param>
///  <param name="APassword">Password for <c>AUserName</c></param>
///  <param name="AProxyHost">Name of the proxy server to use. If an empty string is specified, no proxy server is used. Defaults to ''</param>
///  <param name="AProxyPort">Port of the proxy server. Defaults to 8888 (default port for Fiddler) </param>
///  <param name="AProxyUserName">Proxy server user name. Defaults to ''</param>
///  <param name="AProxyPassword">Password for <c>AProxyUserName</c>. Defaults to ''</param>
///  <remarks>
///  The object returned will need to be freed in the caller
///  </remarks>
procedure InitRestConnectionProps(
  AConnection: TDSRestConnection;
  const AHost: string; const AUrlPath: string = ''; const APort: Integer = 8080;
  const AProtocol: string = 'http'; AContext: string = 'datasnap/';
  AUserName: string = ''; APassword: string = ''; AProxyHost: string = '';
  AProxyPort: Integer = 8888; AProxyUserName: string = ''; AProxyPassword: string = '');

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
///  <param name="AOwner" type="TComponent">
///  Component owner to use for the returned DataSet
///  </param>
///  <param name="AParamCheck" type="boolean">
///  Sets the ParamCheck property of the returned <c>TSQLDataSet</c> instance. Defaults to true.
///  </param>
///  <returns>The created <c>TSQLDataSet</c></returns>
function CreateDataSet(AConnection: TSQLConnection; ASQL: string = '';
  ACommandType: TSQLCommandType = ctQuery; AOwner: TComponent = nil; AParamCheck: Boolean = True): TSQLDataSet;

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
function GetCount(AConnection: TSQLConnection; const ATable: string;
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
function GetValue(AConnection: TSQLConnection; const AFieldOrSQL, ATable: string;
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
function GetValueNullDefault(AConnection: TSQLConnection; const AFieldOrSQL, ATable: string;
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
function QueryValue(AConnection: TSQLConnection; const ASQL: string;
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
function QueryValueNullDefault(AConnection: TSQLConnection; const ASQL: string;
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
function GetBytes(AConnection: TSQLConnection; const AField, ATable: string;
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
function GetMemo(AConnection: TSQLConnection; const AField, ATable: string;
  ADefault: string = ''; const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): string;

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
function ExecNoQuery(AConnection: TSQLConnection; const ASQL: string;
  AParams: TParams = nil; AFreeParams: Boolean = True): Integer;

///  <summary>
///  Open a <c>TSQLDataSet</c> from its connection and SQL statement
///  </summary>
///  <remarks>
///
///  </remarks>
///  <param name="AConnection"><c>TSQLConnection</c> to use for the database connection</param>
///  <param name="AProcName">Name of procedure to execute</param>
///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
///  Defaults to nil.</param>
///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
///  <param name="AReturnParamName">Name of procedure return value</param>
///  <returns>A <c>Variant</c> with the result of the procedure call
///  if <c>AReturnParamName</c> is defined and found</returns>
function ExecProc(AConnection: TSQLConnection; const AProcName: string;
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
function GetDataSet(AConnection: TSQLConnection; const ASQL: string;
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
function GetDataSet(AConnection: TSQLConnection; const AFields, ATable: string;
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
function RecordExists(AConnection: TSQLConnection; const ASQL: string;
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
function RecordExists(AConnection: TSQLConnection; const AFields, ATable: string;
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
function DataSetToCDS(ADataSet: TSQLDataSet): TClientDataSet;

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
function GetClientDataSet(AConnection: TSQLConnection; const ASQL: string;
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
function GetClientDataSet(AConnection: TSQLConnection; const AFields, ATable: string;
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
function GetUpdateSet(AConnection: TSQLConnection; const ASQL: string;
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
function GetUpdateSet(AConnection: TSQLConnection; const AFields, ATable: string;
  AWhere: string = ''; AParams: TParams = nil; AFreeParams: Boolean = True): TClientDataSet; overload;

///  <summary>
///  Create a <c>TParam</c> with the specified values
///  </summary>
///  <remarks>
///  This object will need to be freed in the client code, or with its parent <c>TParams</c>
///  </remarks>
///  <param name="AName">Name of the parameter to create</param>
///  <param name="ADataType"><c>TFieldType</c> to use as the DataType for the
///  <c>TParam</c></param>
///  <param name="AValue">Value to assign to the <c>TParam</c></param>
///  <param name="AParamType">Optional <c>TParamType</c> for the <c>TParam</c>.
///  Defaults to <c>ptInput</c></param>
///  <param name="ASize">Optional <c>Integer</c> to use as the Size. Defaults to 0,
///  but it must be set for some data types.</param>
///  <returns>The initialized <c>TParam</c></returns>
function MakeParam(const AName: string; ADataType: TFieldType; AValue: Variant;
  AParamType: TParamType = ptInput; ASize: Integer = 0): TParam;

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
function MakeParamList(const AName: string; ADataType: TFieldType; AValue: Variant;
  AParamType: TParamType = ptInput; ASize: Integer = 0): TParams; overload;

///  <summary>
///  Creates a <c>TParams</c> and adds one initialized <c>TParam</c> to it
///  </summary>
///  <remarks>
///  This object will need to be freed in the client code
///  </remarks>
///  <param name="AParams">array of initialized <c>TParam</c> objects</param>
///  <returns>The initialized <c>TParams</c> collection</returns>
function MakeParamList(AParams: array of TParam): TParams; overload;

/// <summary>
///  Return the full file path of the active module, whether the module is an
///  .EXE or a DLL
///  </summary>
///  <remarks>
///  ParamStr(0) will not return the expected value for a Delphi dll that is,
///  for example, an ISAPI dll hosted in IIS, and Application exename is not
///  available in many types of applications. This routine can be used
///  instead for both executables and hosted DLLs to get the local path
///  of the "module"
///  </remarks>
///  <returns>The fully qualified file path to the active module</returns>
function ModuleName: string;

/// <summary>
///  Return the local file path of the active module, whether the module is an
///  .EXE or a DLL
///  </summary>
///  <remarks>
///  ParamStr(0) will not return the expected value for a Delphi dll that is,
///  for example, an ISAPI dll hosted in IIS, and Application exename is not
///  available in many types of applications. This routine can be used
///  instead for both executables and hosted DLLs to get the local path
///  of the "module"
///  </remarks>
///  <param name="AFileName">Optional. String to append to the ModulePath</param>
///  <returns>The fully qualified file path to the active module</returns>
function ModulePath(AFileName: string = '') : string;

/// <summary>
/// Returns the path to an ini file for the active module
///  </summary>
///  <remarks>
///  ParamStr(0) will not return the expected value for a Delphi dll that is,
///  for example, an ISAPI dll hosted in IIS, and Application exename is not
///  available in many types of applications. This routine can be used
///  instead for both executables and hosted DLLs to get the local path
///  of the "module"
///  </remarks>
///  <returns><c>ModulePath</c> + ApplicationFirstName.ini</returns>
function ModuleIniFile : string;

///	<summary>
///	  Returns the field name for a specified property name.
///	</summary>
///	<param name="APropName">
///	  The name of the property
///	</param>
///	<returns>
///	  The name of the property as it would be represented as a database field
///	</returns>
///	<remarks>
///	  Property names are converted to uppercase field names with an underscore 
///	  inserted for words broken up using a Camel Case convention. For example,
///	  a property with the name 'FooBar' would be returned as 'FOO_BAR'.
///	</remarks>
function PropNameToFieldName(APropName: string): string;

///	<summary>
///	  Returns the property name for a specified database field name
///	</summary>
///	<param name="AFieldName">
///	  The name of the database field
///	</param>
///	<returns>
///	  The name of the database field as it would be represented as a property
///	</returns>
///	<remarks>
///	  This routine simply strips out any underscore characters, and does not
///	  attempt to Camel Case the result. For example, a database field with the
///	  name 'FOO_BAR' would be returned as 'FOOBAR'.
///	</remarks>
function FieldNameToPropName(AFieldName: string): string;

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
procedure SetParameterValue(AParam: TParam; AValue: string);

/// <summary>
///  Decodes a string stored in a binary blob field, based on the specified
///  encoding.
/// <param name="AMemoField">
///  The TField instance contaning the blob data
/// </param>
/// <param name="AEncoding">
///  The TEncoding instance to use when decoding the binary data in the specified field.
/// </param>
/// <returns>
///   Returns the decoded string data in the specified field using the specified encoding
/// </returns>
function DecodeString(AMemoField: TField; AEncoding: TEncoding): string;
/// <summary>
///  Decodes a UTF7 string stored in a binary blob field
/// <param name="AMemoField">
///  The TField instance contaning the blob data
/// </param>
/// <returns>
///   Returns the decoded UTF7 string data in the specified field
/// </returns>
function AsUTF7String(AMemoField: TField): string;
/// <summary>
///  Decodes a UTF8 string stored in a binary blob field
/// <param name="AMemoField">
///  The TField instance contaning the blob data
/// </param>
/// <returns>
///   Returns the decoded UTF8 string data in the specified field
/// </returns>
function AsUTF8String(AMemoField: TField): string; /// <summary>
///  Decodes a Unicode string stored in a binary blob field
/// <param name="AMemoField">
///  The TField instance contaning the blob data
/// </param>
/// <returns>
///   Returns the decoded Unicode string data in the specified field
/// </returns>
function AsUnicodeString(AMemoField: TField): string;

function TOrF(AInput: Boolean): char;

function YOrN(AInput: Boolean): char;

resourcestring
  StrDbxConnectionNotFound = 'DBXGetConnection for "%s" failed.'#13
    + 'Please check for dbxconnections.ini and that dbExpress is installed';
  StrCollectionFailed = 'Failed to get collection of %s';
  StrCouldNotOpenConnection = 'Could not open connection %s via dbxconnectio' +
  'ns.ini (%s) or application.ini (%s)';
  StrCouldNotInitConnection = 'Could not initialize connection %s via application.ini (%s)';
  StrAppIniMissing = 'Application.ini file %s does not exist';
  StrIniWasNotFound = '%s was not found';


const
  SDatabase = 'Database';
  SUserName = 'UserName';
  SPassword = 'Password';
  SDriver = 'Driver';
  SDefaultUser = 'sysdba';
  SDefaultPassword = 'masterkey';
  SDefaultDriver = 'INTERBASE';
  SHost = 'Host';
  SUrlPath = 'UrlPath';
  SProtocol = 'Protocol';
  SContext = 'Context';
  SProxyHost = 'ProxyHost';
  SProxyUserName = 'ProxyUserName';
  SProxyPassword = 'ProxyPassword';
  SPort = 'Port';
  SProxyPort = 'ProxyPort';
  SDefaultHost = '';
  SDefaultUrlPath = '';
  SDefaultProtocol = 'http';
  SDefaultContext = '';
  SDefaultRestUser = '';
  SDefaultRestPassword = '';
  SDefaultProxyHost = '';
  SDefaultProxyUser = '';
  SDefaultProxyPassword = '';
  SDefaultPort = 8080;
  SDefaultProxyPort = 8888;

implementation

uses SqlTimSt, FmtBCD, DBXMetaDataNames, DBXDataExpressMetaDataProvider,
  {$IFDEF MACOS}
  Posix.Unistd,
  {$ELSE}
  Registry,
  Windows,
  {$ENDIF}
  IniFiles, SyncObjs, Provider, Character, TypInfo;

type
  TObjectClass = class of TObject;

var
  ThreadLock: TCriticalSection;

function ModuleName: string;
var
  FN: array[0..MAX_PATH- 1] of Char;
begin
  SetString(Result, FN, GetModuleFileName(hInstance, FN, SizeOf(FN)));
end;

function ModulePath(AFileName : string = '') : string;
begin
  Result := ExtractFilePath(ModuleName) + LowerCase(ExtractFileName(AFileName));
  if Pos('\\?\', Result) = 1 then
    Result := Copy(Result, 5, Length(Result));
end; { LocalServerPath() }

function ModuleIniFile : string;
var
  FN: array[0..MAX_PATH- 1] of char;
  sPath : string;
begin
  SetString(sPath, FN, GetModuleFileName(hInstance, FN, SizeOf(FN)));
  Result := ChangeFileExt( sPath, '.ini' );
end; { ServerINIFile() }

{ TDBXIntObj }
constructor TDBXIntObj.Create(AValue: Integer);
begin
  inherited Create;
  FValue := AValue;
end;

procedure CheckCollection(const AObject: TObject;
  const ADesiredType: TObjectClass; const ADesc: string);
begin
  if (not Assigned(AObject)) or (not (AObject is ADesiredType)) then
    Raise EDBXMigrator.CreateFmt(StrCollectionFailed,
      [ADesc]);
end;

procedure WriteIniSection(AIni: TIniFile; ASection: string; AValues: TStrings);
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

function DBXGetConnectionList: TStrings;
begin
  // Populate list of available connections
  Result := TStringList.Create;
  TDBXConnectionFactory.GetConnectionFactory.GetConnectionItems(Result);
  (Result as TStringList).Sort;
end;

function DBXConnectionExists(const AConnectionName: string): boolean;
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

function DBXGetConnectionFile(ACreateIfMissing: boolean = False): string;
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

  {$IFNDEF MACOS}
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
     {$IFNDEF MACOS}
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

procedure DBXCreateConnection(const AConnectionName: string;
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

procedure DBXCreateConnection(AConnectionName: string;
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

function DBXRemoveConnection(AConnectionName: string): boolean;
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

function DBXSchemaToString(const AConnectionName: string): string;
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

function DBXGetProcedures(const AProvider: TDBXMetaDataProvider):
  TDBXProceduresTableStorage;
var
  Coll: TDBXTable;
begin
  // Retrieve a collection of all the procedure sources in the database.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetProcedures);
  CheckCollection(Coll, TDBXProceduresTableStorage, 'procedures');
  Result := Coll as TDBXProceduresTableStorage;
end;

function DBXGetProcedureSources(const AProvider: TDBXMetaDataProvider):
  TDBXProcedureSourcesTableStorage;
var
  Coll: TDBXTable;
begin
  // Retrieve a collection of all the procedure sources in the database.
  Coll := AProvider.GetCollection(TDBXMetaDataCommands.GetProcedures);
  CheckCollection(Coll, TDBXProcedureSourcesTableStorage, 'procedures');
  Result := Coll as TDBXProcedureSourcesTableStorage;
end;

function DBXGetTables(const AProvider: TDBXMetaDataProvider):
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
function DBXGetColumns(const AProvider: TDBXMetaDataProvider;
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

function DBXGetColumnConstraints(const AProvider: TDBXMetaDataProvider;
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

function DBXGetProcedureParameters(const AProvider: TDBXMetaDataProvider;
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
function DBXGetIndexes(const AProvider: TDBXMetaDataProvider;
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

function DBXGetIndexColumns(const AProvider: TDBXMetaDataProvider;
  const ATableName, AIndexName: string ): TDBXIndexColumnsTableStorage; overload;
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

function DBXGetCollectionCount(const ACollection: TDBXTable): integer;
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
function DBXGetTableCount(const AProvider: TDBXMetaDataProvider): Integer;
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

function DBXGetTableList(const AConnectionName: string;
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

function DBXGetTableList(const AConnection: TDBXConnection;
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

function DBXGetTableList(const AProvider: TDBXMetaDataProvider;
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
function DBXGetValueAsString(AValue: TDBXValue): string;
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

    TDBXDataTypes.AnsiStringType:
    {$IFDEF NEXTGEN}
      Result := AValue.GetString;
    {$ELSE}
      Result := string(AValue.GetAnsiString);
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
function DBXTableExists(const AProvider: TDBXMetaDataProvider;
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
function DBXProcedureExists(const AProvider: TDBXMetaDataProvider;
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

function DBXGetHostName(const AConnection: TDBXConnection): string;
begin
  Result := AConnection.ConnectionProperties.Values[TDBXPropertyNames.HostName];
end;

function DBXGetHostName(const AConnectionName: string): string;
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

function DBXGetDataBaseName(const AConnection: TDBXConnection): string;
begin
  Result := AConnection.ConnectionProperties.Values[TDBXPropertyNames.Database];
end;

function DBXGetDataBaseName(const AConnectionName: string): string;
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

function DBXGetConnectionName(const AConnection: TDBXConnection): string;
begin
  Result := AConnection.ConnectionProperties.Values[
    TDBXPropertyNames.ConnectionName ];
end;

function DBXGetProcedureSource(const AConnection: TDBXConnection;
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

function DBXGetRowCount(const AConnection: TDBXConnection;
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

function DBXGetConnection(const AConnectionName: string;
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
function DBXGetMetaProvider(const AConnection: TDBXConnection):
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

function DBXGetDataTypes(const AConnection: TDBXConnection): TStrings;
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

function DBXGetTypeFromName(ATypes: TStrings; AName: string): TDBXType;
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

procedure CloneParameters(ADataSet: TSQLDataSet; AParams: TParams);
var
  lItem: TCollectionItem;
  lNewParam: TParam;
begin
  ADataSet.Params.Clear;
  for lItem in AParams do
  begin
    lNewParam := TParam.Create(ADataSet.Params);
    lNewParam.Assign(lItem);
  end;
end;

procedure PopulateDataSet(ADataSet: TSQLDataSet; const AFieldsOrSQL, ATable, AWhere: string;
  AParams: TParams);
begin
  if ATable <> '' then
  begin
    if AWhere <> '' then
      ADataSet.CommandText := Format('SELECT %s FROM %s WHERE %s', [AFieldsOrSQL, ATable, AWhere])
    else
      ADataSet.CommandText := Format('SELECT %s FROM %s', [AFieldsOrSQL, ATable, AWhere]);
  end
  else
    //Assume we've been passed a complete SQL statement
    ADataSet.CommandText := AFieldsOrSQL;

  if Assigned(AParams) then
    CloneParameters(ADataSet, AParams);
end;

function CreateConnection(const AName: string;
  AIniFile: string = ''): TSQLConnection;
begin
  ThreadLock.Acquire;
  try
    Result := TSQLConnection.Create(nil);
    try
      InitConnection(Result, AName, AIniFile);
    except
      Result.Free;
      raise;
    end;
  finally
    ThreadLock.Release;
  end;
end;

function CreateRestConnection(const AName: string;
  AIniFile: string = ''): TDSRestConnection;
begin
  ThreadLock.Acquire;
  try
    Result := TDSRestConnection.Create(nil);
    try
      InitRestConnection(Result, AName, AIniFile);
    except
      Result.Free;
      raise;
    end;
  finally
    ThreadLock.Release;
  end;
end;

function CreateConnectionName(const AName: string): TSQLConnection;
begin
  ThreadLock.Acquire;
  try
    Result := TSQLConnection.Create(nil);
    try
      InitConnectionName(Result, AName);
    except
      Result.Free;
      raise;
    end;
  finally
    ThreadLock.Release;
  end;
end;


function CreateConnectionIni(const AIniSection: string;
  AIniFile: string = ''): TSQLConnection;
begin
  ThreadLock.Acquire;
  try
    Result := TSQLConnection.Create(nil);
    try
      InitConnectionIni(Result, AIniSection, AIniFile);
    except
      Result.Free;
      raise;
    end;
  finally
    ThreadLock.Release;
  end;
end;

function CreateConnectionProps(
  const ADatabase, AUserName, APassword: string;
  const ADriverName: string = 'INTERBASE';
  const AExtra: string = '') : TSQLConnection;
begin
  ThreadLock.Acquire;
  try
    Result := TSQLConnection.Create(nil);
    try
      InitConnectionProps(Result, ADatabase, AUserName, APassword, ADriverName,
        AExtra);
    except
      Result.Free;
      raise;
    end;
  finally
    ThreadLock.Release;
  end;
end;

function CreateRestConnectionProps(
  const AHost: string; const AUrlPath: string = ''; const APort: Integer = 8080;
  const AProtocol: string = 'http'; AContext: string = 'datasnap/';
  AUserName: string = ''; APassword: string = ''; AProxyHost: string = '';
  AProxyPort: Integer = 8888; AProxyUserName: string = ''; AProxyPassword: string = ''): TDSRestConnection;
begin
  ThreadLock.Acquire;
  try
    Result := TDSRestConnection.Create(nil);
    try
      InitRestConnectionProps(Result, AHost, AUrlPath, APort, AProtocol, AContext,
        AUserName, APassword, AProxyHost, AProxyPort, AProxyUserName, AProxyPassword);
    except
      Result.Free;
      raise;
    end;
  finally
    ThreadLock.Release;
  end;
end;

procedure InitConnection(AConnection: TSQLConnection; const AName: string;
  AIniFile: string = '');
var
  error1: string;
begin
  try
    InitConnectionIni(AConnection, AName, AIniFile)
  except
    on E: Exception do
    begin
      error1 := E.Message;
    end;
  end;
  if error1 <> '' then
    try
      InitConnectionName(AConnection, AName);
    except
      on E: Exception do
      begin
        raise EDBXUtils.CreateFmt(StrCouldNotOpenConnection,
          [AName, error1, E.Message] );
      end;
    end;
end;

procedure InitRestConnection(AConnection: TDSRestConnection; const AName: string;
  AIniFile: string = '');
var
  host,
  urlPath,
  protocol,
  context,
  userName,
  password,
  proxyHost,
  proxyUserName,
  proxyPassword: string;
  port,
  proxyPort: Integer;
  Ini: TIniFile;

begin
  try
    if Length(Trim(AIniFile)) = 0 then // default to exe name with .ini extension
      AIniFile := ModuleIniFile;
    if FileExists(AIniFile) then
    begin
      Ini := TIniFile.Create(AIniFile);
      try
        host := Ini.ReadString(AName, SHost, SDefaultHost);
        urlPath := Ini.ReadString(AName, SUrlPath, SDefaultUrlPath);
        protocol := Ini.ReadString(AName, SProtocol, SDefaultProtocol);
        context := Ini.ReadString(AName, SContext, SDefaultContext);
        userName := Ini.ReadString(AName, SUserName, SDefaultRestUser);
        password := Ini.ReadString(AName, SPassword, SDefaultRestPassword);
        proxyHost := Ini.ReadString(AName, SProxyHost, SDefaultProxyHost);
        proxyUserName := Ini.ReadString(AName, SProxyUserName, SDefaultProxyUser);
        proxyPassword := Ini.ReadString(AName, SProxyPassword, SDefaultProxyPassword);
        port := Ini.ReadInteger(AName, SPort, SDefaultPort);
        proxyPort := Ini.ReadInteger(AName, SProxyPort, SDefaultProxyPort);
        InitRestConnectionProps(AConnection, host, urlPath, port, protocol, context, userName, password, proxyHost, proxyPort, proxyUserName, ProxyPassword);
      finally
        Ini.Free;
      end;
    end
    else
      raise EDBXUtils.CreateFmt(StrAppIniMissing, [AIniFile]);
  except
    on E: Exception do
    begin
      raise EDBXUtils.CreateFmt(StrCouldNotInitConnection,
          [AName, E.Message] );
    end;
  end;
end;

procedure InitConnectionName(AConnection: TSQLConnection; const AName: string);
begin
  AConnection.ConnectionName := AName;
  AConnection.LoadParamsOnConnect := True;
  AConnection.Open;
end;

procedure InitConnectionIni(AConnection: TSQLConnection;
  const AIniSection: string; AIniFile: string = '');
var
  database,
  username,
  password,
  driver,
  extra,
  extraIni: string;
  lExtra: TStrings;
  lStr: string;
  Ini: TIniFile;
begin
  if Length(Trim(AIniFile)) = 0 then // default to exe name with .ini extension
    AIniFile := ModuleIniFile;
  if FileExists(AIniFile) then
  begin
    Ini := TIniFile.Create(AIniFile);
    try
      lExtra := TStringList.Create;
      try
        extraIni := AIniSection + 'Extra';
        Ini.ReadSection(extraIni, lExtra);
        for lStr in lExtra do
          extra := Format('%s%s=%s%s', [extra, lStr,
            Ini.ReadString(extraIni, lStr, ''), #13]);

        dataBase := Ini.ReadString(AIniSection, SDatabase, '');
        username := Ini.ReadString(AIniSection, SUserName, SDefaultUser);
        password := Ini.ReadString(AIniSection, SPassword, SDefaultPassword);
        driver := Ini.ReadString(AIniSection, SDriver, SDefaultDriver);
        InitConnectionProps(AConnection, database, username, password, driver,
          extra);
      finally
        lExtra.Free;
      end;
    finally
      Ini.Free;
    end;
  end
  else
    raise EDBXUtils.CreateFmt(StrAppIniMissing, [AIniFile]);
end;

procedure InitConnectionProps(
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

procedure InitRestConnectionProps(
  AConnection: TDSRestConnection;
  const AHost: string; const AUrlPath: string = ''; const APort: Integer = 8080;
  const AProtocol: string = 'http'; AContext: string = 'datasnap/';
  AUserName: string = ''; APassword: string = ''; AProxyHost: string = '';
  AProxyPort: Integer = 8888; AProxyUserName: string = ''; AProxyPassword: string = '');
begin
  AConnection.Host := AHost;
  AConnection.UrlPath := AUrlPath;
  AConnection.Port := APort;
  AConnection.Protocol := AProtocol;
  AConnection.Context := AContext;
  AConnection.UserName := AUserName;
  AConnection.Password := APassword;
  AConnection.LoginPrompt := False;
  AConnection.ProxyHost := AProxyHost;
  AConnection.ProxyPort := AProxyPort;
  AConnection.ProxyUsername := AProxyUserName;
  AConnection.ProxyPassword := AProxyPassword;
  AConnection.ProxyPort := AProxyPort;
end;

function CreateDataSet(AConnection: TSQLConnection; ASQL: string = '';
  ACommandType: TSQLCommandType = ctQuery; AOwner: TComponent = nil; AParamCheck: Boolean = True): TSQLDataSet;
begin
  Result := TSQLDataSet.Create(AOwner);
  Result.ParamCheck := AParamCheck;
  Result.SQLConnection := AConnection;
  Result.CommandType := ACommandType;
  Result.CommandText := ASQL;
end;

function GetCount(AConnection: TSQLConnection; const ATable: string;
  const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): int64;
begin
  Result := GetValue(AConnection, 'count(*)', ATable, -1, AWhere, AParams,
    AFreeParams);
end;

function GetValue(AConnection: TSQLConnection; const AFieldOrSQL, ATable: string;
  ADefault: Variant; const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := GetValueNullDefault(AConnection, AFieldOrSQL, ATable, ADefault, ADefault,
    AWhere, AParams, AFreeParams);
end;

function QueryValue(AConnection: TSQLConnection; const ASQL: string;
  ADefault: Variant; AParams: TParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := QueryValueNullDefault(AConnection, ASQL, ADefault, ADefault, AParams,
    AFreeParams);
end;

function QueryValueNullDefault(AConnection: TSQLConnection; const ASQL: string;
  ADefault, ANullDefault: Variant; AParams: TParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := GetValueNullDefault(AConnection, ASQL, '', ADefault, ANullDefault,
    '', AParams, AFreeParams);
end;

function GetValueNullDefault(AConnection: TSQLConnection; const AFieldOrSQL, ATable: string;
  ADefault, ANullDefault: Variant; const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): Variant;
var
  lDataSet: TSQLDataSet;
begin
  lDataSet := CreateDataSet(AConnection);
  try
    try
      lDataSet.GetMetadata := False;
      PopulateDataSet(lDataSet, AFieldOrSQL, ATable, AWhere, AParams);
      lDataSet.Open;
      if not lDataSet.Eof then
        if not lDataSet.Fields[0].IsNull then
          Result := lDataSet.Fields[0].Value
        else
          Result := ANullDefault
      else
        Result := ADefault;
    finally
     if Assigned(AParams) and AFreeParams then
        AParams.Free;
    end;
  finally
    lDataSet.Free;
  end;
end;

function GetBytes(AConnection: TSQLConnection; const AField, ATable: string;
  ADefault: TBytes; const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): TBytes;
var
  lDataSet: TSQLDataSet;
begin
  lDataSet := CreateDataSet(AConnection);
  try
    try
      PopulateDataSet(lDataSet, AField, ATable, AWhere, AParams);
      lDataSet.Open;
      if not lDataSet.Eof then
        Result := lDataSet.Fields[0].AsBytes
      else
        Result := ADefault;
    finally
      if Assigned(AParams) and AFreeParams then
        AParams.Free;
    end;
  finally
    lDataSet.Free;
  end;
end;

function GetMemo(AConnection: TSQLConnection; const AField, ATable: string;
  ADefault: string = ''; const AWhere: string = ''; AParams: TParams = nil;
  AFreeParams: Boolean = True): string;
var
  lBytes: TBytes;
begin
  lBytes := GetBytes(AConnection, AField, ATable, nil, AWhere, AParams, AFreeParams);
  if Assigned(lBytes) then
    Result := TEncoding.Default.GetString(lBytes)
  else
    Result := ADefault;
end;

function ExecNoQuery(AConnection: TSQLConnection; const ASQL: string;
  AParams: TParams = nil; AFreeParams: Boolean = True): Integer;
var
  lDataSet: TSQLDataSet;
begin
  lDataSet := CreateDataSet(AConnection, ASQL);
  try
    try
      if Assigned(AParams) then
        CloneParameters(lDataSet, AParams);
      Result := lDataSet.ExecSQL;
    finally
      if Assigned(AParams) and AFreeParams then
        AParams.Free;
    end;
  finally
    lDataSet.Free;
  end;
end;

function ExecProc(AConnection: TSQLConnection; const AProcName: string;
  AParams: TParams = nil; AFreeParams: Boolean = True;
  AReturnParamName: string = 'RETURN_VALUE'; AParamCheck: Boolean = True): Variant;
var
  lDataSet: TSQLDataSet;
  lParam: TParam;
begin
  lDataSet := CreateDataSet(AConnection, AProcName, ctStoredProc, nil, AParamCheck);
  try
    try
      if Assigned(AParams) then
        CloneParameters(lDataSet, AParams);
      lDataSet.ExecSQL;
      if Length(AReturnParamName) > 0 then
      begin
        lParam := lDataSet.Params.FindParam(AReturnParamName);
        if Assigned(lParam) then
          Result := lParam.Value;
      end;
    finally
      if Assigned(AParams) and AFreeParams then
        AParams.Free;
    end;
  finally
    lDataSet.Free;
  end;
end;

function GetDataSet(AConnection: TSQLConnection; const AFields, ATable: string;
  AWhere: string = ''; AParams: TParams = nil; AFreeParams: Boolean = True;
  AOwner: TComponent = nil; AGetMetadata: Boolean = True): TSQLDataSet; overload;
const
  cnSelectFmt = 'SELECT %s FROM %s%s';
var
  lWhere: string;
begin
  if AWhere <> '' then
    lWhere := ' WHERE ' + AWhere;
  Result := GetDataSet(AConnection,
    Format(cnSelectFmt, [AFields, ATable, lWhere]), AParams, AFreeParams,
    AOwner, AGetMetaData);
end;

function GetDataSet(AConnection: TSQLConnection; const ASQL: string;
  AParams: TParams = nil; AFreeParams: Boolean = True;
  AOwner: TComponent = nil; AGetMetadata: Boolean = True): TSQLDataSet;
begin
  try
    Result := CreateDataSet(AConnection, ASQL, ctQuery, AOwner);
    Result.GetMetadata := AGetMetadata;
    if Assigned(AParams) then
      CloneParameters(Result, AParams);
    Result.Open;
  finally
    if Assigned(AParams) and AFreeParams then
      AParams.Free;
  end;
end;

function RecordExists(AConnection: TSQLConnection; const AFields, ATable: string;
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

function RecordExists(AConnection: TSQLConnection; const ASQL: string;
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

function DataSetToCDS(ADataSet: TSQLDataSet): TClientDataSet;
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

function GetClientDataSet(AConnection: TSQLConnection; const ASQL: string;
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

function GetClientDataSet(AConnection: TSQLConnection; const AFields, ATable: string;
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

function GetUpdateSet(AConnection: TSQLConnection; const ASQL: string;
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

function GetUpdateSet(AConnection: TSQLConnection; const AFields, ATable: string;
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

function MakeParam(const AName: string; ADataType: TFieldType; AValue: Variant;
  AParamType: TParamType = ptInput; ASize: Integer = 0): TParam;
begin
  Result := TParam.Create(nil);
  Result.Name := AName;
  Result.DataType := ADataType;
  Result.ParamType := AParamType;
  Result.Size := ASize;
  if ((ADataType in [ftString, ftWideString, ftMemo]) and (ASize > 0) and (Length(AValue) > ASize)) then
    AValue := Copy(AValue, 1, ASize);
  if (ADataType = ftMemo) and (AValue <> '') then
    Result.AsBlob := TEncoding.Default.GetBytes(AValue)
  else
    Result.Value := AValue;
end;

function MakeParamList(const AName: string; ADataType: TFieldType; AValue: Variant;
  AParamType: TParamType = ptInput; ASize: Integer = 0): TParams;
begin
  Result := TParams.Create();
  Result.AddParam(MakeParam(AName, ADataType, AValue, AParamType, ASize));
end;

function MakeParamList(AParams: array of TParam): TParams;
var
  lParam: TParam;
begin
  Result := TParams.Create();
  for lParam in AParams do
    Result.AddParam(lParam);
end;

function PropNameToFieldName(APropName: string): string;
var
  I: Integer;
  lLowerFound: Boolean;
begin
  Result := '';
  lLowerFound := False;
  for I := 1 to Length(APropName) do
  begin
    if APropName[I].IsUpper then
    begin
      if lLowerFound then
      begin
        Result := Result + '_';
        lLowerFound := False;
      end;
    end
    else
      lLowerFound := True;

    Result := Result + APropName[I];
  end;
  Result := UpperCase(Result);
end;

function FieldNameToPropName(AFieldName: string): string;
begin
  Result := StringReplace(AFieldName, '_', '', [rfReplaceAll]);
end;

{ TDBXUtils<T> }

class function TDBXUtils<T>.ListFromDataSet(ADataSet: TDataSet; AUseSmartID: Boolean = True): TObjectList<T>;
begin
  Result := TObjectList<T>.Create(True);
  while not ADataSet.EOF do
  begin
    Result.Add(ObjectFromDataSet(ADataSet, AUseSmartID));
    ADataSet.Next;
  end;
end;

class function TDBXUtils<T>.ListFromSQL(AConnection: TSQLConnection; ASQL:
  string; AUseSmartID: Boolean = True; AParams: TParams = nil; AFreeParams: Boolean = True): TObjectList<T>;
var
  lDS: TDataSet;
begin
  lDS := GetDataSet(AConnection, ASQL, AParams, AFreeParams);
  try
    Result := ListFromDataSet(lDS, AUseSmartID);
  finally
    lDS.Free;
  end;
end;

class procedure TDBXUtils<T>.PopulateFromDataSet(AObject: T; ADataSet: TDataSet;
  AUseSmartID: Boolean = True);
var
  lField: TField;
  lContext: TRTTIContext;
  lType: TRTTIType;
  lProps: TArray<TRttiProperty>;
  lProp: TRttiProperty;
  lName: string;
  lVal: TValue;
begin
  if not ADataSet.IsEmpty then
  begin
    lContext := TRTTIContext.Create;
    try
      lType := lContext.GetType(AObject.ClassType);
      for lField in ADataSet.Fields do
      begin
        if AUseSmartID and
          ((UpperCase(AObject.ClassName) + 'ID') = ('T' + UpperCase(FieldNameToPropName(lField.FieldName)))) then
          lName := 'ID'
        else
          lName := FieldNameToPropName(lField.FieldName);
        lProp := lType.GetProperty(lName);
        if Assigned(lProp) and lProp.IsWritable then
        begin
          if lField.DataType = ftTimestamp then
            lVal := TValue.From<TDateTime>(lField.AsDateTime)
          else
            lVal := TValue.FromVariant(lField.Value);
          lProp.SetValue(TObject(AObject), lVal);
        end;
      end;
    finally
      lContext.Free;
    end;
  end;
end;

class function TDBXUtils<T>.ObjectFromDataSet(ADataSet: TDataSet;
  AUseSmartID: Boolean = True): T;
begin
  Result := T.Create;

  PopulateFromDataSet(Result, ADataSet, AUseSmartID);
end;

class procedure TDBXUtils<T>.SaveToCSV(AObjects: TObjectList<T>; AFileName: string;
  ADelimeter: string = '"'; AReplDelimeter: string = '''');
const
  cnNewLine = #13#10;
var
  lStream: TFileStream;
  lWriter: TStreamWriter;
  lObj: T;
  lFreeIt: Boolean;
  lWritten: Boolean;
  lContext: TRTTIContext;
  lType: TRTTIType;
  lProps: TArray<TRttiProperty>;
  lProp: TRttiProperty;
  lName: string;
  lVal: TValue;
  lStr: string;

begin
  lStream := TFileStream.Create(AFileName, fmCreate);
  try
    lWriter := TStreamWriter.Create(lStream);
    try
      lContext := TRTTIContext.Create;
      try
        if AObjects.Count = 0 then
        begin
          lFreeIt := True;
          lObj := T.Create;
        end
        else
        begin
          lObj := AObjects[0];
          lFreeIt := False;
        end;

        try
          lType := lContext.GetType(lObj.ClassType);
          lProps := lType.GetProperties;

          lWritten := False;
          for lProp in lProps do
          begin
            if lWritten then
              lWriter.Write(',')
            else
              lWritten := True;
            lWriter.Write(lProp.Name);
          end;
          lWriter.Write(cnNewLine);

          for lObj in AObjects do
          begin
            lWritten := False;
            for lProp in lProps do
            begin
              if lWritten then
                lWriter.Write(',')
              else
                lWritten := True;
              lVal := lProp.GetValue(TObject(lObj));

              if lProp.PropertyType.Name = 'TDateTime' then
                lStr := DateTimeToStr(lVal.AsType<TDateTime>)
              else
              begin
                lStr := lVal.ToString;
                if (lProp.PropertyType.TypeKind in [tkString, tkUString, tkLString, tkWString]) and (ADelimeter <> '') then
                begin
                  if AReplDelimeter <> '' then
                    lStr := StringReplace(lStr, ADelimeter, AReplDelimeter, [rfReplaceAll]);
                  lStr := ADelimeter + lStr + ADelimeter;
                end;
              end;
              lWriter.Write(lStr);
            end;
            lWriter.Write(cnNewLine);
          end;

        finally
          if lFreeIt then
            lObj.Free;
        end;

      finally
        lContext.Free;
      end;

      lWriter.Close;
    finally
      lWriter.Free;
    end;
  finally
    lStream.Free;
  end;
end;

function TOrF(AInput: Boolean): char;
const
  cnFT: array[0..1] of char = ('F', 'T');
begin
  Result := cnFT[Ord(AInput)];
end;

function YOrN(AInput: Boolean): char;
const
  cnYN: array[0..1] of char = ('N', 'Y');
begin
  Result := cnYN[Ord(AInput)];
end;

procedure SetParameterValue(AParam: TParam; AValue: string);
begin
  if (AParam.Size > 0) and (Length(AValue) > AParam.Size) then
    AParam.AsString := Copy(AValue, 1, AParam.Size)
  else
    AParam.AsString := AValue;
end;

function DecodeString(AMemoField: TField; AEncoding: TEncoding): string;
begin
  Result := AEncoding.GetString(AMemoField.AsBytes);
end;

function AsUTF7String(AMemoField: TField): string;
begin
  Result := DecodeString(AMemoField, TEncoding.UTF7);
end;

function AsUTF8String(AMemoField: TField): string;
begin
  Result := DecodeString(AMemoField, TEncoding.UTF8);
end;

function AsUnicodeString(AMemoField: TField): string;
begin
  Result := DecodeString(AMemoField, TEncoding.Unicode);
end;

initialization
begin
  ThreadLock := TCriticalSection.Create;
end;

finalization
begin
  FreeAndNil(ThreadLock);
end;

end.

