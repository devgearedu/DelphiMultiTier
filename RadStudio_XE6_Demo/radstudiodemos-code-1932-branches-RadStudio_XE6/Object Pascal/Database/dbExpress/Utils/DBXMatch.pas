
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

unit DBXMatch;

interface

uses
  DBXCommon, Generics.Collections, Classes;

type
  TDBXSetLong = (slSame, slTrue, slFalse);

  TDBXTypeMatch = class
  class var FDbxTypes: TStrings;
  private
    FDbPlatform: string;
    FPrecision: integer;
    FTypeName: string;
    FIsLong: TDBXSetLong;
    procedure SetDbPlatform(const Value: string);
    procedure SetTypeName(const Value: string);
  public
    property TypeName: string read FTypeName write SetTypeName;
    property DbPlatform: string read FDbPlatform write SetDbPlatform;
    property Precision: integer read FPrecision write FPrecision;
    property IsLong: TDBXSetLong read FIsLong write FIsLong default slSame;
    constructor Create; overload;
    constructor Create(ADbPlatform, ATypeName: string); overload;
    constructor Create(ADbPlatform, ATypeName: string; APrecision: integer); overload;
    constructor Create(ADbPlatform, ATypeName: string; APrecision: integer;
      AIsLong: TDBXSetLong); overload;
    class procedure DbxTypesFree;
    class function DbxTypesList: TStrings;
    class function DbxTypeFromName(AName: string): TDBXType;
  end;

  TDBXTypeMatchList = TList<TDBXTypeMatch>;

  TDBXTypeConversion = class
  private
    FTypeName: string;
    FList: TDBXTypeMatchList;
    FDBXType: TDBXType;
    procedure SetTypeName(const Value: string);
  public
    property TypeName: string read FTypeName write SetTypeName;
    property DBXType: TDBXType read FDBXType write FDBXType;
    property List: TDBXTypeMatchList read FList;
    constructor Create; overload;
    constructor Create(ATypeName: string); overload;
    constructor Create(ADBXType: TDBXType); overload;
    destructor Destroy; override;
    function AddMatch(ADbPlatform: string; ATypeName: string): TDBXTypeMatch;
      overload;
    function AddMatch(ADbPlatform: string; ATypeName: string;
      APrecision: integer): TDBXTypeMatch; overload;
    function AddMatch(ADbPlatform: string; ATypeName: string;
      APrecision: integer; AIsLong: TDBXSetLong): TDBXTypeMatch; overload;
    function FindMatch(ADbPlatform: string): TDBXTypeMatch;
  end;

  TDBXTypeConversionList = TList<TDBXTypeConversion>;

  TDBXTypeConverter = class
  private
    FList: TDBXTypeConversionList;
  public
    constructor Create;
    destructor Destroy; override;
    property List: TDBXTypeConversionList read FList;
    function FindMatch(ADbPlatform, ATypeName: string): TDBXTypeMatch; overload;
    function FindMatch(ADbPlatform: string; ADbxType: Integer): TDBXTypeMatch; overload;
  end;

var
  DbxTypeConverter : TDbxTypeConverter;

procedure FreeStringObjects(var AStrings: TStrings);
function StripDbxType(ADbxTypeName: UnicodeString): UnicodeString;

implementation

uses
  SysUtils, DBXUtils;

procedure FreeStringObjects(var AStrings: TStrings);
var
  i: Integer;
begin
  if Assigned(AStrings) then
  begin
    for i := 0 to AStrings.Count - 1 do
    begin
      if Assigned(AStrings.Objects[i]) then
        AStrings.Objects[i].Free;
    end;
    FreeAndNil(AStrings);
  end;
end;

function StripDbxType(ADbxTypeName: UnicodeString): UnicodeString;
const
  SDbxTypes = 'TDBXTYPES.';
  StripLen = Length(SDbxTypes) + 1;
begin
  if Pos(SDbxTypes, UpperCase(ADbxTypeName)) = 1 then
    Result := Copy(ADbxTypeName, StripLen, 100)
  else
    Result := ADbxTypeName;
end;

{ TDBXTypeMatch }

constructor TDBXTypeMatch.Create;
begin
  inherited;
  FPrecision := 0;
  FIsLong := slSame;
end;

constructor TDBXTypeMatch.Create(ADbPlatform, ATypeName: string);
begin
  Create(ADbPlatform, ATypeName, 0);
end;

constructor TDBXTypeMatch.Create(ADbPlatform, ATypeName: string;
  APrecision: integer);
begin
  Create(ADbPlatform, ATypeName, APrecision, slSame);
end;

constructor TDBXTypeMatch.Create(ADbPlatform, ATypeName: string;
  APrecision: integer; AIsLong: TDBXSetLong);
