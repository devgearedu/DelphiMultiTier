
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// Tests for marshalling collections
unit GenericListField;

interface
  uses SysUtils, Classes, DBXJSON, Generics.Collections,
  StrUtils, RTTI, DBXJSONReflect, Variants;

type
  TMyListItem = class
  private
    FValue: string;
  public
    constructor Create(const AValue: string);
  end;

  // Class with a TList<> field
  TClassWithGenericListField_Register = class
  private
    [JSONOwned(false)] // Prevent unmarshal from freeing FList after construction
    // converter/referter registered for this field, see initialization
    FList: TList<TMyListItem>;
  public
    constructor Create;
    destructor Destroy; override;
  end;


  TGenericListFieldInterceptor = class(TJSONInterceptor)
  public
    procedure ObjectsReverter(Data: TObject; Field: String;
      Args: TListOfObjects); override;
    function ObjectsConverter(Data: TObject; Field: String): TListOfObjects; override;
  end;

  // Class with a TList<> field
  TClassWithGenericListField = class
  private
    [JSONReflect(ctObjects, rtObjects, TGenericListFieldInterceptor,nil,true)]
    [JSONOwned(false)] // Prevent unmarshal from freeing FList after construction

    FList: TList<TMyListItem>;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  procedure LoadClassWithGenericListField(AValue: TClassWithGenericListField); overload;
  procedure ValidateClassWithGenericListField(AValue: TClassWithGenericListField); overload;
  procedure LoadClassWithGenericListField(AValue: TClassWithGenericListField_Register); overload;
  procedure ValidateClassWithGenericListField(AValue: TClassWithGenericListField_Register); overload;
  procedure LoadGenericList(AValue: TList<TMyListItem>); overload;
  procedure ValidateGenericList(AValue: TList<TMyListItem>); overload;

implementation

procedure LoadClassWithGenericListField(AValue: TClassWithGenericListField);
begin
  AValue.FList.Add(TMyListItem.Create('one'));
  AValue.FList.Add(TMyListItem.Create('two'));
  AValue.FList.Add(TMyListItem.Create('three'));
end;

procedure ValidateClassWithGenericListField(AValue: TClassWithGenericListField);
begin
  Assert(AValue <> nil);
  Assert(AValue.FList <> nil);
  Assert(AValue.FList.Count = 3);
  Assert(AValue.FList[0].FValue = 'one');
  Assert(AValue.FList[1].FValue = 'two');
  Assert(AValue.FList[2].FValue = 'three');
end;

procedure LoadGenericList(AValue: TList<TMyListItem>);
begin
  AValue.Add(TMyListItem.Create('one'));
  AValue.Add(TMyListItem.Create('two'));
  AValue.Add(TMyListItem.Create('three'));
end;

procedure ValidateGenericList(AValue: TList<TMyListItem>);
begin
  Assert(AValue <> nil);
  Assert(AValue.Count = 3);
  Assert(AValue[0].FValue = 'one');
  Assert(AValue[1].FValue = 'two');
  Assert(AValue[2].FValue = 'three');
end;


procedure LoadClassWithGenericListField(AValue: TClassWithGenericListField_Register);
begin
  AValue.FList.Add(TMyListItem.Create('one'));
  AValue.FList.Add(TMyListItem.Create('two'));
  AValue.FList.Add(TMyListItem.Create('three'));
end;

procedure ValidateClassWithGenericListField(AValue: TClassWithGenericListField_Register);
begin
  Assert(AValue <> nil);
  Assert(AValue.FList <> nil);
  Assert(AValue.FList.Count = 3);
  Assert(AValue.FList[0].FValue = 'one');
  Assert(AValue.FList[1].FValue = 'two');
  Assert(AValue.FList[2].FValue = 'three');
end;

{ TListFieldInterceptor }

function TGenericListFieldInterceptor.ObjectsConverter(Data: TObject;
  Field: String): TListOfObjects;
var
  LRttiContext: TRttiContext;
  LValue: TList<TMyListItem>;
  I: Integer;
  LListItem: TMyListItem;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TList<TMyListItem>>;
  SetLength(Result, LValue.Count);
  I := 0;
  for LListItem in LValue do
  begin
    Result[I] := LListItem;
    Inc(I);
  end;
end;

procedure TGenericListFieldInterceptor.ObjectsReverter(Data: TObject; Field: String;
  Args: TListOfObjects);
var
  LRttiContext: TRttiContext;
  LValue: TList<TMyListItem>;
  LListItem: TObject;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TList<TMyListItem>>;
  for LListItem in Args do
  begin
    Assert(LListItem is TMyListItem);
    LValue.Add(TMyListItem(LListItem));
  end;
end;

{ TClassWithGenericListField }

constructor TClassWithGenericListField.Create;
begin
  FList := TObjectList<TMyListItem>.Create;
end;

destructor TClassWithGenericListField.Destroy;
begin
  FList.Free;
  inherited;
end;

{ TClassWithGenericListField_Register }

constructor TClassWithGenericListField_Register.Create;
begin
  FList := TObjectList<TMyListItem>.Create;
end;

destructor TClassWithGenericListField_Register.Destroy;
begin
  FList.Free;
  inherited;
end;

{ TMyListItem }

constructor TMyListItem.Create(const AValue: string);
begin
  FValue := AValue;
end;


procedure RegisterReverterConverters;
var
  LReverter: TReverterEvent;
  LConverter: TConverterEvent;
begin
  // Equivalent to     [JSONReflect(ctObjects, rtObjects, TGenericListFieldInterceptor,nil,true)]
  LReverter := TReverterEvent.Create(TClassWithGenericListField_Register, 'FList');
  LReverter.ObjectsReverter :=
    procedure(Data: TObject; Field: String; Args: TListOfObjects)
    begin
      with TGenericListFieldInterceptor.Create do
      try
        ObjectsReverter(Data, Field, Args);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TClassWithGenericListField_Register, 'FList');
  LConverter.ObjectsConverter :=
    function(Data: TObject; Field: String): TListOfObjects
    begin
      with TGenericListFieldInterceptor.Create do
      try
        Result := ObjectsConverter(Data, Field);
      finally
        Free;
      end;
    end;
  TJSONConverters.AddConverter(LConverter);
end;

initialization
  RegisterReverterConverters;
end.

