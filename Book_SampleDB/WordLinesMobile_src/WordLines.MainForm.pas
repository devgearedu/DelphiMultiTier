unit WordLines.MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Layouts, FMX.ListBox, Generics.Collections,
  WordLines.BoardController, WordLines.Dictionary, WordLines.WordFinder,
  WordLines.Highscores, WordLines.GameFlow, FMX.Effects;

type
  TMainForm = class(TForm)
    BoardBox: TPaintBox;
    InfoLayout: TLayout;
    Rectangle1: TRectangle;
    ClearImg: TImage;
    ClearBtn: TLayout;
    ScoreLbl: TLabel;
    Layout3: TLayout;
    Layout2: TLayout;
    WordsBox: TListBox;
    NewGameBtn: TButton;
    UndoBtn: TButton;
    Image2: TImage;
    CanClearEffect: TGlowEffect;
    Lang: TLang;
    procedure BoardBoxPaint(Sender: TObject; Canvas: TCanvas);
    procedure ClearBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NewGameBtnClick(Sender: TObject);
    procedure HighscoresBtnClick(Sender: TObject);
    procedure UndoBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InfoLayoutMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure InfoLayoutMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure InfoLayoutMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure BoardBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  strict private type
    TViewState = (vsStable, vsReadyToMove, vsMoving);
  strict private
    FCtrlDisableCounter: Integer;
  private
    { Private declarations }
    FBoard: TBoardController;
    FDictionary: TDictionary;
    FWordFinder: TWordFinder;
    FGameFlow: TGameFlow;

    FViewState: TViewState;
    FViewMoveFromPt: TPointF;
    procedure SetReadyToMove(X, Y: Single);

    function GetBoardRect: TRectF; inline;
    procedure RepaintBox(Sender: TObject);
    procedure GameEnd(Sender: TObject);

    procedure StartNewGame(const Language: string);
    procedure ShowWords;
    procedure SelectLangAndStartGame;
    function GetDictionaryFileName(const Language: string): string;

    procedure ShowScore;

    procedure MoveView(ALeft: Single);
    procedure DisableControls; inline;
    procedure EnableControls; inline;
    function ControlsEnabled: Boolean; inline;
    procedure CheckHighscore;
    procedure ClearWords;
    procedure TryUndo;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.Math, System.IOUtils, System.StrUtils, FMX.Platform, Wordlines.Settings,
  WordLines.SelectLanguage;

{$R *.fmx}

procedure TMainForm.ClearBtnClick(Sender: TObject);
begin
  if not ControlsEnabled then
    Exit;

  ClearWords;
  ShowScore;

  BoardBox.Repaint;
  UndoBtn.Enabled := False;
end;

procedure TMainForm.NewGameBtnClick(Sender: TObject);
begin
  if ControlsEnabled then
  begin
    CheckHighscore;
    SelectLangAndStartGame;
  end;
end;

procedure TMainForm.RepaintBox(Sender: TObject);
begin
  BoardBox.Repaint;
  Application.ProcessMessages;
end;

function TMainForm.ControlsEnabled: Boolean;
begin
  Result := FCtrlDisableCounter = 0;
end;

procedure TMainForm.CheckHighscore;
begin
  if FGameFlow.Score > Settings.Score then
  begin
    ShowMessage(Format(Lang.LangStr[Lang.Lang].Values['BestResult!'], [FGameFlow.Score]));
    Settings.Score := FGameFlow.Score;
    Settings.Save;
  end;
end;

procedure TMainForm.ClearWords;
begin
  FGameFlow.ClearWords;
  WordsBox.Items.Clear;
  CanClearEffect.Enabled := False;
end;

procedure TMainForm.TryUndo;
begin
  if ControlsEnabled and FGameFlow.CanUndo then
  begin
    FGameFlow.Undo;
    ShowWords;
    BoardBox.Repaint;
    UndoBtn.Enabled := False;
  end;
end;

procedure TMainForm.SetReadyToMove(X, Y: Single);
begin
  FViewMoveFromPt := PointF(X, Y);
  FViewState := TViewState.vsReadyToMove;
end;

procedure TMainForm.DisableControls;
begin
  Inc(FCtrlDisableCounter);
end;

procedure TMainForm.EnableControls;
begin
  Dec(FCtrlDisableCounter);
end;

procedure TMainForm.ShowWords;
begin
  WordsBox.Items.Assign(FGameFlow.CurrentWords);
  CanClearEffect.Enabled := WordsBox.Count > 0;
end;

procedure TMainForm.ShowScore;
begin
  ScoreLbl.Text := IntToStr(FGameFlow.Score).PadLeft(4, '0');
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
  SUPPORTED_LOCALES = '|ru|fr|';
begin
  if Pos('|' + Lang.Lang + '|', SUPPORTED_LOCALES) = 0 then
    Lang.Lang := 'en';

  Settings.Load;

  FDictionary := nil;
  FBoard := nil;
  FGameFlow := nil;
  FWordFinder := nil;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  CheckHighscore;

  FGameFlow.Free;
  FWordFinder.Free;
  FDictionary.Free;
  FBoard.Free;
end;

