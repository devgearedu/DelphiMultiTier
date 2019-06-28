
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// Tests for marshalling collections
unit GenericDictionaryField;

interface
  uses SysUtils, Classes, DBXJSON, Generics.Collections,
  StrUtils, RTTI, DBXJSONReflect, Variants, Generics.Defaults;

type
  TMyDictionary = class;
  TMyDictionaryItem = class
  private
    FValue: string;
  public
    constructor Create(const AValue: string);
  end;

  // Class with a TDictionary<> field
  TClassWithGenericDictionaryField_Register = class
  private
    [JSONOwned(false)] // Prevent unmarshal from freeing FList after construction
    // converter/referter registered for this field, see initialization
    FDictionary: TMyDictionary;
  public
    constructor Create;
    destructor Destroy; override;
  end;


  TGenericDictionaryFieldInterceptor = class(TJSONInterceptor)
  public
    procedure ObjectsReverter(Data: TObject; Field: String;
      Args: TListOfObjects); override;
    function ObjectsConverter(Data: TObject; Field: String): TListOfObjects; override;
  end;

  TMyDictionary = class(TObjectDictionary<string, TMyDictionaryItem>)
  public
    constructor Create;
  end;

  // Class with a TDictionary<> field
  TClassWithGenericDictionaryField = class
  private
    [JSONReflect(ctObjects, rtObjects, TGenericDictionaryFieldInterceptor,nil,true)]
    [JSONOwned(false)] // Prevent unmarshal from freeing FList after construction

    FDictionary: TMyDictionary;
  public
    constructor Create; overload;
    destructor Destroy; override;
  end;

  // Used to marshal/unmarshal a pair
  [JSONReflect(true)]  // Tell the marshalling system to free this object after
  TMyPairObject = class
    FPair: TPair<string, TMyDictionaryItem>;
    constructor Create; overload; // Must have constructor with no params
    constructor Create(APair: TPair<string, TMyDictionaryItem>); overload;
  end;

  // Use to marshal just the pairs of a dictionary
  // Note that this class does not free keys or values
  TDictionaryPairs<TKey, TValue> = class
  private
    FPairs: TArray<TPair<TKey, TValue>>;
  public
    // constructor used to construct when unmarshalling
    constructor Create; overload;
    // constructor used to construct when marshalling
    constructor Create(APairs: TArray<TPair<TKey, TValue>>); overload;
    property Pairs: TArray<TPair<TKey, TValue>> read FPairs;
  end;

  TMyDictionaryPairs = class(TDictionaryPairs<string, TMyDictionaryItem>)
  end;

  procedure LoadGenericDictionary(AValue: TMyDictionary); overload;
  procedure ValidateGenericDictionary(AValue: TMyDictionary); overload;
  procedure LoadClassWithGenericDictionaryField(AValue: TClassWithGenericDictionaryField); overload;
  procedure ValidateClassWithGenericDictionaryField(AValue: TClassWithGenericDictionaryField); overload;
  procedure LoadClassWithGenericDictionaryField(AValue: TClassWithGenericDictionaryField_Register); overload;
  procedure ValidateClassWithGenericDictionaryField(AValue: TClassWithGenericDictionaryField_Register); overload;

implementation

procedure LoadGenericDictionary(AValue: TMyDictionary);
begin
  AValue.Add('a', TMyDictionaryItem.Create('one'));
  AValue.Add('b', TMyDictionaryItem.Create('two'));
  AValue.Add('c', TMyDictionaryItem.Create('three'));
end;

// Set a value for FComparer.  Since this field can be nil when
// a TDictionary is constructed by the unmarshalling system.  Alternative, is to
// declare a TDictionary descendent class with a zero-parameter constructor, which call
// a inherited constructor.
//procedure InitDictionaryComparer(ADictionary: TObject);
//var
//  rttiType : TRttiType;
//  rttiField : TRttiField;
//  rttiContext: TRttiContext;
//  LValue: TValue;
//begin
//  rttiType := rttiContext.GetType(ADictionary.ClassType);
//  rttiField := rttiType.GetField('FComparer');
//  Assert(rttiField <> nil);
//  LValue := rttiField.GetValue(ADictionary);
//  if LValue.AsInterface = nil then
//    rttiField.SetValue(ADictionary,
//      TValue.From<IEqualityComparer<string>>(TEqualityComparer<string>.Default));
//end;

procedure ValidateGenericDictionary(AValue: TMyDictionary);
begin
  Assert(AValue <> nil);
  //InitDictionaryComparer(AValue);

  Assert(AValue.Count = 3);
  Assert(AValue['a'].FValue = 'one');
  Assert(AValue['b'].FValue = 'two');
  Assert(AValue['c'].FValue = 'three');
