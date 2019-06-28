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
{           Delphi Database Framework Utilities         }
{                                                       }
{    Copyright(c) 2013 Embarcadero Technologies, Inc.   }
{                                                       }
{*******************************************************}
unit DBUtils;

interface

uses
  Data.DB, Generics.Collections, System.SyncObjs, System.Classes,
  System.IniFiles, System.SysUtils;

type

  EDBUtils = class(Exception);

  TConnectionProc = reference to procedure(AConnection: TCustomConnection);
  TConnectionProc<T: TCustomConnection> = reference to procedure(AConnection: T);
  TInitConnectionNameProc<T: TCustomConnection> = reference to procedure(AConnection: T; const AName: string);
  TInitConnectionPropsProc<T: TCustomConnection> = reference to procedure(AConnection: T; const AServer, ADatabase, AUserName, APassword, ADriver, AExtra: string);
  TCreateDataSetFunc<T: TCustomConnection; D: TDataSet; P: TCollection> = reference to function(AConnection: T; ASQL: string; AParams: P; AOwner: TComponent): D;
  TAddParamFunc<P: TCollection; PI: TCollectionItem> = reference to function(AParams: P; const AName: string; ADataType: TFieldType; AValue: Variant; AParamType: TParamType; ASize: Integer): PI;
  TExecuteDataSetFunc<T: TDataSet> = reference to function(ADataSet: T): Integer;
  TDataSetProc<T: TDataSet> = reference to procedure(ADataSet: T);
  TParamValueFunc<T: TDataSet> = reference to function(ADataSet: T; const AParamName: string): Variant;

  TConnectionClass = class of TCustomConnection;
  TDataSetClass = class of TDataSet;
  TParamsClass = class of TCollection;
  TParamClass = class of TCollectionItem;

  ///	<summary>
  ///	  Class containing generic utility methods for various common
  ///	  data access tasks operating on TObject descendants
  ///	</summary>
  TDBUtils<T: constructor, class> = class
  public
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

  TDBUtils = class
  protected
    class var
      ThreadLock: TCriticalSection;
  public
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
    class function ModuleName: string;

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
    class function ModulePath(AFileName: string = '') : string;

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
    class function ModuleIniFile : string;

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
    class function PropNameToFieldName(APropName: string): string;

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
    class function FieldNameToPropName(AFieldName: string): string;

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
    ///  <param name="APrecision">Optional <c>Integer</c> to use as the Precision. Defaults to 0,
    ///  but it must be set for some data types.</param>
    ///  <returns>The initialized <c>TParam</c></returns>
    class function MakeParam(const AName: string; ADataType: TFieldType; AValue: Variant;
      AParamType: TParamType = ptInput; ASize: Integer = 0; APrecision: Integer = 0): TParam;

    ///  <summary>
    ///  Return the appropriate True or False character representation for boolean
    ///  values stored in a character database field.
    ///  </summary>
    ///  <param name="AInput">The boolean value to return the character representation for.</param>
    ///  <returns>Return the appropriate True or False character representation</returns>
    class function TOrF(AInput: Boolean): char;

    ///  <summary>
    ///  Return the appropriate Yes or No character representation for boolean
    ///  values stored in a character database field.
    ///  </summary>
    ///  <param name="AInput">The boolean value to return the character representation for.</param>
    ///  <returns>Return the appropriate Yes or No character representation</returns>
    class function YOrN(AInput: Boolean): char;


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
    class function DecodeString(AMemoField: TField; AEncoding: TEncoding): string;
    /// <summary>
    ///  Decodes an Ansi string stored in a binary blob field
    /// <param name="AMemoField">
    ///  The TField instance contaning the blob data
    /// </param>
    /// <returns>
    ///   Returns the decoded Ansi string data in the specified field
    /// </returns>
    class function AsAnsiString(AMemoField: TField): string;
    /// <summary>
    ///  Decodes a UTF7 string stored in a binary blob field
    /// <param name="AMemoField">
    ///  The TField instance contaning the blob data
    /// </param>
    /// <returns>
    ///   Returns the decoded UTF7 string data in the specified field
    /// </returns>
    class function AsUTF7String(AMemoField: TField): string;
    /// <summary>
    ///  Decodes a UTF8 string stored in a binary blob field
    /// <param name="AMemoField">
    ///  The TField instance contaning the blob data
    /// </param>
    /// <returns>
    ///   Returns the decoded UTF8 string data in the specified field
    /// </returns>
    class function AsUTF8String(AMemoField: TField): string; /// <summary>
    ///  Decodes a Unicode string stored in a binary blob field
    /// <param name="AMemoField">
    ///  The TField instance contaning the blob data
    /// </param>
    /// <returns>
    ///   Returns the decoded Unicode string data in the specified field
    /// </returns>
    class function AsUnicodeString(AMemoField: TField): string;
  end;

  TDBUtils <C: TCustomConnection; D: TDataSet; P: TCollection; PI: TCollectionItem; SP: TDataSet> = class(TDBUtils)
  protected
    class function DoGetDataSet(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>; const ASQL: string; AParams: P;
      AFreeParams: Boolean; AOwner: TComponent): D; overload;
    class function DoGetDataSet(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>;
      const AFieldsOrSQL, ATable, AWhere: string; AParams: P;
      AFreeParams: Boolean; AOwner: TComponent = nil): D; overload;
    class procedure DoCloneParameters(AClass: TParamClass; ASource, ADest: P);

    class function DoCreateConnection(AClass: TConnectionClass; AInitConnection: TConnectionProc<C>): C;

    class procedure DoInitConnection(AConnection: C; const AName: string;
      AInitConnectionProps: TInitConnectionPropsProc<C>;
      AInitConnectionName: TInitConnectionNameProc<C>;
      AIniFile: string = ''; ADefaultDriver: string = 'IB');

    class procedure DoInitConnectionIni(AConnection: C; const AIniSection: string;
      AInitConnectionProps: TinitConnectionPropsProc<C>; AIniFile: string = ''; ADefaultDriver: string = 'IB');

    class function DoMakeParamList(AParamsClass: TParamsClass; AParamItemClass: TParamClass;
      AAddParamFunc: TAddParamFunc<P, PI>; const AName: string;
      ADataType: TFieldType; AValue: Variant; AParamType: TParamType;
      ASize: Integer): P; static;

    class function DoGetValueNullDefault(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>; const AFieldOrSQL,
      ATable: string; ADefault, ANullDefault: Variant; const AWhere: string;
      AParams: P; AFreeParams: Boolean): Variant; static;
    class function DoGetValue(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>; const AFieldOrSQL,
      ATable: string; ADefault: Variant; const AWhere: string; AParams: P;
      AFreeParams: Boolean): Variant; static;
    class function DoQueryValueNullDefault(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>; const ASQL: string; ADefault,
      ANullDefault: Variant; AParams: P; AFreeParams: Boolean): Variant; static;
    class function DoQueryValue(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>; const ASQL: string;
      ADefault: Variant; AParams: P; AFreeParams: Boolean): Variant; static;
    class function DoGetCount(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>;
      const ATable, AWhere: string; AParams: P;
      AFreeParams: Boolean): Int64;
    class function DoGetBytes(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>; const AField, ATable: string;
      ADefault: TBytes; const AWhere: string; AParams: P;
      AFreeParams: Boolean): TBytes;
    class function DoGetMemo(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>; const AField, ATable,
      ADefault, AWhere: string; AParams: P; AFreeParams: Boolean; AEncoding: TEncoding): string;

    class function DoExecNoQuery(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, D, P>;
      AExecuteDataSet: TExecuteDataSetFunc<D>; const ASQL: string; AParams: P;
      AFreeParams: Boolean): Integer;
    class function DoExecProc(AConnection: C;
      ACreateDataSet: TCreateDataSetFunc<C, SP, P>;
      AExecProc: TDataSetProc<SP>; AParamValueFunc: TParamValueFunc<SP>;
      const AProcName: string; AParams: P; AFreeParams: Boolean;
      const AReturnParamName: string): Variant;


    class function DoGetSQL(const AFieldsOrSQL, ATable, AWhere: string): string; static;
  end;

