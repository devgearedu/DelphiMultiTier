
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2010 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DBXPumpForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ActnList, ImgList, Menus, ExtActns, CheckLst,
  DBXTypedTableStorage, CommandParser, ExtCtrls, DBCtrls, DB, Grids, DBGrids,
  StdActns, GridNavFrame, DBXCommon, ToolWin, System.Actions;

type
  TDataPumpForm = class(TForm)
    ButtonMigrate: TButton;
    LabelTable: TLabel;
    ProgressTable: TProgressBar;
    LabelRow: TLabel;
    ProgressRow: TProgressBar;
    Label3: TLabel;
    Label4: TLabel;
    ComboSource: TComboBoxEx;
    ActionList1: TActionList;
    ImageList1: TImageList;
    actMigrate: TAction;
    ComboDest: TComboBoxEx;
    cbTest: TCheckBox;
    EditTestRows: TEdit;
    Warnings: TMemo;
    PageControl1: TPageControl;
    TabStatus: TTabSheet;
    PopupMenuTables: TPopupMenu;
    SelectAll1: TMenuItem;
    Clearselection1: TMenuItem;
    ButtonCancel: TButton;
    EditTransRows: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditUpdateTime: TEdit;
    cbVerify: TCheckBox;
    cbOnlyRead: TCheckBox;
    Log: TRichEdit;
    TabSchema: TTabSheet;
    dsSchema: TDataSource;
    cbCountRows: TCheckBox;
    actLoadSchema: TAction;
    TabOptions: TTabSheet;
    ButtonSaveAs: TButton;
    ActSaveOptions: TFileSaveAs;
    PageControl2: TPageControl;
    TabSchemaTables: TTabSheet;
    TabSchemaProcedures: TTabSheet;
    FrameTables: TGridFrame;
    TableColSplitter: TSplitter;
    FrameColumns: TGridFrame;
    FrameProcedures: TGridFrame;
    ColIndexSplitter: TSplitter;
    FrameIndexes: TGridFrame;
    TableFilter: TRadioGroup;
    ViewSource1: TMenuItem;
    Splitter1: TSplitter;
    Script: TDBRichEdit;
    cbAutoInc: TCheckBox;
    Panel1: TPanel;
    FrameProcParams: TGridFrame;
    Splitter2: TSplitter;
    LoadingLabel: TLabel;
    ProcFilter: TRadioGroup;
    ScriptPanel: TPanel;
    ToolBar1: TToolBar;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ActGenScript: TAction;
    ToolButton7: TToolButton;
    PopupMenuEditing: TPopupMenu;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    SelectAll2: TMenuItem;
    Undo1: TMenuItem;
    cbSkipCreate: TCheckBox;
    cbWipeTable: TCheckBox;
    cbIgnoreDefaults: TCheckBox;
    cbMigrateProcedures: TCheckBox;
    btnViewSwitches: TButton;
    cbChunkCopy: TCheckBox;
    cbOnlyNew: TCheckBox;
    ActSchemaOpen: TFileOpen;
    ActSchemaSave: TFileSaveAs;
    Button1: TButton;
    Button2: TButton;
    ButtonLoadSchema: TButton;
    cbFillById: TCheckBox;
    procedure GenerateProcScript(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure ComboSourceSelect(Sender: TObject);
    procedure actMigrateUpdate(Sender: TObject);
    procedure actMigrateExecute(Sender: TObject);
    procedure cbTestClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure cbVerifyClick(Sender: TObject);
    procedure cbOnlyReadClick(Sender: TObject);
    procedure actLoadSchemaUpdate(Sender: TObject);
    procedure actLoadSchemaExecute(Sender: TObject);
    procedure SchemaGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SchemaGridColExit(Sender: TObject);
    procedure SchemaGridKeyPress(Sender: TObject; var Key: Char);
    procedure SchemaGridColEnter(Sender: TObject);
    procedure SchemaGridCellClick(Column: TColumn);
    procedure cbCountRowsClick(Sender: TObject);
    procedure ActSaveOptionsAccept(Sender: TObject);
    procedure TableFilterClick(Sender: TObject);
    procedure FrameColumnsGridDrawColumnCell
      (Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FrameTablesGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FrameIndexesGridDrawColumnCell
      (Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FrameProcParamsGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ProcFilterClick(Sender: TObject);
    procedure BtnGenScriptClick(Sender: TObject);
    procedure ActGenScriptUpdate(Sender: TObject);
    procedure ActGenScriptExecute(Sender: TObject);
    procedure ComboDestSelect(Sender: TObject);
    procedure cbSkipCreateClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnViewSwitchesClick(Sender: TObject);
    procedure cbOnlyNewClick(Sender: TObject);
    procedure cbWipeTableClick(Sender: TObject);
    procedure cbChunkCopyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActSchemaSaveUpdate(Sender: TObject);
    procedure ActSchemaSaveAccept(Sender: TObject);
    procedure cbFillByIdClick(Sender: TObject);
  private
    { Private declarations }
    FCxnList: TStrings;
    FProcParamsGridCompares,
    FColGridCompares, FTableGridCompares, FIndexGridCompares: TStringList;
    FMigrating: Boolean;
    FCountRows: Boolean;
    FCancel: Boolean;
    FCommandLine: TCommandParser;
    FLastSchemaName: string;

    FShowHelp: Boolean;
    FAutoMigrate: Boolean;
    FSaveCaption: string;
    FTableCaption: string;
    FUpdateTick: Cardinal;
    FMigrateTick: Cardinal;
    FTableTick: Cardinal;
    FIndexTick: Cardinal;
    FRowCountTick: Cardinal;
    FRowTick: Cardinal;
    FCommandsProcessed: Boolean;
    FFormCreated: Boolean;
    FDestVendor: string;
    FSchemaFile: string;
    FIncludeTables: string;
    FExcludeTables: string;
    // FGridOptions : TDBGridOptions;
    procedure StatusLine(AReport: string; AddToLog: Boolean = true);
    procedure RowStatus(AReport: string);
    procedure MigrationStarted(ASender: TObject);
    procedure MigrationStopped(ASender: TObject);
    procedure TableMigrationStarted(ASender: TObject;
      ATableName: string; ATableIndex, ATableCount: Integer;
      var ACancel: Boolean);
    procedure TableMigrationStopped(ASender: TObject;
      ATableName: string; ATableIndex, ATableCount: Integer;
      var ACancel: Boolean);
    procedure ProcMigrationStarted(ASender: TObject;
      AProcName: string; AProcIndex, AProcCount: Integer;
      var ACancel: Boolean);
    procedure ProcMigrationStopped(ASender: TObject;
      AProcName: string; AProcIndex, AProcCount: Integer;
      var ACancel: Boolean);
    procedure RowCountingStarted(ASender: TObject; ATableName: string;
      ATableIndex, ATableCount: Integer; var ACancel: Boolean);
    procedure RowCountingStopped(ASender: TObject; ATableName: string;
      ATableIndex, ATableCount: Integer; var ACancel: Boolean);
    procedure IndexingStarted(ASender: TObject; ATableName: string;
      ATableIndex, ATableCount: Integer; var ACancel: Boolean);
    procedure IndexingStopped(ASender: TObject; ATableName: string;
      ATableIndex, ATableCount: Integer; var ACancel: Boolean);
    procedure RowCopied(ASender: TObject; ATableName: string;
      ARowIndex, ARowCount: Int64; var ACancel: Boolean);
    procedure ColumnWarning(ASender: TObject; ATableName, AColumnName,
      AWarning: string);
    procedure LogMessage(ASender: TObject; AMessage: string);
    procedure ShowDeltaCols(Grid: TDBGrid; Comparisons: TStringList;
      const Rect: TRect; const DataCol: Integer; Column: TColumn;
      const State: TGridDrawState);
    procedure SelectSourceConnection;
    procedure LoadSourceSchema;
    procedure FreeSchema;
    //function SourceSchemaMissing: Boolean;
    procedure InitCommandLine;
    procedure DisplayHelp;
    function GetDestDB: string;
    function GetExcludeTables: string;
    function GetIncludeTables: string;
    function GetSourceDB: string;
    procedure SetDestDB(const Value: string);
    procedure ToggleAllTables(const AToggle: Boolean = true);
    procedure SetExcludeTables(const Value: string);
    procedure SetIncludeTables(const Value: string);
    procedure SetSourceDB(const Value: string);
    function GetTesting: Boolean;
    function GetTestRows: Int64;
    function GetTransRows: Int64;
    function GetUpdateTime: Int64;
    procedure SetTesting(const Value: Boolean);
    procedure SetTestRows(const Value: Int64);
    procedure SetTransRows(const Value: Int64);
    procedure SetUpdateTime(const Value: Int64);
    function GetVerify: Boolean;
    procedure SetVerify(const Value: Boolean);
    function GetOnlyRead: Boolean;
    procedure SetOnlyRead(const Value: Boolean);
    procedure LogEntry(AReport: string);
    function GetCountRows: Boolean;
    procedure SetCountRows(const Value: Boolean);
    procedure SetTableFilter;
    procedure SetProcFilter;
    function GetLastSchemaName: string;
    procedure SetLastSchemaName(const Value: string);
    function GetSkipCreate: Boolean;
    procedure SetSkipCreate(const Value: Boolean);
    function GetAutoInc: Boolean;
    procedure SetAutoInc(const Value: Boolean);
    function GetWipeTable: Boolean;
    procedure SetWipeTable(const Value: Boolean);
    function GetIgnoreDefaults: Boolean;
    procedure SetIgnoreDefaults(const Value: Boolean);
    function GetMigrateProcs: boolean;
    procedure SetMigrateProcs(const Value: boolean);
    function GetChunkCopy: Boolean;
    procedure SetChunkCopy(const Value: Boolean);
    function GetOnlyNew: Boolean;
    procedure SetOnlyNew(const Value: Boolean);
    function GetSchemaFile: string;
    procedure SetSchemaFile(const Value: string);
    function HideNestedDataSet(const AFieldName: string;
      Parent: TDataSet = nil): TDataSet;
    function GetFillById: boolean;
    procedure SetFillById(const Value: boolean);
    procedure WriteLog;
    property LastSchemaName: string read GetLastSchemaName write
      SetLastSchemaName;
    procedure SetTypeDropDowns;
    procedure LoadOrBuildSchema(Conn: TDBXConnection);
    procedure SaveSchemaFile;

  public
    { Public declarations }
    procedure Migrate(const ASource, ADest: string);

  published
    property AutoMigrate: Boolean read FAutoMigrate write FAutoMigrate;
    property SourceDB: string read GetSourceDB write SetSourceDB;
    property DestDB: string read GetDestDB write SetDestDB;
    property IncludeTables: string read GetIncludeTables write
      SetIncludeTables;
    property ExcludeTables: string read GetExcludeTables write
      SetExcludeTables;
    property ShowHelp: Boolean read FShowHelp write FShowHelp;
    property UpdateTime: Int64 read GetUpdateTime write SetUpdateTime;
    property TransRows: Int64 read GetTransRows write SetTransRows;
    property Testing: Boolean read GetTesting write SetTesting;
    property TestRows: Int64 read GetTestRows write SetTestRows;
    property Verify: Boolean read GetVerify write SetVerify;
    property AutoInc: Boolean read GetAutoInc write SetAutoInc;
    property ChunkCopy: Boolean read GetChunkCopy write SetChunkCopy;
    property OnlyRead: Boolean read GetOnlyRead write SetOnlyRead;
    property OnlyNew: Boolean read GetOnlyNew write SetOnlyNew;
    property CountRows: Boolean read GetCountRows write SetCountRows;
    property SkipCreate: Boolean read GetSkipCreate write SetSkipCreate;
    property WipeTable: Boolean read GetWipeTable write SetWipeTable;
    property IgnoreDefaults: Boolean read GetIgnoreDefaults write SetIgnoreDefaults;
    property MigrateProcs: boolean read GetMigrateProcs write SetMigrateProcs;
    property SchemaFile: string read GetSchemaFile write SetSchemaFile;
    property FillById: boolean read GetFillById write SetFillById;
  end;

var
  DataPumpForm: TDataPumpForm;

implementation

uses
  DBXUtils, DBXMigrator, DateUtils, DBClient,
  DBXMetaDataProvider, DBXCommonResStrs,
  DBXMetadataReader, DBXMetaDataNames, DBXCommonTable, DBGridExts, DBXPumpUtils;
{$R *.dfm}

const
  DeltaColor = clSkyBlue;

function FindColumn(ACols: TDBGridColumns; const AName: string): TColumn;
var
  i: Integer;
begin
  for i := 0 to ACols.Count - 1 do
    if ACols[i].FieldName = AName then
    begin
      Result := ACols[i];
      exit;
    end;
  Result := nil;
end;

procedure SetGridColsReadOnly(ACols: TDBGridColumns; AToggle: Boolean;
  AExceptNames: string = '');
var
  i: Integer;
  Vals: TStrings;
  col: TColumn;
begin
  Vals := TStringList.Create;
  try
    Vals.CommaText := AExceptNames;
    for i := 0 to ACols.Count - 1 do
    begin
      col := ACols[i];
      if Vals.IndexOf(col.FieldName) = -1 then
        col.ReadOnly := AToggle
      else
        col.ReadOnly := not AToggle;
    end;
  finally
    FreeAndNil(Vals);
  end;
end;

procedure TDataPumpForm.ActGenScriptExecute(Sender: TObject);
begin
  GenerateProcScript(FrameProcedures.DataSet);
end;

procedure TDataPumpForm.ActGenScriptUpdate(Sender: TObject);
begin
  ActGenScript.Enabled := Assigned(FrameProcedures.DataSet);
end;

procedure TDataPumpForm.actLoadSchemaExecute(Sender: TObject);
begin
  LastSchemaName := '';
  if FileExists(SchemaFile) then
    DeleteFile(SchemaFile);
  LoadSourceSchema;
end;

procedure TDataPumpForm.actLoadSchemaUpdate(Sender: TObject);
begin
  actLoadSchema.Enabled := Length(SourceDB) > 0;
end;

procedure TDataPumpForm.actMigrateExecute(Sender: TObject);
begin
  Migrate(ComboSource.Items[ComboSource.ItemIndex],
    ComboDest.Items[ComboDest.ItemIndex]);
end;

procedure TDataPumpForm.actMigrateUpdate(Sender: TObject);
begin
  actMigrate.Enabled := (not FMigrating) and (ComboDest.ItemIndex > -1) and
    (ComboSource.ItemIndex > -1) and (UpdateTime > -1) and (TransRows > -1) and
    (TestRows > -1);
end;

procedure TDataPumpForm.BtnGenScriptClick(Sender: TObject);
begin
  GenerateProcScript(FrameProcedures.DataSet);
end;

procedure TDataPumpForm.btnViewSwitchesClick(Sender: TObject);
begin
  ShowMessage(FCommandLine.HelpText);
end;

procedure TDataPumpForm.ButtonCancelClick(Sender: TObject);
begin
  FCancel := true;
end;

procedure TDataPumpForm.GenerateProcScript(DataSet: TDataSet);
begin
  DataSet.Edit;
  DataSet.FieldByName(SPumpProcScript).AsString :=
    TDBXMigrator.ProcedureScript(FDestVendor, DataSet);
  DataSet.Post;
end;

procedure TDataPumpForm.cbChunkCopyClick(Sender: TObject);
begin
  ChunkCopy := cbChunkCopy.Checked;
end;

procedure TDataPumpForm.cbCountRowsClick(Sender: TObject);
begin
  FCountRows := cbCountRows.Checked;
end;

procedure TDataPumpForm.cbOnlyNewClick(Sender: TObject);
begin
  OnlyNew := cbOnlyNew.Checked;
end;

procedure TDataPumpForm.cbOnlyReadClick(Sender: TObject);
begin
  if OnlyRead then
  begin
    OnlyNew := False;
    WipeTable := False;
  end;
end;

procedure TDataPumpForm.cbFillByIdClick(Sender: TObject);
begin
  FillById := cbFillById.Checked;
end;

procedure TDataPumpForm.cbSkipCreateClick(Sender: TObject);
begin
  if SkipCreate then
    WipeTable := False;
end;

procedure TDataPumpForm.cbTestClick(Sender: TObject);
begin
  // EditTestRows.Enabled := cbTest.Checked or cbChunkCopy.Checked;
end;

procedure TDataPumpForm.cbVerifyClick(Sender: TObject);
begin
  cbOnlyRead.Enabled := not (cbVerify.Checked or cbChunkCopy.Checked);
end;

procedure TDataPumpForm.cbWipeTableClick(Sender: TObject);
begin
  if WipeTable then
  begin
    OnlyRead := False;
    OnlyNew := False;
  end;
end;

procedure TDataPumpForm.MigrationStarted(ASender: TObject);
begin
  { This is where we could create a structure for all tables in DB to record
    recordcount and record size to give a better overall progress bar for table
    copying. Call it "known size" or something like that. Record the amount of
    time required to copy each table over so rps can be calculated per table,
    and overall byte size per table can be recorded as well }
  LogEntry(Format('Migrating tables %s from %s to %s', [IncludeTables,
      SourceDB, DestDB]));
  FMigrateTick := GetTickCount;
  StatusLine(Format('Migration started at %s...', [DateTimeToStr(Now)]));
  ButtonCancel.Enabled := true;
  cbTest.Enabled := False;
  // EditTestRows.Enabled := False;
end;

procedure TDataPumpForm.ColumnWarning(ASender: TObject;
  ATableName, AColumnName, AWarning: string);
begin
  Warnings.Lines.Add(Format('%s.%s:%s', [ATableName, AColumnName, AWarning]));
end;

procedure TDataPumpForm.ComboDestSelect(Sender: TObject);
begin
  DestDB := ComboDest.Items[ComboDest.ItemIndex];
end;

procedure TDataPumpForm.ComboSourceSelect(Sender: TObject);
begin
  LastSchemaName := '';
  SelectSourceConnection;
  PageControl1.ActivePage := TabSchema;
end;

procedure TDataPumpForm.ActSaveOptionsAccept(Sender: TObject);
begin
  FCommandLine.SaveOptions(ActSaveOptions.Dialog.FileName);
end;

procedure TDataPumpForm.ActSchemaSaveAccept(Sender: TObject);
begin
  SchemaFile := ActSchemaSave.Dialog.FileName;
  SaveSchemaFile;
end;

procedure TDataPumpForm.ActSchemaSaveUpdate(Sender: TObject);
begin
  ActSchemaSave.Enabled := Assigned(dsSchema.DataSet)
    and dsSchema.DataSet.Active;
  if (ActSchemaSave.Enabled and (Length(ActSchemaSave.Dialog.FileName) = 0)) then
  begin
    ActSchemaSave.Dialog.InitialDir := ExtractFilePath(SchemaFile);
    ActSchemaSave.Dialog.FileName := SchemaFile;
  end;

end;

function Pair(first, second: string): string;
begin
  Result := first + '=' + second + ',' + second + '=' + first;
end;

procedure TDataPumpForm.FormActivate(Sender: TObject);
begin
  if not FCommandsProcessed then
  begin
    FCommandsProcessed := True;
    if (not FCommandLine.ProcessCommandLine) or ShowHelp then
      DisplayHelp;
    if FAutoMigrate then
      actMigrate.Execute;
  end;
end;

procedure TDataPumpForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveSchemaFile;
end;

procedure TDataPumpForm.FormCreate(Sender: TObject);
begin
  if not FFormCreated then
  begin
    { TODO : Figure out why FormCreate is being called twice }
    FFormCreated := True;
    LastSchemaName := '';
    FIncludeTables := '';
    FExcludeTables := '';
    ActSaveOptions.Dialog.InitialDir := ExtractFilePath(Application.ExeName);
    FSaveCaption := Caption;
    FCxnList := DBXGetConnectionList;
    ComboSource.Items.Assign(FCxnList);
    FCountRows := cbCountRows.Checked;
    FColGridCompares := TStringList.Create;
    FColGridCompares.CommaText := Pair(SPumpSize, SPumpDestSize) + ',' + Pair
      (SPumpScale, SPumpDestScale) + ',' + Pair(SPumpColumnName, SPumpDestName)
      + ',' + Pair(SPumpTypeName, SPumpDestType) + ',' + Pair
      (SPumpPrecision, SPumpDestPrecision);
    FTableGridCompares := TStringList.Create;
    FTableGridCompares.CommaText := Pair(SPumpTableName, SPumpDestName);
    FIndexGridCompares := TStringList.Create;
    FIndexGridCompares.CommaText := Pair(SPumpIndexName, SPumpDestName);
    FProcParamsGridCompares := TStringList.Create;
    FProcParamsGridCompares.CommaText := Pair(SPumpParameter, SPumpDestName)
      + ',' + Pair(SPumpPrecision, SPumpDestPrecision)
      + ',' + Pair(SPumpTypeName, SPumpDestType);
    InitCommandLine;
  end;
end;

procedure TDataPumpForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCxnList);
  FreeAndNil(FCommandLine);
  FreeAndNil(FColGridCompares);
  FreeAndNil(FTableGridCompares);
  FreeAndNil(FIndexGridCompares);
end;

procedure TDataPumpForm.FrameColumnsGridDrawColumnCell
  (Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  FrameColumns.GridDrawColumnCell(Sender, Rect, DataCol, Column, State);
  ShowDeltaCols(Sender as TDBGrid, FColGridCompares, Rect, DataCol, Column,
    State);
end;

procedure TDataPumpForm.FrameIndexesGridDrawColumnCell
  (Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  FrameIndexes.GridDrawColumnCell(Sender, Rect, DataCol, Column, State);
  ShowDeltaCols(Sender as TDBGrid, FIndexGridCompares, Rect, DataCol, Column,
    State);
end;

procedure TDataPumpForm.FrameProcParamsGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  FrameProcParams.GridDrawColumnCell(Sender, Rect, DataCol, Column, State);
  ShowDeltaCols(Sender as TDBGrid, FProcParamsGridCompares, Rect, DataCol, Column,
    State);

end;

procedure TDataPumpForm.FrameTablesGridDrawColumnCell
  (Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  FrameTables.GridDrawColumnCell(Sender, Rect, DataCol, Column, State);
  ShowDeltaCols(Sender as TDBGrid, FTableGridCompares, Rect, DataCol, Column,
    State);
end;

procedure TDataPumpForm.FreeSchema;
var
  Schema: TDataSet;
begin
  Schema := dsSchema.DataSet;
  dsSchema.DataSet := nil;
  FrameTables.DataSet := nil;
  FrameColumns.DataSet := nil;
  FrameProcedures.DataSet := nil;
  FrameProcParams.DataSet := nil;
  FrameIndexes.DataSet := nil;
  FreeAndNil(Schema);
end;

function TDataPumpForm.GetAutoInc: Boolean;
begin
  Result := cbAutoInc.Checked;
end;

function TDataPumpForm.GetChunkCopy: Boolean;
begin
  Result := cbChunkCopy.Checked;
end;

function TDataPumpForm.GetCountRows: Boolean;
begin
  Result := FCountRows;
end;

function TDataPumpForm.GetDestDB: string;
var
  i: Integer;
begin
  i := ComboDest.ItemIndex;
  if i > 0 then
    Result := ComboDest.Items[i]
  else
    Result := '';
end;

function TDataPumpForm.GetExcludeTables: string;
begin
  Result := ArrayToList(DataSetToArray(FrameTables.DataSet, SPumpTableName,
      SPumpSelected + '=False'));
end;

function TDataPumpForm.GetIgnoreDefaults: Boolean;
begin
  Result := cbIgnoreDefaults.Checked;
end;

function TDataPumpForm.GetIncludeTables: string;
begin
  Result := ArrayToList(DataSetToArray(FrameTables.DataSet, SPumpTableName,
      SPumpSelected + '=True and ' + SPumpTableType + '=''' + SPumpStandardTable + ''''));
end;

function TDataPumpForm.GetLastSchemaName: string;
begin
  Result := FLastSchemaName;
end;

function TDataPumpForm.GetMigrateProcs: boolean;
begin
  Result := cbMigrateProcedures.Checked;
end;

function TDataPumpForm.GetOnlyNew: Boolean;
begin
  Result := cbOnlyNew.Checked;
end;

function TDataPumpForm.GetOnlyRead: Boolean;
begin
  Result := cbOnlyRead.Checked;
end;

function TDataPumpForm.GetFillById: boolean;
begin
  Result := cbFillById.Checked;
end;

function TDataPumpForm.GetSchemaFile: string;
begin
  if (Length(FSchemaFile) = 0) and (Length(SourceDB) > 0) then
    FSchemaFile := AppDataFolder + SourceDB + '.cds';
  Result := FSchemaFile;
end;

function TDataPumpForm.GetSkipCreate: Boolean;
begin
  Result := cbSkipCreate.Checked;
end;

function TDataPumpForm.GetSourceDB: string;
var
  i: Integer;
begin
  i := ComboSource.ItemIndex;
  if i > 0 then
    Result := ComboSource.Items[i]
  else
    Result := '';
end;

function TDataPumpForm.GetTesting: Boolean;
begin
  Result := cbTest.Checked;
end;

function TDataPumpForm.GetTestRows: Int64;
begin
  Result := StrToInt64Def(EditTestRows.Text, 100);
end;

function TDataPumpForm.GetTransRows: Int64;
begin
  Result := StrToInt64Def(EditTransRows.Text, 100000);
end;

function TDataPumpForm.GetUpdateTime: Int64;
begin
  Result := StrToInt64Def(EditUpdateTime.Text, 15);
  FUpdateTick := Result * MSecsPerSec;
end;

function TDataPumpForm.GetVerify: Boolean;
begin
  Result := cbVerify.Checked;
end;

function TDataPumpForm.GetWipeTable: Boolean;
begin
  Result := cbWipeTable.Checked;
end;

procedure TDataPumpForm.IndexingStarted(ASender: TObject;
  ATableName: string; ATableIndex, ATableCount: Integer;
  var ACancel: Boolean);
var
  s: string;
begin
  s := TableCaption(ATableName, ATableIndex, ATableCount);
  StatusLine('Indexing ' + s, False);
  FTableCaption := FSaveCaption + ':' + s;
  Caption := FTableCaption;
  FIndexTick := GetTickCount;
  Application.ProcessMessages;
  ACancel := FCancel;
end;

procedure TDataPumpForm.IndexingStopped(ASender: TObject;
  ATableName: string; ATableIndex, ATableCount: Integer;
  var ACancel: Boolean);
begin
  StatusLine(TableCaption(ATableName, ATableIndex + 1, ATableCount)
      + TicksToTime(GetTickCount - FIndexTick), False);
  Application.ProcessMessages;
  ACancel := FCancel;
end;

procedure TDataPumpForm.InitCommandLine;
const
  YN: array [Boolean] of string = ('off', 'on');
begin
  FCommandLine := TCommandParser.Create(Self, False, Application.Title,
    'dbxpump'); // Do not translate
  FCommandLine.AddSwitch('h', stBoolean, False, YN[ShowHelp],
    'Show this help page', 'help', 'ShowHelp');
  FCommandLine.AddSwitch('t', stBoolean, False, YN[Testing], 'Test mode',
    'Testing', 'Testing');
  FCommandLine.AddSwitch('tr', stInteger, False, IntToStr(TestRows),
    'Testing rows', 'TestRows', 'TestRows');
  FCommandLine.AddSwitch('c', stBoolean, False, YN[CountRows],
    'Count table rows so progress can be displayed', 'Count', 'CountRows');
  FCommandLine.AddSwitch('f', stString, False, '',
    'Schema file name', 'SchemaFile', 'SchemaFile');
  FCommandLine.AddSwitch('s', stString, False, '', 'Source connection',
    'SourceDB', 'SourceDB');
  FCommandLine.AddSwitch('d', stString, False, '', 'Destination connection',
    'DestDB', 'DestDB');
  FCommandLine.AddSwitch('i', stString, False, '', 'List of tables to include',
    'include', 'IncludeTables');
  FCommandLine.AddSwitch('x', stString, False, '', 'List of tables to exclude',
    'exclude', 'ExcludeTables');
  FCommandLine.AddSwitch('u', stInteger, False, IntToStr(UpdateTime),
    'Update every [x] seconds', 'UpdateTime', 'UpdateTime');
  FCommandLine.AddSwitch('r', stInteger, False, IntToStr(TransRows),
    'Rows per transaction', 'TransRows', 'TransRows');
  FCommandLine.AddSwitch('v', stBoolean, False, YN[Verify], 'Verify data copy',
    'Verify', 'Verify');
  FCommandLine.AddSwitch('o', stBoolean, False, YN[OnlyRead],
    'Only read from source, don''t write to destination', 'OnlyRead', 'OnlyRead');
  FCommandLine.AddSwitch('b', stBoolean, False, YN[FillById],
    'Fill in missing records by ID in eligible destination tables', 'FillById', 'FillById');
  FCommandLine.AddSwitch('n', stBoolean, False, YN[OnlyNew],
    'Only copy new records from source', 'OnlyNew', 'OnlyNew');
  FCommandLine.AddSwitch('k', stBoolean, False, YN[ChunkCopy],
    'Copy records in chunks of test rows size', 'ChunkCopy', 'ChunkCopy');
  FCommandLine.AddSwitch('sk', stBoolean, False, YN[SkipCreate],
    'Skip metadata creation for existing destination tables',
    'SkipCreate', 'SkipCreate');
  FCommandLine.AddSwitch('w', stBoolean, False, YN[SkipCreate],
    'Wipe destination table data before migrating data',
    'wipe', 'WipeTable');
  FCommandLine.AddSwitch('ai', stBoolean, False, YN[AutoMigrate],
    'Migrate auto-increment as auto-increment', 'ai', 'AutoInc');
  FCommandLine.AddSwitch('ig', stBoolean, False, YN[IgnoreDefaults],
    'Ignore default values in source connection', 'ignore', 'IgnoreDefaults');
  FCommandLine.AddSwitch('mp', stBoolean, False, YN[MigrateProcs],
    'Migrate procedures', 'migrateprocs', 'MigrateProcs');
  FCommandLine.AddSwitch('a', stBoolean, False, YN[AutoMigrate],
    'Automatically start migration', 'auto', 'AutoMigrate');
end;

procedure TDataPumpForm.MigrationStopped(ASender: TObject);
begin
  StatusLine(Format('Migration completed in %s',
      [TicksToTime(GetTickCount - FMigrateTick)]));
  StatusLine(Format('Migration stopped at %s', [DateTimeToStr(Now)]));
  ButtonCancel.Enabled := False;
  cbTest.Enabled := true;
  // EditTestRows.Enabled := cbTest.Checked or cbChunkCopy.Checked;
end;

procedure TDataPumpForm.ProcFilterClick(Sender: TObject);
begin
  SetProcFilter;
end;

procedure TDataPumpForm.ProcMigrationStarted(ASender: TObject;
  AProcName: string; AProcIndex, AProcCount: Integer;
  var ACancel: Boolean);
var
  s: string;
begin
  s := ProcCaption(AProcName, AProcIndex, AProcCount);
  StatusLine(s);
  FTableCaption := FSaveCaption + ':' + s;
  Caption := FTableCaption;
  FTableTick := GetTickCount;
  FRowTick := GetTickCount; // Used for timing row update
  Application.ProcessMessages;
  ACancel := FCancel;
end;

procedure TDataPumpForm.ProcMigrationStopped(ASender: TObject;
  AProcName: string; AProcIndex, AProcCount: Integer;
  var ACancel: Boolean);
var
  k: Integer;
begin
  { TODO : Create CDS Grid to track and display procedure migration progress }
  StatusLine(ProcCaption(AProcName, AProcIndex + 1, AProcCount), False);
  k := Log.Lines.Count - 1;
  Log.Lines[k] := Log.Lines[k] + LabelRow.Caption + TicksToTime
    (GetTickCount - FTableTick);
  ProgressTable.Max := AProcCount - 1;
  ProgressTable.Position := AProcIndex;
  Application.ProcessMessages;
  ACancel := FCancel;
end;

procedure TDataPumpForm.TableMigrationStarted(ASender: TObject;
  ATableName: string; ATableIndex, ATableCount: Integer;
  var ACancel: Boolean);
var
  s: string;
begin
  s := TableCaption(ATableName, ATableIndex, ATableCount);
  StatusLine(s);
  FTableCaption := FSaveCaption + ':' + s;
  Caption := FTableCaption;
  FTableTick := GetTickCount;
  FRowTick := GetTickCount; // Used for timing row update
  Application.ProcessMessages;
  ACancel := FCancel;
end;

procedure TDataPumpForm.TableMigrationStopped(ASender: TObject;
  ATableName: string; ATableIndex, ATableCount: Integer;
  var ACancel: Boolean);
var
  k: Integer;
begin
  { TODO : Create CDS Grid to track and display table migration progress }
  StatusLine(TableCaption(ATableName, ATableIndex + 1, ATableCount), False);
  k := Log.Lines.Count - 1;
  Log.Lines[k] := Log.Lines[k] + LabelRow.Caption + TicksToTime
    (GetTickCount - FTableTick);
  ProgressTable.Max := ATableCount - 1;
  ProgressTable.Position := ATableIndex;
  Application.ProcessMessages;
  ACancel := FCancel;
end;

procedure TDataPumpForm.RowCountingStarted(ASender: TObject;
  ATableName: string; ATableIndex, ATableCount: Integer;
  var ACancel: Boolean);
var
  s: string;
begin
  s := TableCaption(ATableName, ATableIndex, ATableCount);
  StatusLine('Counting ' + s);
  FTableCaption := FSaveCaption + ':' + s;
  Caption := FTableCaption;
  FRowCountTick := GetTickCount;
  Application.ProcessMessages;
  ACancel := FCancel;
end;

procedure TDataPumpForm.RowCountingStopped(ASender: TObject;
  ATableName: string; ATableIndex, ATableCount: Integer;
  var ACancel: Boolean);
var
  k: Integer;
begin
  { TODO : Create CDS Grid to track and display table migration progress }
  StatusLine(TableCaption(ATableName, ATableIndex + 1, ATableCount), False);
  k := Log.Lines.Count - 1;
  Log.Lines[k] := Log.Lines[k] + TicksToTime(GetTickCount - FRowCountTick);
  Application.ProcessMessages;
  ACancel := FCancel;
end;

procedure TDataPumpForm.StatusLine(AReport: string;
  AddToLog: Boolean = true);
begin
  LabelTable.Caption := AReport;
  if AddToLog then
    LogEntry(AReport);
end;

procedure TDataPumpForm.ToggleAllTables(const AToggle: Boolean = true);
begin
  CheckDataSetRequest(FrameTables.DataSet, 'Toggle All');
  ToggleDataSet(FrameTables.DataSet, SPumpTableName, SPumpSelected, nil,
    AToggle);
end;

procedure TDataPumpForm.RowStatus(AReport: string);
begin
  LabelRow.Caption := AReport;
  // Log.Lines.Add(AReport);
end;

procedure TDataPumpForm.TableFilterClick(Sender: TObject);
begin
  SetTableFilter;
end;

procedure TDataPumpForm.RowCopied(ASender: TObject; ATableName: string;
  ARowIndex, ARowCount: Int64; var ACancel: Boolean);
var
  rps, ttc, etc, Lapse: double;
  tick: Cardinal;
  Estimate, perc: string;

begin
  tick := GetTickCount - FRowTick;
  if (ARowIndex = 1) or (tick > FUpdateTick) or
    (FCountRows and (ARowIndex >= ARowCount - 1)) or
    (Testing and (ARowIndex >= TestRows - 1)) then
  begin
    FRowTick := GetTickCount; // Reset timer
    if FCountRows then
    begin
      ProgressRow.Max := ARowCount;
      ProgressRow.Position := ARowIndex;
    end;
    tick := GetTickCount - FTableTick;
    Lapse := tick / MSecsPerSec;
    if Lapse > 0 then
    begin
      rps := ARowIndex / Lapse;
      if FCountRows and (rps > 0) then
      begin
        ttc := ARowCount / rps;
        etc := (ARowCount - ARowIndex ) / rps;
        Estimate := Format(', ttc: %s, etc: %s',
          [ TicksToTime(trunc(ttc * MSecsPerSec)),
            TicksToTime(trunc(etc * MSecsPerSec)) ]
          );
        perc := Format(' %.2f%%', [ARowIndex / ARowCount * 100]);
      end
      else
      begin
        Estimate := '';
        perc := '';
      end;
    end
    else
    begin
      rps := 0;
      Estimate := '';
      perc := '';
    end;
    RowStatus(Format('row:%d/%d (rps:%f%s)%s', [ARowIndex, ARowCount + 1, rps,
        Estimate, perc]));
    Caption := FTableCaption + perc;
    Application.ProcessMessages;
    ACancel := FCancel;
  end;

end;

procedure TDataPumpForm.Migrate(const ASource, ADest: string);
var
  Migrator: TDBXMigrator;
begin
  FCancel := False;
  // if SourceSchemaMissing then
  // LoadSourceSchema;
  PageControl1.ActivePage := TabStatus;
  // if cbFresh.Checked then
  // DeleteFile(DBXGetDatabaseName(ADest));
  Migrator := TDBXMigrator.Create(ASource, ADest, CountRows);
  try
    if Testing then
    begin
      Migrator.MaxRows := TestRows;
      if TestRows <= 5 then
        Migrator.TransRows := TestRows
      else
        Migrator.TransRows := Migrator.MaxRows div 5;
    end
    else
      Migrator.TransRows := TransRows;
    Migrator.OnlyRead := OnlyRead;
    Migrator.OnlyNew := OnlyNew;
    Migrator.FillById := FillById;
    Migrator.ChunkCopy := ChunkCopy;
    if ChunkCopy then
      Migrator.ChunkRows := TestRows;
    Migrator.SkipCreateTable := SkipCreate;
    Migrator.WipeTable := WipeTable;
    Migrator.MigrateProcs := MigrateProcs;
    Migrator.OnMigrationStarted := MigrationStarted;
    Migrator.OnMigrationStopped := MigrationStopped;
    Migrator.OnTableMigrationStarted := TableMigrationStarted;
    Migrator.OnTableMigrationStopped := TableMigrationStopped;
    Migrator.OnProcMigrationStarted := ProcMigrationStarted;
    Migrator.OnProcMigrationStopped := ProcMigrationStopped;
    Migrator.OnRowCopied := RowCopied;
    Migrator.OnColumnWarning := ColumnWarning;
    Migrator.OnLogMessage := LogMessage;
    Migrator.OnIndexingStarted := IndexingStarted;
    Migrator.OnIndexingStopped := IndexingStopped;
    Migrator.OnRowCountStarted := RowCountingStarted;
    Migrator.OnRowCountStopped := RowCountingStopped;

    FMigrating := true;
    Migrator.Migrate(dsSchema.DataSet);
    if (not OnlyRead) and Verify then
      { TODO : Run verification }
      ;
  finally
    FreeAndNil(Migrator);
    FCancel := False;
    ButtonCancel.Enabled := False;
    cbTest.Enabled := true;
    // EditTestRows.Enabled := cbTest.Checked or cbChunkCopy.Checked;
    FMigrating := False;
    if FAutoMigrate then
    begin
      WriteLog;
      Self.Close;
    end;
  end;
end;

procedure TDataPumpForm.WriteLog;
//var
//  LogFile: string;
//  content: TStringList;
begin
  WriteLn(Log.Text);
//  LogFile := AppDataFolder + ExtractFileName(Application.ExeName) + '.log';
//  content := TStringList.Create;
//  try
//    if FileExists(LogFile) then
//      content.LoadFromFile(LogFile);
//    content.Text := content.Text + Log.Text + #13#10;
//    content.SaveToFile(LogFile);
//  finally
//    FreeAndNil(content);
//  end;
end;

procedure TDataPumpForm.SaveSchemaFile;
begin
  if Assigned(dsSchema.DataSet) and (Length(SchemaFile) > 0) then
    (dsSchema.DataSet as TClientDataSet).SaveToFile(SchemaFile);
end;

procedure TDataPumpForm.LoadOrBuildSchema(Conn: TDBXConnection);
var
  Schema: TDBXMigratorSchema;
  cds: TClientDataSet;
begin
  if FileExists(SchemaFile) then
  begin
    cds := TClientDataSet.Create(nil);
    cds.LoadFromFile(SchemaFile);
    dsSchema.DataSet := cds;
    if CountRows then
    begin
      FrameTables.DataSet := HideNestedDataSet(SPumpTables);
      FrameTables.ActCountRowsExecute(FrameTables);
    end;
  end
  else
  begin
    Schema := TDBXMigratorSchema.Create(Conn, CountRows);
    try
      Schema.AllowAutoInc := AutoInc;
      Schema.IgnoreDefaults := IgnoreDefaults;
      Schema.OnLogMessage := LogMessage;
      dsSchema.DataSet := Schema.GetSchema;
    finally
      FreeAndNil(Schema);
    end;
  end;
end;

procedure TDataPumpForm.SetTypeDropDowns;
var
  Types: TStrings;
  Conn : TDBXConnection;
begin
  if Length(DestDB) > 0 then
    Conn := DBXGetConnection(DestDB)
  else
    Conn := DBXGetConnection(SourceDB);
  FDestVendor := Conn.ProductName;
  try
    Types := DBXGetDataTypes(Conn);
    FindColumn(FrameColumns.Grid.Columns, SPumpDestType).PickList := Types;
  finally
    Conn.Free;
  end;
end;

procedure TDataPumpForm.SetSchemaFile(const Value: string);
begin
  if FSchemaFile <> Value then
  begin
    FSchemaFile := Value;
    if Length(FSchemaFile) > 0 then
    begin
      if not FileExists(FSchemaFile) then
        if Length(ExtractFilePath(FSchemaFile)) = 0 then
          // Default the folder path
          FSchemaFile := AppDataFolder + FSchemaFile;
    end;
  end;
end;

procedure TDataPumpForm.SetSkipCreate(const Value: Boolean);
begin
  cbSkipCreate.Checked := Value;
end;

procedure TDataPumpForm.SetTableFilter;
var
  choice: string;
begin
  if TableFilter.ItemIndex = 0 then
  begin
    FrameTables.DataSet.Filtered := False;
  end
  else
  begin
    choice := TableFilter.Items[TableFilter.ItemIndex];
    FrameTables.DataSet.Filter := SPumpTableType + '= ''' + UpperCase(choice)
      + '''';
    FrameTables.DataSet.Filtered := true;
  end;
end;

procedure TDataPumpForm.SetProcFilter;
var
  choice: string;
begin
  if ProcFilter.ItemIndex = 0 then
  begin
    FrameProcedures.DataSet.Filtered := False;
  end
  else
  begin
    choice := ProcFilter.Items[ProcFilter.ItemIndex];
    FrameProcedures.DataSet.Filter := SPumpProcType + '= ''' + UpperCase(choice)
      + '''';
    FrameProcedures.DataSet.Filtered := true;
  end;
end;

function TDataPumpForm.HideNestedDataSet(const AFieldName: string;
  Parent: TDataSet = nil): TDataSet;
var
  Field: TField;
begin
  if not Assigned(Parent) then
    Parent := dsSchema.DataSet;
  Field := Parent.FieldByName(AFieldName);
  Field.Visible := False;
  Result := GetNestedDataSet(Field);
end;

procedure TDataPumpForm.LoadSourceSchema;
const
  SRWAll = SPumpSelected + ',' + SPumpDestName;
  SRWTableColNames = SRWAll + ',' + SPumpRowCount + ',' + SPumpTableSize;
  SRWColumnColNames = SRWAll + ',' + SPumpDestSize
    + ',' + SPumpDestType + ',' + SPumpDestScale + ',' + SPumpDestPrecision
    + ',' + SPumpLong + ',' + SPumpDefaultValue + ',' + SPumpNullable;
  SRWIndexColNames = SRWAll + ',' + SPumpNullable;
  SRWProcColNames = SRWAll + ',' + SPumpProcScript;
  SRWProcParamColNames = SRWAll + ',' + ',' + SPumpDestType + ',' + SPumpDestPrecision;
var
  Conn: TDBXConnection;
  SaveCursor: TCursor;


begin
  // Don't reload schema if it's already been loaded.
  // If schema needs to be refreshed, FreeSchema should be called explicitly
  // first.
  if LastSchemaName = SourceDB then
    exit;
  FreeSchema;
  LastSchemaName := SourceDB;
  PageControl1.ActivePage := TabSchema;
  LoadingLabel.Caption := Format('Loading schema for %s ...',[SourceDB]);
  LoadingLabel.Visible := true;
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  Conn := DBXGetConnection(SourceDB);
  try
    FDestVendor := Conn.ProductName;
    LoadOrBuildSchema(Conn);
    FrameTables.DataSet := HideNestedDataSet(SPumpTables);
    FrameProcedures.DataSet := HideNestedDataSet(SPumpProcedures);
    FrameProcedures.DataSet.AutoCalcFields := True;
    FrameProcedures.DataSet.OnCalcFields := GenerateProcScript;
    FrameProcParams.DataSet := HideNestedDataSet(SPumpProcParams,
      FrameProcedures.DataSet);
    FrameColumns.DataSet := HideNestedDataSet(SPumpColumns,
      FrameTables.DataSet);
    FrameIndexes.DataSet := HideNestedDataSet(SPumpIndexes,
      FrameTables.DataSet);
    // Customize grid column behavior
    SetGridColsReadOnly(FrameTables.Grid.Columns, true, SRWTableColNames);
    SetGridColsReadOnly(FrameColumns.Grid.Columns, true, SRWColumnColNames);
    SetGridColsReadOnly(FrameIndexes.Grid.Columns, true, SRWIndexColNames);
    SetGridColsReadOnly(FrameProcedures.Grid.Columns, true, SRWProcColNames);
    SetTypeDropDowns;

    FindColumn(FrameColumns.Grid.Columns, SDbxDataType).Visible := False;

    SetTableFilter;
    if Length(FExcludeTables) > 0 then
      ExcludeTables := FExcludeTables
    else if Length(FIncludeTables) > 0 then
      IncludeTables := FIncludeTables
    else
      ToggleAllTables(true);
  finally
    FreeAndNil(Conn);
    LoadingLabel.Visible := False;
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TDataPumpForm.LogEntry(AReport: string);
begin
  // Support output to a log file as well
  Log.Lines.Add(AReport);
end;

//function TDataPumpForm.SourceSchemaMissing: Boolean;
//begin
//  Result := not Assigned(dsSchema.DataSet);
//end;

procedure TDataPumpForm.SelectSourceConnection;
begin
  ComboDest.Items.Assign(ComboSource.Items);
  ComboDest.Items.Delete(ComboSource.ItemIndex);
  ComboDest.Enabled := true;
  LoadSourceSchema;
end;

procedure TDataPumpForm.SetAutoInc(const Value: Boolean);
begin
  cbAutoInc.Checked := Value;
end;

procedure TDataPumpForm.SetChunkCopy(const Value: Boolean);
begin
  cbChunkCopy.Checked := Value;
  if Value then
  begin
    cbOnlyRead.Checked := False;
    cbOnlyNew.Checked := False;
  end;
end;

procedure TDataPumpForm.SetCountRows(const Value: Boolean);
begin
  cbCountRows.Checked := Value;
  FCountRows := Value;
  ProgressRow.Visible := FCountRows;
end;

procedure TDataPumpForm.SetDestDB(const Value: string);
begin
  if (DestDB <> Value) then
  begin
    if SetComboValue(ComboDest, Value) then
    begin
      ComboDest.ItemIndex := ComboDest.Items.IndexOf(Value);
      SetTypeDropDowns;
    end
    else
      AutoMigrate := False;
  end;
end;

procedure TDataPumpForm.SetExcludeTables(const Value: string);
begin
  FExcludeTables := Value;
  CheckDataSetRequest(FrameTables.DataSet, 'Exclude', Value);
  ToggleDataSet(FrameTables.DataSet, SPumpTableName, SPumpSelected, nil, true);
  ToggleDataSet(FrameTables.DataSet, SPumpTableName, SPumpSelected, ListToArray
      (Value), False);
end;

procedure TDataPumpForm.SetIgnoreDefaults(const Value: Boolean);
begin
  cbIgnoreDefaults.Checked := Value;
end;

procedure TDataPumpForm.SetIncludeTables(const Value: string);
begin
  FIncludeTables := Value;
  CheckDataSetRequest(FrameTables.DataSet, 'Include', Value);
  ToggleDataSet(FrameTables.DataSet, SPumpTableName, SPumpSelected, nil, False);
  ToggleDataSet(FrameTables.DataSet, SPumpTableName, SPumpSelected, ListToArray
      (Value), true);
end;

procedure TDataPumpForm.SetLastSchemaName(const Value: string);
begin
  FLastSchemaName := Value;
end;

procedure TDataPumpForm.SetMigrateProcs(const Value: boolean);
begin
  cbMigrateProcedures.Checked := Value;
end;

procedure TDataPumpForm.SetOnlyNew(const Value: Boolean);
begin
  cbOnlyNew.Checked := Value;
  if Value then
  begin
    cbOnlyRead.Checked := False;
    cbChunkCopy.Checked := False;
    cbWipeTable.Checked := False;
    cbSkipCreate.Checked := True;
  end;
end;

procedure TDataPumpForm.SetOnlyRead(const Value: Boolean);
begin
  cbOnlyRead.Checked := Value;
  if Value then
  begin
    cbOnlyNew.Checked := False;
    cbWipeTable.Checked := False;
    cbSkipCreate.Checked := False;
    cbFillById.Checked := False;
  end;
end;

procedure TDataPumpForm.SetFillById(const Value: boolean);
begin
  cbFillById.Checked := Value;
  if Value then
  begin
    cbOnlyRead.Checked := False;
    cbOnlyNew.Checked := False;
    cbWipeTable.Checked := False;
    cbSkipCreate.Checked := False;
  end;
end;

procedure TDataPumpForm.SetSourceDB(const Value: string);
begin
  if not SameText(Value, GetSourceDB) then
  begin
    if SetComboValue(ComboSource, Value) then
      SelectSourceConnection
    else
      AutoMigrate := False;
  end;
end;

procedure TDataPumpForm.SetTesting(const Value: Boolean);
begin
  cbTest.Checked := Value;
end;

procedure TDataPumpForm.SetTestRows(const Value: Int64);
begin
  EditTestRows.Text := IntToStr(Value);
end;

procedure TDataPumpForm.SetTransRows(const Value: Int64);
begin
  EditTransRows.Text := IntToStr(Value);
end;

procedure TDataPumpForm.SetUpdateTime(const Value: Int64);
begin
  EditUpdateTime.Text := IntToStr(Value);
  FUpdateTick := Value * MSecsPerSec;
end;

procedure TDataPumpForm.SetVerify(const Value: Boolean);
begin
  cbVerify.Checked := Value;
end;

procedure TDataPumpForm.SetWipeTable(const Value: Boolean);
begin
  cbWipeTable.Checked := Value;
  if Value then
  begin
    cbOnlyRead.Checked := False;
    cbOnlyNew.Checked := False;
  end;
end;

procedure TDataPumpForm.ShowDeltaCols(Grid: TDBGrid; Comparisons: TStringList;
  const Rect: TRect; const DataCol: Integer; Column: TColumn;
  const State: TGridDrawState);
var
  CompareField: string;
begin
  CompareField := Comparisons.Values[Column.FieldName];
  if Length(CompareField) > 0 then
  begin
    if Grid.DataSource.DataSet.FieldByName(CompareField)
      .Value <> Column.Field.Value then
    begin
      Grid.Canvas.Brush.Color := DeltaColor;
      Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;

end;

procedure TDataPumpForm.SchemaGridCellClick(Column: TColumn);
begin
  TDBGridExts.CellClick(Column);
end;

procedure TDataPumpForm.SchemaGridColEnter(Sender: TObject);
begin
  TDBGridExts.ColEnter(Sender);
end;

procedure TDataPumpForm.SchemaGridColExit(Sender: TObject);
begin
  TDBGridExts.ColExit(Sender);
end;

procedure TDataPumpForm.SchemaGridDrawColumnCell
  (Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  TDBGridExts.DrawColumnCell(Sender, Rect, DataCol, Column, State);
end;

procedure TDataPumpForm.SchemaGridKeyPress(Sender: TObject; var Key: Char);
begin
  TDBGridExts.KeyPress(Sender, Key);
end;

procedure TDataPumpForm.DisplayHelp;
begin
  ShowMessage(FCommandLine.HelpText);
end;

procedure TDataPumpForm.LogMessage(ASender: TObject; AMessage: string);
begin
  StatusLine(AMessage);
end;

end.
