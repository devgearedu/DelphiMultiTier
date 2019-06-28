unit WordLines.GameFlow;

interface

uses
  System.Types, System.Classes, Generics.Collections, WordLines.BoardController,
  WordLines.WordFinder, WordLines.Dictionary;

type
  TGameFlow = class
  private type
    TCellList = class
    private
      FData: TList<TPoint>;
    public
      constructor Create;
      destructor Destroy; override;

      procedure Add(const Value: TPoint);
      procedure Remove(const Value: TPoint);
      procedure Clear;

      function Empty: Boolean;
      function RandomCell: TPoint;
    end;
  private
    FEmptyCells: TCellList;
    FCurrentWords: TStringList;
    FScore: Integer;

    FLastPath: TList<TBoardController.TStep>;
    FLastLetters: TList<TPoint>;

    [Weak] FBoard: TBoardController;
    [Weak] FDictionary: TDictionary;
    [Weak] FWordFinder: TWordFinder;

    FOnRepaint: TNotifyEvent;
    FOnGameEnd: TNotifyEvent;

    function GetCanUndo: Boolean;
    procedure MoveLetter(const Path: TList<TBoardController.TStep>);
    function NextLetterDrop(var LetterDrop: TPoint): Boolean;
    procedure UpdateWords;

    function RandomChar: Char;

    procedure DoRepaint;
    procedure DoGameEnd;
  public
    procedure NewGame;

    procedure ClearWords;

    procedure MoveTo(CellPos: TPoint);
    procedure Undo;

    constructor Create(WordFinder: TWordFinder; Board: TBoardController; Dictionary: TDictionary);
    destructor Destroy; override;

    property CanUndo: Boolean read GetCanUndo;
    property CurrentWords: TStringList read FCurrentWords;
    property Score: Integer read FScore;
    property OnRepaint: TNotifyEvent read FOnRepaint write FOnRepaint;
    property OnGameEnd: TNotifyEvent read FOnGameEnd write FOnGameEnd;
  end;

implementation

uses
  System.SysUtils, System.Math, FMX.Forms;

{ TGameFlow }

procedure TGameFlow.ClearWords;
var
  I,J: Integer;
  Cells: TList<TPoint>;
begin
  FBoard.BeginUpdate;
  try
    for I := 0 to FCurrentWords.Count-1 do
    begin
      FScore := FScore + Length(FCurrentWords[I]) - 1;

      Cells := FCurrentWords.Objects[I] as TList<TPoint>;
      for J := 0 to Cells.Count - 1 do
      begin
        FBoard.ClearCell(Cells[J]);
        FEmptyCells.Add(Cells[J]);
        FWordFinder.InvalidateCell(Cells[J]);
      end;
    end;

    FBoard.ClearHighlights;
  finally
    FBoard.EndUpdate;
  end;

  FCurrentWords.Clear;
end;

constructor TGameFlow.Create(WordFinder: TWordFinder; Board: TBoardController; Dictionary: TDictionary);
begin
  inherited Create;
  FEmptyCells := TCellList.Create;
  FCurrentWords := TStringList.Create;

  FLastPath := TList<TBoardController.TStep>.Create;
  FLastLetters := TList<TPoint>.Create;

  FWordFinder := WordFinder;
  FBoard := Board;
  FDictionary := Dictionary;
end;

destructor TGameFlow.Destroy;
begin
  FCurrentWords.Free;
  FEmptyCells.Free;
  FLastPath.Free;
  FLastLetters.Free;
  inherited;
end;

procedure TGameFlow.DoGameEnd;
begin
  if Assigned(FOnGameEnd) then
    FOnGameEnd(nil);
end;

procedure TGameFlow.DoRepaint;
begin
  if Assigned(FOnRepaint) then
    FOnRepaint(nil);
end;

procedure TGameFlow.MoveTo(CellPos: TPoint);
var
  I: Integer;
  LetterDrop: TPoint;
begin
  FBoard.ClearNew;

  FEmptyCells.Add(FBoard.Selection);
  FEmptyCells.Remove(CellPos);
  FWordFinder.InvalidateCell(FBoard.Selection);
  FWordFinder.InvalidateCell(CellPos);

  FBoard.PreparePath(CellPos, FLastPath);
  MoveLetter(FLastPath);

  FLastLetters.Clear;
  for I := 0 to 2 do
    if NextLetterDrop(LetterDrop) then
    begin
      FLastLetters.Add(LetterDrop);
      FBoard[LetterDrop.X, LetterDrop.Y] := RandomChar;

      FEmptyCells.Remove(LetterDrop);
      FWordFinder.InvalidateCell(LetterDrop);
    end;

  FBoard.ClearSelection;

  UpdateWords;

  if FEmptyCells.Empty and (FCurrentWords.Count = 0) then
    DoGameEnd;
