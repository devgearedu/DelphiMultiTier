
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RibbonLunaStyleActnCtrls, Ribbon, ActnCtrls, ToolWin, ActnMan,
  ActnMenus, RibbonActnMenus, ImgList, ActnList, StdActns, StdCtrls,
  RibbonActnCtrls, ExtCtrls, ComCtrls, CheckLst, jpeg, ExtDlgs, Direct2D, D2D1,
  ExtActns, System.Actions;

type
  TForm1 = class(TForm)
    Ribbon1: TRibbon;
    ActionManager1: TActionManager;
    rpHome: TRibbonPage;
    rpView: TRibbonPage;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    RibbonQuickAccessToolbar1: TRibbonQuickAccessToolbar;
    ilGFX32_d: TImageList;
    ilGFX32: TImageList;
    ilGFX16_d: TImageList;
    ilGFX16: TImageList;
    GroupAction: TRibbonGroup;
    ComboBox1: TComboBox;
    GroupCoordinates: TRibbonGroup;
    ListBox1: TListBox;
    GroupDimensions: TRibbonGroup;
    Edit2: TEdit;
    GroupDirect2D: TRibbonGroup;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    GroupGDI: TRibbonGroup;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    GroupSettings: TRibbonGroup;
    GroupImages: TRibbonGroup;
    rpText: TRibbonPage;
    GroupText: TRibbonGroup;
    Edit4: TEdit;
    GroupTextOptions: TRibbonGroup;
    CheckListBox1: TCheckListBox;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    FontDialog1: TFontDialog;
    Edit1: TEdit;
    FileExit1: TFileExit;
    MyOpenPictureDialog: TAction;
    Font: TAction;
    BalloonHint1: TBalloonHint;
    ActionEnableD2D: TAction;
    ActionEnableGDI: TAction;
    EditPenWidth: TRibbonSpinEdit;
    ActionTranslate: TAction;
    ActionAntiAlias: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure MyOpenPictureDialogExecute(Sender: TObject);
    procedure FontExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  protected
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
      message WM_ERASEBKGND;
  private
    FMoving: Boolean;
    FPoints: array of TPoint;
    fctrl : TCustomControl;
    procedure TestPaint(Canvas: TCustomCanvas);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses DXGIformat, typinfo;

{$R *.dfm}

type
  TDrawFunctions = (dfTextOut,
                    dfTextRect,
                    dfTextRect2,
                    dfDraw,
                    dfStretchDraw,
                    dfRectangle,
                    dfFillRect,
                    dfFrameRect,
                    dfRoundRectangle,
                    dfEllipse,
                    dfPie,
                    dfArc,
                    dfChord,
                    dfPolyBezier,
                    dfPolyLine,
                    dfPolygon);

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute(Handle) then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    Invalidate;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FontDialog1.Font := Canvas.Font;
  if FontDialog1.Execute(handle) then
  begin
    canvas.Font := FontDialog1.Font;
    invalidate;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  I: Integer;
begin
  ListBox1.Clear;

  GroupDimensions.Visible := ComboBox1.ItemIndex = 5;

  case TDrawFunctions(ComboBox1.ItemIndex) of
    dfTextOut, dfDraw:
    begin
      SetLength(FPoints, 1);
      FPoints[0] := Point(100,200);
    end;
    dfTextRect, dfStretchDraw .. dfEllipse : //StretchDraw, Rectangle, FrameRect, FillRect, Round Rectangle, Ellipse
    begin
      SetLength(FPoints, 2);
      FPoints[0] := Point(100,200);
      FPoints[1] := Point(200,300);
    end;
    dfTextRect2:
    begin
      SetLength(FPoints, 3);
      FPoints[0] := Point(100,200);
      FPoints[1] := Point(200,300);
      FPoints[2] := Point(150,200);
    end;
    dfPie .. dfChord: //Pie, Arc, Chord
    begin
      SetLength(FPoints, 4);
      FPoints[0] := Point(100,200);
      FPoints[1] := Point(200,300);
      FPoints[2] := Point(150,200);
      FPoints[3] := Point(100,250);
    end;
    dfPolyBezier .. dfPolygon: //PolyBezier, PolyLine, Polygon
    begin
      if Length(FPoints) < 3 then
      begin
        SetLength(FPoints, 4);
        FPoints[0] := Point(100, 200);
        FPoints[1] := Point(200, 200);
        FPoints[2] := Point(200, 300);
        FPoints[3] := Point(100, 300);
      end;
    end;
  end;
  for I := 0 to Length(FPoints) - 1 do
    ListBox1.Items.Add(Format('(%d, %d)', [FPoints[I].X, FPoints[I].Y]));
  Invalidate;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  Invalidate;
