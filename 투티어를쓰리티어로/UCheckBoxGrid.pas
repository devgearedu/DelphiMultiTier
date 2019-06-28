
unit UCheckBoxGrid;

{$IF RTLVersion >= 23.0}
{$DEFINE DELPHIXE2_HIGHER}
{$IFEND}
{$IF RTLVersion >= 21.0}
{$DEFINE DELPHI2010_HIGHER}
{$IFEND}

interface

uses Classes, Windows, Controls, Grids, DBGrids;

type
  TImpCheckState = (icbUnchecked, icbChecked, icbGrayed);

  TCheckDBGrid = class(TDBGrid)
  private
    FMultiSelectCheckbox: boolean;
    procedure DrawSelCheckbox(ARect: TRect; IsChecked: TImpCheckState);
    procedure Title0Clicked;
    procedure DrawTitle0;
    procedure SelectAll;
    procedure SetMultiSelectCheckbox(const Value: boolean);
  protected
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure SetColumnAttributes; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property MultiSelectCheckbox: boolean read FMultiSelectCheckbox write SetMultiSelectCheckbox default true;
  end;

  TDBGrid = class(TCheckDBGrid);

implementation

uses Graphics{$IFDEF DELPHIXE2_HIGHER}, Themes{$ENDIF};

{ TImpDBGrid }

constructor TCheckDBGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMultiSelectCheckbox := true;
end;

procedure TCheckDBGrid.DrawCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState);

  function RowIsMultiSelected: Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in Options) and Datalink.Active and
      SelectedRows.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  end;

{$IFNDEF DELPHI2010_HIGHER}
  procedure DrawCellBackground(const ARect: TRect; AColor: TColor; AState: TGridDrawState; ACol, ARow: Integer);
  begin
    Canvas.Brush.Color := FixedColor;
    Canvas.FillRect(ARect);
  end;
{$ENDIF}

var
  OldActive: Integer;
  MultiSelected: Boolean;
  IsChecked: TImpCheckState;
{$IFDEF DELPHIXE2_HIGHER}
  IsCustomStyle: Boolean;
{$ENDIF}
begin
{$IFDEF DELPHIXE2_HIGHER}
  IsCustomStyle := TStyleManager.IsCustomStyleActive;
{$ENDIF}
  if csLoading in ComponentState then
  begin
{$IFDEF DELPHIXE2_HIGHER}
    if IsCustomStyle and (seClient in StyleElements) then
      Canvas.Brush.Color := StyleServices.GetStyleColor(scGrid)
    else
{$ENDIF}
      Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
    Exit;
  end;

  if dgTitles in Options then Dec(ARow, 1);
  Dec(ACol, IndicatorOffset);

  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines]) then
    InflateRect(ARect, -1, -1);

  if (gdFixed in AState) and (ACol < 0) then
  begin
    DrawCellBackground(ARect, FixedColor, AState, ACol, ARow);

    if ARow < 0 then
      DrawTitle0
    else
    begin
      if Assigned(DataLink) and DataLink.Active then
      begin
        MultiSelected := False;
        if ARow >= 0 then
        begin
          OldActive := DataLink.ActiveRecord;
          try
            Datalink.ActiveRecord := ARow;
            MultiSelected := RowIsMultiselected;
          finally
            Datalink.ActiveRecord := OldActive;
          end;
        end;
        if MultiSelected then IsChecked := icbChecked
        else                  IsChecked := icbUnchecked;
        DrawSelCheckbox(ARect, IsChecked);
      end;

      if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines]){$IFDEF DELPHIXE2_HIGHER} and (FInternalDrawingStyle = gdsClassic) and not (gdPressed in AState){$ENDIF} then
      begin
        InflateRect(ARect, 1, 1);
{$IFDEF DELPHIXE2_HIGHER}
        if not IsCustomStyle then
{$ENDIF}
        begin
          DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
          DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
        end;
      end;
    end;
  end
  else
  begin
    if dgTitles in Options then Inc(ARow, 1);
    Inc(ACol, IndicatorOffset);
    inherited DrawCell(ACol, ARow, ARect, AState);
  end;
end;

