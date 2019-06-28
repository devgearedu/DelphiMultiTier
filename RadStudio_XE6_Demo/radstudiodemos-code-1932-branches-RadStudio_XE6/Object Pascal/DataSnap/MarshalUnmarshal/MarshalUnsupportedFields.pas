
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit MarshalUnsupportedFields;

// Demonstrate how to marshal/unmarshal some of the field types that are not automatically supported:
// Set, Variant, Interface and and Interface (TTypeKind.tkSet, TTypeKind.tkVariant,
// TTypeKind.tkInterface, TTypeKind.tkPointer)

// This list of field types that are not supported include:
// TTypeKind.tkSet, TTypeKind.tkMethod, TTypeKind.tkVariant,
// TTypeKind.tkInterface, TTypeKind.tkPointer, TTypeKind.tkClassRef,
// TTypeKind.tkProcedureunit MarshalUnsupportedFields;

interface
  uses SysUtils, Classes, DBXJSON, Generics.Collections,
  StrUtils, RTTI, DBXJSONReflect, Variants;

type

  TSampleEnum = (suOne, suTwo, suThree);
  TSampleSet = set of TSampleEnum;
  ISampleInterface = interface
    function GetValue: string;
    property Value: string read GetValue;
  end;

  TSampleInterface = class(TInterfacedObject, ISampleInterface)
  private
    FValue: string;
    function GetValue: string;
    constructor Create(const AValue: string);
  end;

  TUnsupportedFieldsClass_Register = class
  private
    FSampleEnum: TSampleEnum;  // Enums are supported so no need for conversion

    // converter/reverter registered for the following fields.  See initialization.
    FSampleSet: TSampleSet;
    FSampleVariant: Variant;
    FSampleInterface: ISampleInterface;
    FSamplePointer: PChar;
    FSampleDouble: Double;
  public
    destructor Destroy; override;
  end;

  // Helper to convert FSampleSet
  TSampleSetInterceptor = class(TJSONInterceptor)
  private
  public
    function ObjectConverter(Data: TObject; Field: String): TObject; override;
    procedure ObjectReverter(Data: TObject; Field: String; Arg: TObject); override;
  end;

  // Helper to marshal FSampleVariant
  TSampleVariantInterceptor = class(TJSONInterceptor)
  private
  public
    function ObjectConverter(Data: TObject; Field: String): TObject; override;
    procedure ObjectReverter(Data: TObject; Field: String; Arg: TObject); override;
  end;

  // Helper to marshal FSampleInterface
  TSampleInterfaceInterceptor = class(TJSONInterceptor)
  private
  public
    function ObjectConverter(Data: TObject; Field: String): TObject; override;
    procedure ObjectReverter(Data: TObject; Field: String; Arg: TObject); override;
  end;

  // Helper to marshal FSamplePointer
  TSamplePointerInterceptor = class(TJSONInterceptor)
  private
  public
    function ObjectConverter(Data: TObject; Field: String): TObject; override;
    procedure ObjectReverter(Data: TObject; Field: String; Arg: TObject); override;
  end;

  // Helper to marshal FSampleDouble
  // Works around a problem when marshalling/unmarshalling double when the
  // DecimalSeparator is not '.'
  TSampleDoubleInterceptor = class(TJSONInterceptor)
  private
  public
    function StringConverter(Data: TObject; Field: String): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;


  TUnsupportedFieldsClass = class
  private
    FSampleEnum: TSampleEnum;  // Enums are supported so no need for interceptor

    [JSONReflect(ctObject, rtObject, TSampleSetInterceptor,nil,true)]
    FSampleSet: TSampleSet;

    [JSONReflect(ctObject, rtObject, TSampleVariantInterceptor,nil,true)]
    FSampleVariant: Variant;

    [JSONReflect(ctObject, rtObject, TSampleInterfaceInterceptor,nil,true)]
    FSampleInterface: ISampleInterface;

    [JSONReflect(ctObject, rtObject, TSamplePointerInterceptor,nil,true)]
    FSamplePointer: PChar;

    [JSONReflect(ctString, rtString, TSampleDoubleInterceptor,nil,true)]
    FSampleDouble: Double;
  public
    destructor Destroy; override;
  end;

  [JSONReflect(true)] // Freed by marshalling system
  // Serializable object to represent TSampleSet
  TReflectSampleSet = class
  private
    // Serializable
    FValues: TArray<TSampleEnum>;
  public
    constructor Create; overload;
    constructor Create(ASampleSet: TSampleSet); overload;
    function GetSet: TSampleSet;
  end;

  [JSONReflect(true)] // Freed by marshalling system
  // Serializable object to represent FSampleVariant
  TReflectVariantObject = class
  private
    // Serializable
    FType: TVarType;
    FValue: string;
  public
    constructor Create; overload;
    constructor Create(ASampleVariant: Variant); overload;
    function GetVariant: Variant;
  end;


  [JSONReflect(true)] // Freed by marshalling system
  // Serializable object to represent FSampleInterface
  TReflectInterfaceObject = class
  private
    FValue: string;
  public
    constructor Create; overload;
    constructor Create(ASampleInterface: ISampleInterface); overload;
    function GetInterface: ISampleInterface;
  end;

  [JSONReflect(true)] // Freed by marshalling system
  // Serializable object to represent FSamplePointer
  TReflectSamplePointer = class
  private
    FValue: string;
    FNull: Boolean;
  public
    constructor Create; overload;
    constructor Create(APointer: PChar); overload;
    function GetPointer: PChar;
  end;


  procedure LoadUnsupportedFieldsClass(AValue: TUnsupportedFieldsClass); overload;
  procedure ValidateUnsupportedFieldsClass(AValue: TUnsupportedFieldsClass); overload;
  procedure LoadUnsupportedFieldsClass(AValue: TUnsupportedFieldsClass_Register); overload;
  procedure ValidateUnsupportedFieldsClass(AValue: TUnsupportedFieldsClass_Register); overload;

