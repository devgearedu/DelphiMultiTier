
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit EditorTabFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DesignIntf, ComCtrls, ToolsAPI, IniFiles, Menus, Registry,
  ImgList;

type
  TEditorTabHandler = class;
  TPossibleColors = (pcBlue, pcRed, pcYellow, pcGreen, pcWhite, pcBlack, pcPurple, pcFuchsia, pcLime, pcSilver, pcNavy, pcTeal);

  TEditorTab = class(TFrame)
    Ball: TShape;
    MoveTimer: TTimer;
    FramePopupMenu: TPopupMenu;
    StopStartItem: TMenuItem;
    SetShapetoHereItem: TMenuItem;
    PropertiesItem: TMenuItem;
    procedure MoveTimerTimer(Sender: TObject);
    procedure StopStartItemClick(Sender: TObject);
    procedure SetShapetoHereItemClick(Sender: TObject);
    procedure PropertiesItemClick(Sender: TObject);
  private
    FNegVertMove, FNegHorzMove: Boolean;
    FTimerCount, FChangeDirCount: Integer;
    FEditorTabHandler: TEditorTabHandler;
    FCurColor: TPossibleColors;
    class var FCount: Integer;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TEditorTabHandler = class(TInterfacedObject, INTACustomEditorView,
    INTACustomEditorView150, INTACustomEditorViewStatusPanel, INTACustomEditorViewState)
  private
    FEditorTab: TEditorTab;
    FFileName: string;
    class var FEditorTabHandler: TEditorTabHandler;
  public
    constructor Create(const Filename: string);
    destructor Destroy; override;
    class procedure OnViewMenuClick(Sender: TObject);
    class procedure OnCloseMenuClick(Sender: TObject);
    { INTACustomEditorView }
    procedure CloseAllCalled(var ShouldClose: Boolean);
    procedure DeselectView;
    function EditAction(Action: TEditAction): Boolean;
    function GetCanCloneView: Boolean;
    function CloneEditorView: INTACustomEditorView;
    function GetCaption: string;
    function GetEditState: TEditState;
    function GetEditorWindowCaption: string;
    function GetViewIdentifier: string;
    procedure SelectView;
    function GetFrameClass: TCustomFrameClass;
    procedure FrameCreated(AFrame: TCustomFrame);
    function CreateFrameInstance(AOwner: TComponent): TCustomFrame;
    { INTACustomEditorView150 }
    function GetImageIndex: Integer;
    function GetTabHintText: string;
    procedure Close(var Allowed: Boolean);
    { INTACustomEditorTabStatusPanel }
    procedure ConfigurePanel(StatusBar: TStatusBar;
      Panel: TStatusPanel);
    procedure DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    function GetStatusPanelCount: Integer;
    { INTACustomEditorViewState }
    procedure LoadViewState(const Desktop: TCustomIniFile;
      const ViewDeskSection: string);
    procedure SaveViewState(const Desktop: TCustomIniFile;
      const IsProject: Boolean; const ViewDeskSection: string);
  end;

  TBouncyBallOptions = class
  private
    FVertMove, FHorzMove: Integer;
    FColor: TColor;
    FCycleColors: Boolean;
    FRegIniFile: TRegistryIniFile;
    FUseExistingView: Boolean;
    FChanged: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetCycleColors(const Value: Boolean);
    procedure SetHorzMove(const Value: Integer);
    procedure SetVertMove(const Value: Integer);
    procedure SetUseExistingView(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    property VertMove: Integer read FVertMove write SetVertMove;
    property HorzMove: Integer read FHorzMove write SetHorzMove;
    property Color: TColor read FColor write SetColor;
    property CycleColors: Boolean read FCycleColors write SetCycleColors;
    property UseExistingView: Boolean read FUseExistingView write SetUseExistingView;
  end;

var
  BouncyBallOpts: TBouncyBallOptions = nil;

const
  cViewIdentifier = 'BouncyBallView';
resourcestring
  sBouncyBall = 'Bouncy Ball';
  sCloseBouncyBall = 'Close Bouncy Ball';

function RecreateTab: INTACustomEditorView;

implementation

uses BouncyBallDataMod;

{$R *.dfm}

function RecreateTab: INTACustomEditorView;
begin
  Result := TEditorTabHandler.Create(sBouncyBall) as INTACustomEditorView;
end;

{ TEditorTab }

const
  ActualColors: array[TPossibleColors] of TColor = (clBlue, clRed, clYellow, clGreen, clWhite, clBlack, clPurple, clFuchsia, clLime, clSilver, clNavy, clTeal);

constructor TEditorTab.Create(AOwner: TComponent);
begin
  FCurColor := Low(TPossibleColors);
  FTimerCount := 0;
  FChangeDirCount := 0;
  inherited;
  Name := Format('%s_%d', [Name, FCount]);
  Inc(FCount);
end;

procedure TEditorTab.MoveTimerTimer(Sender: TObject);

  procedure UpdateStatusBar(const NewText: string);
  var
    EditWindow: INTAEditWindow;
  begin
    EditWindow := (BorlandIDEServices as IOTAEditorViewServices).GetOwningEditWindow(FEditorTabHandler as INTACustomEditorView);
    EditWindow.StatusBar.Panels[0].Text := NewText;
  end;

begin
  Inc(FTimerCount);
  if FNegVertMove then
    Ball.Top := Ball.Top - BouncyBallOpts.VertMove
  else
    Ball.Top := Ball.Top + BouncyBallOpts.VertMove;
  if FNegHorzMove then
    Ball.Left := Ball.Left - BouncyBallOpts.HorzMove
  else
    Ball.Left := Ball.Left + BouncyBallOpts.HorzMove;

  if Ball.Top + Ball.Height > Height then
    Ball.Top := Height - Ball.Height;
  if Ball.Top < 0 then
    Ball.Top := 0;
  if (Ball.Top + Ball.Height >= Height) or (Ball.Top <= 0)  then
  begin
    FNegVertMove := not FNegVertMove;
    Inc(FChangeDirCount);
    UpdateStatusBar(IntToStr(FChangeDirCount));
  end;

  if Ball.Left + Ball.Width > Width then
    Ball.Left := Width - Ball.Width;
  if Ball.Left < 0 then
    Ball.Left := 0;
  if (Ball.Left + Ball.Width >= Width) or (Ball.Left <= 0) then
  begin
    FNegHorzMove := not FNegHorzMove;
    Inc(FChangeDirCount);
    UpdateStatusBar(IntToStr(FChangeDirCount));
  end;
  if BouncyBallOpts.CycleColors then
  begin
    if FTimerCount mod 50 = 0 then
    begin
      if FCurColor = High(TPossibleColors) then
        FCurColor := Low(TPossibleColors)
      else
        FCurColor := Succ(FCurColor);
      FTimerCount := 0;
      Ball.Brush.Color := ActualColors[FCurColor];
    end;
  end else
    Ball.Brush.Color := BouncyBallOpts.Color;
end;

procedure TEditorTab.PropertiesItemClick(Sender: TObject);
begin
  (BorlandIDEServices as IOTAServices).GetEnvironmentOptions.EditOptions('', sBouncyBall);
end;

procedure TEditorTab.SetShapetoHereItemClick(Sender: TObject);
var
  MyPoint: TPoint;
begin
  MyPoint := ScreenToClient(FramePopupMenu.PopupPoint);
  Ball.Left := MyPoint.X;
  Ball.Top := MyPoint.Y;
end;

procedure TEditorTab.StopStartItemClick(Sender: TObject);
begin
  MoveTimer.Enabled := not MoveTimer.Enabled;
end;

{ TEditorTabHandler }

constructor TEditorTabHandler.Create(const Filename: string);
begin
  inherited Create;
  FFileName := Filename;
end;

destructor TEditorTabHandler.Destroy;
begin
  if FEditorTabHandler = Self then
    FEditorTabHandler := nil;
  inherited;
end;

procedure TEditorTabHandler.Close(var Allowed: Boolean);
begin
  Allowed := True;
  FEditorTab := nil;//probably not necessary
end;

procedure TEditorTabHandler.CloseAllCalled(var ShouldClose: Boolean);
begin
  ShouldClose := True;
end;

procedure TEditorTabHandler.ConfigurePanel(StatusBar: TStatusBar;
  Panel: TStatusPanel);
begin
  Panel.Style := psText;
  Panel.Text := '';
end;

procedure TEditorTabHandler.DeselectView;
begin
  FEditorTab.MoveTimer.Enabled := False;
end;

procedure TEditorTabHandler.DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
   //no owner-drawn panels to deal with
end;

function TEditorTabHandler.EditAction(Action: TEditAction): Boolean;
begin
   //do nothing
   Result := True;
end;

function TEditorTabHandler.GetCanCloneView: Boolean;
begin
  Result := True;
end;

function TEditorTabHandler.CloneEditorView: INTACustomEditorView;
begin
  Result := TEditorTabHandler.Create(FFilename) as INTACustomEditorView;
end;

function TEditorTabHandler.GetCaption: string;
begin
  Result := FFileName;
end;

function TEditorTabHandler.GetEditorWindowCaption: string;
begin
  Result := FFileName;
end;

function TEditorTabHandler.GetEditState: TEditState;
begin
  Result := [];
end;

function TEditorTabHandler.GetFrameClass: TCustomFrameClass;
begin
  Result := TEditorTab;
end;

function TEditorTabHandler.GetImageIndex: Integer;
begin
  Result := EditorBaseImageIndex + cBouncyBallViewGlyphIndex;
end;

procedure TEditorTabHandler.FrameCreated(AFrame: TCustomFrame);
begin
  if AFrame is TEditorTab then
  begin
    FEditorTab := TEditorTab(AFrame);
    FEditorTab.FEditorTabHandler := Self;
  end;
end;

function TEditorTabHandler.CreateFrameInstance(AOwner: TComponent): TCustomFrame;
begin
  FEditorTab := TEditorTab.Create(AOwner);
  Result := FEditorTab;
end;

function TEditorTabHandler.GetStatusPanelCount: Integer;
begin
  Result := 1;
end;

function TEditorTabHandler.GetTabHintText: string;
begin
  Result := 'Hint: ' + GetCaption;
end;

function TEditorTabHandler.GetViewIdentifier: string;
begin
  Result := cViewIdentifier;
end;

procedure TEditorTabHandler.LoadViewState(const Desktop: TCustomIniFile;
  const ViewDeskSection: string);
begin
  FEditorTab.Ball.Brush.Color := StringToColor(Desktop.ReadString(ViewDeskSection, 'BallColor', ColorToString(FEditorTab.Ball.Brush.Color)));
  FEditorTab.Ball.Top := Desktop.ReadInteger(ViewDeskSection, 'Top', FEditorTab.Ball.Top);
  FEditorTab.Ball.Left := Desktop.ReadInteger(ViewDeskSection, 'Left', FEditorTab.Ball.Left);
  FEditorTab.FNegVertMove := Desktop.ReadBool(ViewDeskSection, 'NegVertMove', FEditorTab.FNegVertMove);
  FEditorTab.FNegHorzMove := Desktop.ReadBool(ViewDeskSection, 'NegHorzMove', FEditorTab.FNegHorzMove);
end;

class procedure TEditorTabHandler.OnCloseMenuClick(Sender: TObject);
begin
  if FEditorTabHandler <> nil then
    (BorlandIDEServices as IOTAEditorViewServices).CloseEditorView(FEditorTabHandler as INTACustomEditorView);
end;

class procedure TEditorTabHandler.OnViewMenuClick(Sender: TObject);
begin
  if BouncyBallOpts.UseExistingView then
  begin
    if FEditorTabHandler = nil then
      FEditorTabHandler := TEditorTabHandler.Create('Bouncy Ball');
  end else
    FEditorTabHandler := TEditorTabHandler.Create('Bouncy Ball');

  (BorlandIDEServices as IOTAEditorViewServices).ShowEditorView(FEditorTabHandler as INTACustomEditorView);
end;

procedure TEditorTabHandler.SaveViewState(const Desktop: TCustomIniFile;
  const IsProject: Boolean; const ViewDeskSection: string);
begin
  Desktop.WriteString(ViewDeskSection, 'BallColor', ColorToString(FEditorTab.Ball.Brush.Color));
  Desktop.WriteInteger(ViewDeskSection, 'Top', FEditorTab.Ball.Top);
  Desktop.WriteInteger(ViewDeskSection, 'Left', FEditorTab.Ball.Left);
  Desktop.WriteBool(ViewDeskSection, 'NegVertMove', FEditorTab.FNegVertMove);
  Desktop.WriteBool(ViewDeskSection, 'NegHorzMove', FEditorTab.FNegHorzMove);
end;

procedure TEditorTabHandler.SelectView;
begin
  FEditorTab.MoveTimer.Enabled := True;
end;

{ TBouncyBallOptions }

const
  sBouncyBallOptions = 'BouncyBall';
  vVertMove = 'VertMove';
  vHorzMove = 'HorzMove';
  vColor = 'Color';
  vCycleColors = 'CycleColors';
  vUseExisting = 'UseExisting';

constructor TBouncyBallOptions.Create;
var
  BaseRegKey: string;
begin
  BaseRegKey := (BorlandIDEServices as IOTAServices).GetBaseRegistryKey;
  FRegIniFile := TRegistryIniFile.Create(BaseRegKey);
  FVertMove := FRegIniFile.ReadInteger(sBouncyBallOptions, vVertMove, 2);
  FHorzMove := FRegIniFile.ReadInteger(sBouncyBallOptions, vHorzMove, 2);
  FColor := StringToColor(FRegIniFile.ReadString(sBouncyBallOptions, vColor, 'clBlack'));
  FCycleColors := FRegIniFile.ReadBool(sBouncyBallOptions, vCycleColors, True);
  FUseExistingView := FRegIniFile.ReadBool(sBouncyBallOptions, vUseExisting, False);
  FChanged := False;
end;

destructor TBouncyBallOptions.Destroy;
begin
  assert(Assigned(FRegIniFile));
  if FChanged then
  begin
    FRegIniFile.WriteInteger(sBouncyBallOptions, vVertMove, FVertMove);
    FRegIniFile.WriteInteger(sBouncyBallOptions, vHorzMove, FHorzMove);
    FRegIniFile.Writestring(sBouncyBallOptions, vColor, ColorToString(FColor));
    FRegIniFile.WriteBool(sBouncyBallOptions, vCycleColors, FCycleColors);
    FRegIniFile.WriteBool(sBouncyBallOptions, vUseExisting, FUseExistingView);
  end;
  FreeAndNil(FRegIniFile);
  inherited;
end;

procedure TBouncyBallOptions.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FChanged := True;
  end;
end;

procedure TBouncyBallOptions.SetCycleColors(const Value: Boolean);
begin
  if FCycleColors <> Value then
  begin
    FCycleColors := Value;
    FChanged := True;
  end;
end;

procedure TBouncyBallOptions.SetHorzMove(const Value: Integer);
begin
  if FHorzMove <> Value then
  begin
    FHorzMove := Value;
    FChanged := True;
  end;
end;

procedure TBouncyBallOptions.SetUseExistingView(const Value: Boolean);
begin
  if FUseExistingView <> Value then
  begin
    FUseExistingView := Value;
    FChanged := True;
  end;
end;

procedure TBouncyBallOptions.SetVertMove(const Value: Integer);
begin
  if FVertMove <> Value then
  begin
    FVertMove := Value;
    FChanged := True;
  end;
end;

initialization
  TEditorTab.FCount := 0;
  BouncyBallOpts := TBouncyBallOptions.Create;
finalization
  FreeAndNil(BouncyBallOpts);
end.
