unit Unit37;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Def, FireDAC.Phys.Intf, FireDAC.UI.Intf,
  FireDAC.DatS, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DApt.Intf, DBClient, MConnect,
  SConnect, DB, FireDAC.VCLUI.Async, FireDAC.Phys, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.DataSet, FireDAC.Comp.Client, StdCtrls,
  Grids, DBGrids, FireDAC.VCLUI.Error;

type
  TForm37 = class(TForm)
    FDConnection1: TFDConnection;
    FDStoredProc1: TFDStoredProc;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button3: TButton;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    procedure FDStoredProc1BeforeOpen(DataSet: TDataSet);
    procedure FDStoredProc1AfterOpen(DataSet: TDataSet);
    procedure FDStoredProc1BeforeExecute(DataSet: TFDDataSet);
    procedure FDStoredProc1AfterExecute(DataSet: TFDDataSet);
    procedure FDStoredProc1BeforeGetRecords(DataSet: TFDDataSet);
    procedure FDStoredProc1AfterGetRecords(DataSet: TFDDataSet);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    procedure trace(const AStr: String);
    procedure CommandAfterExecute(Sender: TObject);
    procedure CommandAfterFetch(Sender: TObject);
    procedure CommandAfterOpen(Sender: TObject);
    procedure CommandBeforeExecute(Sender: TObject);
    procedure CommandBeforeFetch(Sender: TObject);
    procedure CommandBeforeOpen(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form37: TForm37;

implementation

{$R *.dfm}

type
  TSyncMsg = class(TObject)
  private
    FStr: String;
    FThreadId: Longword;
    FTicks: Longword;
    FForm: TForm37;
  public
    constructor Create(const AStr: String; AForm: TForm37);
    procedure Trace;
  end;

constructor TSyncMsg.Create(const AStr: String; AForm: TForm37);
begin
  inherited Create;
  FStr := AStr;
  FForm := AForm;
  FThreadId := GetCurrentThreadId();
  FTicks := GetTickCount();
end;

procedure TSyncMsg.Trace;
begin
  FForm.Memo1.Lines.Add(Format('%.8u - %.8u - %s', [FThreadId, FTicks, FStr]));
  Application.ProcessMessages;
end;

procedure TForm37.trace(const AStr: String);
begin
  if GetCurrentThreadId() = MainThreadID then begin
    Memo1.Lines.Add(Format('%.8u - %.8u - %s', [GetCurrentThreadId(), GetTickcount(), AStr]));
    Application.ProcessMessages;
  end
  else
    TThread.StaticSynchronize(nil, TSyncMsg.Create(AStr, Self).Trace);
end;

procedure TForm37.FDStoredProc1AfterExecute(DataSet: TFDDataSet);
begin
  trace('AfterExecute');
end;

procedure TForm37.FDStoredProc1AfterGetRecords(DataSet: TFDDataSet);
begin
  trace('AfterGetRecords');
end;

procedure TForm37.FDStoredProc1AfterOpen(DataSet: TDataSet);
begin
  trace('AfterOpen');
  DBGrid1.DataSource := DataSource1;
end;

procedure TForm37.FDStoredProc1BeforeExecute(DataSet: TFDDataSet);
begin
  trace('BeforeExecute');
end;

procedure TForm37.FDStoredProc1BeforeGetRecords(DataSet: TFDDataSet);
begin
  trace('BeforeGetRecords');
end;

procedure TForm37.FDStoredProc1BeforeOpen(DataSet: TDataSet);
begin
  trace('BeforeOpen');
end;

procedure TForm37.CommandBeforeExecute(Sender: TObject);
begin
  trace('Command BeforeExecute');
end;

procedure TForm37.CommandBeforeOpen(Sender: TObject);
begin
  trace('Command BeforeOpen');
end;

procedure TForm37.CommandBeforeFetch(Sender: TObject);
begin
  trace('Command BeforeFetch');
end;

procedure TForm37.CommandAfterExecute(Sender: TObject);
begin
  trace('Command AfterExecute');
end;

procedure TForm37.CommandAfterOpen(Sender: TObject);
begin
  trace('Command AfterOpen');
end;

procedure TForm37.CommandAfterFetch(Sender: TObject);
begin
  trace('Command AfterFetch');
end;

procedure TForm37.FormCreate(Sender: TObject);
begin
  FDStoredProc1.Command.BeforeExecute := CommandBeforeExecute;
  FDStoredProc1.Command.BeforeOpen := CommandBeforeOpen;
  FDStoredProc1.Command.BeforeFetch := CommandBeforeFetch;
  FDStoredProc1.Command.AfterExecute := CommandAfterExecute;
  FDStoredProc1.Command.AfterOpen := CommandAfterOpen;
  FDStoredProc1.Command.AfterFetch := CommandAfterFetch;
  ComboBox1Click(nil);
end;

procedure TForm37.ComboBox1Click(Sender: TObject);
begin
  FDStoredProc1.ResourceOptions.CmdExecMode := TFDStanAsyncMode(ComboBox1.ItemIndex);
end;

procedure TForm37.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
  FDStoredProc1.Close;
  trace('ExecProc enter');
  FDStoredProc1.ExecProc;
  trace('ExecProc exit');
end;

procedure TForm37.Button2Click(Sender: TObject);
begin
  Memo1.Clear;
  FDStoredProc1.Close;
  DBGrid1.DataSource := nil;
  trace('Open enter');
  FDStoredProc1.Open;
  trace('Open exit');
end;

procedure TForm37.Button3Click(Sender: TObject);
begin
  Memo1.Clear;
  FDStoredProc1.Close;
  trace('Update fielddefs enter');
  FDStoredProc1.FieldDefs.Updated := False;
  FDStoredProc1.FieldDefs.Update;
  trace('Update fielddefs exit');
end;

end.