const
  SDatabase = 'Database';
  SUserName = 'UserName';
  SPassword = 'Password';
  SDriver = 'Driver';
  SServer = 'Server';
  SDefaultUser = 'sysdba';
  SDefaultPassword = 'masterkey';
  SDefaultDriver = 'IB';
  SDefaultServer = 'localhost';
  SDefaultDatabase = '<unspecified>';

resourcestring
  StrCouldNotOpenConnection = 'Could not open connection %s via framework .ini (%s) or application.ini (%s)';
  StrAppIniMissing = 'Application.ini file %s does not exist';
  StrInvalidSection = 'Invalid Section %s';

implementation

uses
  System.Rtti, System.TypInfo, System.Character,
  {$IFDEF MSWINDOWS}
  WinApi.Windows,
  {$ENDIF}
  System.Variants;

{ TDBUtils<T> }

class function TDBUtils<T>.ListFromDataSet(ADataSet: TDataSet; AUseSmartID: Boolean = True): TObjectList<T>;
begin
  Result := TObjectList<T>.Create(True);
  while not ADataSet.EOF do
  begin
    Result.Add(ObjectFromDataSet(ADataSet, AUseSmartID));
    ADataSet.Next;
  end;
end;

class procedure TDBUtils<T>.PopulateFromDataSet(AObject: T; ADataSet: TDataSet;
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
          ((UpperCase(AObject.ClassName) + 'ID') = ('T' + UpperCase(TDBUtils.FieldNameToPropName(lField.FieldName)))) then
          lName := 'ID'
        else
          lName := TDBUtils.FieldNameToPropName(lField.FieldName);
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

class function TDBUtils<T>.ObjectFromDataSet(ADataSet: TDataSet;
  AUseSmartID: Boolean = True): T;
begin
  Result := T.Create;

  PopulateFromDataSet(Result, ADataSet, AUseSmartID);
end;

class procedure TDBUtils<T>.SaveToCSV(AObjects: TObjectList<T>; AFileName: string;
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

{ TDBUtils }

class function TDBUtils.PropNameToFieldName(APropName: string): string;
var
  I: Integer;
  lLowerFound: Boolean;
begin
  Result := '';
  lLowerFound := False;
  for I := Low(APropName) to High(APropName) do
  begin
    if TCharacter.IsUpper(APropName[I]) then
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

class function TDBUtils.TOrF(AInput: Boolean): char;
const
  cnFT: array[0..1] of char = ('F', 'T');
begin
  Result := cnFT[Ord(AInput)];
end;

class function TDBUtils.YOrN(AInput: Boolean): char;
const
  cnYN: array[0..1] of char = ('N', 'Y');
begin
  Result := cnYN[Ord(AInput)];
end;

class function TDBUtils.FieldNameToPropName(AFieldName: string): string;
begin
  Result := StringReplace(AFieldName, '_', '', [rfReplaceAll]);
end;

class function TDBUtils.ModuleName: string;
var
  FN: array[0..MAX_PATH- 1] of Char;
begin
  SetString(Result, FN, GetModuleFileName(hInstance, FN, SizeOf(FN)));
end;

class function TDBUtils.ModulePath(AFileName : string = '') : string;
begin
  Result := ExtractFilePath(ModuleName) + LowerCase(ExtractFileName(AFileName));
  if Pos('\\?\', Result) = 1 then
    Result := Copy(Result, 5, Length(Result));
end;

class function TDBUtils.ModuleIniFile : string;
var
  FN: array[0..MAX_PATH- 1] of char;
  sPath : string;
begin
  SetString(sPath, FN, GetModuleFileName(hInstance, FN, SizeOf(FN)));
  Result := ChangeFileExt( sPath, '.ini' );
end;

class function TDBUtils.MakeParam(const AName: string; ADataType: TFieldType; AValue: Variant;
  AParamType: TParamType = ptInput; ASize: Integer = 0; APrecision: Integer
   = 0): TParam;
begin
  Result := TParam.Create(nil);
  Result.Name := AName;
  Result.DataType := ADataType;
  Result.ParamType := AParamType;
  Result.Size := ASize;
  Result.Precision := APrecision;
  if ((ADataType in [ftString, ftWideString, ftMemo]) and (ASize > 0) and (Length(AValue) > ASize)) then
    AValue := Copy(AValue, 1, ASize);
  if (ADataType = ftMemo) and (AValue <> '') then
    Result.Value := TEncoding.Default.GetBytes(AValue)
  else
    Result.Value := AValue;
end;

class function TDBUtils.DecodeString(AMemoField: TField; AEncoding: TEncoding): string;
begin
  Result := AEncoding.GetString(AMemoField.AsBytes);
end;

class function TDBUtils.AsAnsiString(AMemoField: TField): string;
begin
  Result := DecodeString(AMemoField, TEncoding.UTF7);
end;

class function TDBUtils.AsUTF7String(AMemoField: TField): string;
begin
  Result := DecodeString(AMemoField, TEncoding.UTF7);
end;

class function TDBUtils.AsUTF8String(AMemoField: TField): string;
begin
  Result := DecodeString(AMemoField, TEncoding.UTF8);
end;

class function TDBUtils.AsUnicodeString(AMemoField: TField): string;
begin
  Result := DecodeString(AMemoField, TEncoding.Unicode);
end;

{ TDBUtils<C, D, P, PI, SP> }

class procedure TDBUtils<C, D, P, PI, SP>.DoCloneParameters(AClass: TParamClass; ASource, ADest: P);
var
  lItem: TCollectionItem;
  lNewParam: TCollectionItem;
begin
  ADest.Clear;
  for lItem in TCollection(ASource) do
  begin
    lNewParam := AClass.Create(ADest);
    lNewParam.Assign(lItem);
  end;
end;

class function TDBUtils<C, D, P, PI, SP>.DoCreateConnection(AClass: TConnectionClass;
  AInitConnection: TConnectionProc<C>): C;
begin
  TDBUtils.ThreadLock.Acquire;
  try
    Result := AClass.Create(nil) as C;
    try
      AInitConnection(Result);
    except
      begin
        Result.Free;
        raise;
      end;
    end;
  finally
    TDBUtils.ThreadLock.Release;
  end;
end;

class procedure TDBUtils<C, D, P, PI, SP>.DoInitConnection(AConnection: C; const AName: string;
  AInitConnectionProps: TInitConnectionPropsProc<C>;
  AInitConnectionName: TInitConnectionNameProc<C>;
  AIniFile: string = ''; ADefaultDriver: string = 'IB');
var
  error1: string;
begin
  try
    DoInitConnectionIni(AConnection, AName, AInitConnectionProps, AIniFile, ADefaultDriver)
  except
    on E: Exception do
    begin
      error1 := E.Message;
    end;
  end;
  if error1 <> '' then
    try
      AInitConnectionName(AConnection, AName);
    except
      on E: Exception do
      begin
        raise EDBUtils.CreateFmt(StrCouldNotOpenConnection,
          [AName, error1, E.Message] );
      end;
    end;
end;

class procedure TDBUtils<C, D, P, PI, SP>.DoInitConnectionIni(AConnection: C; const AIniSection: string;
  AInitConnectionProps: TinitConnectionPropsProc<C>; AIniFile: string = ''; ADefaultDriver: string = 'IB');
var
  lExtra: TStringList;
  lDatabase,
  lUserName,
  lPassword,
  lServer,
  lDriver,
  lExtraStr,
  lExtraIni: string;
  lStr: string;
  Ini: TIniFile;
begin
  if Length(Trim(AIniFile)) = 0 then // default to exe name with .ini extension
    AIniFile := TDBUtils.ModuleIniFile;
  if FileExists(AIniFile) then
  begin
    Ini := TIniFile.Create(AIniFile);
    try
      if Ini.SectionExists(AIniSection) then
      begin
        lExtra := TStringList.Create;
        try
          lExtraIni := AIniSection + 'Extra';
          Ini.ReadSection(lExtraIni, lExtra);
          for lStr in lExtra do
            lExtraStr := Format('%s%s=%s%s', [lExtraStr, lStr,
              Ini.ReadString(lExtraIni, lStr, ''), #13]);

          lServer := Ini.ReadString(AIniSection, SServer, SDefaultServer);
          lDatabase := Ini.ReadString(AIniSection, SDatabase, SDefaultDatabase);
          lUserName := Ini.ReadString(AIniSection, SUserName, SDefaultUser);
          lPassword := Ini.ReadString(AIniSection, SPassword, SDefaultPassword);
          lDriver := Ini.ReadString(AIniSection, SDriver, ADefaultDriver);
          AInitConnectionProps(AConnection, lServer, lDataBase, lUserName,
            lPassword, lDriver, lExtraStr);
        finally
          lExtra.Free;
        end;
      end
      else
        raise EDBUtils.CreateFmt(StrInvalidSection, [AIniSection]);
    finally
      Ini.Free;
    end;
  end
  else
    raise EDBUtils.CreateFmt(StrAppIniMissing, [AIniFile]);
end;

class function TDBUtils<C, D, P, PI, SP>.DoGetSQL(const AFieldsOrSQL, ATable, AWhere: string): string;
begin
  if ATable <> '' then
  begin
    if AWhere <> '' then
      Result := Format('SELECT %s FROM %s WHERE %s', [AFieldsOrSQL, ATable, AWhere])
    else
      Result := Format('SELECT %s FROM %s', [AFieldsOrSQL, ATable]);
  end
  else
    //Assume we've been passed a complete SQL statement
    Result := AFieldsOrSQL;
end;

class function TDBUtils<C, D, P, PI, SP>.DoGetDataSet(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>;
  const ASQL: string; AParams: P; AFreeParams: Boolean;
  AOwner: TComponent): D;
begin
  try
    Result := ACreateDataSet(AConnection, ASQL, AParams, AOwner);
    Result.Open;
  finally
    if Assigned(AParams) and AFreeParams then
      AParams.Free;
  end;
end;

class function TDBUtils<C, D, P, PI, SP>.DoGetCount(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>; const ATable, AWhere: string;
  AParams: P; AFreeParams: Boolean): Int64;
const
  cnCount = 'count(*)';
begin
  Result := DoGetValue(AConnection, ACreateDataSet, cnCount, ATable, -1, AWhere,
    AParams, AFreeParams);
end;

class function TDBUtils<C, D, P, PI, SP>.DoGetDataSet(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>;
  const AFieldsOrSQL, ATable, AWhere: string; AParams: P; AFreeParams: Boolean;
  AOwner: TComponent): D;
begin
  Result := DoGetDataSet(AConnection, ACreateDataSet,
    DoGetSQL(AFieldsOrSQL, ATable, AWhere), AParams, AFreeParams, AOwner);
end;

class function TDBUtils<C, D, P, PI, SP>.DoMakeParamList(AParamsClass: TParamsClass; AParamItemClass: TParamClass;
  AAddParamFunc: TAddParamFunc<P, PI>;
  const AName: string; ADataType: TFieldType; AValue: Variant; AParamType: TParamType;
  ASize: Integer): P;
begin
  Result := AParamsClass.Create(AParamItemClass) as P;
  if ((ADataType in [ftString, ftWideString, ftMemo]) and (ASize > 0) and (Length(AValue) > ASize)) then
    AValue := Copy(AValue, 1, ASize);
  AAddParamFunc(Result, AName, ADataType, AValue, AParamType, ASize);
end;

class function TDBUtils<C, D, P, PI, SP>.DoGetValueNullDefault(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>;
  const AFieldOrSQL, ATable: string;
  ADefault, ANullDefault: Variant; const AWhere: string; AParams: P;
  AFreeParams: Boolean): Variant;
var
  lDS: D;
begin
  lDS := DoGetDataSet(AConnection, ACreateDataSet, AFieldOrSql, ATable, AWhere, AParams, AFreeParams, nil);
  try
    if not lDS.Eof then
      if not lDS.Fields[0].IsNull then
        Result := lDS.Fields[0].Value
      else
        Result := ANullDefault
    else
      Result := ADefault;
  finally
    lDS.Free;
  end;
end;

class function TDBUtils<C, D, P, PI, SP>.DoGetValue(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>;
  const AFieldOrSQL, ATable: string;
  ADefault: Variant; const AWhere: string; AParams: P;
  AFreeParams: Boolean): Variant;
begin
  Result := DoGetValueNullDefault(AConnection, ACreateDataSet, AFieldOrSQL, ATable,
    ADefault, ADefault, AWhere, AParams, AFreeParams);
end;

class function TDBUtils<C, D, P, PI, SP>.DoQueryValueNullDefault(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>; const ASQL: string;
  ADefault, ANullDefault: Variant; AParams: P; AFreeParams: Boolean): Variant;
begin
  Result := DoGetValueNullDefault(AConnection, ACreateDataSet, ASQL, '', ADefault,
    ANullDefault, '', AParams, AFreeParams);
end;

class function TDBUtils<C, D, P, PI, SP>.DoQueryValue(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>; const ASQL: string;
  ADefault: Variant; AParams: P; AFreeParams: Boolean): Variant;
begin
  Result := DoGetValueNullDefault(AConnection, ACreateDataSet, ASQL, '', ADefault,
    ADefault, '', AParams, AFreeParams);
end;

class function TDBUtils<C, D, P, PI, SP>.DoGetBytes(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>; const AField, ATable: string;
  ADefault: TBytes; const AWhere: string; AParams: P; AFreeParams: Boolean): TBytes;
var
  lDS: D;
begin
  lDS := DoGetDataSet(AConnection, ACreateDataSet, AField, ATable, AWhere, AParams, AFreeParams, nil);
  try
    if not lDS.Eof then
      Result := lDS.Fields[0].AsBytes
    else
      Result := ADefault;
  finally
    lDS.Free;
  end;
end;

class function TDBUtils<C, D, P, PI, SP>.DoGetMemo(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>; const AField, ATable, ADefault,
  AWhere: string; AParams: P; AFreeParams: Boolean; AEncoding: TEncoding): string;
var
  lBytes: TBytes;
begin
  lBytes := DoGetBytes(AConnection, ACreateDataSet, AField, ATable, nil, AWhere, AParams, AFreeParams);
  if Assigned(lBytes) then
    Result := AEncoding.GetString(lBytes)
  else
    Result := ADefault;
end;

class function TDBUtils<C, D, P, PI, SP>.DoExecNoQuery(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, D, P>; AExecuteDataSet: TExecuteDataSetFunc<D>;
  const ASQL: string; AParams: P; AFreeParams: Boolean): Integer;
var
  lDS: D;
begin
  lDS := ACreateDataSet(AConnection, ASQL, AParams, nil);
  try
    try
      Result := AExecuteDataSet(lDS);
    finally
      if Assigned(AParams) and AFreeParams then
        AParams.Free;
    end;
  finally
    lDS.Free;
  end;
end;

class function TDBUtils<C, D, P, PI, SP>.DoExecProc(AConnection: C;
  ACreateDataSet: TCreateDataSetFunc<C, SP, P>;
  AExecProc: TDataSetProc<SP>; AParamValueFunc: TParamValueFunc<SP>;
  const AProcName: string; AParams: P; AFreeParams: Boolean;
  const AReturnParamName: string): Variant;
var
  lProc: SP;
begin
  Result := Null;
  lProc := ACreateDataSet(AConnection, AProcName, AParams, nil);
  try
    try
      AExecProc(lProc);
      if Length(AReturnParamName) > 0 then
        Result := AParamValueFunc(lProc, AReturnParamName);
    finally
      if Assigned(AParams) and AFreeParams then
        AParams.Free;
    end;
  finally
    lProc.Free;
  end;
end;

initialization
begin
  TDBUtils.ThreadLock := TCriticalSection.Create;
end;

finalization
begin
  FreeAndNil(TDBUtils.ThreadLock);
end;


end.
