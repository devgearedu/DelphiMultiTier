
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ThSort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TThreadSortForm = class(TForm)
    BubbleSortBox: TPaintBox;
    SelectionSortBox: TPaintBox;
    QuickSortBox: TPaintBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    StartBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure StartBtnClick(Sender: TObject);
    procedure BubbleSortBoxPaint(Sender: TObject);
    procedure SelectionSortBoxPaint(Sender: TObject);
    procedure QuickSortBoxPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    ThreadsRunning: Integer;
    procedure RandomizeArrays;
    procedure ThreadDone(Sender: TObject);
  public
    procedure PaintArray(Box: TPaintBox; const A: array of Integer);
  end;

var
  ThreadSortForm: TThreadSortForm;

implementation

uses SortThds;

{$R *.dfm}
type
  PSortArray = ^TSortArray;
  TSortArray =  array[0..114] of Integer;

var
  ArraysRandom: Boolean;
  BubbleSortArray, SelectionSortArray, QuickSortArray: TSortArray;

{ TThreadSortForm }

procedure TThreadSortForm.PaintArray(Box: TPaintBox; const A: array of Integer);
var
  I: Integer;
begin
  with Box do
  begin
    Canvas.Pen.Color := clRed;
    for I := Low(A) to High(A) do PaintLine(Canvas, I, A[I]);
  end;
end;

procedure TThreadSortForm.BubbleSortBoxPaint(Sender: TObject);
begin
  PaintArray(BubbleSortBox, BubbleSortArray);
end;

procedure TThreadSortForm.SelectionSortBoxPaint(Sender: TObject);
begin
  PaintArray(SelectionSortBox, SelectionSortArray);
end;

procedure TThreadSortForm.QuickSortBoxPaint(Sender: TObject);
begin
  PaintArray(QuickSortBox, QuickSortArray);
end;

procedure TThreadSortForm.FormCreate(Sender: TObject);
begin
  RandomizeArrays;
end;

procedure TThreadSortForm.StartBtnClick(Sender: TObject);
begin
  RandomizeArrays;
  ThreadsRunning := 3;
  with TBubbleSort.Create(BubbleSortBox, BubbleSortArray) do
    OnTerminate := ThreadDone;
  with TSelectionSort.Create(SelectionSortBox, SelectionSortArray) do
    OnTerminate := ThreadDone;
  with TQuickSort.Create(QuickSortBox, QuickSortArray) do
    OnTerminate := ThreadDone;
  StartBtn.Enabled := False;
end;

procedure TThreadSortForm.RandomizeArrays;
var
  I: Integer;
begin
  if not ArraysRandom then
  begin
    Randomize;
    for I := Low(BubbleSortArray) to High(BubbleSortArray) do
      BubbleSortArray[I] := Random(170);
    SelectionSortArray := BubbleSortArray;
    QuickSortArray := BubbleSortArray;
    ArraysRandom := True;
    Repaint;
  end;
end;

procedure TThreadSortForm.ThreadDone(Sender: TObject);
begin
  Dec(ThreadsRunning);
  if ThreadsRunning = 0 then
  begin
    StartBtn.Enabled := True;
    ArraysRandom := False;
  end;
end;


end.
