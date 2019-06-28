unit UbatchMove;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.BatchMove.Text, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.DataSet, Vcl.Grids, Vcl.DBGrids, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  Datasnap.DBClient, FireDAC.Comp.BatchMove.JSON;

type
  TBatchForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DBLookupComboBox1: TDBLookupComboBox;
    FDMetaInfoQuery1: TFDMetaInfoQuery;
    metainfoSource: TDataSource;
    DBGrid1: TDBGrid;
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDBatchMoveTextWriter1: TFDBatchMoveTextWriter;
    DataSource1: TDataSource;
    FDMemTable1: TFDMemTable;
    FDBatchMove2: TFDBatchMove;
    FDBatchMoveTextReader1: TFDBatchMoveTextReader;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    Button4: TButton;
    Button5: TButton;
    BindingsList1: TBindingsList;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    ClientDataSet1: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    Button6: TButton;
    FDMemTable2: TFDMemTable;
    StringGrid1: TStringGrid;
    FDBatchMove3: TFDBatchMove;
    FDBatchMoveDataSetReader2: TFDBatchMoveDataSetReader;
    FDBatchMoveDataSetWriter2: TFDBatchMoveDataSetWriter;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    DataSource3: TDataSource;
    DBGrid3: TDBGrid;
    TabSheet4: TTabSheet;
    StringGrid2: TStringGrid;
    Button7: TButton;
    FDBatchMoveJSONWriter1: TFDBatchMoveJSONWriter;
    FDBatchMove4: TFDBatchMove;
    FDBatchMoveTextReader2: TFDBatchMoveTextReader;
    ClientDataSet2: TClientDataSet;
    FDBatchMoveDataSetReader3: TFDBatchMoveDataSetReader;
    BindSourceDB3: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource;
    ClientDataSet2Name: TStringField;
    ClientDataSet2Capital: TStringField;
    ClientDataSet2Continent: TStringField;
    ClientDataSet2Area: TFloatField;
    ClientDataSet2Population: TFloatField;
    Memo3: TMemo;
    Button8: TButton;
    Button2: TButton;
    Button1: TButton;
    Memo2: TMemo;
    Memo1: TMemo;
    RichEdit1: TRichEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BatchForm: TBatchForm;

implementation

{$R *.dfm}

uses Udm,System.JSON,System.IOUtils;

procedure TBatchForm.Button1Click(Sender: TObject);
begin
  if dbLookUpCombobox1.KeyValue = 'DEPT' then
     FDBatchMoveDatasetReader1.DataSet := dm.Dept
  else
     FDBatchMoveDatasetReader1.DataSet := dm.Insa;
  dataSource1.DataSet := FDBatchMoveDatasetReader1.DataSet;
end;

procedure TBatchForm.Button2Click(Sender: TObject);
begin
  if FileExists('FireDac_sample.txt') then
     DeleteFile('FireDac_sample.txt');

  FDBatchMove1.Execute;

  RichEdit1.Lines.Clear;
  RichEdit1.Lines.LoadFromFile('FireDac_sample.txt');
end;

procedure TBatchForm.Button4Click(Sender: TObject);
begin
  Memo3.Lines.Clear;
  Memo3.lines.LoadFromFile('FireDac_sample.txt');
end;

procedure TBatchForm.Button5Click(Sender: TObject);
begin
  FDBatchMove2.Execute;
end;

procedure TBatchForm.Button6Click(Sender: TObject);
begin
  FDBatchMove3.Execute;
end;

procedure TBatchForm.Button7Click(Sender: TObject);
begin
 if FileExists('sample.json') then
    DeleteFile('sample.json');

  FDBatchMove4.Execute;
  Memo1.Lines.LoadFromFile('sample.json');
 end;

procedure TBatchForm.Button8Click(Sender: TObject);
var
  FileName: TFileName;
  JSONValue, jv: TJSONValue;
begin
 // FileName := TPath.Combine(TPath.GetHomePath,'sample.json');
  FileName := 'sample.json';
  Memo2.Clear;
  JSONValue := TJSONObject.ParseJSONValue(TFile.ReadAllText(FileName));
  try
    if JSONValue is TJSONArray then
    begin
      for jv in TJSONArray(JSONValue) do
      begin
        Memo2.Lines.add('"' + jv.GetValue<string>('Name')+ '"' + ','
        + '"' + jv.GetValue<string>('Capital') + '"'+ ',' +
        '"' + jv.GetValue<string>('Continent') + '"'+ ',' +
        '"' + IntToStr(jv.GetValue<integer>('Area')) + '"'+ ',' +
        '"' + IntTostr(jv.GetValue<integer>('Population'))+ '"');
      end;
    end;
  finally
    JSONValue.Free;
  end;
end;

procedure TBatchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TBatchForm.FormCreate(Sender: TObject);
begin
  FDMemTable1.Close;
  FDMemTable1.FieldDefs.Add('CODE',ftString,4,true);
  FDMemTable1.FieldDefs.Add('DEPT',ftString,6,false);
  FDMemTable1.FieldDefs.Add('SECTION',ftString,8,false);
  FDMemTable1.CreateDataSet;
  FDMemTable1.Open;

  FDMemTable2.Close;
  FDMemTable2.FieldDefs.Add('NAME',ftString,20,true);
  FDMemTable2.FieldDefs.Add('SIZE',ftInteger);
  FDMemTable2.FieldDefs.Add('WEIGHT',ftInteger);
  FDMemTable2.CreateDataSet;

end;

end.