implementation

uses
  TypInfo, DBXPlatform;

procedure LoadUnsupportedFieldsClass(AValue: TUnsupportedFieldsClass);
var
  LSampleValue: string;
begin
  AValue.FSampleEnum := suTwo;
  AValue.FSampleSet := [suOne, suThree];
  AValue.FSampleVariant := 123.456;
  AValue.FSampleDouble := 789.25;
  AValue.FSampleInterface := TSampleInterface.Create('SampleValue');
  LSampleValue := 'SampleValue';
  GetMem(AValue.FSamplePointer, (Length(LSampleValue)+1) * 2);
  Move(LSampleValue[1], AValue.FSamplePointer^, Length(LSampleValue)*2);
  AValue.FSamplePointer[Length(LSampleValue)] := #0;
end;

procedure ValidateUnsupportedFieldsClass(AValue: TUnsupportedFieldsClass);
begin
  Assert(AValue.FSampleEnum = suTwo, 'FSampleEnum: suTwo');
  Assert(AValue.FSampleSet = [suOne, suThree], 'FSampleSet: [suOne, suThree]');
  Assert(AValue.FSampleVariant = 123.456);
  Assert(AValue.FSampleDouble = 789.25);
  Assert(AValue.FSampleInterface <> nil);
  Assert(AValue.FSampleInterface.Value = 'SampleValue');
  Assert(AValue.FSamplePointer <> nil);
  Assert(SameText(AValue.FSamplePointer, 'SampleValue'));
end;


procedure LoadUnsupportedFieldsClass(AValue: TUnsupportedFieldsClass_Register);
var
  LSampleValue: string;
begin
  AValue.FSampleEnum := suTwo;
  AValue.FSampleSet := [suOne, suThree];
  AValue.FSampleVariant := 123.456;
  AValue.FSampleDouble := 789.25;
  AValue.FSampleInterface := TSampleInterface.Create('SampleValue');
  LSampleValue := 'SampleValue';
  GetMem(AValue.FSamplePointer, (Length(LSampleValue)+1) * 2);
  Move(LSampleValue[1], AValue.FSamplePointer^, Length(LSampleValue)*2);
  AValue.FSamplePointer[Length(LSampleValue)] := #0;
end;

procedure ValidateUnsupportedFieldsClass(AValue: TUnsupportedFieldsClass_Register);
begin
  Assert(AValue.FSampleEnum = suTwo, 'FSampleEnum: suTwo');
  Assert(AValue.FSampleSet = [suOne, suThree], 'FSampleSet: [suOne, suThree]');
  Assert(AValue.FSampleVariant = 123.456);
  Assert(AValue.FSampleDouble = 789.25);
  Assert(AValue.FSampleInterface <> nil);
  Assert(AValue.FSampleInterface.Value = 'SampleValue');
  Assert(AValue.FSamplePointer <> nil);
  Assert(SameText(AValue.FSamplePointer, 'SampleValue'));
end;

{ TSampleSetInterceptor }

function TSampleSetInterceptor.ObjectConverter(Data: TObject;
  Field: String): TObject;
var
  LRttiContext: TRttiContext;
  LValue: TSampleSet;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TSampleSet>;
  Result := TReflectSampleSet.Create(LValue);
end;

procedure TSampleSetInterceptor.ObjectReverter(Data: TObject; Field: String; Arg: TObject);
var
  LRttiContext: TRttiContext;
  LValue: TSampleSet;
begin
  Assert(Arg is TReflectSampleSet);
  LValue := TReflectSampleSet(Arg).GetSet;
  LRttiContext.GetType(Data.ClassType).GetField(Field).SetValue(Data, TValue.From<TSampleSet>(LValue));
  Arg.Free;  // Must free the serializable object
