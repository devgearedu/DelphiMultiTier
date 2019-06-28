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

unit DelegateForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, FMTBcd, Grids, DBGrids, DBClient, DB, SqlExpr,
  StdCtrls, Menus, ComCtrls, Provider, Mask, ExtCtrls, DBCtrls,
  DBXCommon, DBXClient, IniFiles, DBXPool, DBXTrace, Registry, ShellAPI;
const
  TraceDelegateDemoFile = 'TraceDelegateDemo.txt';
type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    ClientDataSet1: TClientDataSet;
    Pagecontrol: TPageControl;
    ConnectionSheet: TTabSheet;
    QuerySheet: TTabSheet;
    FilesSheet: TTabSheet;
    PoolSheet: TTabSheet;
    DataSetProvider1: TDataSetProvider;
    DataSource1: TDataSource;
    Button1: TButton;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    DBNavigator1: TDBNavigator;
    ConnectSheet: TPanel;
    ListBox1: TListBox;
    RadioGroup2: TRadioGroup;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    SQLDataSet1: TSQLDataSet;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    Label5: TLabel;
    PoolConnectEdit: TEdit;
    PoolTraceConnectEdit: TEdit;
    PoolConnectButton: TButton;
    PoolTraceConnectButton: TButton;
    Label6: TLabel;
    Label7: TLabel;
    NonPooledBenchEdit: TEdit;
    PooledBenchEdit: TEdit;
    NonPooledBenchButton: TButton;
    PooledBenchButton: TButton;
    NonPooledBenchLabel: TLabel;
    PooledBenchLabel: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    TraceFileLabel: TLabel;
    TraceFileButton: TButton;
    DbxConnectionsLabel: TLabel;
    DbxDriverLabel: TLabel;
    DbxConnectionsButton: TButton;
    DbxDriversButton: TButton;
    ComboBox2: TComboBox;
    Button4: TButton;
    EditResult: TEdit;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBox1Enter(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure NonPooledBenchButtonClick(Sender: TObject);
    procedure PooledBenchButtonClick(Sender: TObject);
    procedure PoolConnectButtonClick(Sender: TObject);
    procedure PoolTraceConnectButtonClick(Sender: TObject);
    procedure TraceFileButtonClick(Sender: TObject);
    procedure DbxConnectionsButtonClick(Sender: TObject);
    procedure DbxDriversButtonClick(Sender: TObject);
    procedure EmptyTraceFileClick(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    FConnectionName: WideString;
    FPoolConnectionName: WideString;
    FTraceConnectionName: WideString;
    FPoolTraceConnectionName: WideString;
    FLastConnectionName: WideString;
    FPoolConnections: TStringList;
    FPoolTraceConnections: TStringList;
    FConnectionsFileName: WideString;
    FDriversFileName: WideString;
    procedure CopyConnection(IniFile: TMemIniFile; SourceName,
      DestName: WideString);
    function GetConnectionsIniFile: String;
    function GetDriversIniFile: String;
    procedure AddDelegatesToIniFile(ConnectionName: WideString);
    procedure ExecuteQuery;
    procedure InitCommandTypes;
    procedure InitCommands;
    procedure ConnectDisConnect(Pooled: Boolean);
    procedure OpenConnections(PoolTrace: Boolean);
    procedure EditFile(FileName: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.ComboBox1Enter(Sender: TObject);
begin
  InitCommands;
end;

procedure TForm1.ComboBox2Enter(Sender: TObject);
begin
  InitCommandTypes;
end;

procedure TForm1.ConnectDisConnect(Pooled: Boolean);
var
  ConnectionName: WideString;
  EditBox: TEdit;
  LabelOut: TLabel;
  Count: Integer;
  I: Integer;
  Connection: TDBXConnection;
  StartTicks: Cardinal;
  Ticks: Cardinal;
begin
  if Pooled then
  begin
    ConnectionName  := FPoolConnectionName;
    EditBox         := PooledBenchEdit;
    LabelOut        := PooledBenchLabel;
  end else
  begin
    ConnectionName  := FConnectionName;
    EditBox         := NonPooledBenchEdit;
    LabelOut        := NonPooledBenchLabel;
  end;

  Count := StrToInt(EditBox.Text);
  StartTicks := GetTickCount;
  for I := 0 to Count - 1 do
  begin
    Connection := TDBXConnectionFactory
                  .GetConnectionFactory
                  .GetConnection(ConnectionName, '', '');
    Connection.Free;
  end;
  Ticks := GetTickCount - StartTicks;
  LabelOut.Caption := IntToStr(Ticks) + ' Ticks';
end;

procedure TForm1.CopyConnection(IniFile: TMemIniFile; SourceName,
  DestName: WideString);
var
  List: TStringList;
  I: Integer;
  Value: String;
begin
  IniFile.EraseSection(DestName);
  List := TStringList.Create;
  try
    IniFile.ReadSection(SourceName, List);
    for I := 0 to List.Count - 1 do
    begin
      Value := IniFile.ReadString(SourceName, List[I], '');
      IniFile.WriteString(DestName, List[I], Value);
    end;

  finally
    List.Free;
  end;

end;


procedure TForm1.DbxConnectionsButtonClick(Sender: TObject);
begin
  EditFile(FConnectionsFileName);
end;

procedure TForm1.DbxDriversButtonClick(Sender: TObject);
begin
  EditFile(FDriversFileName);
end;

procedure TForm1.EditFile(FileName: String);
var
  SEI: TShellExecuteInfo;
begin
  FillChar(SEI, SizeOf(SEI), 0); // Wipe the record to start with
  with SEI do
  begin
    cbSize := SizeOf(SEI);
    fMask := see_Mask_NoCloseProcess;
    Wnd := 0;
    lpFile := PChar('NotePad.exe');
    lpParameters := PChar(FileName) ;
    nShow := SW_SHOW;
    if not ShellExecuteEx(@SEI) then
      raise Exception.Create('Problem launching notepad.exe '+FileName);
  end;
end;

procedure TForm1.EmptyTraceFileClick(Sender: TObject);
begin
  DeleteFile(TraceDelegateDemoFile);
end;


procedure TForm1.ExecuteQuery;
var
  ParamCount: Integer;
  Index: Integer;
  StringValue: String;
begin
  ClientDataSet1.Active := false;
  InitCommandTypes;
  SQLDataSet1.DbxCommandType := ComboBox2.Items[ComboBox2.ItemIndex];
  SQLDataSet1.CommandText := Memo1.Lines.Text;
  if SQLDataSet1.CommandType = ctServerMethod then
  begin
    ParamCount := SQLDataSet1.Params.Count;
    if (ParamCount > 0) and (SQLDataSet1.Params[SQLDataSet1.Params.Count-1].DataType <> ftCursor) then
    begin
      SQLDataSet1.ExecSQL();
      StringValue := '';
      for Index := 0 to ParamCount - 1 do
      begin
        case SQLDataSet1.Params[Index].ParamType of
          ptOutput, ptInputOutput, ptResult:
            StringValue := StringValue + SQLDataSet1.Params[Index].Value;
        end;
        EditResult.Text := StringValue;
      end;
      exit;
    end;
  end;
  ClientDataSet1.Active := true;
end;

procedure TForm1.AddDelegatesToIniFile(ConnectionName: WideString);
var
  IniFile:              TMemIniFile;
begin


  FConnectionName           := ConnectionName;
  FPoolConnectionName       := 'Pool_DelegateDemo';
  FTraceConnectionName      := 'Trace_DelegateDemo';
  FPoolTraceConnectionName  := 'PoolTrace_DelegateDemo';

  IniFile := TMemIniFile.Create(FConnectionsFileName);

  // Clone the DBXTrace and send the trace output to a local file.
  //
  CopyConnection(IniFile, 'DBXTraceConnection', 'DBXTraceConnection_DelegateDemo');
  // Send trace to file instead of to console.
  //
  IniFile.WriteString('DBXTraceConnection_DelegateDemo', TDBXTracePropertyNames.TraceFile, TraceDelegateDemoFile);
  // Disable noisy driver tracing.
  //
  IniFile.WriteString('DBXTraceConnection_DelegateDemo', TDBXTracePropertyNames.TraceDriver, 'False');
  // Create a Pool->Trace Delegate Driver connection that can be used
  // by other connections that need a delegate that performs pooling
  // and tracing.
  //
  CopyConnection(IniFile, 'DBXPoolConnection', 'DBXPoolTraceConnection_DelegateDemo');
  IniFile.WriteString('DBXPoolTraceConnection_DelegateDemo', TDBXPropertyNames.DelegateConnection, 'DBXTraceConnection_DelegateDemo');
  IniFile.WriteString(FPoolTraceConnectionName, TDBXPropertyNames.DelegateConnection, 'DBXPoolTraceConnection');

  // Add a connection that uses trace delegate.
  //
  CopyConnection(IniFile, ConnectionName, FTraceConnectionName);
  IniFile.WriteString(FTraceConnectionName, TDBXPropertyNames.DelegateConnection, 'DBXTraceConnection_DelegateDemo');

  // Add a connection that uses pool delegate.
  //
  CopyConnection(IniFile, ConnectionName, FPoolConnectionName);
  IniFile.WriteString(FPoolConnectionName, TDBXPropertyNames.DelegateConnection, 'DBXPoolConnection');

  // Add a connection that uses pool->trace delegate.
  //
  CopyConnection(IniFile, ConnectionName, FPoolTraceConnectionName);
  IniFile.WriteString(FPoolTraceConnectionName, TDBXPropertyNames.DelegateConnection, 'DBXPoolTraceConnection_DelegateDemo');

  IniFile.UpdateFile;
  IniFile.Free;

  // Force the default factory to reload the ini file.
  //
  TDBXConnectionFactory.GetConnectionFactory.Close;
  TDBXConnectionFactory.GetConnectionFactory.Open;

end;

function TForm1.GetConnectionsIniFile: String;
var
  Reg: TRegistry;
begin
  Result := TDBXConnectionFile;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly(TDBXRegistryKey) then
      Result := Reg.ReadString(TDBXRegistryConnectionValue);
  finally
    Reg.Free;
  end;
end;

function TForm1.GetDriversIniFile: String;
var
  Reg: TRegistry;
begin
  Result := TDBXDriverFile;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly(TDBXRegistryKey) then
      Result := Reg.ReadString(TDBXRegistryDriverValue);
  finally
    Reg.Free;
  end;
end;


procedure TForm1.InitCommands;
var
  CommandType: String;
begin
  if ComboBox2.Items.Count < 1 then
    InitCommandTypes;

  CommandType := ComboBox2.Items[ComboBox2.ItemIndex];

  ComboBox1.Items.Clear;
  if SQLConnection1.DBXConnection <> nil then
  begin
    SQLConnection1.DBXConnection.GetCommands(CommandType, ComboBox1.Items);
  end;
  ComboBox1.ItemIndex := 0;
end;

procedure TForm1.InitCommandTypes;
begin
  if FLastConnectionName <> SQLConnection1.ConnectionName then
  begin
    ComboBox2.Items.Clear;
    if SQLConnection1.DBXConnection <> nil then
    begin
      SQLConnection1.DBXConnection.GetCommandTypes(ComboBox2.Items);
    end;
    ComboBox2.ItemIndex := 0;
    FLastConnectionName := SQLConnection1.ConnectionName;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  ConnectionName: WideString;
begin
  ConnectionName :=  RadioGroup2.Items[0];
  AddDelegatesToIniFile(ConnectionName);
  case RadioGroup2.ItemIndex of
    1: ConnectionName := FTraceConnectionName;
    2: ConnectionName := FPoolConnectionName;
    3: ConnectionName := FPoolTraceConnectionName;
  end;
  SQLConnection1.ConnectionName := ConnectionName;
  SQLConnection1.Connected := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Lines.Add(ComboBox1.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ExecuteQuery;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ClientDataSet1.ApplyUpdates(-1);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  SQLConnection1.Connected := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TDBXConnectionFactory.GetConnectionFactory.GetConnectionItems(ListBox1.Items);
  FPoolConnections := TStringList.Create;
  FPoolTraceConnections := TStringList.Create;
  FConnectionsFileName := GetConnectionsIniFile;
  FDriversFileName := GetDriversIniFile;
  TraceFileLabel.Caption := TraceDelegateDemoFile;
  DbxConnectionsLabel.Caption := FConnectionsFileName;
  DbxDriverLabel.Caption := FDriversFileName;
  DeleteFile(TraceDelegateDemoFile);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var
  ConnectionName:  String;
  Index: Integer;
begin
  Index := ListBox1.ItemIndex;
  if Index < 0 then
    Index := 0;
  ConnectionName := ListBox1.Items[Index];
  RadioGroup2.Items.Clear;
  RadioGroup2.Items.Add(ConnectionName);
  RadioGroup2.Items.Add('Trace_DelegateDemo (DBXTrace->'+ConnectionName+')');
  RadioGroup2.Items.Add('Pool_DelegateDemo (DBXPool->'+ConnectionName+')');
  RadioGroup2.Items.Add('PoolTrace_DelegateDemo (DBXPool->DBXTrace->'+ConnectionName+')');
  RadioGroup2.ItemIndex := 0;

end;

procedure TForm1.TraceFileButtonClick(Sender: TObject);
begin
  EditFile(TraceDelegateDemoFile);
end;

procedure TForm1.Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F9 then
    ExecuteQuery;
end;


procedure TForm1.NonPooledBenchButtonClick(Sender: TObject);
begin
  ConnectDisConnect(false);
end;

procedure TForm1.OpenConnections(PoolTrace: Boolean);
var
  EditBox: TEdit;
  ConnectionList: TStringList;
  ConnectionName: WideString;
  Index: Integer;
  Count: Integer;
begin
  if PoolTrace then
  begin
    EditBox := PoolConnectEdit;
    ConnectionList := FPoolTraceConnections;
    ConnectionName := FPoolTraceConnectionName;
  end else
  begin
    EditBox := PoolTraceConnectEdit;
    ConnectionList := FPoolConnections;
    ConnectionName := FPoolConnectionName;
  end;
  Count := ConnectionList.Count;
  for Index := 0 to Count - 1 do
    ConnectionList.Objects[Index].Free;
  ConnectionList.Clear;
  Count := StrToInt(EditBox.Text);
  for Index := 0 to Count - 1 do
    ConnectionList.AddObject('', TDBXConnectionFactory.GetConnectionFactory
                            .GetConnection(ConnectionName, '', ''));
end;

procedure TForm1.PoolConnectButtonClick(Sender: TObject);
begin
  OpenConnections(false);
end;

procedure TForm1.PooledBenchButtonClick(Sender: TObject);
begin
  ConnectDisConnect(true);
end;

procedure TForm1.PoolTraceConnectButtonClick(Sender: TObject);
begin
  OpenConnections(true);
end;

end.
