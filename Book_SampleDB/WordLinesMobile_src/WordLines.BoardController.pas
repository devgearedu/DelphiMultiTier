unit WordLines.BoardController;

interface

uses
  System.Types, System.UITypes, System.Classes, FMX.Types, FMX.Objects, FMX.Graphics,
  Generics.Collections, WordLines.Classes;

type
  TCellType = (ctDefault, ctAvailable, ctNotAvailable, ctNew);

  TCustomBitmapCache<TKey> = class(TDictionary<TKey, TBitmap>)
  strict protected
    procedure ValueNotify(const Value: TBitmap; Action: TCollectionNotification); override;
  end;

  TCellBitmapCache = class(TCustomBitmapCache<TCellType>)
  public
    constructor Create(AHeight, AWidth: Single);
  end;

  TCharBitmapCache = class(TCustomBitmapCache<TPair<Char, TAlphaColor> >)
  public
    function Key(AChar: Char; AColor: TAlphaColor): TPair<Char, TAlphaColor>;
    function NewCharBitmap(AChar: Char; AColor: TAlphaColor; AHeight, AWidth: Single): TBitmap;
  end;

  TBoardController = class
  public type
    TCellStates = (csHighlighted, csSelected, csNew);
    TCellState = set of TCellStates;
    TCell = class(TPersistent)
    strict private
      FState: TCellState;
      FValue: Char;
    public
      constructor Create;

      procedure Assign(Source: TPersistent); override;
      procedure Clear;
      function IsEmpty: Boolean;

      property Value: Char read FValue write FValue;
      property State: TCellState read FState write FState;
    end;
    TStep = record
      FromPos: TPoint;
      ToPos: TPoint;
    end;
  private const
    cMoves: array [0..3] of TPoint = (
      (X: -1; Y: 0), (X: 1; Y: 0), (X: 0; Y: -1), (X: 0; Y: 1));
  private
    FColCount, FRowCount: Byte;
    FCellWidth, FCellHeight: Single;
    FRect: TRectF;
    FScreenScale: Single;
    FCharBitmapCache: TCharBitmapCache;
    FCellBitmapCache: TCellBitmapCache;

    FCells: TTwoDimArray<TCell>;
    FDistance: TTwoDimArray<Integer>;
    FSelection: TPoint;

    FUpdating: Integer;

    function GetLetter(X, Y: Cardinal): Char;
    procedure SetLetter(X, Y: Cardinal; const Value: Char);

    function HasSelection: Boolean;
    procedure CalculateDistance(AFromX, AFromY: Cardinal);
    function RoundLogicPointsToMatchPixel(const ALogicPoints: Single;
      const AtLeastOnePixel: Boolean = False): Single; overload;
    procedure RoundLogicPointsToMatchPixel(var ARect: TRectF); overload;
  public
    constructor Create(AColCount, ARowCount: Byte; ARect: TRectF; AScreenScale: Single); reintroduce;
    destructor Destroy; override;

    procedure Draw(const ACanvas: TCanvas);

    procedure ClearAll;
    procedure ClearCell(APos: TPoint);
    procedure ClearHighlights;
    procedure ClearSelection;
    procedure ClearNew;

    function CanMove(APosTo: TPoint): Boolean;
    function SetSelection(APos: TPoint): Boolean;
    function IsCellEmpty(X, Y: Cardinal): Boolean;
    procedure HighlightCell(APos: TPoint);

    function CursorToCell(X, Y: Single): TPoint;

    procedure MakeStep(AStep: TStep);
    procedure PreparePath(AToPos: TPoint; var Result: TList<TStep>);

    procedure BeginUpdate;
    procedure EndUpdate;

    property Letters[X, Y: Cardinal]: Char read GetLetter write SetLetter; default;
    property Selection: TPoint read FSelection;
    property ColCount: Byte read FColCount;
    property RowCount: Byte read FRowCount;
  end;

implementation

procedure TCustomBitmapCache<TKey>.ValueNotify(const Value: TBitmap; Action: TCollectionNotification);
begin
  if Action = cnRemoved then
    Value.Free;
end;

{ TCellBitmapCache }

constructor TCellBitmapCache.Create(AHeight, AWidth: Single);
const
  cCellColor: array[TCellType] of TAlphaColor =
    (TAlphaColorRec.Whitesmoke,
    TAlphaColorRec.Darkseagreen,
    TAlphaColorRec.Darksalmon,
    TAlphaColorRec.Thistle);