procedure TCheckDBGrid.DrawSelCheckbox(ARect: TRect; IsChecked: TImpCheckState);
const
  CCheckboxSizeNoTheme = 14;
var
{$IFDEF DELPHIXE2_HIGHER}
  ThemedButton: TThemedButton;
{$ENDIF}
  R: TRect;
  uState: UINT;
begin
{$IFDEF DELPHIXE2_HIGHER}
  if StyleServices.Enabled then
  begin
    case IsChecked of
      icbUnchecked: ThemedButton := tbCheckBoxUncheckedNormal;
      icbChecked:   ThemedButton := tbCheckBoxCheckedNormal;
      icbGrayed:    ThemedButton := tbCheckBoxMixedNormal;
    end;
    StyleServices.DrawElement(Canvas.Handle, StyleServices.GetElementDetails(ThemedButton), Rect(ARect.Left + 1, ARect.Top, ARect.Right, ARect.Bottom));
  end
  else
{$ENDIF}
  begin
    R.Left   := ARect.Left + (ARect.Right - ARect.Left) div 2 - CCheckboxSizeNoTheme div 2;
    R.Top    := ARect.Top + (ARect.Bottom - ARect.Top) div 2 - CCheckboxSizeNoTheme div 2;
    R.Right  := R.Left + CCheckboxSizeNoTheme;
    R.Bottom := R.Top + CCheckboxSizeNoTheme;
    case IsChecked of
      icbUnchecked: uState := 0;
      icbChecked:   uState := DFCS_CHECKED;
      icbGrayed:    uState := DFCS_CHECKED or DFCS_INACTIVE;
    end;
    DrawFrameControl(Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or uState);
  end;
end;

procedure TCheckDBGrid.DrawTitle0;
var
  R: TRect;
  IsChecked: TImpCheckState;
begin
  if MultiSelectCheckbox then
  begin
    R := Rect(0, 0, ColWidths[0], RowHeights[0]);
    if DataLink.Active and (SelectedRows.Count = DataLink.DataSource.DataSet.RecordCount) then
      IsChecked := icbChecked
    else if DataLink.Active and (SelectedRows.Count >= 2) then
      IsChecked := icbGrayed
    else
      IsChecked := icbUnchecked;

    DrawSelCheckbox(R, IsChecked);
  end;
end;

procedure TCheckDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (dgMultiSelect in Options) and MultiSelectCheckbox and DataLink.Active and (MouseCoord(X, Y).X = 0) then
    Shift := Shift + [ssCtrl];

  inherited MouseDown(Button, Shift, X, Y);

  if MultiSelectCheckbox then
    DrawTitle0;
end;

procedure TCheckDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
begin
  inherited MouseUp(Button, Shift, X, Y);
  Cell := MouseCoord(X, Y);
  if MultiSelectCheckbox and (Cell.X=0) and (Cell.Y=0) then
    Title0Clicked;
end;

procedure TCheckDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if MultiSelectCheckbox then
    DrawTitle0;
end;

procedure TCheckDBGrid.SelectAll;
begin
  SelectedRows.Clear;
  with DataLink.DataSource do
  begin
    DataSet.DisableControls;
    try
      DataSet.First;
      while not DataSet.Eof do
      begin
        SelectedRows.CurrentRowSelected := true;
        DataSet.Next;
      end;
    finally
      DataSet.EnableControls;
      DataSet.First;
    end;
  end;
end;

procedure TCheckDBGrid.SetColumnAttributes;
begin
  inherited SetColumnAttributes;
  if (dgIndicator in Options) then
    ColWidths[0] := 24; //IndicatorWidth;
end;

procedure TCheckDBGrid.SetMultiSelectCheckbox(const Value: boolean);
begin
  FMultiSelectCheckbox := Value;
  Invalidate;
end;

procedure TCheckDBGrid.Title0Clicked;
begin
  if not DataLink.Active or not (dgMultiSelect in Options) or not MultiSelectCheckbox then exit;

  if SelectedRows.Count >= 2 then
  begin
    SelectedRows.Clear;
    SelectedRows.CurrentRowSelected := true;
  end
  else
    SelectAll;
  DrawTitle0;
end;

end.