end;

procedure TForm1.FontExecute(Sender: TObject);
begin
  FontDialog1.Font := Canvas.Font;
  if FontDialog1.Execute(handle) then
  begin
    canvas.Font := FontDialog1.Font;
    invalidate;
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Ribbon1.TabIndex := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I : TDrawFunctions;
  s : string;
begin

  for I := low(TDrawFunctions) to high(TDrawFunctions) do
  begin
    s := GetEnumName(TypeInfo(TDrawFunctions), integer(I));
    ComboBox1.Items.Add(copy(s, 3, length(s)));
  end;

  ComboBox1.ItemIndex := 5;
  ComboBox1Change(ComboBox1);

  canvas.Font := Screen.CaptionFont;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  if Button = mbLeft then
  begin
    FMoving :=  True;
    if (ComboBox1.ItemIndex >=10) and (ssDouble in Shift) then
    begin
      SetLength(FPoints, Length(FPoints)+1);
      FPoints[Length(FPoints)-1] := Point(x,y);
      ListBox1.Items.Add(Format('(%d,%d)', [x,y]));
      ListBox1.ItemIndex := Length(FPoints)-1;
    end
    else
    begin
      ListBox1.ItemIndex := -1;
      for I := 0 to Length(FPoints) - 1 do
      begin
        if (FPoints[I].X - X)*(FPoints[I].X - X) +
           (FPoints[I].Y - Y)*(FPoints[I].Y - Y) < 25 then
        begin
          ListBox1.ItemIndex := I;
          Break;
        end;
      end;

    end;
    FormMouseMove(Sender, Shift, X, Y);
  end;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  I: Integer;
begin
    if (ListBox1.ItemIndex >= 0) and FMoving then
  begin
    FPoints[ListBox1.ItemIndex].X := X;
    FPoints[ListBox1.ItemIndex].Y := Y;
    Invalidate;
    listbox1.Items[ListBox1.ItemIndex] := Format('(%d,%d)', [X,Y]);
  end
  else
  begin
    for I := 0 to Length(FPoints) - 1 do
    begin
      if (FPoints[I].X - X)*(FPoints[I].X - X) +
         (FPoints[I].Y - Y)*(FPoints[I].Y - Y) < 25 then
      begin
        Cursor := crCross;
        exit;
      end;
    end;
    Cursor := crDefault;
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FMoving := False;
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if PtInRect(Ribbon1.BoundsRect, ScreenToClient(MousePos)) then exit;
  ActiveControl.Perform(CB_SHOWDROPDOWN, 0, 0);

  Handled := True;
  if (WheelDelta > 0) and (ComboBox1.ItemIndex > 0) then
    ComboBox1.ItemIndex := ComboBox1.ItemIndex - 1
  else if (WheelDelta < 0) and (ComboBox1.ItemIndex < ComboBox1.Items.Count) then
    ComboBox1.ItemIndex := ComboBox1.ItemIndex + 1;
  ComboBox1Change(ComboBox1);
end;

type
  TGDITestDrawer = class(TInterfacedObject, IDWriteTextRenderer)
  private
    brt: idwritebitmaprendertarget;
  public
    constructor Create(Canvas: TCanvas);

    function DrawGlyphRun(clientDrawingContext: Pointer; baselineOriginX: Single;
      baselineOriginY: Single; measuringMethod: TDWriteMeasuringMode;
      var glyphRun: TDwriteGlyphRun;
      var glyphRunDescription: TDwriteGlyphRunDescription;
      const clientDrawingEffect: IUnknown): HResult; stdcall;

    function DrawUnderline(clientDrawingContext: Pointer; baselineOriginX: Single;
      baselineOriginY: Single; var underline: TDwriteUnderline;
      const clientDrawingEffect: IUnknown): HResult; stdcall;

    function DrawStrikethrough(clientDrawingContext: Pointer;
      baselineOriginX: Single; baselineOriginY: Single;
      var strikethrough: TDwriteStrikethrough;
      const clientDrawingEffect: IUnknown): HResult; stdcall;

    function DrawInlineObject(clientDrawingContext: Pointer; originX: Single;
      originY: Single; var inlineObject: IDWriteInlineObject; isSideways: BOOL;
      isRightToLeft: BOOL; const clientDrawingEffect: IUnknown): HResult; stdcall;

    function IsPixelSnappingDisabled(clientDrawingContext: Pointer;
      var isDisabled: BOOL): HResult; stdcall;

    function GetCurrentTransform(clientDrawingContext: Pointer;
      var transform: TDwriteMatrix): HResult; stdcall;

    function GetPixelsPerDip(clientDrawingContext: Pointer;
      var pixelsPerDip: Single): HResult; stdcall;
  end;

