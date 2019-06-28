unit MainForm;

(*
  --------------------------------------------------------------------------
// Copyright (c) 1995-2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.
  --------------------------------------------------------------------------
*)
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Menus;

const
  GAME_WIDTH = 10;
  GAME_HEIGHT = 20;
  MIN_BLOCKSIZE = 15;
  // once 5 lines and more were removed increase the speed...
  SPEEDUPATLINES = 5;

type
  TGameState = (gsGameOver, gsBlockDropping, gsPaused);

  TBlock = record
    size: integer; // 2x2, 3x3, or 4x4 (size of square which completely
    // contains the piece)
    elements: array [0 .. 16] of AnsiChar;
    procedure Rotate(const aNumber: integer);
  end;

  TBlockForm = class(TForm)
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    GamePopupMenu: TPopupMenu;
    StartnewgameF1: TMenuItem;
    Pause1: TMenuItem;
    Help1: TMenuItem;
    Help2: TMenuItem;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure StartnewgameF1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure Help2Click(Sender: TObject);
  private
    { Private declarations }
    gameState: TGameState; // current state of the game
    currentBlock: TBlock; // currently falling block
    x, y: integer; // current block position
    CountRemovedLines, BColor: integer; // current block color
    dropCount: integer; // countdown to next time piece falls one row
    dropping: boolean; // is the user holding the 'drop' key down?
    gameSpeed, blockSize: integer; // read from .INI file
    board: array [0 .. GAME_HEIGHT, 0 .. GAME_WIDTH + 1] of integer;
    procedure ClearBoard;
    procedure NewGame;
    procedure NewBlock(blockType: integer);
    function HitTest(var block: TBlock; x, y: integer): boolean;
    procedure PlaceBlock;
    procedure RemoveLines;
    procedure Pause;
    procedure DrawBlock(ACanvas: TCanvas; var block: TBlock; pos: TPoint);
    procedure DrawGameWindow(ACanvas: TCanvas);
    procedure ChangeWindowSize;
    procedure DecreaseBlockSize;
    procedure IncreaseBlockSize;
    procedure DecreaseSpeed;
    procedure IncreaseSpeed;
    procedure DrawGameOverScreen(ACanvas: TCanvas);
    procedure DrawPausedScreen(ACanvas: TCanvas);

  public
    { Public declarations }
  end;

const
  NumberofBlocks = 7;
  blocks: array [0 .. NumberofBlocks - 1] of TBlock = ((size: 4; elements: ' *  ' + ' *  ' + ' *  ' + ' *  '), (size: 3; elements: ' ** ' + ' *  ' + ' *  ' + '    '), (size: 3; elements: '**  ' + ' *  ' + ' *  ' + '    '), (size: 3; elements: ' *  ' + '*** ' + '    ' + '    '), (size: 3; elements: '**  ' + ' ** ' + '    ' + '    '), (size: 3; elements: ' ** ' + '**  ' + '    ' + '    '), (size: 2; elements: '**  ' + '**  ' + '    ' + '    '));
  sHelpString = 'F1 to see this crude help' + #13#10 + 'F2 to start a new game' + #13#10 + 'F3 to pause the game' + #13#10 + '"+" to increase block size"-" to reduce block size' + #13#10 + 'PageUp to increase speed, PageDn to reduce' + #13#10 + 'Left and Right arrow keys move the blocks' + #13#10 + 'Up arrow or spacebar of Numpad 5 rotates' + #13#10 + 'Down arrow drops';

var
  cpen: array [0 .. 7] of TColor;
  cBrush: array [0 .. 7] of TColor;

var
  BlockForm: TBlockForm;

implementation

{$R *.dfm}

procedure InitColours;
begin
  cpen[0] := RGB(0, 0, 64);
  cpen[1] := RGB(0, 0, 255);
  cpen[2] := RGB(0, 255, 0);
  cpen[3] := RGB(255, 0, 0);
  cpen[4] := RGB(255, 255, 0);
  cpen[5] := RGB(255, 0, 255);
  cpen[6] := RGB(0, 255, 255);
  cpen[7] := RGB(0255, 255, 255);
  cBrush[0] := RGB(0, 0, 64);
  cBrush[1] := RGB(0, 0, 128);
  cBrush[2] := RGB(0, 128, 0);
  cBrush[3] := RGB(128, 0, 0);
  cBrush[4] := RGB(128, 128, 0);
  cBrush[5] := RGB(128, 0, 128);
  cBrush[6] := RGB(0, 128, 128);
  cBrush[7] := RGB(128, 128, 128);
end;

{ TBlock }

procedure TBlock.Rotate(const aNumber: integer);
var
  idx, loopHigh, i, j, k: integer;
  tempBlock: array [0 .. 16] of AnsiChar;
begin
  for k := 1 to aNumber do
  begin
    if size in [3, 4] then
    begin
      loopHigh := size - 1;
      idx := (size mod 2) * 2;
      Move(elements, tempBlock, sizeof(tempBlock));
      for i := 0 to loopHigh do
        for j := 0 to loopHigh do
          tempBlock[abs(idx - i) * 4 + j] := elements[j * 4 + i];
      Move(tempBlock, elements, sizeof(tempBlock));
    end;
  end;