end;

{ TReflectSampleSet }

constructor TReflectSampleSet.Create(ASampleSet: TSampleSet);
var
  LValue: TSampleEnum;
  LValues: TList<TSampleEnum>;
begin
  LValues := TList<TSampleEnum>.Create;
  try
    for LValue in ASampleSet do
      LValues.Add(LValue);
    FValues := LValues.ToArray;
  finally
    LValues.Free;
  end;
end;

// This constructor is called when rtti is used to instantiate object
constructor TReflectSampleSet.Create;
begin
end;

function TReflectSampleSet.GetSet: TSampleSet;
var
  LValue: TSampleEnum;
begin
  Result := [];
  for LValue in FValues do
    Include(Result, LValue);
end;

{ TSampleVariantInterceptor }

function TSampleVariantInterceptor.ObjectConverter(Data: TObject;
  Field: String): TObject;
var
  LRttiContext: TRttiContext;
  LVariant: Variant;
begin
  LVariant := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<Variant>;
  Result := TReflectVariantObject.Create(LVariant);
end;

procedure TSampleVariantInterceptor.ObjectReverter(Data: TObject; Field: String;
  Arg: TObject);
var
  LRttiContext: TRttiContext;
  LVariant: Variant;
begin
  Assert(Arg is TReflectVariantObject);
  LVariant := TReflectVariantObject(Arg).GetVariant;
  LRttiContext.GetType(Data.ClassType).GetField(Field).SetValue(Data,
    TValue.FromVariant(LVariant));
  Arg.Free;
end;

{ TVariantObject }

constructor TReflectVariantObject.Create(ASampleVariant: Variant);
begin
  FType := VarType(ASampleVariant);
  FValue := ASampleVariant; // Convert to string
end;

// This constructor is called when rtti is used to instantiate object
constructor TReflectVariantObject.Create;
begin
end;

function TReflectVariantObject.GetVariant: Variant;
var
  V: Variant;
begin
  V := FValue;
  VarCast(Result, V, FType);
end;

{ TSampleInterface }

constructor TSampleInterface.Create(const AValue: string);
begin
  inherited Create;
  FValue := AValue;
end;

function TSampleInterface.GetValue: string;
begin
  Result := FValue;
end;

{ TSampleInterfaceInterceptor }

function TSampleInterfaceInterceptor.ObjectConverter(Data: TObject;
  Field: String): TObject;
var
  LRttiContext: TRttiContext;
  LValue: ISampleInterface;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<ISampleInterface>;
  Result := TReflectInterfaceObject.Create(LValue);
end;

procedure TSampleInterfaceInterceptor.ObjectReverter(Data: TObject;
  Field: String; Arg: TObject);
var
  LRttiContext: TRttiContext;
  LValue: ISampleInterface;
begin
  Assert(Arg is TReflectInterfaceObject);
  LValue := TReflectInterfaceObject(Arg).GetInterface;
  LRttiContext.GetType(Data.ClassType).GetField(Field).SetValue(Data, TValue.From<ISampleInterface>(LValue));
  Arg.Free;  // Must free the serializable object
end;

{ TSamplePointerInterceptor }

function TSamplePointerInterceptor.ObjectConverter(Data: TObject;
  Field: String): TObject;
//begin
//  Assert(Field = 'FSamplePointer');
//  Assert(Data is TUnsupportedFieldsClass);
//  Result := TReflectSamplePointer.Create(TUnsupportedFieldsClass(Data).FSamplePointer)
var
  LRttiContext: TRttiContext;
  LValue: PChar;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<PChar>;
  Result := TReflectSamplePointer.Create(LValue);
end;

procedure TSamplePointerInterceptor.ObjectReverter(Data: TObject;
  Field: String; Arg: TObject);
var
  LRttiContext: TRttiContext;
  LValue: PChar;
begin
  Assert(Arg is TReflectSamplePointer);
  LValue := TReflectSamplePointer(Arg).GetPointer;
  LRttiContext.GetType(Data.ClassType).GetField(Field).SetValue(Data, TValue.From<PChar>(LValue));
  Arg.Free;  // Must free the serializable object
end;

{ TInterfaceObject }

constructor TReflectInterfaceObject.Create(ASampleInterface: ISampleInterface);
begin
  FValue := ASampleInterface.Value;
end;

// This constructor is called when rtti is used to instantiate object
constructor TReflectInterfaceObject.Create;
begin
end;

function TReflectInterfaceObject.GetInterface: ISampleInterface;
begin
  Result := TSampleInterface.Create(FValue);
end;

{ TReflectSamplePointer }

constructor TReflectSamplePointer.Create;
begin

end;

constructor TReflectSamplePointer.Create(APointer: PChar);
begin
  if APointer <> nil then
  begin
    FValue := APointer;
    FNull := False;
  end
  else
    FNull := True;