procedure TForm1.FormPaint(Sender: TObject);
var
  LD2DCanvas: TDirect2DCanvas;
  b: id2d1SolidColorBrush;
  color : Integer;
  I : Integer;
var
  TextFormat: IDWriteTextFormat;
  TextLayout:IDWriteTextLayout;
  drawer: TGDITestDrawer;
  tr: IDWriteTextRenderer;
  MemCanvas: TCanvas;
  BF:TBlendFunction;
begin
  LD2DCanvas := TDirect2DCanvas.Create(Canvas, ClientRect);
  with LD2DCanvas do
  try
    Font.Name := Canvas.Font.Name;
    Font.Size := Canvas.Font.Size;
    Font.Style := Canvas.Font.Style;
    Font.Pitch := Canvas.Font.Pitch;
    Font.Orientation := Canvas.Font.Orientation;

    RenderTarget.BeginDraw;

    Pen.Color := ColorBox1.Selected;
    Font.Color := ColorBox1.Selected;
    pen.Width :=  EditPenWidth.Value;
    if ColorBox2.Selected <> clNone then
      Brush.Color := ColorBox2.Selected
    else
      Brush.Style := bsClear;

    RenderTarget.Clear(D2D1ColorF(1.0,1.0,1.0,1.0));

    if ActionAntiAlias.Checked then
      RenderTarget.SetAntialiasMode(D2D1_ANTIALIAS_MODE_PER_PRIMITIVE)
    else
      RenderTarget.SetAntialiasMode(D2D1_ANTIALIAS_MODE_ALIASED);

    if ActionTranslate.Checked then
      RenderTarget.SetTransform(TD2DMatrix3x2F.Translation(ClientWidth / 2, 0))
    else
      RenderTarget.SetTransform(TD2DMatrix3x2F.Identity);

    if ActionEnableD2D.Checked then
      TestPaint(LD2DCanvas);

    RenderTarget.EndDraw;
  finally
    ld2dcanvas.free;
  end;

  Canvas.Pen.Color := ColorBox3.Selected;
  canvas.pen.Width := EditPenWidth.Value;
  if ColorBox4.Selected <> clNone then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := ColorBox4.Selected;
  end
  else
    Canvas.Brush.Style := bsClear;
  if ActionEnableGDI.Checked then
    TestPaint(Canvas);
  //Draw anchor points to move points
  Canvas.Pen.Width := 1;
  canvas.Pen.color := clWhite;
  canvas.Pen.Mode := pmXor;
  canvas.Brush.Style := bsClear;
  for I := 0 to Length(FPoints) - 1 do
    canvas.Ellipse(FPoints[i].x-5, FPoints[i].Y-5,
                   FPoints[i].x+5, FPoints[i].Y+5);
  canvas.Pen.Mode := pmCopy;
  canvas.brush.style := bssolid;
end;

procedure TForm1.MyOpenPictureDialogExecute(Sender: TObject);
begin
  if OpenPictureDialog1.Execute(Handle) then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    Invalidate;
  end;
end;

procedure TForm1.TestPaint(Canvas: TCustomCanvas);
var
  Points: array[0..9] of TPoint;
  p: array[0..1] of TPoint;
  I: Integer;
  R: TRect;
  S: String;
  Fmt: TTextFormat;