begin
  inherited Create;
  DbPlatform := ADbPlatform;
  TypeName := ATypeName;
  FPrecision := APrecision;
  IsLong := AIsLong;
end;

procedure TDBXTypeMatch.SetDbPlatform(const Value: string);
begin
  FDbPlatform := UpperCase(Value);
end;

procedure TDBXTypeMatch.SetTypeName(const Value: string);
begin
  FTypeName := UpperCase(Value);
end;

class function TDBXTypeMatch.DbxTypeFromName(AName: string): TDBXType;
var
  i: Integer;
begin
  if not Assigned(FDbxTypes) then
    DbxTypesList;
  i := FDbxTypes.IndexOf(AName);
  if i > -1 then
    Result := TDBXType((FDbxTypes.Objects[i] as TDBXIntObj).Value)
  else
    Result := TDBXDataTypes.UnknownType;
end;

class procedure TDBXTypeMatch.DbxTypesFree;
begin
  FreeStringObjects(FDbxTypes);
end;

class function TDBXTypeMatch.DbxTypesList: TStrings;
var
  i: Integer;
begin
  if not Assigned(FDbxTypes) then
  begin
    FDbxTypes := TStringList.Create;
    for i := 0 to TDBXDataTypes.VariantType do
      FDbxTypes.AddObject(StripDbxType(
        TDBXValueType.DataTypeName(TDBXType(i))), TDBXIntObj.Create(i));
  end;
  Result := FDbxTypes;
end;

{ TDBXTypeConversion }

function TDBXTypeConversion.AddMatch(ADbPlatform,
  ATypeName: string): TDBXTypeMatch;
begin
  Result := AddMatch(ADbPlatform, ATypeName, 0, slSame);
end;

function TDBXTypeConversion.AddMatch(ADbPlatform, ATypeName: string;
  APrecision: integer): TDBXTypeMatch;
begin
  Result := AddMatch(ADbPlatform, ATypeName, APrecision, slSame);
end;

function TDBXTypeConversion.AddMatch(ADbPlatform, ATypeName: string;
  APrecision: integer; AIsLong: TDBXSetLong): TDBXTypeMatch;
begin
  Result := TDBXTypeMatch.Create(ADbPlatform, ATypeName, APrecision, AIsLong);
  FList.Add(Result);
end;

constructor TDBXTypeConversion.Create;
begin
  inherited;
  FList := TDBXTypeMatchList.Create;
end;

constructor TDBXTypeConversion.Create(ATypeName: string);
begin
  Create;
  TypeName := ATypeName;
  FDBXType := TDbxTypeMatch.DbxTypeFromName(TypeName);
end;

constructor TDBXTypeConversion.Create(ADBXType: TDBXType);
begin
  Create;
  TypeName := UpperCase(TDBXValueType.DataTypeName(ADBXType));
  FDBXType := ADBXType;
end;

destructor TDBXTypeConversion.Destroy;
var
  obj: TObject;
begin
  if Assigned(FList) then
  begin
    for obj in FList do
    begin
      obj.Free;
    end;
    FreeAndNil(FList);
  end;
  inherited;
end;

function TDBXTypeConversion.FindMatch(ADbPlatform: string): TDBXTypeMatch;
var
  match : TDBXTypeMatch;
begin
  for match in List do
    if SameText(match.DbPlatform, ADbPlatform,
      TLocaleOptions.loInvariantLocale) then
    begin
      Result := match;
      exit;
    end;
  Result := nil;
end;

procedure TDBXTypeConversion.SetTypeName(const Value: string);
begin
  FTypeName := UpperCase(StripDbxType(Value));
end;

{ TDBXTypeConverter }

constructor TDBXTypeConverter.Create;
begin
  FList := TDBXTypeConversionList.Create;
end;

destructor TDBXTypeConverter.Destroy;
var
  obj: TObject;
begin
  if Assigned(FList) then
  begin
    for obj in FList do
    begin
      obj.Free;
    end;
    FreeAndNil(FList);
  end;
  inherited Destroy;
end;

function TDBXTypeConverter.FindMatch(ADbPlatform: string; ADbxType: Integer): TDBXTypeMatch;
begin
  Result := FindMatch(ADbPlatform, TDBXValueType.DataTypeName(ADbxType));
end;

function TDBXTypeConverter.FindMatch(ADbPlatform, ATypeName: string): TDBXTypeMatch;
var
  conversion: TDBXTypeConversion;
begin
  ATypeName := UpperCase(StripDbxType(ATypeName));
  ADbPlatform := UpperCase(ADbPlatform);
  for conversion in List do
  begin
    if SameText(conversion.TypeName, ATypeName,
      TLocaleOptions.loInvariantLocale) then
    begin
      Result := conversion.FindMatch(ADbPlatform);
      exit;
    end;
  end;
  Result := nil;
end;

