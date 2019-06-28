unit WordLines.WordFinder;

interface

uses
  System.Types, System.Classes, Generics.Collections, WordLines.Classes,
  WordLines.BoardController, WordLines.Dictionary;

type
  TWordFinder = class
  private type
    TCharSeq = class
    strict private
      FStr: array of Char;
      FPts: TArray<TPoint>;
      FPos: Integer;
      function GetChar(I: Integer): Char;
    public
      constructor Create(ASize: Integer); reintroduce;
      procedure Add(AChar: Char; APoint: TPoint);
      procedure Clear;

      function SubString(AStartPos, ALength: Integer): string;
      function SubPoints(AStartPos, ALength: Integer): TArray<TPoint>;
      property Chars[I: Integer]: Char read GetChar;
      property Count: Integer read FPos;
    end;
  private
    [Weak] FBoard: TBoardController;
    [Weak] FDictionary: TDictionary;
    FValidCols, FValidRows: set of Byte;
    FWordsInCols: array of TStringList;
    FWordsInRows: array of TStringList;
  public
    constructor Create(const ABoard: TBoardController;
      const ADictionary: TDictionary); reintroduce;
    destructor Destroy; override;

    procedure Invalidate;
    procedure InvalidateCell(APos: TPoint);

    procedure Update(const AWordList: TStrings);
  end;

implementation

{ TWordFinder }

constructor TWordFinder.Create(const ABoard: TBoardController;
  const ADictionary: TDictionary);
var
  I: Integer;
begin
  inherited Create;
  FBoard := ABoard;
  FDictionary := ADictionary;

  SetLength(FWordsInCols, FBoard.ColCount);
  SetLength(FWordsInRows, FBoard.RowCount);

  for I := Low(FWordsInCols) to High(FWordsInCols) do
    FWordsInCols[I] := TStringList.Create(True);

  for I := Low(FWordsInCols) to High(FWordsInRows) do
    FWordsInRows[I] := TStringList.Create(True);

  Invalidate;
end;

destructor TWordFinder.Destroy;
var
  I: Integer;
begin
  for I := 0 to High(FWordsInCols) do
    FWordsInCols[I].Free;

  for I := 0 to High(FWordsInRows) do
    FWordsInRows[I].Free;

  inherited;
end;

procedure TWordFinder.Invalidate;
begin
  FValidCols := [];
  FValidRows := [];
end;

procedure TWordFinder.InvalidateCell(APos: TPoint);
begin
  FValidCols := FValidCols - [APos.X];
  FValidRows := FValidRows - [APos.Y];
end;

procedure TWordFinder.Update(const AWordList: TStrings);

  procedure AddWords(const AWord: TCharSeq; const AWords: TStringList);
  var
    I, J: Integer;
    WordCells: TList<TPoint>;
    PossibleWord: string;
  begin
    if AWord.Count < 2 then
      Exit;

    for I := 0 to AWord.Count - 2 do
    begin
      if not FDictionary.WorthLooking2(AWord.Chars[I], AWord.Chars[I + 1]) then
        Continue;

      for J := I + 1 to AWord.Count - 1 do
      begin
        if (J - I = 2) and not FDictionary.WorthLooking3(AWord.Chars[I], AWord.Chars[I + 1], AWord.Chars[I + 2]) then
          Continue;

        PossibleWord := AWord.SubString(I, J - I + 1);
        if FDictionary.Exists(PossibleWord) then
        begin
          WordCells := TList<TPoint>.Create;
          WordCells.AddRange(AWord.SubPoints(I, J - I + 1));
          AWords.AddObject(PossibleWord, WordCells);
        end;
      end;
    end;
  end;

var
  I, J: Integer;
  WordInRow, WordInCol: TCharSeq;
begin
  WordInRow := TCharSeq.Create(FBoard.ColCount);
  WordInCol := TCharSeq.Create(FBoard.RowCount);

  for I in ([0 .. FBoard.RowCount - 1] - FValidRows) do
  begin
    WordInRow.Clear;
    FWordsInRows[I].Clear;

    for J := 0 to FBoard.ColCount - 1 do
      if not FBoard.IsCellEmpty(J, I) then
        WordInRow.Add(FBoard[J, I], Point(J, I))
      else if WordInRow.Count > 0 then
      begin
        AddWords(WordInRow, FWordsInRows[I]);
        WordInRow.Clear;
      end;
    AddWords(WordInRow, FWordsInRows[I]);
  end;

  for I in ([0 .. FBoard.ColCount - 1] - FValidCols) do
  begin
    WordInCol.Clear;
    FWordsInCols[I].Clear;

    for J := 0 to FBoard.RowCount - 1 do
      if not FBoard.IsCellEmpty(I, J) then
        WordInCol.Add(FBoard[I, J], Point(I, J))
      else if WordInCol.Count > 0 then
      begin
        AddWords(WordInCol, FWordsInCols[I]);
        WordInCol.Clear;
      end;
    AddWords(WordInCol, FWordsInCols[I]);
  end;

  FValidRows := [0 .. FBoard.RowCount - 1];
  FValidCols := [0 .. FBoard.ColCount - 1];

  AWordList.Clear;
  for I := Low(FWordsInRows) to High(FWordsInRows) do
    AWordList.AddStrings(FWordsInRows[I]);
  for I := Low(FWordsInRows) to High(FWordsInCols) do
    AWordList.AddStrings(FWordsInCols[I]);
end;

{ TWordFinder.TWord }

procedure TWordFinder.TCharSeq.Add(AChar: Char; APoint: TPoint);
begin
  FStr[FPos] := AChar;
  FPts[FPos] := APoint;
  Inc(FPos);
end;

procedure TWordFinder.TCharSeq.Clear;
begin
  FPos := 0;
end;

constructor TWordFinder.TCharSeq.Create(ASize: Integer);
begin
  inherited Create;
  SetLength(FStr, ASize);
  SetLength(FPts, ASize);
  FPos := 0;
end;

function TWordFinder.TCharSeq.GetChar(I: Integer): Char;
begin
  Result := FStr[I];
end;

function TWordFinder.TCharSeq.SubPoints(AStartPos, ALength: Integer): TArray<TPoint>;
begin
  Result := Copy(FPts, AStartPos, ALength);
end;

function TWordFinder.TCharSeq.SubString(AStartPos, ALength: Integer): string;

  function IntSubstring(S: array of Char; AStartPos, ALength: Integer): string;
  begin
    Result := Copy(S, AStartPos, ALength);
  end;

begin
  Result := IntSubstring(FStr, AStartPos + 1, ALength);
end;

end.
