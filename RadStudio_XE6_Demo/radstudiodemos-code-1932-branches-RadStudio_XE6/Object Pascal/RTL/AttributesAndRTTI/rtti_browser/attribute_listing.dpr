
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program attribute_listing;

{$APPTYPE CONSOLE}

uses
  Rtti,
  SysUtils,
  DemoAttr in 'DemoAttr.pas';

{ List all attributes of every public type that has attributes. }

procedure ListAttributes(AType: TRttiType);

  function GetQualifiedName(AObj: TRttiObject): string;
  begin
    if (AObj = nil) then
      Exit('');
    
    if AObj is TRttiType then
    begin
      if TRttiType(AObj).IsPublicType then
        Exit(TRttiType(AObj).QualifiedName);
      Exit(TRttiType(AObj).Name);
    end;

    Result := GetQualifiedName(AObj.Parent);
    if AObj is TRttiNamedObject then
      Result := Result + '.' + TRttiNamedObject(AObj).Name
    else
      Result := Result + '..';
  end;
  
  procedure ListObject(AObj: TRttiObject);
  var
    attrList: TArray<TCustomAttribute>;
    attr: TCustomAttribute;
  begin
    attrList := AObj.GetAttributes;
    if Length(attrList) = 0 then
      Exit;

    Writeln(GetQualifiedName(AObj), ' has:');
    for attr in attrList do
      Writeln('  ', attr.ClassName)
  end;

var
  f: TRttiField;
  p: TRttiProperty;
  m: TRttiMethod;
  par: TRttiParameter;
begin
  ListObject(AType);

  for f in AType.GetFields do
    ListObject(f);
  for p in AType.GetProperties do
    ListObject(p);
  for m in AType.GetMethods do
  begin
    ListObject(m);
    for par in m.GetParameters do
      ListObject(par);
  end;
end;

var
  t: TRttiType;
  { TRttiContext is a record and is initialized on first use. It has Create
    and Free methods for familiarity with the traditional try/finally pattern.
    All objects retrieved via the context are shared across all threads. The
    shared objects are not freed until the last context goes out of scope. }
  c: TRttiContext;
begin
  try
    // Create TDemoObject to prevent it from being removed by linker.
    // {$STRONGLINKTYPES ON} can also prevent this, for all public types.
    TDemoObject.Create.Free;

    Writeln('Listing all attributed members:');
    for t in c.GetTypes do
      ListAttributes(t);
    Writeln('Done');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  if DebugHook <> 0 then // pause when run from IDE
    Readln;
end.