end;


procedure LoadClassWithGenericDictionaryField(AValue: TClassWithGenericDictionaryField);
begin
  AValue.FDictionary.Add('a', TMyDictionaryItem.Create('one'));
  AValue.FDictionary.Add('b', TMyDictionaryItem.Create('two'));
  AValue.FDictionary.Add('c', TMyDictionaryItem.Create('three'));
end;

procedure ValidateClassWithGenericDictionaryField(AValue: TClassWithGenericDictionaryField);
begin
  Assert(AValue <> nil);
  Assert(AValue.FDictionary <> nil);
  ValidateGenericDictionary(AValue.FDictionary);
end;


procedure LoadClassWithGenericDictionaryField(AValue: TClassWithGenericDictionaryField_Register);
begin
  LoadGenericDictionary(AValue.FDictionary);
end;

procedure ValidateClassWithGenericDictionaryField(AValue: TClassWithGenericDictionaryField_Register);
begin
  Assert(AValue <> nil);
  Assert(AValue.FDictionary <> nil);
  ValidateGenericDictionary(AValue.FDictionary);
end;

{ TGenericDictionaryFieldInterceptor }


constructor TMyPairObject.Create(APair: TPair<string, TMyDictionaryItem>);
begin
  FPair := APair;
end;

function TGenericDictionaryFieldInterceptor.ObjectsConverter(Data: TObject;
  Field: String): TListOfObjects;
var
  LRttiContext: TRttiContext;
  LValue: TMyDictionary;
  I: Integer;
  LListItem: TPair<string, TMyDictionaryItem>;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TMyDictionary>;
  SetLength(Result, LValue.Count);
  I := 0;
  for LListItem in LValue do
  begin
    Result[I] := TMyPairObject.Create(LListItem);
    Inc(I);
  end;
end;

procedure TGenericDictionaryFieldInterceptor.ObjectsReverter(Data: TObject; Field: String;
  Args: TListOfObjects);
var
  LRttiContext: TRttiContext;
  LValue: TMyDictionary;
  LListItem: TObject;
  LMyPairObject: TMyPairObject;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TMyDictionary>;
  for LListItem in Args do
  begin
    Assert(LListItem is TMyPairObject);
    LMyPairObject := TMyPairObject(LListItem);
    LValue.Add(LMyPairObject.FPair.Key, LMyPairObject.FPair.Value);
    LMyPairObject.Free; // Reverter must free this
  end;
end;

{ TClassWithGenericDictionaryField }

constructor TClassWithGenericDictionaryField.Create;
begin
  FDictionary := TMyDictionary.Create();
end;

destructor TClassWithGenericDictionaryField.Destroy;
begin
  FDictionary.Free;
  inherited;
end;

{ TClassWithGenericDictionaryField_Register }

constructor TClassWithGenericDictionaryField_Register.Create;
begin
  FDictionary := TMyDictionary.Create();
end;

destructor TClassWithGenericDictionaryField_Register.Destroy;
begin
  FDictionary.Free;
  inherited;
end;

{ TMyListItem }

constructor TMyDictionaryItem.Create(const AValue: string);
begin
  FValue := AValue;
end;


procedure RegisterReverterConverters;
var
  LReverter: TReverterEvent;
  LConverter: TConverterEvent;
begin
  // Equivalent to     [JSONReflect(ctObjects, rtObjects, TGenericDictionaryFieldInterceptor,nil,true)]
  LReverter := TReverterEvent.Create(TClassWithGenericDictionaryField_Register, 'FDictionary');
  LReverter.ObjectsReverter :=
    procedure(Data: TObject; Field: String; Args: TListOfObjects)
    begin
      with TGenericDictionaryFieldInterceptor.Create do
      try
        ObjectsReverter(Data, Field, Args);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TClassWithGenericDictionaryField_Register, 'FDictionary');
  LConverter.ObjectsConverter :=
    function(Data: TObject; Field: String): TListOfObjects
    begin
      with TGenericDictionaryFieldInterceptor.Create do
      try
        Result := ObjectsConverter(Data, Field);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddConverter(LConverter);
end;

constructor TMyPairObject.Create;
begin
//
end;

{ TMyDictionary }

constructor TMyDictionary.Create;
begin
  inherited Create([doOwnsValues]); // Call contructor to initialize FComparer
end;

{ TDictionaryPairs<TKey, TValue> }

constructor TDictionaryPairs< TKey, TValue>.Create;
begin
  // called when unmarshalled
end;

constructor TDictionaryPairs< TKey, TValue>.Create(
  APairs: TArray<TPair<TKey, TValue>>);
begin
  FPairs := APairs;
end;

initialization
  RegisterReverterConverters;
end.