procedure TMainForm.FormShow(Sender: TObject);
const
  cRowCount = 8;
  cColCount = 12;
var
  WindowSrv: IFMXWindowService;
begin
  FDictionary := TDictionary.Create;

  BoardBox.Width := cColCount * BoardBox.Height / cRowCount;

  WindowSrv := TPlatformServices.Current.GetPlatformService(IFMXWindowService) as IFMXWindowService;
  FBoard := TBoardController.Create(cColCount, cRowCount, GetBoardRect,
    WindowSrv.GetWindowScale(Self));

  FWordFinder := TWordFinder.Create(FBoard, FDictionary);

  FGameFlow := TGameFlow.Create(FWordFinder, FBoard, FDictionary);
  FGameFlow.OnRepaint := RepaintBox;
  FGameFlow.OnGameEnd := GameEnd;

  MoveView(ClientWidth - (InfoLayout.Width + BoardBox.Width));

  SelectLangAndStartGame;
end;

procedure TMainForm.GameEnd(Sender: TObject);
begin
  CheckHighscore;
  SelectLangAndStartGame;
end;

function TMainForm.GetBoardRect: TRectF;
begin
  Result := RectF(0, 0, BoardBox.Width, BoardBox.Height);
end;

function TMainForm.GetDictionaryFileName(const Language: string): string;
begin
  {$IFDEF ANDROID}
  Result := TPath.Combine(TPath.GetDocumentsPath, Format('dictionary_%s.txt', [Language.ToLower]));
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  Result := TPath.Combine(ExtractFilePath(ParamStr(0)), Format('Resources\dictionary_%s.txt', [Language]));
  {$ENDIF}
end;

procedure TMainForm.HighscoresBtnClick(Sender: TObject);
var
  ScoresFrm: THighscoresForm;
begin
  ScoresFrm := THighscoresForm.Create(Self);
  {$IFDEF ANDROID}
    ScoresFrm.ShowModal(procedure (Res: TModalResult) begin end);
  {$ELSE}
    try
      ScoresFrm.ShowModal;
    finally
      ScoresFrm.Free;
    end;
  {$ENDIF}
end;

procedure TMainForm.InfoLayoutMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if not ControlsEnabled then
    Exit;

  SetReadyToMove(X, Y);
end;

procedure TMainForm.InfoLayoutMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if (FViewState = TViewState.vsReadyToMove) and (Abs(FViewMoveFromPt.X - X) > 10) then
      FViewState := TViewState.vsMoving;

  if FViewState = TViewState.vsMoving then
    MoveView(InfoLayout.Position.X + X - FViewMoveFromPt.X);
end;

procedure TMainForm.InfoLayoutMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FViewState := TViewState.vsStable;
end;

procedure TMainForm.MoveView(ALeft: Single);
begin
  if ALeft > 0 then
    ALeft := 0;

  if (ALeft + InfoLayout.Width + BoardBox.Width) < ClientWidth then
  begin
    ALeft := ClientWidth - (InfoLayout.Width + BoardBox.Width);
    if ALeft > 0 then
      ALeft := ALeft / 2;
  end;

  InfoLayout.Position.X := ALeft;
  BoardBox.Position.X := InfoLayout.Width + ALeft;
end;

procedure TMainForm.SelectLangAndStartGame;
var
  SelectLangFrm: TSelectLanguageFrm;
  LangName: string;
begin
  SelectLangFrm := TSelectLanguageFrm.Create(Self);
  {$IFDEF ANDROID}
    SelectLangFrm.ShowModal(procedure (Res: TModalResult)
                            begin
                              LangName := SelectLangFrm.Lang;
                              StartNewGame(LangName);
                            end);
  {$ELSE}
    try
      SelectLangFrm.ShowModal;
      LangName := SelectLangFrm.Lang;
      StartNewGame(LangName);
    finally
      SelectLangFrm.Free;
    end;
  {$ENDIF}
end;

procedure TMainForm.BoardBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  CellPos: TPoint;
begin
  if FViewState = TViewState.vsMoving then
  begin
    FViewState := TViewState.vsStable;
    Exit;
  end;

  if FViewState = TViewState.vsReadyToMove then
    FViewState := TViewState.vsStable;

  CellPos := FBoard.CursorToCell(X, Y);
  if not FBoard.SetSelection(CellPos) and FBoard.CanMove(CellPos) then
  begin
    DisableControls;
    try
      FGameFlow.MoveTo(CellPos);
      ShowWords;
    finally
      EnableControls;
    end;
  end;

  UndoBtn.Enabled := FGameFlow.CanUndo;

  BoardBox.Repaint;
end;

procedure TMainForm.BoardBoxPaint(Sender: TObject; Canvas: TCanvas);
begin
  FBoard.Draw(Canvas);
end;

procedure TMainForm.UndoBtnClick(Sender: TObject);
begin
  TryUndo;
end;

procedure TMainForm.StartNewGame(const Language: string);
begin
  FDictionary.LoadFromFile(GetDictionaryFileName(Language));

  FGameFlow.NewGame;
  ShowWords;
  ShowScore;

  UndoBtn.Enabled := False;
  BoardBox.Repaint;
end;

end.
