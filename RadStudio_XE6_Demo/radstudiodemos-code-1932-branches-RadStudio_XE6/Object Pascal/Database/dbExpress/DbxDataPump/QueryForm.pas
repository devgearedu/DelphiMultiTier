
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit QueryForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, FMTBcd, StdCtrls, Grids, DBGrids, ExtCtrls, DB, SqlExpr,
  ComCtrls, DBClient, Provider, StdActns, ActnList, ImgList,
  PlatformDefaultStyleActnCtrls, ActnMan, Menus, DBXInterBase;

type
  TFormQuery = class(TForm)
    QueryDb: TSQLConnection;
    DataSource1: TDataSource;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    ButtonSelect: TButton;
    StatusBar1: TStatusBar;
    SQLDataSet1: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    ButtonCopy: TButton;
    ButtonExecute: TButton;
    cbSplitExec: TCheckBox;
    Splitter1: TSplitter;
    cbCreateTables: TCheckBox;
    cbCreateIndexes: TCheckBox;
    cbExecOther: TCheckBox;
    ComboConnection: TComboBoxEx;
    TopPanel: TPanel;
    Splitter2: TSplitter;
    ListTables: TListBox;
    ActionManager1: TActionManager;
    ImageList1: TImageList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    actFileOpen: TFileOpen;
    PopupMenuSql: TPopupMenu;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Delete1: TMenuItem;
    Paste1: TMenuItem;
    SelectAll1: TMenuItem;
    Undo1: TMenuItem;
    Open1: TMenuItem;
    PopupMenuTableList: TPopupMenu;
    actInsertTableName: TAction;
    ActLoadTable: TAction;
    Loadtable1: TMenuItem;
    Inserttablename1: TMenuItem;
    actFileSave: TFileSaveAs;
    SaveAs1: TMenuItem;
    SearchFind1: TSearchFind;
    SearchFindNext1: TSearchFindNext;
    SearchReplace1: TSearchReplace;
    SearchFindFirst1: TSearchFindFirst;
    Find1: TMenuItem;
    FindNext1: TMenuItem;
    Replace1: TMenuItem;
    procedure ButtonSelectClick(Sender: TObject);
    procedure ButtonCopyClick(Sender: TObject);
    procedure ButtonExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboConnectionSelect(Sender: TObject);
    procedure ListTablesDblClick(Sender: TObject);
    procedure actFileOpenAccept(Sender: TObject);
    procedure actInsertTableNameUpdate(Sender: TObject);
    procedure actInsertTableNameExecute(Sender: TObject);
    procedure ActLoadTableUpdate(Sender: TObject);
    procedure ActLoadTableExecute(Sender: TObject);
    procedure actFileSaveUpdate(Sender: TObject);
    procedure actFileSaveAccept(Sender: TObject);
  private
    FTableName: string;
    FDefaultConnection: string;
    { Private declarations }
    function SplitExecute(ASQL: String): Integer;
    procedure AddToMemo(const Value: string);
    procedure SetConnection(const AConnectionName: string);
    procedure DoSelect;
    procedure SetTableName(const Value: string);
    procedure SelectTable;
  public
    { Public declarations }
    property DefaultConnection: string read FDefaultConnection
      write FDefaultConnection;
    property TableName: string read FTableName write SetTableName;
  end;

procedure OpenTable(const AConnectionName: string;
  const ATableName: string);

var
  FormQuery: TFormQuery;

implementation

uses
  Clipbrd, DBXUtils;

{$R *.dfm}

procedure OpenTable(const AConnectionName: string;
  const ATableName: string);
var
  q : TFormQuery;
begin
  // Set owner to application so form will be destroyed app is closed
  q := TFormQuery.Create(Application);
  q.DefaultConnection := AConnectionName;
  q.TableName := ATableName;
  q.Show;
end;

{ TFormQuery }

procedure TFormQuery.ButtonSelectClick(Sender: TObject);
begin
  DoSelect;
end;

procedure TFormQuery.ComboConnectionSelect(Sender: TObject);
var
  List : TStrings;
begin
  List := DbxGetTableList(ComboConnection.Text);
  try
    ListTables.Items.Assign(List);
  finally
    List.Free;
  end;
end;

procedure TFormQuery.ButtonCopyClick(Sender: TObject);
var
  I  : Integer;
  Str : String;

begin
  Str := '';

  for I := 0 to ClientDataSet1.Fields.Count - 1 do
    Str := Str + ClientDataSet1.Fields.Fields[ I ].FieldName + ',';

  Str := Str + #13#10;

  ClientDataSet1.First();
  while( not ClientDataSet1.Eof ) do
    begin
    for I := 0 to ClientDataSet1.Fields.Count - 1 do
      Str := Str + Trim( ClientDataSet1.Fields.Fields[ I ].AsString ) + ',';

    Str := Str + #13#10;

    ClientDataSet1.Next();
    end;

  Clipboard.AsText := Str;

end;

procedure TFormQuery.SetConnection(const AConnectionName: string);
begin
  QueryDb.Close;
  QueryDb.ConnectionName := ComboConnection.Text;
  QueryDB.LoadParamsOnConnect := True;
end;

procedure TFormQuery.SetTableName(const Value: string);
begin
  FTableName := Value;
  ComboConnection.Text := DefaultConnection;
  ComboConnectionSelect(nil);
  ListTables.ItemIndex := ListTables.Items.IndexOf(Value);
  SelectTable;