end;

{ TBlockForm }

procedure TBlockForm.ClearBoard;
var
  i, j: integer;
begin
  for i := 0 to GAME_HEIGHT do
    for j := 0 to GAME_WIDTH + 1 do
      board[i][j] := 0;
  for i := 0 to GAME_HEIGHT do
  begin
    board[i][0] := -1;
    board[i][GAME_WIDTH + 1] := -1;
  end;
  for j := 0 to GAME_WIDTH + 1 do
    board[GAME_HEIGHT][j] := -1;
  Timer1.Enabled := true;
end;

procedure TBlockForm.Help2Click(Sender: TObject);
begin
  ShowMessage(sHelpString);
end;

function TBlockForm.HitTest(var block: TBlock; x, y: integer): boolean;
var
  i, j: integer;
begin
  Result := false;
  for i := 0 to 3 do
    for j := 0 to 3 do
      if (((x + i) < (GAME_WIDTH + 2)) and ((x + i + 1) >= 0) and ((y + j) < (GAME_HEIGHT + 1)) and ((y + j) >= 0)) then
        // make sure block in question is in range
        if (board[y + j][x + 1 + i] <> 0) then
          // if the board piece is empty, skip test
          if (block.elements[j * 4 + i] = '*') then
            Result := true;
end;

procedure TBlockForm.IncreaseSpeed;
begin
  Dec(gameSpeed);
  if gameSpeed < 2 then
    gameSpeed := 1;
  dropCount := 0;
  Invalidate;
end;

procedure TBlockForm.DrawGameOverScreen(ACanvas: TCanvas);
begin
  ACanvas.Pen.Color := RGB(0, 255, 255);
  ACanvas.Brush.Color := clFuchsia;
  ACanvas.TextOut((blockSize * 3 div 2), blockSize * 9, '***** G A M E   O V E R *****');
  ACanvas.TextOut((blockSize * 3 div 2), blockSize * 10, '* F2 to start a new game... *');
  ACanvas.TextOut((blockSize * 3 div 2), blockSize * 11, '* F1 for HELP!!! *');
end;

procedure TBlockForm.DrawPausedScreen(ACanvas: TCanvas);
begin
  ACanvas.Pen.Color := RGB(0, 255, 255);
  ACanvas.Brush.Color := clFuchsia;
  ACanvas.TextOut((blockSize * 3 div 2), blockSize * 9, '* * P A U S E D * * ');
end;

procedure TBlockForm.DecreaseSpeed;
begin
  Inc(gameSpeed);
  if gameSpeed > 20 then
    gameSpeed := 20;
  dropCount := 0;
  Invalidate;
end;

procedure TBlockForm.IncreaseBlockSize;
var
  TempBlockSize: integer;
begin
  TempBlockSize := blockSize;
  Inc(blockSize);
  if (blockSize * GAME_HEIGHT >= (Screen.Height - blockSize)) then
    blockSize := TempBlockSize;
  ChangeWindowSize;
end;

procedure TBlockForm.DecreaseBlockSize;
begin
  Dec(blockSize);
  if blockSize < MIN_BLOCKSIZE then
    blockSize := MIN_BLOCKSIZE;
  ChangeWindowSize;
end;

procedure TBlockForm.NewBlock(blockType: integer);
begin
  currentBlock := blocks[blockType];
  BColor := blockType + 1;
  x := 4;
  y := 0;
  // if the new block hits anything on the screen, the game is over
  if (HitTest(currentBlock, x, y)) then
  begin
    PlaceBlock;
    Invalidate;
    gameState := gsGameOver;
  end;
end;

procedure TBlockForm.DrawBlock(ACanvas: TCanvas; var block: TBlock; pos: TPoint);
var
  i, j, bsize: integer;
begin
  bsize := block.size - 1;
  ACanvas.Brush.Color := cBrush[BColor];
  ACanvas.Pen.Color := cpen[BColor];
  for i := 0 to bsize do
    for j := 0 to bsize do
      if (block.elements[j * 4 + i] = '*') then
        ACanvas.Rectangle(pos.x * blockSize + i * blockSize, pos.y * blockSize + j * blockSize, pos.x * blockSize + i * blockSize + blockSize, pos.y * blockSize + j * blockSize + blockSize);
end;

procedure TBlockForm.PaintBox1Paint(Sender: TObject);
begin
  DrawGameWindow(PaintBox1.Canvas);
end;

procedure TBlockForm.Pause;
const
  GameStateArray: array [gsBlockDropping .. gsPaused] of TGameState = (gsPaused, gsBlockDropping);
begin
  gameState := GameStateArray[gameState];
  Invalidate;
end;

procedure TBlockForm.Pause1Click(Sender: TObject);
begin
  Pause;
end;

procedure TBlockForm.PlaceBlock;
var
  i, j: integer;
