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

unit GridNavFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, Grids, DBGrids, ExtCtrls, DBCtrls, ActnList, ImgList, Menus,
  DBXCommon, StdCtrls, System.Actions;

type
  TGridFrame = class(TFrame)
    Navigator: TDBNavigator;
    Grid: TDBGrid;
    DataSource: TDataSource;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActSelectAll: TAction;
    ActClearAll: TAction;
    SelectAll1: TMenuItem;
    Clearall1: TMenuItem;
    ActCountRows: TAction;
    N1: TMenuItem;
    CountRows1: TMenuItem;
    Label1: TLabel;
    ActOpenTable: TAction;
    Opentable1: TMenuItem;
    ActEstimate: TAction;
    Estimate1: TMenuItem;
    procedure GridCellClick(Column: TColumn);
    procedure GridColEnter(Sender: TObject);
    procedure GridColExit(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ActClearAllExecute(Sender: TObject);
    procedure ActSelectAllExecute(Sender: TObject);
    procedure ActSelectAllUpdate(Sender: TObject);
    procedure ActClearAllUpdate(Sender: TObject);
    procedure ActCountRowsUpdate(Sender: TObject);
    procedure ActCountRowsExecute(Sender: TObject);
    procedure ActOpenTableUpdate(Sender: TObject);
    procedure ActOpenTableExecute(Sender: TObject);
    procedure ActEstimateUpdate(Sender: TObject);
    procedure ActEstimateExecute(Sender: TObject);
  private
    { Private declarations }
    FConnection: TDBXConnection;
    FRowField: TField;
    FTableField: TField;
    FRowSizeField: TField;
    FTableSizeField: TField;
    function GetDataSet: TDataSet;
    function ToggleAll(const AToggle: boolean): int64;
    procedure SetDataSet(const Value: TDataSet);
    function CountRows(const AGrid: TCustomDBGrid; var Cancel: boolean): boolean;
    function IsTableDataSet: boolean;
  public
    { Public declarations }
    property DataSet: TDataSet read GetDataSet write SetDataSet;
  end;

implementation

uses DBGridExts, DBXUtils, DBXPumpForm, DBXMigrator, QueryForm, DBXPumpUtils;

{$R *.dfm}

procedure TGridFrame.ActClearAllExecute(Sender: TObject);
begin
  ToggleAll(False);
end;

procedure TGridFrame.ActClearAllUpdate(Sender: TObject);
begin
  ActClearAll.Enabled := Assigned(DataSet) and DataSet.Active;
end;

procedure TGridFrame.ActCountRowsExecute(Sender: TObject);
begin
  FConnection := DBXGetConnection((Owner as TDataPumpForm).SourceDB);
  try
    FRowField := DataSet.FieldByName(SPumpRowCount);
    FTableField := DataSet.FieldByName(SPumpTableName);
    FTableSizeField := DataSet.FieldByName(SPumpTableSize);
    FRowSizeField := DataSet.FieldByName(SPumpRowSize);
    TDBGridExts.DoSelection(Grid, CountRows);
  finally
    FreeAndNil(FConnection);
  end;
end;

function TGridFrame.IsTableDataSet: boolean;
begin
  Result := Assigned(DataSet)
    and Assigned(DataSet.FindField(SPumpRowCount));
end;

procedure TGridFrame.ActCountRowsUpdate(Sender: TObject);
begin
  ActCountRows.Enabled := IsTableDataSet;
end;

procedure TGridFrame.ActEstimateExecute(Sender: TObject);
var
  Mark : TBytes;
  TableSize,
  RowCount,
  Selected: TField;
  Rows,
  Bytes: int64;
begin
  Mark := nil;
  DataSet.DisableControls;
  try
    Mark := DataSet.Bookmark;
    Selected := DataSet.FieldByName(SPumpSelected);
    RowCount := DataSet.FieldByName(SPumpRowCount);
    TableSize := DataSet.FieldByName(SPumpTableSize);
    DataSet.First;
    Rows := 0;
    Bytes := 0;
    while not DataSet.Eof do
    begin
      if Selected.AsBoolean then
      begin
        Rows := Rows + RowCount.AsLargeInt;
        Bytes := Bytes + TableSize.AsLargeInt;
      end;
      DataSet.Next;
    end;
    ShowMessage(Format('Pump estimate: %14.0n rows, Max of %s',
      [Rows + 0.0, SizeInK(Bytes)]));
  finally
    if Assigned(Mark) then
      DataSet.Bookmark := Mark;
    DataSet.EnableControls;
  end;
end;

procedure TGridFrame.ActEstimateUpdate(Sender: TObject);
begin
  ActEstimate.Enabled := IsTableDataSet;
end;

procedure TGridFrame.ActOpenTableExecute(Sender: TObject);
begin
  QueryForm.OpenTable((Owner as TDataPumpForm).SourceDB,
    DataSet.FieldByName(SPumpTableName).AsString);
end;

procedure TGridFrame.ActOpenTableUpdate(Sender: TObject);
begin
  ActOpenTable.Enabled := IsTableDataSet;
end;

procedure TGridFrame.ActSelectAllExecute(Sender: TObject);
begin
  ToggleAll(True);
end;

procedure TGridFrame.ActSelectAllUpdate(Sender: TObject);
begin
  ActSelectAll.Enabled := Assigned(DataSet) and DataSet.Active;
end;

function TGridFrame.CountRows(const AGrid: TCustomDBGrid; var Cancel: boolean)
  : boolean;
var
  AutoEdit: boolean;
begin
  try
    AutoEdit := not (DataSet.State in dsEditModes);
    try
      if AutoEdit then
        DataSet.Edit;
      FRowField.Value := DBXGetRowCount(FConnection, FTableField.asWideString);
      FTableSizeField.Value := FRowField.Value *  FRowSizeField.Value;
    finally
      if AutoEdit then
        DataSet.Post;
    end;
    Result := True;
  except
    Cancel := True;
    Raise;
  end;

end;

function TGridFrame.GetDataSet: TDataSet;
begin
  Result := DataSource.DataSet;
end;

procedure TGridFrame.GridCellClick(Column: TColumn);
begin
  TDBGridExts.CellClick(Column);
end;

procedure TGridFrame.GridColEnter(Sender: TObject);
begin
  TDBGridExts.ColEnter(Sender);
end;

procedure TGridFrame.GridColExit(Sender: TObject);
begin
  TDBGridExts.ColExit(Sender);
end;

procedure TGridFrame.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TDBGridExts.DrawColumnCell(Sender, Rect, DataCol, Column, State);
end;

procedure TGridFrame.GridKeyPress(Sender: TObject; var Key: Char);
begin
  TDBGridExts.KeyPress(Sender, Key);
end;

procedure TGridFrame.SetDataSet(const Value: TDataSet);
begin
  DataSource.DataSet := Value;
end;

function TGridFrame.ToggleAll(const AToggle: boolean): int64;
var
  Mark: TBookmark;
  SelFld: TField;
begin
  Result := 0;
  if Assigned(DataSet) then
    SelFld := DataSet.FieldByName('Selected')
  else
    SelFld := nil;
  if Assigned(SelFld) then
  begin
    Mark := DataSet.Bookmark;
    DataSet.First;
    DataSet.DisableControls;
    try
      while not DataSet.EOF do
      begin
        Inc(Result);
        DataSet.Edit;
        SelFld.AsBoolean := AToggle;
        DataSet.Post;
        DataSet.Next;
      end;

    finally
      DataSet.BookMark := Mark;
      DataSet.EnableControls;
    end;
  end;
end;

end.