end;

procedure TFormQuery.SelectTable;
begin
  Memo1.Text := 'select * from ' + ListTables.Items[ListTables.ItemIndex] + ' ';
  DoSelect;
end;

procedure TFormQuery.DoSelect;
begin
  SetConnection(ComboConnection.Text);
  ClientDataSet1.Close;
  SQLDataSet1.Close;
  SQLDataSet1.CommandText := Memo1.Text;
  ClientDataSet1.Open;
  StatusBar1.SimpleText := IntToStr(ClientDataSet1.RecordCount) + ' records.';
end;

procedure TFormQuery.ButtonExecuteClick(Sender: TObject);
var
  R: Integer;
begin
  SetConnection(ComboConnection.Text);
  ClientDataSet1.Close;
  SQLDataSet1.Close;

  if not cbSplitExec.Checked then
  begin
    SQLDataSet1.CommandText := Memo1.Text;
    R := SQLDataSet1.ExecSQL();
  end else
    R := SplitExecute(Memo1.Text);

  ShowMessage( 'Execute returned ' + IntToStr( R ) );
end;

procedure TFormQuery.actFileOpenAccept(Sender: TObject);
begin
  actFileOpen.Dialog.InitialDir := ExtractFilePath(actFileOpen.Dialog.FileName);
  actFileSave.Dialog.InitialDir := actFileOpen.Dialog.InitialDir;
  actFileSave.Dialog.FileName := actFileOpen.Dialog.FileName;
  Memo1.Lines.LoadFromFile(actFileOpen.Dialog.FileName);
end;

procedure TFormQuery.FormCreate(Sender: TObject);
var
  List : TStrings;
begin
  List := DbxGetConnectionList;
  try
    ComboConnection.Items.Assign(List);
    if List.Count > 30 then
      ComboConnection.DropDownCount := 30
    else
      ComboConnection.DropDownCount := List.Count;
  finally
    FreeAndNil(List);
  end;
end;

procedure TFormQuery.actInsertTableNameExecute(Sender: TObject);
var
  input: string;
begin
  input := ListTables.Items[ListTables.ItemIndex] + ' ';
  if Length(Trim(Memo1.Lines.Text)) = 0 then
    input := 'select * from ' + input;
  AddToMemo(input);
end;

procedure TFormQuery.actInsertTableNameUpdate(Sender: TObject);
begin
  actInsertTableName.Enabled := ListTables.ItemIndex >= 0;
end;

procedure TFormQuery.ActLoadTableExecute(Sender: TObject);
begin
  SelectTable;
end;

procedure TFormQuery.ActLoadTableUpdate(Sender: TObject);
begin
  actLoadTable.Enabled := ListTables.ItemIndex >= 0;
end;

procedure TFormQuery.actFileSaveAccept(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(actFileSave.Dialog.FileName);
end;

procedure TFormQuery.actFileSaveUpdate(Sender: TObject);
begin
  actFileSave.Enabled := Length(Trim(Memo1.Text)) > 0;
end;

procedure TFormQuery.AddToMemo(const Value: string);
begin
  Memo1.SelText := Value;
end;

procedure TFormQuery.ListTablesDblClick(Sender: TObject);
begin
  actLoadTableExecute(Sender);
end;

function TFormQuery.SplitExecute(ASQL: String): Integer;
const
  //              1234567890123456
  CREATE_TABLE = 'CREATE TABLE';
  CREATE_INDEX = 'CREATE INDEX';
var
  I: Integer;
  InCreateTable: Boolean;
  Lines: TStringList;
  CreateTableSQL: TStringList;
  CreateIndexSQL: TStringList;
  OtherSQL: TStringList;
begin
  Result := -1;
  Lines := TStringList.Create;
  CreateTableSQL := TStringList.Create;
  CreateIndexSQL := TStringList.Create;
  OtherSQL := TStringList.Create;
  try
    InCreateTable := False;
    Lines.Text := ASQL;

    for I := 0 to Lines.Count - 1 do
    begin
      if SameText(Copy(Lines[I], 1, 12), CREATE_TABLE) then
        InCreateTable := True;

      if InCreateTable then
        CreateTableSQL.Add(Lines[I])
      else if SameText(Copy(Lines[I], 1, 12), CREATE_INDEX) then
        CreateIndexSQL.Add(Lines[I])
      else
        OtherSQL.Add(Lines[I]);

      if InCreateTable and (Lines[I] = ');') then
        InCreateTable := False;
    end;

    if cbCreateTables.Checked then
    begin
      SQLDataSet1.CommandText := CreateTableSQL.Text;
      Result := SQLDataSet1.ExecSQL();
    end;

    if cbCreateIndexes.Checked then
    begin
      SQLDataSet1.CommandText := CreateIndexSQL.Text;
      Result := SQLDataSet1.ExecSQL();
    end;

    if cbExecOther.Checked then
    begin
      SQLDataSet1.CommandText := OtherSQL.Text;
      Result := SQLDataSet1.ExecSQL();
    end;
  finally
    FreeAndNil(Lines);
    FreeAndNil(CreateTableSQL);
    FreeAndNil(CreateIndexSQL);
    FreeAndNil(OtherSQL);
  end;
end;

end.
