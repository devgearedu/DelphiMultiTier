{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
// Copyright (c) 1995-2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.
{                                                       }
{*******************************************************}

unit DBGridExts;

interface

uses Classes, Types, Grids, DBGrids, SysUtils;

type

  EDBGridExts = class(Exception);
  TGridKeySet = set of char;
  TGridOperation = function (const AGrid: TCustomDBGrid; var Cancel: boolean)
    : boolean of object;

  TDBGridState = record
    Grid: TDBGrid;
    Options: TDBGridOptions;
  end;

  TDBGridList = array of TDBGridState;

  TDBGridExts = class
  private
    class var FTrueKeys: TGridKeySet;
    class var FFalseKeys: TGridKeySet;
    class var FToggleKeys: TGridKeySet;
  protected
    class var FGridList: TDBGridList;
    class function IndexOfGrid(const AGrid: TDBGrid): integer;
    class function FindOptions(const AGrid: TDBGrid): TDBGridOptions;
    class function SaveOptions(const AGrid: TDBGrid): TDBGridOptions;
    class function RestoreOptions(const AGrid: TDBGrid): TDBGridOptions;
    class procedure NoMultiSelect(const AGrid: TDBGrid);

  public
    class property TrueKeys: TGridKeySet read FTrueKeys write FTrueKeys;
    class property FalseKeys: TGridKeySet read FFalseKeys write FFalseKeys;
    class property ToggleKeys: TGridKeySet read FToggleKeys write FToggleKeys;
    class procedure SetCheck(const AGrid: TCustomDBGrid;
      const AToggle: boolean); static;
    class procedure ToggleCheck(const AGrid: TCustomDBGrid); static;
    class procedure CellClick(Column: TColumn); static;
    class procedure ColEnter(Sender: TObject); static;
    class procedure ColExit(Sender: TObject); static;
    class procedure DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState); static;
    class procedure KeyPress(Sender: TObject; var Key: Char); static;
    class function SelectAll(const AGrid: TDBGrid): int64; static;
    class procedure ClearAll(const AGrid: TDBGrid); static;
    class function DoSelection(const AGrid: TDBGrid;
      const AOperation: TGridOperation): int64; static;
{$if DEFINED(CLR)} // it appears class constructors are not available in Win32?
    class constructor Create;
{$ifend}
  end;

implementation

uses DB, Windows, DBCtrls, DBClient;

var
  GridCheck: TDBCheckBox;
const
  DefaultTrueKeys : TGridKeySet = ['Y','y','T','t'];
  DefaultFalseKeys : TGridKeySet = ['N','n','F','f'];
  DefaultToggleKeys : TGridKeySet = [' '];

function GridIterate(       { Run through the selected rows for a grid }
  AGrid : TDBGrid;          { Grid to iterate through }
  Test : TGridOperation;    { Function to call for each iteration }
  SavePos : boolean = true  { Restore dataset position }
  ) : int64;
var
  cds   : TCustomClientDataSet;
  Rows,
  Row : integer;
  Mark : TBookMark;
  DataSet : TDataSet;
  Cancel: boolean;
begin
  cds := nil;
  Result := 0;
  Rows := AGrid.SelectedRows.Count;
  DataSet := AGrid.DataSource.DataSet;
  Cancel := False;
  if SavePos then
    Mark := DataSet.BookMark;
  try
    if DataSet is TCustomClientDataSet then
    begin // Performance tweak - should we skip it?
      cds := TCustomClientDataSet.Create(nil);
      cds.CloneCursor(TCustomClientDataSet(DataSet), False, True);
      DataSet := cds;
    end;
    DataSet.DisableControls;
    if Rows > 0 then
    begin
      for Row := 0 to Rows - 1 do
      begin
        DataSet.BookMark := AGrid.SelectedRows[ Row ];
        if Test(AGrid, Cancel) then
          Inc(Result);
        if Cancel then
          Exit;
       end;
    end
    else if Test(AGrid, Cancel) then
      Inc(Result);
  finally
    if SavePos then
      DataSet.BookMark := Mark;
    DataSet.EnableControls;
    FreeAndNil(cds);
  end;
end; { GridIterate() }

{ TDBGridExts }
class function TDBGridExts.SelectAll(const AGrid: TDBGrid): int64;
var
  save: TBookMark;
  DataSet: TDataSet;
  Selection : TBookmarkList;
begin
  Result := 0;
  if dgMultiSelect in AGrid.Options then
  begin
    DataSet := AGrid.DataSource.DataSet;
    Save := DataSet.BookMark;
    DataSet.DisableControls;
    try
      Selection := AGrid.SelectedRows;
      DataSet.First;
      while not DataSet.Eof do
      begin
        Selection.CurrentRowSelected := True;
        DataSet.Next;
        Inc(Result);
      end;
    finally
      DataSet.BookMark := Save;
      DataSet.EnableControls;
    end;
  end
  else
    NoMultiSelect(AGrid);
end;

class procedure TDBGridExts.SetCheck(const AGrid: TCustomDBGrid;
  const AToggle: boolean);
var
  GridData: TDataSet;
  AutoEdit: boolean;