end;

procedure TGameFlow.NewGame;
var
  I, J: Integer;
  LetterDrop: TPoint;
begin
  FScore := 0;

  FBoard.ClearAll;

  FEmptyCells.Clear;
  for I := 0 to FBoard.ColCount - 1 do
    for J := 0 to FBoard.RowCount - 1 do
      FEmptyCells.Add(Point(I, J));

  FWordFinder.Invalidate;
  for I := 1 to 9 do
    if NextLetterDrop(LetterDrop) then
    begin
      FLastLetters.Add(LetterDrop);
      FBoard[LetterDrop.X, LetterDrop.Y] := RandomChar;

      FEmptyCells.Remove(LetterDrop);
    end;

  FBoard.ClearNew;

  UpdateWords;
end;

function TGameFlow.NextLetterDrop(var LetterDrop: TPoint): Boolean;
begin
  if not FEmptyCells.Empty then
  begin
    Result := True;
    LetterDrop := FEmptyCells.RandomCell;
  end else
    Result := False;
end;

function TGameFlow.RandomChar: Char;

  function CharOnField(Value: Char): Boolean;
  var
    X,Y: Integer;
  begin
    Result := False;

    for X := 0 to FBoard.ColCount - 1 do
      for Y := 0 to FBoard.RowCount - 1 do
        if FBoard[X, Y] = Value then
        begin
          Result := True;
          Break;
        end;
  end;

begin
  Result := FDictionary.RandomChar;

  if (Random < 0.3) and CharOnField(Result) then // 30% probability
    Result := RandomChar;
end;

function TGameFlow.GetCanUndo: Boolean;
begin
  Result := (FLastPath.Count > 0) and (FLastLetters.Count > 0);
end;

procedure TGameFlow.MoveLetter(const Path: TList<TBoardController.TStep>);
var
  Step: TBoardController.TStep;
begin
  for Step in Path do
  begin
    FBoard.MakeStep(Step);
    Sleep(70);
    DoRepaint;
  end;
end;

procedure TGameFlow.Undo;
var
  I: Integer;
  Step: TBoardController.TStep;
begin
  FLastPath.Reverse;
  for I := 0 to FLastPath.Count - 1 do
  begin
    Step.FromPos := FLastPath[I].ToPos;
    Step.ToPos := FLastPath[I].FromPos;

    FLastPath[I] := Step;
  end;

  for I := 0 to FLastLetters.Count - 1 do
  begin
    FBoard.ClearCell(FLastLetters[I]);
    FEmptyCells.Add(FLastLetters[I]);
    FWordFinder.InvalidateCell(FLastLetters[I]);
  end;

  FEmptyCells.Add(FLastPath.First.FromPos);
  FEmptyCells.Remove(FLastPath.Last.ToPos);
  FWordFinder.InvalidateCell(FLastPath.First.FromPos);
  FWordFinder.InvalidateCell(FLastPath.Last.ToPos);

  MoveLetter(FLastPath);

  UpdateWords;

  FLastPath.Clear;
  FLastLetters.Clear;

  FBoard.ClearNew;
  FBoard.ClearSelection;
end;

procedure TGameFlow.UpdateWords;
var
  I,J: Integer;
  Cells: TList<TPoint>;
begin
  FWordFinder.Update(FCurrentWords);

  FBoard.ClearHighlights;
  for I := 0 to FCurrentWords.Count-1 do
  begin
    Cells := FCurrentWords.Objects[I] as TList<TPoint>;
    for J := 0 to Cells.Count-1 do
      FBoard.HighlightCell(Cells[J]);
  end;
end;

{ TGameFlow.TCellList }

procedure TGameFlow.TCellList.Add(const Value: TPoint);
begin
  if FData.IndexOf(Value) = -1 then
    FData.Add(Value);
end;

procedure TGameFlow.TCellList.Clear;
begin
  FData.Clear;
end;

constructor TGameFlow.TCellList.Create;
begin
  inherited;
  FData := TList<TPoint>.Create;
end;

destructor TGameFlow.TCellList.Destroy;
begin
  FData.Free;
  inherited;
end;

function TGameFlow.TCellList.Empty: Boolean;
begin
  Result := FData.Count = 0;
end;

function TGameFlow.TCellList.RandomCell: TPoint;
begin
  Result := FData[Random(FData.Count)];
end;

procedure TGameFlow.TCellList.Remove(const Value: TPoint);
begin
  FData.Remove(Value);
end;

end.
