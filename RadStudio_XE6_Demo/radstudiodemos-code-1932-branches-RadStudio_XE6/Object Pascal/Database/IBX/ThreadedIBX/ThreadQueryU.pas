// ---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

// ---------------------------------------------------------------------------
unit ThreadQueryU;

interface

uses
  Windows, Classes, SysUtils, db, grids, dmThreadU;

type
  ThreadQuery = class(TThread)
  private
    Fds: TDataSource;
    dmThread: TdmThread;
    FDatabaseName: String;
    FSql: String;
    FGrid: TStringGrid;
    FUserName, FPassword: String;
    procedure DisplayResults;
    procedure EmptyResults;
    procedure SetColumns;
    procedure WriteGridRow;
    procedure AddRow;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(SQL: String; ds: TDataSource; DB_Name: String;
      username: String; password: String); overload;
    constructor Create(SQL: String; grid: TStringGrid; DB_Name: String;
      username: String; password: String); overload;
    destructor Destroy; override;
  end;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

  Synchronize(UpdateCaption);

  and UpdateCaption could look like,

  procedure ThreadQuery.UpdateCaption;
  begin
  Form1.Caption := 'Updated in a thread';
  end; }

{ ThreadQuery }

constructor ThreadQuery.Create(SQL: String; ds: TDataSource; DB_Name: String;
  username: String; password: String);
begin
  inherited Create(false);
  FSql := SQL;
  FDatabaseName := DB_Name;
  FUserName := username;
  FPassword := password;
  FGrid := nil;
  Fds := ds;
end;

procedure ThreadQuery.AddRow;
begin
  FGrid.RowCount := FGrid.RowCount + 1;
end;

constructor ThreadQuery.Create(SQL: String; grid: TStringGrid;
  DB_Name, username, password: String);
begin
  inherited Create(false);
  FSql := SQL;
  FDatabaseName := DB_Name;
  FUserName := username;
  FPassword := password;
  FGrid := grid;
end;

destructor ThreadQuery.Destroy;
begin
  dmThread.Free;
  inherited Destroy;
end;

procedure ThreadQuery.DisplayResults;
begin
  Fds.DataSet:= dmThread.IBQuery1;
end;

procedure ThreadQuery.EmptyResults;
begin
  Fds.DataSet:= nil;
end;

procedure ThreadQuery.Execute;
begin
  dmThread := TdmThread.Create(FDatabaseName, FUserName, FPassword);
  { Place thread code here }
  try
    if FGrid = nil then
      Synchronize(EmptyResults);
    dmThread.IBQuery1.Active := false;
    dmThread.IBQuery1.SQL.Clear;
    dmThread.IBQuery1.SQL.Add(FSql);
    dmThread.IBQuery1.Active := True;
    dmThread.IBQuery1.FetchAll;
    if FGrid = nil then
      Synchronize(DisplayResults)
    else
    begin
      Synchronize(SetColumns);
      while not dmThread.IBQuery1.Eof do
      begin
        Synchronize(WriteGridRow);
        dmThread.IBQuery1.Next;
        if not dmThread.IBQuery1.Eof then
          Synchronize(AddRow);
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('Database error = ' + E.Message), 'Error', MB_OK);
  end;
end;

procedure ThreadQuery.SetColumns;
var
  i: Integer;
begin
  FGrid.ColCount := dmThread.IBQuery1.FieldDefs.Count;
  for i := 0 to Pred(dmThread.IBQuery1.FieldDefs.Count) do
    FGrid.Cells[i, 0] := dmThread.IBQuery1.FieldDefs[i].DisplayName;
end;

procedure ThreadQuery.WriteGridRow;
var
  i, row: Integer;
begin
  row := FGrid.RowCount - 1;
  for i := 0 to Pred(dmThread.IBQuery1.FieldDefs.Count) do
    FGrid.Cells[i, row] := dmThread.IBQuery1.Fields[i].AsString;
end;

end.
