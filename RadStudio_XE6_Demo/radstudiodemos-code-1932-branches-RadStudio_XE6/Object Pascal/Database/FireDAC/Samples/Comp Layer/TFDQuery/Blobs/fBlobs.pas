unit fBlobs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, DB, ComCtrls, Buttons,
  fMainQueryBase,
  FireDAC.Stan.Intf, FireDAC.DatS, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.VCLUI.ResourceOptions, FireDAC.VCLUI.FetchOptions,
    FireDAC.VCLUI.FormatOptions, FireDAC.VCLUI.UpdateOptions,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.Controls, FireDAC.Stan.Error;

type
  TfrmMain = class(TfrmMainQueryBase)
    qCategories: TFDQuery;
    dsCategories: TDataSource;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    Image1: TImage;
    DBNavigator1: TDBNavigator;
    btnClrPic: TButton;
    btnSavePic: TButton;
    btnLoadPic: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    qCategoriesCategoryID: TIntegerField;
    qCategoriesCategoryName: TStringField;
    qCategoriesDescription: TMemoField;
    qCategoriesPicture: TBlobField;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure dsCategoriesDataChange(Sender: TObject; Field: TField);
    procedure cbDBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnClrPicClick(Sender: TObject);
    procedure btnSavePicClick(Sender: TObject);
    procedure btnLoadPicClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses dmMainComp;

{$R *.dfm}

procedure TfrmMain.cbDBClick(Sender: TObject);
begin
  qCategories.Close;
  inherited cbDBClick(Sender);
  qCategories.Open;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited FormCreate(Sender);
  RegisterDS(qCategories);
end;

procedure TfrmMain.dsCategoriesDataChange(Sender: TObject;
  Field: TField);
var
  oStr: TStream;
  oBmp: TBitmap;
  s: AnsiString;
  i: Integer;
begin
  oStr := qCategories.CreateBlobStream(qCategories.FieldByName('Picture'), bmRead);
  try
    if oStr.Size = 0 then
      Image1.Visible := False
    else begin
      SetLength(s, oStr.Size);
      oStr.Read(PAnsiChar(s)^, oStr.Size);
      i := Pos('BM', s);
      if i <> -1 then
        oStr.Position := i - 1;
      oBmp := TBitmap.Create;
      try
        oBmp.LoadFromStream(oStr);
        Image1.Picture.Bitmap := oBmp;
        Image1.Visible := True;
      finally
        oBmp.Free;
      end;
    end;
  finally
    oStr.Free;
  end;
end;

procedure TfrmMain.btnClrPicClick(Sender: TObject);
begin
  if not (qCategories.State in dsEditModes) then
    qCategories.Edit;
  qCategories.FieldByName('Picture').Clear;
end;

procedure TfrmMain.btnSavePicClick(Sender: TObject);
var
  oFld: TBlobField;
begin
  oFld := TBlobField(qCategories.FieldByName('Picture'));
  if not oFld.IsNull and SaveDialog1.Execute then
    oFld.SaveToFile(SaveDialog1.FileName);
end;

procedure TfrmMain.btnLoadPicClick(Sender: TObject);
var
  oFld: TBlobField;
begin
  oFld := TBlobField(qCategories.FieldByName('Picture'));
  if OpenDialog1.Execute then begin
    if not (qCategories.State in dsEditModes) then
      qCategories.Edit;
    oFld.LoadFromFile(OpenDialog1.FileName);
  end;
end;

end.
