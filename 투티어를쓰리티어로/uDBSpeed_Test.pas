unit uDBSpeed_Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,System.Diagnostics, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.StdCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.Provider, Datasnap.DBClient, FireDAC.Phys.SQLiteVDataSet,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI, Vcl.Grids, Vcl.DBGrids;

type
  TTestForm = class(TForm)
    Memo1: TMemo;
    FDQuery1: TFDQuery;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button3: TButton;
    Button5: TButton;
    FDMemTable1: TFDMemTable;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    Button6: TButton;
    FDTable1: TFDTable;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestForm: TTestForm;

implementation

{$R *.dfm}

uses UDept, Udm;

procedure TTestForm.Button1Click(Sender: TObject);
var
 StopWatch: TStopwatch;
 i:integer;
begin
 FDQuery1.close;
 FDQuery1.SQL.Text := 'insert into test values (:pcode,:pname,:pmark)';
 StopWatch := TStopWatch.StartNew;

 for i := 1 to 1000 do
 begin
   fdquery1.Params[0].AsString :=  inttostr(i);
   fdquery1.Params[1].AsString :=  inttostr(i);
   fdquery1.Params[2].AsString :=  'Mark' + inttostr(i);
   fdquery1.ExecSQL;
 end;
  StopWatch.Stop;
  Memo1.Lines.Add('Insert STD : ' + StopWatch.ElapsedMilliseconds.ToString + ' ms');

  Button6Click(button6);

end;

procedure TTestForm.Button2Click(Sender: TObject);
var
 StopWatch: TStopwatch;
 i:integer;
begin
 FDQuery1.close;
 FDQuery1.SQL.Text := 'insert into test values (:pcode,:pname,:mark)';
 StopWatch := TStopWatch.StartNew;
 FDConnection1.StartTransaction;
 for i := 1 to 1000 do
 begin
   FDQuery1.Params[0].AsString :=  inttostr(i);
   FDQuery1.Params[1].AsString :=  inttostr(i);
   FDQuery1.Params[2].AsString :=  'Mark' + inttostr(i);
   FDQuery1.ExecSQL;
 end;
  FDConnection1.Commit;
  StopWatch.Stop;
  Memo1.Lines.Add('Insert STD : ' + StopWatch.ElapsedMilliseconds.ToString + ' ms');

  Button6Click(button6);
end;


procedure TTestForm.Button3Click(Sender: TObject);
var
 StopWatch: TStopwatch;
 i:integer;
begin
  ClientDataset1.FieldDefs.Add('CODE', FTSTRING,4,TRUE);
  ClientDataset1.FieldDefs.Add('NAME', ftSTRING,6,False);
  ClientDataset1.FieldDefs.Add('MARK', ftSTRING,10,false);
  ClientDataset1.CreateDataSet;
  ClientDataset1.open;
  StopWatch := TStopWatch.StartNew;

 for i := 1 to 1000 do
 begin
   ClientDataset1.insert;
   ClientDataset1.fields[0].AsString :=  inttostr(i);
   ClientDataset1.fields[1].AsString :=  inttostr(i);
   ClientDataset1.fields[2].AsString :=  inttostr(i);
   ClientDataset1.Post;
 end;
  StopWatch.Stop;
  Memo1.Lines.Add('Insert STD : ' + StopWatch.ElapsedMilliseconds.ToString + ' ms');

  Button6Click(button6);
end;


procedure TTestForm.Button4Click(Sender: TObject);
var
 StopWatch: TStopwatch;
 i:integer;
begin
 fdquery1.Close;
 fdquery1.SQL.Text := 'insert into test values (:pcode,:pname,:pmark)';
 fdquery1.Params.ArraySize := 1000;
 StopWatch := TStopWatch.StartNew;

 for i := 1 to 1000 do
 begin
   fdquery1.Params[0].AsString :=  inttostr(i);
   fdquery1.Params[1].AsString :=  inttostr(i);
   fdquery1.Params[2].AsString :=  'Mark' + inttostr(i);
   fdquery1.ExecSQL;
 end;
  StopWatch.Stop;
  Memo1.Lines.Add('Insert STD : ' + StopWatch.ElapsedMilliseconds.ToString + ' ms');

  Button6Click(button6);

end;

procedure TTestForm.Button5Click(Sender: TObject);
var
 StopWatch: TStopwatch;
 i:integer;
begin
  FDMemTable1.FieldDefs.Add('CODE', ftSTRING,4,TRUE);
  FDMemTable1.FieldDefs.Add('NAME', ftSTRING,6,False);
  FDMemTable1.FieldDefs.Add('MARK', ftSTRING,10,false);
  FDMemTable1.CreateDataSet;

  FDMemTable1.open;
  StopWatch := TStopWatch.StartNew;

 for i := 1 to 1000 do
 begin
   FDMemTable1.insert;
   FDMemTable1.fields[0].AsString :=  inttostr(i);
   FDMemTable1.fields[1].AsString :=  inttostr(i);
   FDMemTable1.fields[2].AsString :=  inttostr(i);
   FDMemTable1.post;
 end;
  StopWatch.Stop;
  Memo1.Lines.Add('Insert STD : ' + StopWatch.ElapsedMilliseconds.ToString + ' ms');
  Button6Click(button6);
end;


procedure TTestForm.Button6Click(Sender: TObject);
var
  i:word;
begin
 FDTable1.First;
 while not FDTable1.Eof  do
 begin
   FDtable1.Delete;
 end;
//  FdTable1.EmptyDataSet;
end;

procedure TTestForm.Button7Click(Sender: TObject);
var
 StopWatch: TStopwatch;
 i:integer;
begin

 FDQuery1.close;
 FDQuery1.SQL.Text := 'insert into test values (:pcode,:pname,:mark)';
 StopWatch := TStopWatch.StartNew;
 FDQuery1.Params.ArraySize := 1000;
 FDConnection1.StartTransaction;
 for i := 1 to 1000 do
 begin
   FDQuery1.Params[0].AsString :=  inttostr(i);
   FDQuery1.Params[1].AsString :=  inttostr(i);
   FDQuery1.Params[2].AsString :=  'Mark' + inttostr(i);
   FDQuery1.ExecSQL;
 end;
  FDConnection1.Commit;
  StopWatch.Stop;
  Memo1.Lines.Add('Insert STD : ' + StopWatch.ElapsedMilliseconds.ToString + ' ms');

  Button6Click(button6);
end;

procedure TTestForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
end;

end.
