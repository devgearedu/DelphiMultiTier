
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit StringsField;

interface

uses SysUtils, Classes, DBXJSON, Generics.Collections,
  StrUtils, RTTI, DBXJSONReflect, Variants;

type
  TClassWithTStringsField_Attribute = class
  private
    [JSONReflect(ctTypeObject, rtTypeObject, TStringListInterceptor,nil,true)]
    FField: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  // Converter registered in initialization section
  TClassWithTStringsField_Register = class
  private
    FField: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  procedure LoadClassWithTStringsSampleDate(AValue: TClassWithTStringsField_Register); overload;
  procedure LoadClassWithTStringsSampleDate(AValue: TClassWithTStringsField_Attribute); overload;
  procedure ValidateClassWithTStringsSampleDate(AValue: TClassWithTStringsField_Register); overload;
  procedure ValidateClassWithTStringsSampleDate(AValue: TClassWithTStringsField_Attribute); overload;
implementation


procedure LoadClassWithTStringsSampleDate(AValue: TClassWithTStringsField_Register);
begin
  AValue.FField.Add('one');
  AValue.FField.Add('two');
  AValue.FField.Add('three');
end;

procedure LoadClassWithTStringsSampleDate(AValue: TClassWithTStringsField_Attribute);
begin
  AValue.FField.Add('three');
  AValue.FField.Add('four');
  AValue.FField.Add('five');
end;

procedure ValidateClassWithTStringsSampleDate(AValue: TClassWithTStringsField_Register);
begin
  Assert(AValue <> nil);
  Assert(AValue.FField <> nil);
  Assert(AValue.FField.Count = 3);
  Assert(AValue.FField[0] = 'one');
  Assert(AValue.FField[1] = 'two');
  Assert(AValue.FField[2] = 'three');
end;

procedure ValidateClassWithTStringsSampleDate(AValue: TClassWithTStringsField_Attribute);
begin
  Assert(AValue <> nil);
  Assert(AValue.FField <> nil);
  Assert(AValue.FField.Count = 3);
  Assert(AValue.FField[0] = 'three');
  Assert(AValue.FField[1] = 'four');
  Assert(AValue.FField[2] = 'five');
end;

{ TClassWithTStringsField_Attribute }

constructor TClassWithTStringsField_Attribute.Create;
begin
  FField := TStringList.Create;
end;

destructor TClassWithTStringsField_Attribute.Destroy;
begin
  FField.Free;
  inherited;
end;

{ TClassWithTStringsField_Register }

constructor TClassWithTStringsField_Register.Create;
begin
  FField := TStringList.Create;
end;

destructor TClassWithTStringsField_Register.Destroy;
begin
  FField.Free;
  inherited;
end;




procedure RegisterReverterConverters;
var
  LReverter: TReverterEvent;
  LConverter: TConverterEvent;
begin
// Equivalent to:  [JSONReflect(ctTypeObject, rtTypeObject, TStringListInterceptor,nil,true)]
  LReverter := TReverterEvent.Create(TClassWithTStringsField_Register, 'FField');
  LReverter.TypeObjectReverter := StringListReverter;
  TJSONConverters.AddReverter(LReverter);
  LConverter := TConverterEvent.Create(TClassWithTStringsField_Register, 'FField');
  LConverter.TypeObjectConverter := StringListConverter;
  TJSONConverters.AddConverter(LConverter);

end;

initialization
  RegisterReverterConverters;
end.