end;

function TReflectSamplePointer.GetPointer: PChar;
begin
  if FNull then
    Result := nil
  else
  begin
    GetMem(Result, (Length(FValue)+1)*2);
    Move(FValue[1], Result^, Length(FValue)*2);
    Result[Length(FValue)] := #0;
  end;
end;

{ TUnsupportedFieldsClass }

destructor TUnsupportedFieldsClass.Destroy;
begin
  if FSamplePointer <> nil then
    FreeMem(FSamplePointer);
  inherited;
end;

{ TUnsupportedFieldsClass_Register }

destructor TUnsupportedFieldsClass_Register.Destroy;
begin
  if FSamplePointer <> nil then
    FreeMem(FSamplePointer);
  inherited;
end;

procedure RegisterReverterConverters;
var
  LReverter: TReverterEvent;
  LConverter: TConverterEvent;
begin
  // Equivalent to [JSONReflect(ctObject, rtObject, TSampleSetInterceptor,nil,true)]
  LReverter := TReverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSampleSet');
  LReverter.ObjectReverter :=
    procedure(Data: TObject; Field: String; Arg: TObject)
    begin
      with TSampleSetInterceptor.Create do
      try
        ObjectReverter(Data, Field, Arg);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSampleSet');
  LConverter.ObjectConverter :=
    function(Data: TObject; Field: String): TObject
    begin
      with TSampleSetInterceptor.Create do
      try
        Result := ObjectConverter(Data, Field);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddConverter(LConverter);

  // Equivalent to [JSONReflect(ctObject, rtObject, TSampleVariantInterceptor,nil,true)]
  LReverter := TReverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSampleVariant');
  LReverter.ObjectReverter :=
    procedure(Data: TObject; Field: String; Arg: TObject)
    begin
      with TSampleVariantInterceptor.Create do
      try
        ObjectReverter(Data, Field, Arg);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSampleVariant');
  LConverter.ObjectConverter :=
    function(Data: TObject; Field: String): TObject
    begin
      with TSampleVariantInterceptor.Create do
      try
        Result := ObjectConverter(Data, Field);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddConverter(LConverter);

  // Equivalent to [JSONReflect(ctObject, rtObject, TSampleInterfaceInterceptor,nil,true)]
  LReverter := TReverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSampleInterface');
  LReverter.ObjectReverter :=
    procedure(Data: TObject; Field: String; Arg: TObject)
    begin
      with TSampleInterfaceInterceptor.Create do
      try
        ObjectReverter(Data, Field, Arg);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSampleInterface');
  LConverter.ObjectConverter :=
    function(Data: TObject; Field: String): TObject
    begin
      with TSampleInterfaceInterceptor.Create do
      try
        Result := ObjectConverter(Data, Field);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddConverter(LConverter);

  // Equivalent to [JSONReflect(ctObject, rtObject, TSamplePointerInterceptor,nil,true)]
  LReverter := TReverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSamplePointer');
  LReverter.ObjectReverter :=
    procedure(Data: TObject; Field: String; Arg: TObject)
    begin
      with TSamplePointerInterceptor.Create do
      try
        ObjectReverter(Data, Field, Arg);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSamplePointer');
  LConverter.ObjectConverter :=
    function(Data: TObject; Field: String): TObject
    begin
      with TSamplePointerInterceptor.Create do
      try
        Result := ObjectConverter(Data, Field);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddConverter(LConverter);

  // Equivalent to [JSONReflect(ctString, rtString, TSampleDoubleInterceptor,nil,true)]
  LReverter := TReverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSampleDouble');
  LReverter.StringReverter :=
    procedure(Data: TObject; Field: String; Arg: string)
    begin
      with TSampleDoubleInterceptor.Create do
      try
        StringReverter(Data, Field, Arg);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TUnsupportedFieldsClass_Register, 'FSampleDouble');
  LConverter.StringConverter :=
    function(Data: TObject; Field: String): string
    begin
      with TSampleDoubleInterceptor.Create do
      try
        Result := StringConverter(Data, Field);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddConverter(LConverter);

end;

{ TSampleDoubleInterceptor }

function TSampleDoubleInterceptor.StringConverter(Data: TObject;
  Field: String): string;
var
  LRttiContext: TRttiContext;
  LValue: Double;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<Double>;
  Result := TDBXPlatform.JsonFloat(LValue);
end;

procedure TSampleDoubleInterceptor.StringReverter(Data: TObject; Field: string; Arg: string);
var
  LRttiContext: TRttiContext;
  LValue: Double;
begin
  LValue := TDBXPlatform.JsonToFloat(Arg);
  LRttiContext.GetType(Data.ClassType).GetField(Field).SetValue(Data, TValue.From<Double>(LValue));
end;

initialization
  RegisterReverterConverters;
end.