var
  Bmp: TBitmap;
  CellType: TCellType;
begin
  inherited Create;

  for CellType := Low(TCellType) to High(TCellType) do
  begin
    Bmp := TBitmap.Create(Round(AWidth + 1), Round(AHeight + 1));
    Bmp.Canvas.BeginScene;
    try
      Bmp.Canvas.Clear(TAlphaColorRec.Null);
      Bmp.Canvas.Fill.Color := cCellColor[CellType];
      Bmp.Canvas.FillRect(RectF(0, 0, AWidth, AHeight), AWidth / 5.5, AHeight / 5.5, AllCorners, 1);
      Bmp.Canvas.DrawRectSides(RectF(0, 0, AWidth, AHeight), AWidth / 5.5, AHeight / 5.5, AllCorners, 1, AllSides);
    finally
      Bmp.Canvas.EndScene;
    end;
    Self.AddOrSetValue(CellType, Bmp);
  end;
end;

{ TCharBitmapCache }

function TCharBitmapCache.Key(AChar: Char; AColor: TAlphaColor): TPair<Char, TAlphaColor>;
begin
  Result.Create(AChar, AColor);
end;

function TCharBitmapCache.NewCharBitmap(AChar: Char; AColor: TAlphaColor; AHeight, AWidth: Single): TBitmap;

  procedure CalcFontSize(ACanvas: TCanvas); // dirty hack, sorry :(
  begin
    ACanvas.Font.Size := 10;
    while ACanvas.TextHeight('ABC') < (AHeight * 2/3) do
      ACanvas.Font.Size := ACanvas.Font.Size + 1;
  end;

begin
  Result := TBitmap.Create(Round(AWidth + 1), Round(AHeight + 1));
  Result.Canvas.BeginScene;
  try
    CalcFontSize(Result.Canvas);
    Result.Canvas.Clear(TAlphaColorRec.Null);
    Result.Canvas.Fill.Color := AColor;
    Result.Canvas.FillText(RectF(0, 0, AWidth, AHeight), AChar, False, 1,
     [TFillTextFlag.ftRightToLeft], TTextAlign.taCenter);
  finally
    Result.Canvas.EndScene;
  end;
end;

{ TBoardController }

procedure TBoardController.BeginUpdate;
begin
  Inc(FUpdating);
end;

procedure TBoardController.CalculateDistance(AFromX, AFromY: Cardinal);

  procedure Step(X, Y: Integer);
  var
    CurrentDistance: Integer;
    I, NewX, NewY: Integer;
  begin
    CurrentDistance := FDistance[X, Y];

    for I := 0 to High(cMoves) do
    begin
      NewX := X + cMoves[I].X;
      NewY := Y + cMoves[I].Y;

      if (NewX in [0 .. FColCount - 1]) and (NewY in [0 .. FRowCount - 1])
        and IsCellEmpty(NewX, NewY) and (FDistance[NewX, NewY] > CurrentDistance + 1) then
      begin
        FDistance[NewX, NewY] := CurrentDistance + 1;
        Step(NewX, NewY);
      end;
    end;
  end;

begin
  FDistance.ForEach(
    function(Item: Integer): Integer
    begin
      Result := High(Integer);
    end);

  FDistance[AFromX, AFromY] := 0;
  Step(AFromX, AFromY);
end;

function TBoardController.CanMove(APosTo: TPoint): Boolean;
begin
  Result := HasSelection and (FDistance[APosTo.X, APosTo.Y] < High(Integer));
end;

procedure TBoardController.ClearAll;
begin
  FCells.ForEach(
    procedure (Item: TCell)
    begin
      Item.Clear;
    end);

  ClearSelection;
end;

procedure TBoardController.ClearCell(APos: TPoint);
begin
  FCells[APos.X, APos.Y].Clear;
end;

procedure TBoardController.ClearHighlights;
begin
  FCells.ForEach(
    procedure (Item: TCell)
    begin
      Item.State := Item.State - [TCellStates.csHighlighted];
    end);
end;

procedure TBoardController.ClearNew;
begin
  FCells.ForEach(
    procedure (Item: TCell)
    begin
      Item.State := Item.State - [TCellStates.csNew];
    end);
end;