begin
  for i := 0 to 3 do
    for j := 0 to 3 do
      if (currentBlock.elements[j * 4 + i] = '*') then
        board[y + j][x + 1 + i] := BColor;
  Invalidate;
  RemoveLines();
end;

procedure TBlockForm.DrawGameWindow(ACanvas: TCanvas);
var
  i, j: integer;
begin
  // if the game is paused, blank the screen (to prevent cheating!)
  if (gameState = gsPaused) then
  begin
    DrawPausedScreen(ACanvas);
    Exit;
  end;
  // clear the memory DC
  // draw the permanent blocks
  for j := 0 to GAME_HEIGHT - 1 do
    for i := 0 to GAME_WIDTH - 1 do
      if (board[j][i + 1] <> 0) then
      begin
        ACanvas.Brush.Color := cpen[board[j][i + 1]];
        ACanvas.Pen.Color := cBrush[board[j][i + 1]];
        ACanvas.Rectangle(i * blockSize, j * blockSize, i * blockSize + blockSize, j * blockSize + blockSize);
      end;
  // display the game over message if the game has ended
  if (gameState = gsGameOver) then
  begin
    DrawGameOverScreen(ACanvas);
  end;
  // if a block is dropping, draw it
  if (gameState = gsBlockDropping) then
    DrawBlock(ACanvas, currentBlock, Point(x, y));
end;

procedure TBlockForm.FormCreate(Sender: TObject);
begin
  Randomize;
  ClearBoard;
  CountRemovedLines := 0;
  blockSize := MIN_BLOCKSIZE + 5;
  gameSpeed := 20;
  dropCount := 0;
  gameState := gsGameOver;
  dropping := false;
  ChangeWindowSize;
  InitColours;
end;

procedure TBlockForm.ChangeWindowSize;
begin
  // Size the form
  ClientWidth := blockSize * GAME_WIDTH;
  ClientHeight := blockSize * GAME_HEIGHT;
end;

procedure TBlockForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (gameState = gsPaused) then
  begin
    gameState := gsBlockDropping;
    Exit;
  end;

  case (Key) of
    VK_PRIOR:
      IncreaseSpeed;
    VK_NEXT:
      DecreaseSpeed;

    VK_ADD:
      IncreaseBlockSize;
    VK_SUBTRACT:
      DecreaseBlockSize;

    // move block left
    VK_NUMPAD4, VK_LEFT:
      begin
        Dec(x);
        if (HitTest(currentBlock, x, y)) then
          Inc(x)
        else
          Invalidate;
      end;
    // move block right
    VK_NUMPAD6, VK_RIGHT:
      begin
        Inc(x);
        if (HitTest(currentBlock, x, y)) then
          Dec(x)
        else
          Invalidate;
      end;
    // turn on fast dropping
    VK_NUMPAD2, VK_DOWN:
      dropping := true;
    // rotate block
    VK_UP, VK_NUMPAD5, VK_SPACE:
      begin
        currentBlock.Rotate(1);
        if (HitTest(currentBlock, x, y)) then
        begin
          currentBlock.Rotate(3);
        end;
        Invalidate;
      end;
  end;
end;

procedure TBlockForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [VK_NUMPAD2, VK_DOWN] then
    dropping := false;
end;

procedure TBlockForm.RemoveLines;
var
  i, j, k, l: integer;
  lineFull, linesRemoved: boolean;
begin
  linesRemoved := false;
  j := GAME_HEIGHT - 1;
  while (j >= 0) do
  begin
    lineFull := true;
    for i := 1 to GAME_WIDTH do
      if (board[j][i] = 0) then
        lineFull := false;
    if (lineFull) then
    begin
      linesRemoved := true;
      Inc(CountRemovedLines);
      for k := j downto 1 do
        for l := 1 to GAME_WIDTH do
          board[k][l] := board[k - 1][l];
      for l := 1 to GAME_WIDTH do
        board[0][l] := 0;
    end
    else
      Dec(j);
  end;
  if (linesRemoved) then
  begin
    if (CountRemovedLines mod SPEEDUPATLINES) = 0 then
      IncreaseSpeed;
    Invalidate;
  end;
end;

procedure TBlockForm.StartnewgameF1Click(Sender: TObject);
begin
  NewGame;
end;

procedure TBlockForm.Timer1Timer(Sender: TObject);
begin
  if (gameState = gsBlockDropping) then // game in progress
  begin
    Inc(dropCount); // increment drop counter
    if ((dropping) or (dropCount = gameSpeed)) then // if time to drop
    begin
      dropCount := 0; // reset counter
      Inc(y); // move block down
      if (HitTest(currentBlock, x, y)) then // if it hit something
      begin
        Dec(y); // move it back up
        PlaceBlock(); // make it permanent
        RemoveLines();
        NewBlock(random(NumberofBlocks));
      end;
      Invalidate; // redraw game board
    end;
  end;
end;

procedure TBlockForm.NewGame;
begin
  ClearBoard;
  NewBlock(random(NumberofBlocks));
  gameState := gsBlockDropping;
  CountRemovedLines := 0;
  Timer1.Enabled := true;
  Invalidate;
end;

end.
