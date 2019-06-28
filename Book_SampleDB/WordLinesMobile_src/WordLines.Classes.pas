unit WordLines.Classes;

interface

type
  TTwoDimArray<T> = class
  private
    FData: array of T;
    FColCount: Integer;
    FRowCount: Integer;
    function GetItem(X, Y: Integer): T;
    procedure SetItem(X, Y: Integer; const Value: T);

    function PosToIndex(X, Y: Integer): Integer; inline;
  public type
    TForEachFunc = reference to function(Item: T): T;
    TForEachProc = reference to procedure(Item: T);
  public
    constructor Create(AColCount, ARowCount: Integer); reintroduce;

    procedure ForEach(Func: TForEachFunc); overload;
    procedure ForEach(Proc: TForEachProc); overload;

    property Items[X, Y: Integer]: T read GetItem write SetItem; default;
  end;

implementation

{ TTwoDimArray<T> }

constructor TTwoDimArray<T>.Create(AColCount, ARowCount: Integer);
begin
  inherited Create;
  SetLength(FData, AColCount * AColCount);
  FColCount := AColCount;
  FRowCount := ARowCount;
end;

procedure TTwoDimArray<T>.ForEach(Func: TForEachFunc);
var
  I: Integer;
begin
  for I := Low(FData) to High(FData) do
    FData[I] := Func(FData[I]);
end;

procedure TTwoDimArray<T>.ForEach(Proc: TForEachProc);
var
  I: Integer;
begin
  for I := Low(FData) to High(FData) do
    Proc(FData[I]);
end;

function TTwoDimArray<T>.GetItem(X, Y: Integer): T;
begin
  Result := FData[PosToIndex(X, Y)];
end;

function TTwoDimArray<T>.PosToIndex(X, Y: Integer): Integer;
begin
  Result := Y * FColCount + X;
end;

procedure TTwoDimArray<T>.SetItem(X, Y: Integer; const Value: T);
begin
  FData[PosToIndex(X, Y)] := Value;
end;

end.