begin
  for I := 0 to 10 - 1 do
  begin
    Points[i].X := (i mod 2)*100;
    Points[i].Y := I*10;
  end;
  with Canvas do
  begin
    case TDrawFunctions(ComboBox1.ItemIndex) of
      dfTextOut:
        TextOut(FPoints[0].x, FPoints[0].y, Edit4.Text);
      dfTextRect:
        begin
          Fmt := [];
          for I := 0 to CheckListBox1.Count - 1 do
          begin
            if CheckListBox1.Checked[I] then
              Include(Fmt, TTextFormats(I));
          end;
          S := edit4.Text;
          R := Rect(
            FPoints[0].x, FPoints[0].y,
            FPoints[1].x, FPoints[1].y);
          TextRect(R, S, fmt);
        end;
      dfTextRect2:
        begin
          S := edit4.Text;
          R := Rect(
            FPoints[0].x, FPoints[0].y,
            FPoints[1].x, FPoints[1].y);
          TextRect(R, FPoints[2].X, FPoints[2].Y,  S);
        end;
      dfDraw:
        Draw(FPoints[0].x, FPoints[0].y, Image1.Picture.Graphic);
      dfStretchDraw:
        StretchDraw(Rect(fpoints[0], fpoints[1]), Image1.Picture.Graphic);
      dfRectangle:
        Rectangle(Rect(fpoints[0], fpoints[1]));
      dfFillRect:
        FillRect(Rect(fpoints[0], fpoints[1]));
      dfFrameRect:
        FrameRect(Rect(fpoints[0], fpoints[1]));
      dfRoundRectangle:
        RoundRect(Rect(fpoints[0], fpoints[1]), StrToInt(Edit1.Text), StrToInt(Edit2.Text));
      dfEllipse:
        Ellipse(Rect(fpoints[0], fpoints[1]));
      dfPie:
        Pie(FPoints[0].X, FPoints[0].Y,
            FPoints[1].X, FPoints[1].Y,
            FPoints[2].X, FPoints[2].Y,
            FPoints[3].X, FPoints[3].Y);
      dfArc:
        Arc(FPoints[0].X, FPoints[0].Y,
            FPoints[1].X, FPoints[1].Y,
            FPoints[2].X, FPoints[2].Y,
            FPoints[3].X, FPoints[3].Y);
      dfChord:
        Chord(FPoints[0].X, FPoints[0].Y,
            FPoints[1].X, FPoints[1].Y,
            FPoints[2].X, FPoints[2].Y,
            FPoints[3].X, FPoints[3].Y);
      dfPolyBezier:
        PolyBezier(FPoints);
      dfPolyLine:
        Polyline(FPoints);
      dfPolygon:
        Polygon(FPoints);
    end;
  end;
end;

procedure TForm1.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

{ TGDITestDrawer }

constructor TGDITestDrawer.Create(Canvas: TCanvas);
var
  gi: IDWriteGdiInterop;
begin
    DWriteFactory.GetGdiInterop(gi);
    gi.CreateBitmapRenderTarget(0, 300, 100,  brt );
end;

function TGDITestDrawer.DrawGlyphRun(clientDrawingContext: Pointer;
  baselineOriginX, baselineOriginY: Single;
  measuringMethod: TDWriteMeasuringMode; var glyphRun: TDwriteGlyphRun;
  var glyphRunDescription: TDwriteGlyphRunDescription;
  const clientDrawingEffect: IInterface): HResult;
var
  rect: TRect;
  rp: IDWriteRenderingParams;
begin
  DWriteFactory.CreateRenderingParams(rp);
  brt.DrawGlyphRun(baselineOriginX, baselineOriginY, measuringMethod, glyphRun, rp, $0000FF, nil);
  Result := S_OK;
end;

function TGDITestDrawer.DrawInlineObject(clientDrawingContext: Pointer; originX,
  originY: Single; var inlineObject: IDWriteInlineObject; isSideways,
  isRightToLeft: BOOL; const clientDrawingEffect: IInterface): HResult;
begin
  Result := E_NOTIMPL;
end;

function TGDITestDrawer.DrawStrikethrough(clientDrawingContext: Pointer;
  baselineOriginX, baselineOriginY: Single;
  var strikethrough: TDwriteStrikethrough;
  const clientDrawingEffect: IInterface): HResult;
begin
  Result := E_NOTIMPL;
end;

function TGDITestDrawer.DrawUnderline(clientDrawingContext: Pointer;
  baselineOriginX, baselineOriginY: Single; var underline: TDwriteUnderline;
  const clientDrawingEffect: IInterface): HResult;
begin
  Result := E_NOTIMPL;
end;

function TGDITestDrawer.GetCurrentTransform(clientDrawingContext: Pointer;
  var transform: TDwriteMatrix): HResult;
begin
  transform.m11:=1.0;
  transform.m12:=0.0;
  transform.m21:=0.0;
  transform.m22:=1.0;
  transform.dx:=0.0;
  transform.dy:=0.0;
  Result := S_OK;
end;

function TGDITestDrawer.GetPixelsPerDip(clientDrawingContext: Pointer;
  var pixelsPerDip: Single): HResult;
begin
  pixelsPerDip := 1;
  Result := S_OK;
end;

function TGDITestDrawer.IsPixelSnappingDisabled(clientDrawingContext: Pointer;
  var isDisabled: BOOL): HResult;
begin
  isDisabled := FALSE;
  Result := S_OK;
end;

end.
