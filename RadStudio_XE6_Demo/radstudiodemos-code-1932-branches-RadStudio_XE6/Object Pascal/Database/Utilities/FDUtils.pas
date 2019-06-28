//---------------------------------------------------------------------------

// This software is Copyright (c) 2013 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
{*******************************************************}
{                                                       }
{                FireDAC Framework Utilities            }
{                                                       }
{    Copyright(c) 2013 Embarcadero Technologies, Inc.   }
{                                                       }
{*******************************************************}

unit FDUtils;

interface

uses
  FireDac.Comp.Client, System.SysUtils, System.Classes, Data.DB, FireDac.Stan.Param,
  DBUtils, Generics.Collections;

type
  ///	<summary>
  ///	  Class containing generic utility methods for various common dbExpress
  ///	  data access tasks operating on TObject descendants
  ///	</summary>
  TFDUtils<T: constructor, class> = class(TDBUtils<T>)
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
    class function ListFromSQL(AConnection: TFDConnection;
      ASQL: string; AUseSmartID: Boolean = True; AParams: TFDParams = nil;
      AFreeParams: Boolean = True): TObjectList<T>;
  end;

  TFDUtils = class(TDBUtils<TFDConnection, TFDQuery, TFDParams, TFDParam, TFDStoredProc>)
  private
    class procedure CloneParameters(AQuery: TFDQuery;
      AParams: TFDParams); overload;
    class procedure CloneParameters(AProc: TFDStoredProc;
      AParams: TFDParams); overload;
    class function AddParam(AParams: TFDParams; const AName: string;
      ADataType: TFieldType; AValue: Variant; AParamType: TParamType;
      ASize: Integer): TFDParam;
  public
    ///  <summary>
    ///  Create and open a <c>TFDConnection</c> with the specified connection name
    ///  trying to open it a) first by trying application.ini then b) by
    ///  reading ADConnectionDefs.ini if a) fails
    ///  </summary>
    ///  <param name="AName">Name of connection to open</param>
    ///  <param name="AIniFile">Optional. Name of the Ini file.
    ///  Defaults to the application name + '.ini'</param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class function CreateConnection(const AName: string; AIniFile: string = ''): TFDConnection;

    ///  <summary>
    ///  Create and open a <c>TFDConnection</c> with the specified connection name
    ///  for ADConnectionDefs.ini
    ///  </summary>
    ///  <param name="AName">Name of connection to open</param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class function CreateConnectionName(const AName: string): TFDConnection;

    class function CreateConnectionIni(const AIniSection: string; AIniFile: string = ''): TFDConnection;

    ///  <summary>
    ///  Create and open a <c>TFDConnection</c> with the specified connection properties
    ///  </summary>
    ///  <param name="AServer">Name of the server where the database resides</param>
    ///  <param name="ADatabase">Name of the database to open</param>
    ///  <param name="AUserName">Database user name</param>
    ///  <param name="APassword">Password for <c>AUserName</c></param>
    ///  <param name="ADriverName">Optional. Defaults to 'IB'</param>
    ///  <param name="AExtra">Optional. Extra properties to set for the connection.
    ///  Defaults to ''.</param>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    class function CreateConnectionProps(
      const AServer, ADatabase, AUserName, APassword: string;
      const ADriverName: string = 'IB';
      const AExtra: string = ''): TFDConnection;

    ///  <summary>
    ///  Initialize and open a <c>TFDConnection</c> with the specified connection name
    ///  trying to open it a) first by trying application.ini then b) by
    ///  reading ADConnectionDefs.ini if a) fails
    ///  </summary>
    ///  <param name="AConnection">The TFDConnection instance to initialize</param>
    ///  <param name="AName">Name of connection to open</param>
    ///  <param name="AIniFile">Optional. Name of the Ini file.
    ///  Defaults to the application name + '.ini'</param>
    class procedure InitConnection(AConnection: TFDConnection; const AName: string;
      AIniFile: string = '');

    ///  <summary>
    ///  Intializes and opens a <c>TFDConnection</c> with the specified connection name
    ///  for ADConnectionDefs.ini
    ///  </summary>
    ///  <param name="AConnection">The TFDConnection instance to initialize</param>
    ///  <param name="AName">Name of connection to open</param>
    class procedure InitConnectionName(AConnection: TFDConnection; const AName: string);

    ///  <summary>
    ///  Initializes and opens a <c>TFDConnection</c> with properties read from the
    ///  application ini
    ///  </summary>
    ///  <param name="AConnection">The TFDConnection instance to initialize</param>
    ///  <param name="AIniSection">Name of the Ini section to read</param>
    ///  <param name="AIniFile">Optional. Name of the Ini file.
    ///  Defaults to the application name + '.ini'
    ///  </param>
    class procedure InitConnectionIni(AConnection: TFDConnection;
      const AIniSection: string; AIniFile: string = '');

    ///  <summary>
    ///  Initializes and opens a <c>TFDConnection</c> with the specified connection properties
    ///  </summary>
    ///  <param name="AConnection">The TFDConnection instance to initialize</param>
    ///  <param name="ADatabase">Name of the server where the database resides</param>
    ///  <param name="ADatabase">Name of the database to open</param>
    ///  <param name="AUserName">Database user name</param>
    ///  <param name="APassword">Password for <c>AUserName</c></param>
    ///  <param name="ADriverName">Optional. Defaults to 'IB'</param>
    ///  <param name="AExtra">Optional. Extra properties to set for the connection.
    class procedure InitConnectionProps(
      AConnection: TFDConnection;
      const AServer, ADatabase, AUserName, APassword: string;
      const ADriverName: string = 'IB';
      const AExtra: string = '');

    ///  <summary>
    ///  Creates a <c>TFDQuery</c> for the specified connection and SQL statement
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection" type="TFDConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="ASQL" type="string">SQL select statement to use</param>
    ///  <param name="AParams" type="TFDParams">
    ///  Optional. The list of <c>TFDParams</c> to use with the constructed SQL command.
    ///  <param name="AOwner" type="TComponent">
    ///  Component owner to use for the returned DataSet
    ///  </param>
    ///  <returns>The created <c>TFDQuery</c></returns>
    class function CreateQuery(AConnection: TFDConnection; ASQL: string = '';
      AParams: TFDParams = nil; AOwner: TComponent = nil): TFDQuery;

    ///  <summary>
    ///  Creates a <c>TFDStoredProc</c> for the specified connection and procedure name
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection" type="TFDConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="AProcName" type="string">Stored procedure to execute</param>
    ///  <param name="AParams" type="TFDParams">
    ///  Optional. The list of <c>TFDParams</c> to use with the stored procedure.
    ///  <param name="AOwner" type="TComponent">
    ///  Component owner to use for the returned <c>TFDStoredProc</c>
    ///  </param>
    ///  <returns>The created <c>TFDStoredProc</c></returns>
    class function CreateStoredProc(AConnection: TFDConnection; AProcName: string = '';
      AParams: TFDParams = nil; AOwner: TComponent = nil): TFDStoredProc;

    ///  <summary>
    ///  Creates an open <c>TFDQuery</c> for the specified connection and SQL statement
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">SQL select statement to execute</param>
    ///  <param name="AParams"> Optional. The list of <c>TFDParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <param name="AOwner" type="TComponent">
    ///  Component owner to use for the returned query
    ///  </param>
    ///  <returns>The created and opened <c>TFDQuery</c></returns>
    class function GetQuery(AConnection: TFDConnection; const ASQL: string;
      AParams: TFDParams = nil; AFreeParams: Boolean = True;
      AOwner: TComponent = nil): TFDQuery; overload;

    ///  <summary>
    ///  Creates an open <c>TADQeuery</c> for the specified connection and using
    ///  specified criteria to built up the SQL statement to execute
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller
    ///  </remarks>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="AFields">The list of fields to return</param>
    ///  <param name="AFrom">The table to return the fields from</param>
    ///  <param name="AWhere">Optional where clause to apply when executing the SQL</param>
    ///  <param name="AParams"> Optional. The list of <c>TFDParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <param name="AOwner" type="TComponent">
    ///  Component owner to use for the returned query
    ///  </param>
    ///  <returns>The created and opened <c>TFDQuery</c></returns>
    class function GetQuery(AConnection: TFDConnection; const AFields, ATable: string;
      AWhere: string = ''; AParams: TFDParams = nil; AFreeParams: Boolean = True;
      AOwner: TComponent = nil): TFDQuery; overload;

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
      AParamType: TParamType = ptInput; ASize: Integer = 0): TFDParams; overload;

    ///  <summary>
    ///  Creates a <c>TParams</c> and adds one initialized <c>TParam</c> to it
    ///  </summary>
    ///  <remarks>
    ///  This object will need to be freed in the client code
    ///  </remarks>
    ///  <param name="AParams">array of initialized <c>TParam</c> objects</param>
    ///  <param name="AFreeInputParams">Indicates whether the passed in <c>TParam</c> instances
    ///  should be freed.</param>
    ///  <returns>The initialized <c>TParams</c> collection</returns>
    class function MakeParamList(AParams: array of TParam; AFreeInputParams: Boolean = True): TFDParams; overload;

    /// <summary>
    /// Creates a <c>TFDParam</c> instance based on the specified <c>TParam</c> instance.
    /// if AFreeInputParam is set to True, the passed in <c>TParam</c> instance will
    /// be freed.
    /// </summary>
    /// <param name="AParam">The <c>TParam</c> instance to copy</param>
    /// <param name="AParams">The <c>TFDParams</c> instance that will own and contain the
    ///  returned <c>TFDParam</c> instance.</param>
    /// <param name="AFreeInputParam">Indicates whether the passed in <c>TParam</c> instance
    ///  should be freed</param>
    /// <returns>The initialized <c>TFDParam</c> instance.</returns>
    class function ADParamFromParam(AParam: TParam; AParams: TFDParams; AFreeInputParam: Boolean = True): TFDParam;

    ///  <summary>
    ///  Retrieve the value of column in a data table
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller.
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="AFieldOrSQL">
    ///  The name of the column to retrieve. Alternatively this can be used to pass
    ///  a full SQL statement. If doing so, then ATable should be an empty string.</param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails to locate any rows</param>
    ///  <param name="ANullDefault">The default value of the return value if retrieval returns a null value</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TFDParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>Variant</c> representing the value of <c>AField</c>, or
    ///  <c>ADefault</c> if the retrieval fails</returns>
    class function GetValueNullDefault(AConnection: TFDConnection; const AFieldOrSQL, ATable: string;
      ADefault, ANullDefault: Variant; const AWhere: string = ''; AParams: TFDParams = nil;
      AFreeParams: Boolean = True): Variant;

    ///  <summary>
    ///  Retrieve the value of column in a data table
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller.
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="AFieldOrSQL">
    ///  The name of the column to retrieve. Alternatively this can be used to pass
    ///  a full SQL statement. If doing so, then ATable should be an empty string.
    ///  </param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails to locate any rows</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TFDParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>Variant</c> representing the value of <c>AField</c>, or
    ///  <c>ADefault</c> if the retrieval fails</returns>
    class function GetValue(AConnection: TFDConnection; const AFieldOrSQL, ATable: string;
      ADefault: Variant; const AWhere: string = ''; AParams: TFDParams = nil;
      AFreeParams: Boolean = True): Variant;

    ///  <summary>
    ///  Retrieve the value of column in a data table from a specified SQL statement
    ///  </summary>
    ///  <remarks>
    ///  The object returned will need to be freed in the caller.
    ///  </remarks>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">
    ///  The SQL statement to retrieve. The value of the first field in the dataset will be returned</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails to locate any rows</param>
    ///  <param name="AParams"> Optional. The list of <c>TFDParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>Variant</c> representing the value of the first field, or
    ///  <c>ADefault</c> if the retrieval fails</returns>
    class function QueryValue(AConnection: TFDConnection; const ASQL: string;
      ADefault: Variant; AParams: TFDParams = nil;
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
    class function QueryValueNullDefault(AConnection: TFDConnection; const ASQL: string;
      ADefault, ANullDefault: Variant; AParams: TFDParams = nil;
      AFreeParams: Boolean = True): Variant;

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
    class function GetCount(AConnection: TFDConnection; const ATable: string;
      const AWhere: string = ''; AParams: TFDParams = nil;
      AFreeParams: Boolean = True): int64;

    ///  <summary>
    ///  Retrieve a <c>TBytes</c> array from a column in a data table
    ///  </summary>
    ///  <remarks>
    ///  This object will need to be freed in the client code.
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="AField">The name of the column to retrieve</param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails to locate any rows</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TFDParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>TBytes</c> object representing <c>AField</c>, or
    ///  <c>ADefault</c> if retrieval fails</returns>
    class function GetBytes(AConnection: TFDConnection; const AField, ATable: string;
      ADefault: TBytes; const AWhere: string = ''; AParams: TFDParams = nil;
      AFreeParams: Boolean = True): TBytes;

    ///  <summary>
    ///  Retrieve a <c>string</c> from a column in a data table
    ///  </summary>
    ///  <remarks>
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="AField">The name of the column to retrieve</param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TFDParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>TBytes</c> object representing <c>AField</c>, or
    ///  <c>ADefault</c> if retrieval fails</returns>
    class function GetMemo(AConnection: TFDConnection; const AField, ATable: string;
      ADefault: string = ''; const AWhere: string = ''; AParams: TFDParams = nil;
      AFreeParams: Boolean = True): string; overload;

    ///  <summary>
    ///  Retrieve a <c>string</c> from a column in a data table
    ///  </summary>
    ///  <remarks>
    ///  The various parameters passed in will be used to construct the select
    ///  statement to retrieve the value of the column.
    ///  </remarks>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="AField">The name of the column to retrieve</param>
    ///  <param name="ATable">The name of the table containing the column</param>
    ///  <param name="AEncoding">
    ///  The <c>TEncoding</c> to use when constructing the string from the bytes
    ///  stored in the Memo field.
    ///  </param>
    ///  <param name="ADefault">The default value of the return value if retrieval fails</param>
    ///  <param name="AWhere">Optional. The 'where' clause conditions to add to the retrieval.
    ///  Defaults to ''.</param>
    ///  <param name="AParams"> Optional. The list of <c>TFDParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>A <c>TBytes</c> object representing <c>AField</c>, or
    ///  <c>ADefault</c> if retrieval fails</returns>
    class function GetMemo(AConnection: TFDConnection; const AField, ATable: string;
      AEncoding: TEncoding; ADefault: string = ''; const AWhere: string = ''; AParams: TFDParams = nil;
      AFreeParams: Boolean = True): string; overload;

    ///  <summary>
    ///  Execute the specified query on the <c>AConnection</c>
    ///  </summary>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="ASQL">SQL command to execute</param>
    ///  <param name="AParams"> Optional. The list of <c>TFDParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <returns>The number of rows affected by the command</returns>
    class function ExecNoQuery(AConnection: TFDConnection; const ASQL: string;
      AParams: TFDParams = nil; AFreeParams: Boolean = True): Integer;

    ///  <summary>
    ///  Execute the specified stored procedure on the <c>AConnection/c>.
    ///  </summary>
    ///  <param name="AConnection"><c>TFDConnection</c> to use for the database connection</param>
    ///  <param name="AProcName">Name of procedure to execute</param>
    ///  <param name="AParams"> Optional. The list of <c>TParams</c> to use with the constructed SQL command
    ///  Defaults to nil.</param>
    ///  <param name="AFreeParams">Use <c>True</c> if <c>AParams</c> is created in the invoker,
    ///  or <c>False</c> if the caller manages the lifetime of <c>AParams</c></param>
    ///  <param name="AReturnParamName">Name of procedure return value. Defaults to 'RETURN_VALUE'</param>
    ///  <returns>A <c>Variant</c> with the result of the procedure call
    ///  if <c>AReturnParamName</c> is defined and found</returns>
    class function ExecProc(AConnection: TFDConnection; const AProcName: string;
      AParams: TFDParams = nil; AFreeParams: Boolean = True;
      AReturnParamName: string = 'RETURN_VALUE'): Variant;

    ///  <summary>
    ///  Retreive the value for the specified parameter for the specified
    ///  <c>TFDStoredProc</c> instance.
    ///  </summary>
    ///  <param name="AStoredProc">The <c>TFDStoredProc</c> instance to query.</param>
    ///  <param name="AParamName">The name of the parameter to query.</param>
    ///  <returns>A <c>Variant</c> with the value of the specified parameter, if
    ///  <c>AParamName</c> is defined and found.
    class function GetParamValue(AStoredProc: TFDStoredProc;
      const AParamName: string): Variant; static;

    /// <summary>
    ///   Provides a safe way to set the value of a string parameter, ensuring the
    ///   length of the string used does not exceed the value of TParam.Size
    /// </summary>
    /// <param name="AParam">
    ///    The TFDParam instance to set the value of
    /// </param>
    /// <param name="AValue">
    ///    The value to set the TFDParam instance to
    /// </param>
    class procedure SetParameterValue(AParam: TFDParam; AValue: string);
  end;

resourcestring
  StrInvalidConnectionDefName = 'Invalid ConnectionDefName %s';

implementation

uses
  System.SyncObjs, WinApi.Windows, System.IniFiles, FireDac.Stan.Def, FireDac.DApt,
  FireDAC.Comp.UI, FireDac.VCLUI.Wait, FireDac.FMXUI.Wait;

class procedure TFDUtils.CloneParameters(AQuery: TFDQuery; AParams: TFDParams);
begin
  DoCloneParameters(TFDParam, AParams, AQuery.Params);
end;

class procedure TFDUtils.CloneParameters(AProc: TFDStoredProc; AParams: TFDParams);
begin
  DoCloneParameters(TFDParam, AParams, AProc.Params);
end;

class function TFDUtils.MakeParamList(const AName: string;
  ADataType: TFieldType; AValue: Variant; AParamType: TParamType;
  ASize: Integer): TFDParams;
begin
  Result := DoMakeParamList(TFDParams, TFDParam, AddParam, AName, ADataType, AValue, AParamType, ASize);
end;

class function TFDUtils.AddParam(AParams: TFDParams; const AName: string;
  ADataType: TFieldType; AValue: Variant; AParamType: TParamType;
  ASize: Integer): TFDParam;
begin
  Result := AParams.Add(AName, ADataType, ASize, AParamType);
  Result.Value := AValue;
end;

class function TFDUtils.CreateConnection(const AName: string;
  AIniFile: string = ''): TFDConnection;
begin
  Result := DoCreateConnection(TFDConnection,
    procedure(AConnection: TFDConnection)
    begin
      InitConnection(AConnection, AName, AIniFile);
    end);
end;

class function TFDUtils.CreateConnectionIni(const AIniSection: string;
  AIniFile: string): TFDConnection;
begin
  Result := DoCreateConnection(TFDConnection,
    procedure(AConnection: TFDConnection)
    begin
      InitConnectionIni(AConnection, AIniSection, AIniFile);
    end);
end;

class procedure TFDUtils.SetParameterValue(AParam: TFDParam; AValue: string);
begin
  if (AParam.Size > 0) and (Length(AValue) > AParam.Size) then
    AParam.AsString := Copy(AValue, 1, AParam.Size)
  else
    AParam.AsString := AValue;
end;


class function TFDUtils.CreateConnectionName(const AName: string): TFDConnection;
begin
  Result := DoCreateConnection(TFDConnection,
    procedure(AConnection: TFDConnection)
    begin
      InitConnectionName(AConnection, AName);
    end);
end;

class function TFDUtils.CreateConnectionProps(
  const AServer, ADatabase, AUserName, APassword: string;
  const ADriverName: string = 'IB';
  const AExtra: string = ''): TFDConnection;
begin
  Result := DoCreateConnection(TFDConnection,
    procedure(AConnection: TFDConnection)
    begin
      InitConnectionProps(AConnection, AServer, ADatabase, AUserName, APassword, ADriverName, AExtra);
    end);
end;

class procedure TFDUtils.InitConnection(AConnection: TFDConnection; const AName: string;
  AIniFile: string = '');
begin
  DoInitConnection(AConnection, AName, InitConnectionProps, InitConnectionName, AIniFile);
end;

class procedure TFDUtils.InitConnectionName(AConnection: TFDConnection; const AName: string);
begin
  if not FDManager.IsConnectionDef(AName) then
    raise EDBUtils.CreateFmt(StrInvalidConnectionDefName, [AName]);

  AConnection.Params.Clear;
  AConnection.DriverName := '';
  AConnection.ConnectionDefName := AName;
  AConnection.Open;
end;

class procedure TFDUtils.InitConnectionIni(AConnection: TFDConnection;
  const AIniSection: string; AIniFile: string = '');
begin
  DoInitConnectionIni(AConnection, AIniSection, InitConnectionProps, AIniFile);
end;

class procedure TFDUtils.InitConnectionProps(
  AConnection: TFDConnection;
  const AServer, ADatabase, AUserName, APassword: string;
  const ADriverName: string = 'IB';
  const AExtra: string = '');
const
  SCxnParams =
    'Server=%s' + #13#10 +
    'Database=%s' + #13#10 +
    'User_name=%s' + #13#10 +
    'Password=%s' + #13#10 +
    '%s';
begin
  AConnection.Params.Text := Format(SCxnParams,
    [AServer, ADatabase, AUserName, APassword, AExtra]);
  AConnection.DriverName := ADriverName;
  AConnection.Open;
end;

class function TFDUtils.CreateQuery(AConnection: TFDConnection; ASQL: string = '';
  AParams: TFDParams = nil; AOwner: TComponent = nil): TFDQuery;
begin
  Result := TFDQuery.Create(AOwner);
  Result.Connection := AConnection;
  Result.SQL.Text := ASQL;
  if Assigned(AParams) then
    CloneParameters(Result, AParams);
end;

class function TFDUtils.CreateStoredProc(AConnection: TFDConnection;
  AProcName: string; AParams: TFDParams; AOwner: TComponent): TFDStoredProc;
begin
  Result := TFDStoredProc.Create(AOwner);
  Result.Connection := AConnection;
  Result.StoredProcName := AProcName;
  if Assigned(AParams) then
    CloneParameters(Result, AParams);
end;

class function TFDUtils.GetQuery(AConnection: TFDConnection; const ASQL: string;
  AParams: TFDParams = nil; AFreeParams: Boolean = True;
  AOwner: TComponent = nil): TFDQuery;
begin
  Result := DoGetDataSet(AConnection, CreateQuery, ASQL, AParams, AFreeParams, AOwner);
end;

class function TFDUtils.GetQuery(AConnection: TFDConnection; const AFields, ATable: string;
  AWhere: string = ''; AParams: TFDParams = nil; AFreeParams: Boolean = True;
  AOwner: TComponent = nil): TFDQuery;
begin
  Result := DoGetDataSet(AConnection, CreateQuery, AFields, ATable, AWhere, AParams, AFreeParams, AOwner);
end;

class function TFDUtils.ADParamFromParam(AParam: TParam; AParams: TFDParams; AFreeInputParam: Boolean = True): TFDParam;
begin
  Result := AParams.Add;
  Result.Name := AParam.Name;
  Result.DataType := AParam.DataType;
  Result.Size := AParam.Size;
  Result.Precision := AParam.Precision;
  Result.ParamType := AParam.ParamType;
  Result.DisplayName := AParam.DisplayName;
  Result.NumericScale := AParam.NumericScale;
  Result.Value := AParam.Value;

  if AFreeInputParam then
    AParam.Free;
end;

class function TFDUtils.MakeParamList(AParams: array of TParam; AFreeInputParams: Boolean = True): TFDParams;
var
  lParam: TParam;
begin
  Result := TFDParams.Create();
  for lParam in AParams do
    ADParamFromParam(lParam, Result, AFreeInputParams);
end;

class function TFDUtils.GetValueNullDefault(AConnection: TFDConnection; const AFieldOrSQL, ATable: string;
  ADefault, ANullDefault: Variant; const AWhere: string = ''; AParams: TFDParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := DoGetValueNullDefault(AConnection, CreateQuery, AFieldOrSQL, ATable,
    ADefault, ANullDefault, AWhere, AParams, AFreeParams);
end;

class function TFDUtils.GetValue(AConnection: TFDConnection; const AFieldOrSQL, ATable: string;
  ADefault: Variant; const AWhere: string = ''; AParams: TFDParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := DoGetValue(AConnection, CreateQuery, AFieldOrSQL, ATable,
    ADefault, AWhere, AParams, AFreeParams);
end;

class function TFDUtils.QueryValue(AConnection: TFDConnection; const ASQL: string;
  ADefault: Variant; AParams: TFDParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := DoQueryValue(AConnection, CreateQuery, ASQL, ADefault, AParams, AFreeParams);
end;

class function TFDUtils.QueryValueNullDefault(AConnection: TFDConnection; const ASQL: string;
  ADefault, ANullDefault: Variant; AParams: TFDParams = nil;
  AFreeParams: Boolean = True): Variant;
begin
  Result := DoQueryValueNullDefault(AConnection, CreateQuery, ASQL, ADefault,
    ANullDefault, AParams, AFreeParams);
end;

class function TFDUtils.GetCount(AConnection: TFDConnection; const ATable: string;
  const AWhere: string = ''; AParams: TFDParams = nil;
  AFreeParams: Boolean = True): int64;
begin
  Result := DoGetCount(AConnection, CreateQuery, ATable, AWhere, AParams,
    AFreeParams);
end;

class function TFDUtils.GetBytes(AConnection: TFDConnection; const AField, ATable: string;
  ADefault: TBytes; const AWhere: string = ''; AParams: TFDParams = nil;
  AFreeParams: Boolean = True): TBytes;
begin
  Result := DoGetBytes(AConnection, CreateQuery, AField, ATable, ADefault, AWhere,
    AParams, AFreeParams);
end;

class function TFDUtils.GetMemo(AConnection: TFDConnection; const AField, ATable: string;
  ADefault: string = ''; const AWhere: string = ''; AParams: TFDParams = nil;
  AFreeParams: Boolean = True): string;
begin
  Result := GetMemo(AConnection, AField, ATable, TEncoding.UTF8, ADefault, AWhere,
    AParams, AFreeParams);
end;

class function TFDUtils.GetMemo(AConnection: TFDConnection; const AField,
  ATable: string; AEncoding: TEncoding; ADefault: string = ''; const AWhere: string = '';
  AParams: TFDParams = nil; AFreeParams: Boolean = True): string;
begin
  Result := DoGetMemo(AConnection, CreateQuery, AField, ATable, ADefault, AWhere,
    AParams, AFreeParams, AEncoding);
end;

class function TFDUtils.ExecNoQuery(AConnection: TFDConnection; const ASQL: string;
  AParams: TFDParams = nil; AFreeParams: Boolean = True): Integer;
begin
  Result := DoExecNoQuery(AConnection, CreateQuery, function(AQuery: TFDQuery): Integer
    begin
      AQuery.ExecSQL;
      Result := AQuery.RowsAffected;
    end,
    ASQL, AParams, AFreeParams);
end;

class function TFDUtils.GetParamValue(AStoredProc: TFDStoredProc; const AParamName: string): Variant;
var
  lParam: TFDParam;
begin
  lParam := AStoredProc.FindParam(AParamName);
  if Assigned(lParam) then
    Result := lParam.Value;
end;

class function TFDUtils.ExecProc(AConnection: TFDConnection; const AProcName: string;
  AParams: TFDParams = nil; AFreeParams: Boolean = True;
  AReturnParamName: string = 'RETURN_VALUE'): Variant;
begin
  Result := DoExecProc(AConnection, CreateStoredProc,
    procedure(AProc: TFDStoredProc)
    begin
      AProc.ExecProc;
    end,
    GetParamValue, AProcName, AParams, AFreeParams, AReturnParamName);
end;

{ TFDUtils<T> }

class function TFDUtils<T>.ListFromSQL(AConnection: TFDConnection; ASQL: string;
  AUseSmartID: Boolean; AParams: TFDParams; AFreeParams: Boolean): TObjectList<T>;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDUtils.GetQuery(AConnection, ASQL, AParams, AFreeParams);
  try
    Result := ListFromDataSet(lQuery, AUseSmartID);
  finally
    lQuery.Free;
  end;
end;

end.