begin
  if AGrid.SelectedField.DataType = ftBoolean then
  begin
    GridData := AGrid.DataSource.DataSet;
    AutoEdit := not (GridData.State in dsEditModes);
    if AutoEdit then
      GridData.Edit;
    AGrid.SelectedField.AsBoolean := AToggle;
    if AutoEdit then
      GridData.Post;
  end;
end;

class procedure TDBGridExts.ToggleCheck(const AGrid: TCustomDBGrid);
begin
  if AGrid.SelectedField.DataType = ftBoolean then
    SetCheck(AGrid, not AGrid.SelectedField.AsBoolean);
end;

class procedure TDBGridExts.CellClick(Column: TColumn);
begin
  ToggleCheck(Column.Grid);
end;

class procedure TDBGridExts.ClearAll(const AGrid: TDBGrid);
begin
  if dgMultiSelect in AGrid.Options then
    AGrid.SelectedRows.Clear
  else
    NoMultiSelect(AGrid);
end;

class procedure TDBGridExts.ColEnter(Sender: TObject);
var
  Grid: TDBGrid;
begin
  Grid := Sender as TDBGrid;
  if Grid.SelectedField.DataType = ftBoolean then
    Grid.Options := SaveOptions(Grid) - [dgEditing];
end;

class procedure TDBGridExts.ColExit(Sender: TObject);
var
  Grid: TDBGrid;
begin
  Grid := Sender as TDBGrid;
  if Grid.SelectedField.DataType = ftBoolean then
    Grid.Options := FindOptions(Grid);
end;

{$if DEFINED(CLR)}
class constructor TGridExts.Create;
begin
  FTrueKeys := DefaultTrueKeys;
  FFalseKeys := DefaultFalseKeys;
  FToggleKeys := DefaultToggleKeys;
end;
{$ifend}

class function TDBGridExts.DoSelection(const AGrid: TDBGrid;
  const AOperation: TGridOperation): int64;
begin
  Result := GridIterate(AGrid, AOperation, True);
end;

class procedure TDBGridExts.DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
Const
 CtrlState : array[Boolean] of Integer = (DFCS_BUTTONCHECK,
     DFCS_BUTTONCHECK or DFCS_CHECKED);
var
  CheckRect : TRect;
  Grid : TDBGrid;
begin
  if Column.Field.DataType = ftBoolean then
  begin
    Grid := Sender as TDBGrid;
    Grid.Canvas.FillRect(Rect);
    CheckRect.Left := Rect.Left + 2;
    CheckRect.Right := Rect.Right - 2;
    CheckRect.Top := Rect.Top + 2;
    CheckRect.Bottom := Rect.Bottom - 2;
    DrawFrameControl(Grid.Canvas.Handle, CheckRect, DFC_BUTTON,
      CtrlState[Column.Field.AsBoolean]);
  end;
end;

class function TDBGridExts.FindOptions(const AGrid: TDBGrid): TDBGridOptions;
var
  i : integer;
begin
  i := IndexOfGrid(AGrid);
  if i > 0 then
    Result := FGridList[i].Options
  else
    Result := AGrid.Options; // Return what grid currently has if not found
end;

class function TDBGridExts.IndexOfGrid(const AGrid: TDBGrid): integer;
var
  i: integer;
begin
  for I := 0 to Length(FGridList) - 1 do
    if FGridList[I].Grid = AGrid then
    begin
      Result := i;
      exit;
    end;
  Result := -1;
end;

class procedure TDBGridExts.KeyPress(Sender: TObject; var Key: Char);
var
  Grid : TCustomDBGrid;
begin
  if (key = #9) then Exit;
  Grid := Sender as TCustomDBGrid;
  if (Grid.SelectedField.DataType = ftBoolean) then
    if CharInSet(key, ToggleKeys) then ToggleCheck(Grid)
    else if CharInSet(key, TrueKeys) then SetCheck(Grid, True)
    else if CharInSet(key, FalseKeys) then SetCheck(Grid, False)
    else
      Key := #0;
end;

class procedure TDBGridExts.NoMultiSelect(const AGrid: TDBGrid);
begin
  Raise EDBGridExts.CreateFmt('%s %s does not have multi-select enabled',
    [AGrid.ClassName, AGrid.Name]);
end;

class function TDBGridExts.RestoreOptions(const AGrid: TDBGrid): TDBGridOptions;
var
  i: integer;
begin
  i := IndexOfGrid(AGrid);
  if i > 0 then
    Result := FGridList[i].Options
  else
    Result := AGrid.Options;
    
  AGrid.Options := Result;
end;

class function TDBGridExts.SaveOptions(const AGrid: TDBGrid): TDBGridOptions;
var
  i: integer;
begin
  Result := AGrid.Options;
  i := IndexOfGrid(AGrid);
  if i < 0 then
  begin
    i := Length(FGridList); // add grid to dynamic array
    SetLength(FGridList, i + 1);
    FGridList[i].Grid := AGrid;
    FGridList[i].Options := Result;
  end
  else
    FGridList[i].Options := Result;
end;

initialization
begin
  GridCheck := TDBCheckBox.Create(nil);
  TDBGridExts.TrueKeys := DefaultTrueKeys;
  TDBGridExts.FalseKeys := DefaultFalseKeys;
  TDBGridExts.ToggleKeys := DefaultToggleKeys;

end;

finalization

begin
  FreeAndNil(GridCheck);
end;
end.