procedure TBoardController.ClearSelection;
begin
  if HasSelection then
  begin
    FCells[FSelection.X, FSelection.Y].State :=
      FCells[FSelection.X, FSelection.Y].State - [TCellStates.csSelected];
    FSelection := Point(-1, -1);
  end;
end;

constructor TBoardController.Create(AColCount, ARowCount: Byte; ARect: TRectF; AScreenScale: Single);
begin
  inherited Create;

  FColCount := AColCount;
  FRowCount := ARowCount;
  FRect := ARect;
  FScreenScale := AScreenScale;

  RoundLogicPointsToMatchPixel(FRect);
  FCellWidth := FRect.Width / FColCount;
  FCellHeight := FRect.Height / FRowCount;

  FCells := TTwoDimArray<TCell>.Create(FColCount, FRowCount);
  FDistance := TTwoDimArray<Integer>.Create(FColCount, FRowCount);

  FCells.ForEach(
    function(Item: TCell): TCell
    begin
      Result := TCell.Create;
    end);

  FCellBitmapCache := TCellBitmapCache.Create(FCellHeight, FCellWidth);
  FCharBitmapCache := TCharBitmapCache.Create;

  ClearSelection;
end;

function TBoardController.CursorToCell(X, Y: Single): TPoint;
begin
  Result := Point(Trunc(X / FCellWidth), Trunc(Y / FCellHeight));
end;

procedure TBoardController.HighlightCell(APos: TPoint);
begin
  FCells[APos.X, APos.Y].State :=
    FCells[APos.X, APos.Y].State + [TCellStates.csHighlighted];
end;

function TBoardController.GetLetter(X, Y: Cardinal): Char;
begin
  Result := FCells[X, Y].Value;
end;

function TBoardController.HasSelection: Boolean;
begin
  Result := (FSelection.X > -1) and (FSelection.Y > -1);
end;

function TBoardController.IsCellEmpty(X, Y: Cardinal): Boolean;
begin
  Result := FCells[X, Y].IsEmpty;
end;

procedure TBoardController.MakeStep(AStep: TStep);
begin
  FCells[AStep.ToPos.X, AStep.ToPos.Y].Assign(
    FCells[AStep.FromPos.X, AStep.FromPos.Y]);

  if FSelection = AStep.FromPos then
    FSelection := AStep.ToPos;

  FCells[AStep.FromPos.X, AStep.FromPos.Y].Clear;
end;

destructor TBoardController.Destroy;
begin
  FCells.ForEach(
    procedure(Item: TCell)
    begin
      Item.Free;
    end);

  FCells.Free;
  FDistance.Free;

  FCharBitmapCache.Free;

  inherited;
end;

procedure TBoardController.Draw(const ACanvas: TCanvas);
var
  I, J: Integer;
  Cell: TCell;
  CellRect: TRectF;
  CellType: TCellType;
  FontColor: TAlphaColor;
begin
  if ACanvas.BeginScene then
  try
    ACanvas.Stroke.Kind := TBrushKind.bkSolid;
    ACanvas.Stroke.Thickness := RoundLogicPointsToMatchPixel(1.0, True);
    ACanvas.Fill.Color := TAlphaColorRec.Black;
    ACanvas.Fill.Kind := TBrushKind.bkSolid;

    for I := 0 to FColCount - 1 do
      for J := 0 to FRowCount - 1 do
      begin
        Cell := FCells[I, J];

        if TCellStates.csSelected in Cell.State then
          CellType := TCellType.ctAvailable
        else if TCellStates.csNew in Cell.State then
          CellType := TCellType.ctNew
        else if not HasSelection or not Cell.IsEmpty then
          CellType := TCellType.ctDefault
        else if FDistance[I, J] < High(Integer) then
          CellType := TCellType.ctAvailable
        else
          CellType := TCellType.ctNotAvailable;

        CellRect := RectF(FRect.Left + I * FCellWidth,
          FRect.Top + J * FCellHeight, (I + 1) * FCellWidth,
          (J + 1) * FCellHeight);
        RoundLogicPointsToMatchPixel(CellRect);

        ACanvas.DrawBitmap(FCellBitmapCache[CellType], RectF(0, 0, FCellWidth, FCellHeight), CellRect, 1);

        if Cell.IsEmpty then
          Continue;

        if TCellStates.csSelected in Cell.State then
          FontColor := TAlphaColorRec.Yellow
        else if TCellStates.csHighlighted in Cell.State then
          FontColor := TAlphaColorRec.Red
        else
          FontColor := TAlphaColorRec.Black;

        if not FCharBitmapCache.ContainsKey(FCharBitmapCache.Key(Cell.Value, FontColor)) then
          FCharBitmapCache.Add(FCharBitmapCache.Key(Cell.Value, FontColor),
            FCharBitmapCache.NewCharBitmap(Cell.Value, FontColor, FCellHeight, FCellWidth));

        ACanvas.DrawBitmap(FCharBitmapCache[FCharBitmapCache.Key(Cell.Value, FontColor)],
          RectF(0, 0, FCellWidth, FCellHeight), CellRect, 1);
      end;
  finally
    ACanvas.EndScene;
  end;
