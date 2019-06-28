unit WordLines.Dictionary;

interface

uses
  System.Classes;

type
  TDictionary = class
  private const
    cMaxLetterValue = 40;
    procedure BuildCache;
  private
    FNullChar: Char;
    FWords: TStringList;
    FWorthLooking3Cache: TBits;
    function GetPseudoHash3(Char1, Char2, Char3: Char): Cardinal; inline;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadFromFile(const AFileName: string);

    procedure Add(const AWord: string);
    procedure Remove(const AWord: string);
    function Exists(const AWord: string): Boolean;

    function WorthLooking2(Char1, Char2: Char): Boolean;
    function WorthLooking3(Char1, Char2, Char3: Char): Boolean;

    function RandomChar: Char;
  end;

implementation

uses
  System.SysUtils, Generics.Defaults;

{ TDictionary }

procedure TDictionary.Add(const AWord: string);
begin
  FWords.Add(AWord);
end;

constructor TDictionary.Create;
begin
  inherited;
  FWords := TStringList.Create;
  FWords.Duplicates := TDuplicates.dupIgnore;

  FWorthLooking3Cache := TBits.Create;
  FWorthLooking3Cache.Size := cMaxLetterValue * cMaxLetterValue * cMaxLetterValue;
end;

destructor TDictionary.Destroy;
begin
  FWorthLooking3Cache.Free;
  FWords.Free;
  inherited;
end;

function TDictionary.Exists(const AWord: string): Boolean;
begin
  Result := FWords.IndexOf(AWord) > -1;
end;

function TDictionary.GetPseudoHash3(Char1, Char2, Char3: Char): Cardinal;
begin
  Result := (Ord(Char1) - Ord(FNullChar)) * cMaxLetterValue * cMaxLetterValue +
            (Ord(Char2) - Ord(FNullChar)) * cMaxLetterValue +
            (Ord(Char3) - Ord(FNullChar));
end;

procedure TDictionary.LoadFromFile(const AFileName: string);
begin
  FWords.LoadFromFile(AFileName);
  FWords.Sorted := True;

  BuildCache;
end;

function TDictionary.RandomChar: Char;
var
  RandomWord: string;
begin
  RandomWord := FWords[Random(FWords.Count)];
  Result := RandomWord.Chars[Random(RandomWord.Length)];
end;

procedure TDictionary.BuildCache;
var
  S: string;
begin
  FNullChar := Pred(FWords[0].Chars[0]);
  for S in FWords do
  begin
    if S.Length > 1 then
      FWorthLooking3Cache[GetPseudoHash3(FNullChar, S.Chars[0], S.Chars[1])] := True;
    if S.Length > 2 then
      FWorthLooking3Cache[GetPseudoHash3(S.Chars[0], S.Chars[1], S.Chars[2])] := True;
  end;
end;

procedure TDictionary.Remove(const AWord: string);
var
  I: Integer;
begin
  I := FWords.IndexOf(AWord);
  if I > -1 then
    FWords.Delete(I);
end;

function TDictionary.WorthLooking2(Char1, Char2: Char): Boolean;
begin
  Result := FWorthLooking3Cache[GetPseudoHash3(FNullChar, Char1, Char2)];
end;

function TDictionary.WorthLooking3(Char1, Char2, Char3: Char): Boolean;
begin
  Result := FWorthLooking3Cache[GetPseudoHash3(Char1, Char2, Char3)];
end;

end.
