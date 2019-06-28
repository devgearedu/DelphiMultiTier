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
unit ParseIds;

interface

type
  TIdentArray = array of string;

function ParseIdents(const AText: string; out AIdents: TIdentArray;
  out At: Integer): Boolean;

implementation

uses SysUtils;

const
  CInitIdentChars = ['A'..'Z', 'a'..'z', '_'];
  CSuccIdentChars = ['A'..'Z', 'a'..'z', '_', '0'..'9'];
  CIdentSeparator = ['.'];

function ParseIdents(const AText: string; out AIdents: TIdentArray;
  out At: Integer): Boolean;
var
  LCount, LAt: Integer;
  procedure AddIdent(const AIdent: string);
  begin
    if LAt + 1 > LCount then
    begin
      Inc(LCount, 4);
      SetLength(AIdents, LCount);
    end;
    AIdents[LAt] := AIdent;
    Inc(LAt);
  end;

  procedure PackIdents;
  begin
    SetLength(AIdents, LAt);
  end;

var
  LLength: Integer;
  function ParseIdent(out AIdent: string): Boolean;
  var
    LStart: Integer;
  begin
    LStart := At;
    Result := (At <= LLength) and (CharInSet(AText[At],CInitIdentChars));
    if Result then
    begin
      while (At <= LLength) and (CharInSet(AText[At], CSuccIdentChars)) do
        Inc(At);
      AIdent := Copy(AText, LStart, At - LStart);
    end;
  end;

  function ParseSeparator: Boolean;
  begin
    Result := (At < LLength) and (CharInSet(AText[At], CIdentSeparator));
    if Result then
      Inc(At);
  end;

var
  LIdent: string;
begin
  At := 1;
  LLength := Length(AText);
  Result := At <= LLength;
  if Result then
  begin
    LCount := 0;
    LAt := 0;
    while At <= LLength do
    begin
      if not ParseIdent(LIdent) then
        Break;
      AddIdent(LIdent);
      if (At <= LLength) and not ParseSeparator then
        Break;
    end;
    PackIdents;
    Result := At > LLength;
  end;
end;

end.