end;

procedure TBoardController.EndUpdate;
begin
  Dec(FUpdating);
  if (FUpdating = 0) and HasSelection then
    CalculateDistance(FSelection.X, FSelection.Y);
end;

procedure TBoardController.PreparePath(AToPos: TPoint; var Result: TList<TStep>);

  procedure Step(X, Y: Integer);
  var
    CurrentDistance: Integer;
    I, NewX, NewY: Integer;
    NextStep: TStep;
  begin
    CurrentDistance := FDistance[X, Y];

    if CurrentDistance = 0 then
      Exit;

    for I := Low(cMoves) to High(cMoves) do
    begin
      NewX := X + cMoves[I].X;
      NewY := Y + cMoves[I].Y;

      if (NewX in [0 .. FColCount - 1]) and (NewY in [0 .. FRowCount - 1])
        and (FDistance[NewX, NewY] = CurrentDistance - 1) then
      begin
        NextStep.FromPos := Point(NewX, NewY);
        NextStep.ToPos := Point(X, Y);

        Result.Add(NextStep);
        Step(NewX, NewY);

        Break;
      end;
    end;
  end;

begin
  Result.Clear;
  Step(AToPos.X, AToPos.Y);
  Result.Reverse;
end;

procedure TBoardController.RoundLogicPointsToMatchPixel(var ARect: TRectF);
begin
  ARect.Left := RoundLogicPointsToMatchPixel(ARect.Left);
  ARect.Top := RoundLogicPointsToMatchPixel(ARect.Top);
  ARect.Bottom :=  RoundLogicPointsToMatchPixel(ARect.Bottom);
  ARect.Right :=  RoundLogicPointsToMatchPixel(ARect.Right);
end;

function TBoardController.RoundLogicPointsToMatchPixel(
  const ALogicPoints: Single; const AtLeastOnePixel: Boolean): Single;
var
  Pixels: Single;
begin
  // Maybe you will want to use Ceil or Trunc instead of Round
  Pixels := Round(ALogicPoints * FScreenScale);

  if AtLeastOnePixel and (Pixels < 1) then
    Pixels := 1.0;

  Result := Pixels / FScreenScale;
end;

procedure TBoardController.SetLetter(X, Y: Cardinal; const Value: Char);
begin
  FCells[X, Y].Value := Value;
  FCells[X, Y].State := FCells[X, Y].State + [TCellStates.csNew];
end;

function TBoardController.SetSelection(APos: TPoint): Boolean;
begin
  Result := not FCells[APos.X, APos.Y].IsEmpty;

  if Result then
  begin
    if HasSelection then
      FCells[FSelection.X, FSelection.Y].State :=
        FCells[FSelection.X, FSelection.Y].State - [TCellStates.csSelected];

    FSelection := APos;
    FCells[FSelection.X, FSelection.Y].State :=
      FCells[FSelection.X, FSelection.Y].State + [TCellStates.csSelected];
    CalculateDistance(FSelection.X, FSelection.Y);
  end;
end;

{ TBoardController.TCell }

procedure TBoardController.TCell.Assign(Source: TPersistent);
begin
  if Source is TCell then
  begin
    FValue := TCell(Source).Value;
    FState := TCell(Source).State;
  end else
    inherited;
end;

procedure TBoardController.TCell.Clear;
begin
  Value := #0;
  State := [];
end;

constructor TBoardController.TCell.Create;
begin
  inherited;
  Clear;
end;

function TBoardController.TCell.IsEmpty: Boolean;
begin
  Result := FValue = #0;
end;

end.
