{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Components                                  }
{                                                                             }
// Copyright (c) 1995-2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.
{                                                                             }
{ *************************************************************************** }
unit PropertyHelpers;

interface

uses Classes, ParseIds;

procedure SetPropertyValue(AObject: TPersistent;
  const AExpression: string; const AValue : variant;
  const SearchOwner: boolean = False );
function GetPropertyValue(AObject: TPersistent;
  const AExpression: string; const SearchOwner: boolean = False ): variant;

implementation

uses
  TypInfo, Contnrs, SysUtils;

resourcestring
  SBadRTTISyntax = 'Bad RTTI Syntax: %s<%s>%s';

type
  TAccessPersistent = class(TPersistent)
  end;

function GetLastObject(AObject: TPersistent; const AIdents: TIdentArray;
  var APropPos : integer;  ASearchOwner: boolean = False): TObject;
var
  IdCount : integer;
  TestObj,
  Obj: TObject;

  function AssignObject(AProperty: string) : boolean;
  begin
    Result := Assigned(GetPropInfo(Obj, AIdents[APropPos], [tkClass]));
    if Result then
      Obj := GetObjectProp(Obj as Obj.ClassType, AIdents[APropPos], TPersistent);
  end;

  function TryObjLookup: boolean;
  begin
    TestObj := nil;
    if Assigned(Obj) and (Obj is TComponent) then
    begin
      if SameText(TComponent(Obj).Name, AIdents[APropPos]) then
        Inc(APropPos)
      else
      begin
        TestObj := TComponent(Obj).FindComponent(AIdents[APropPos]);
        if Assigned(TestObj) then
        begin
          Obj := TestObj;
          Inc(APropPos);
        end;
      end;
    end;
    Result := Assigned(TestObj);
  end;

begin
  Assert(Assigned(AObject), 'GetLastObject: AObject must be assigned');
  APropPos := 0;
  Obj := AObject;
  IdCount := Length(AIdents);
  TestObj := nil;
  if SameText(AIdents[APropPos], 'self') then
  begin
    Inc(APropPos);
    ASearchOwner := False;
  end;
  if IsPublishedProp(Obj as Obj.ClassType, AIdents[APropPos]) then
  begin
    if AssignObject(AIdents[APropPos]) then
      Inc(APropPos);
  end
  else if (not TryObjLookup) and ASearchOwner then
  begin
    Obj := TAccessPersistent(Obj).GetOwner;
    TryObjLookup;
  end;
      (*
    if Assigned(Obj) and (Obj is TComponent) then
    begin
      if SameText(TComponent(Obj).Name, AIdents[APropPos]) then
        Inc(APropPos)
      else
      begin
        TestObj := TComponent(Obj).FindComponent(AIdents[APropPos]);
        if Assigned(TestObj) then
        begin
          Obj := TestObj;
          Inc(APropPos);
        end;
        if (not Assigned(Obj)) and (AErrorHandling = peException) then
          Raise Exception.CreateFmt(SPropertyNotFound, [AIdents[APropPos]])
        else
        begin
          Result := AObject;
          exit;
        end;
      end;
    end;
    if Assigned(Obj) then
      Inc(APropPos)
    else
    begin
      if AErrorHandling = peException then
        Raise Exception.CreateFmt(SPropertyNotFound, [AIdents[APropPos]])
      else
      begin
        Result := AObject;
        exit;
      end;
    end;
    (**)
  while APropPos < IdCount do
  begin
    if not AssignObject(AIdents[APropPos]) then
      break;
    Inc(APropPos);
  end;

  Result := Obj;
end;

//function GetPropertyValue(AObject: TPersistent; const AExpression: string;
//  var AValue : variant; const ASearchOwner: boolean = False) : boolean;
//var
//  Idents : TIdentArray;
//  i,
//  LAt: integer;
//  Obj: TObject;
//
//begin
//  VarClear(AValue);
//  { This is where support for index accessors coud be added }
//  if ParseIdents(AExpression, Idents, LAt) then
//  begin
//    Obj := GetLastObject(AObject, Idents, i, ASearchOwner);
//    if IsPublishedProp(Obj as Obj.ClassType, Idents[i]) then
//      AValue := GetPropValue(Obj as Obj.ClassType, Idents[i], True);
//  end;
//  Result := not VarIsClear(AValue);
//end;


procedure BadSyntax(const AExpression: string; const LAt: integer);
begin
  Raise Exception.CreateFmt( SBadRTTISyntax,
    [ Copy(AExpression, 1, LAt - 1),
      Copy(AExpression, LAt, 1),
      Copy(AExpression, LAt + 1, MaxInt)]);
end;

procedure SetPropertyValue(AObject: TPersistent;
  const AExpression: string; const AValue : variant;
  const SearchOwner: boolean = False );
var
  Idents: TIdentArray;
  i,
  LAt: integer;
  Obj: TObject;
begin
  if ParseIdents(AExpression, Idents, LAt) then
  begin
    Obj := GetLastObject(AObject, Idents, i, SearchOwner);
    { TODO : This is where to add support for index accessors.
    Do I need to check for published properties? }
//    if IsPublishedProp(Obj, Idents[i]) then
    if Assigned(Obj) then
      SetPropValue(Obj, Idents[i], AValue);
  end
  else
    BadSyntax( AExpression, LAt );
end;

function GetPropertyValue(AObject: TPersistent;
  const AExpression: string;
  const SearchOwner: boolean = False ): variant;
var
  Idents: TIdentArray;
  i,
  LAt: integer;
  Obj: TObject;
begin
  if ParseIdents(AExpression, Idents, LAt) then
  begin
    Obj := GetLastObject(AObject, Idents, i, SearchOwner);
    { This is where support for index accessors could be added }
//    if IsPublishedProp(Obj, Idents[i]) then
    if Assigned(Obj) then
      Result := GetPropValue(Obj, Idents[i], True);
  end
  else
    BadSyntax( AExpression, LAt );
end;

end.