const
  SBlackfish = 'BlackfishSQL';
  SInterbase = 'InterBase';
  SFirebird = 'FireBird';
  SDB2 = 'DB2';
  SMSSQL = 'MSSQL';
  // bigint,binary,bit,blob,bool,char,date,datetime,decimal,double,enum,float,int,longblob,longtext,mediumblob,mediumint,mediumtext,numeric,set,smallint,text,time,timestamp,tinyblob,tinyint,tinytext,varbinary,varchar,year
  SMySQL = 'MySQL';
  SOracle = 'Oracle';
  SSqlAnywhere = 'SQLAnywhere';
  SSybase = 'Sybase';
  SInformix = 'Informix';
  SBigInt = 'BigInt';
  SBlob = 'Blob';
  SDoublePrecision = 'DOUBLE PRECISION';
  SInt = 'Int';
  SInteger = 'Integer';
  SSmallInt = 'SmallInt';
  SNumber = 'Number';
  SNumeric = 'Numeric';
  SVarChar = 'VarChar';
  SVarBinary = 'VarBinary';
  SBoolean = 'Boolean';
  SZString = 'ZString';
  SLongText = 'LongText';
  SDecimal = 'Decimal';

// Type-specific conversion constructors
function MatchInt64: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(TDBXDataTypes.Int64Type);
  Result.AddMatch(SInterBase, SNumeric, 18);
  Result.AddMatch(SBlackfish, SBigInt);
//  Result.AddMatch(SFireBird, SBigInt);
//  Result.AddMatch(SDB2, SBigInt);
  Result.AddMatch(SMSSQL, SBigInt);
  Result.AddMatch(SMySQL, SBigInt);
  Result.AddMatch(SOracle, SNumber, 19);
//  Result.AddMatch(SSqlAnywhere, SBigInt);
//  Result.AddMatch(SSybase, SBigInt);
//  Result.AddMatch(SInformix, SBigInt);
end;

function MatchBigInt: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(SBigInt);
  Result.AddMatch(SInterBase, SNumeric, 18);
  Result.AddMatch(SOracle, SNumber, 19);
end;

function MatchInt32: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(TDBXDataTypes.Int32Type);
  Result.AddMatch(SBlackfish, SInteger);
  Result.AddMatch(SInterBase, SInteger);
  Result.AddMatch(SMySQL, SInt);
end;

function MatchInt16: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(TDBXDataTypes.Int16Type);
  Result.AddMatch(SBlackfish, SSmallInt);
  Result.AddMatch(SInterBase, SSmallInt);
  Result.AddMatch(SMySQL, SSmallInt);
end;

function MatchWideString: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(TDBXDataTypes.WideStringType);
  Result.AddMatch(SBlackfish, SVarChar);
  Result.AddMatch(SInterBase, SVarChar);
  Result.AddMatch(SMySQL, SVarChar);
end;

function MatchBool: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(TDBXDataTypes.BooleanType);
  Result.AddMatch(SBlackfish, SBoolean);
  Result.AddMatch(SInterBase, SBoolean);
end;

function MatchBlob: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(TDBXDataTypes.BlobType);
  Result.AddMatch(SBlackfish, SVarBinary, 0, slTrue);
  Result.AddMatch(SInterBase, SBlob, 0, slTrue);
  Result.AddMatch(SMySQL, 'longblob', 0, slTrue);
end;

function MatchDouble: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(TDBXDataTypes.DoubleType);
  Result.AddMatch(SInterBase, SDoublePrecision);
  Result.AddMatch(SMySQL, SDoublePrecision);
end;

function MatchBcd: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(TDBXDataTypes.BcdType);
  Result.AddMatch(SInterBase, SDecimal);
end;

function MatchZString: TDBXTypeConversion;
begin
  Result := TDBXTypeConversion.Create(TDBXDataTypes.AnsiStringType);
  Result.AddMatch(SMySQL, SVarChar);
  Result.AddMatch(SInterbase, SVarChar);
end;

initialization

begin
  DbxTypeConverter := TDBXTypeConverter.Create;
  DbxTypeConverter.List.Add(MatchInt64);
  DbxTypeConverter.List.Add(MatchBigInt);
  DbxTypeConverter.List.Add(MatchInt32);
  DbxTypeConverter.List.Add(MatchInt16);
  DbxTypeConverter.List.Add(MatchWideString);
  DbxTypeConverter.List.Add(MatchBool);
  DbxTypeConverter.List.Add(MatchBlob);
  DbxTypeConverter.List.Add(MatchDouble);
  DbxTypeConverter.List.Add(MatchZString);
  DbxTypeConverter.List.Add(MatchBcd);
end;

finalization
begin
  FreeAndNil(DbxTypeConverter);
  TDBXTypeMatch.DbxTypesFree;
end;

end.
