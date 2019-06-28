
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// Register types to test
unit TestTypeFactory;

interface
  uses Generics.Collections, SysUtils, Classes;

type
  TTypeFactory = class
  public
    function TypeDescription: string; virtual; abstract;
    function QualifiedName: string; virtual;
    function TypeName: string; virtual;
    function CreateClass: TObject; virtual; abstract;
    procedure ValidateClass(AObject: TObject); virtual; abstract;
  end;

  procedure RegisterTypeFactory(ATypeFactory: TTypeFactory);
  procedure UnRegisterTypeFactory(ATypeFactory: TTypeFactory);
  function GetTypeFactories: TArray<TTypeFactory>;

  procedure LogLine(const ALine: string);

var
  GLogLineProc: TProc<string> = nil;

implementation

procedure LogLine(const ALine: string);
begin
  Assert(Assigned(GLogLineProc));
  GLogLineProc(ALine);
end;

var
  FTypeFactories: TList<TTypeFactory>;

procedure RegisterTypeFactory(ATypeFactory: TTypeFactory);
begin
  FTypeFactories.Add(ATypeFactory);
end;

procedure UnRegisterTypeFactory(ATypeFactory: TTypeFactory);
begin
  FTypeFactories.Remove(ATypeFactory);
end;

function GetTypeFactories: TArray<TTypeFactory>;
begin
  Result := FTypeFactories.ToArray;
end;


{ TTypeFactory }

function TTypeFactory.QualifiedName: string;
begin
  with CreateClass do
  try
    Result := UnitName + '.' + ClassName
  finally
    Free;
  end;
end;

function TTypeFactory.TypeName: string;
begin
  with CreateClass do
  try
    Result := ClassName
  finally
    Free;
  end;
end;

initialization
  FTypeFactories := TObjectList<TTypeFactory>.Create;
finalization
  FTypeFactories.Free;

end.
