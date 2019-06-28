unit uClientProductForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, ComCtrls, StdCtrls,
  DBCtrls, ExtCtrls, Buttons, ImgList;

type
  TClientProductForm = class(TForm)
    ProductDataSet: TClientDataSet;
    ProductSource: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    pdNumber: TEdit;
    pdName: TEdit;
    pdMedia: TComboBox;
    pdGenre: TComboBox;
    pdArtist: TEdit;
    pdProducer: TEdit;
    pdPrice: TEdit;
    pdMileage: TEdit;
    pdButtonImage: TButton;
    pdStock: TEdit;
    pdDetailInfo: TMemo;
    ImageOpenDialog: TOpenDialog;
    ProductDataSetproduct_num: TIntegerField;
    ProductDataSetname: TStringField;
    ProductDataSetimage: TBlobField;
    ProductDataSetgenre: TIntegerField;
    ProductDataSetmedia: TStringField;
    ProductDataSetscreen: TStringField;
    ProductDataSetaudio: TStringField;
    ProductDataSetartist: TStringField;
    ProductDataSetmaker: TStringField;
    ProductDataSetrelease_date: TDateField;
    ProductDataSetprice: TIntegerField;
    ProductDataSetmileage_rate: TSmallintField;
    ProductDataSetdetail_infor: TStringField;
    ProductDataSetstock_num: TIntegerField;
    pdNotImage: TLabel;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    pdImage: TDBImage;
    pdButtonApply: TBitBtn;
    pdButtonCancel: TBitBtn;
    pdReleaseDate: TDateTimePicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ImageList1: TImageList;
    pdButtonInsert: TBitBtn;
    pdButtonModify: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pdButtonInsertClick(Sender: TObject);
    procedure pdButtonModifyClick(Sender: TObject);
    procedure pdButtonApplyClick(Sender: TObject);
    procedure pdButtonCancelClick(Sender: TObject);
    procedure ProductDataNavigated;
    procedure pdButtonImageClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure pdNumberEnter(Sender: TObject);
    procedure ProductSourceDataChange(Sender: TObject; Field: TField);
    procedure ProductSourceStateChange(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ProductDetailLock(Locking: Boolean);
  public
    { Public declarations }
  end;

var
  ClientProductForm: TClientProductForm;

implementation

uses uClientModuleUnit, Jpeg;


{$R *.dfm}


procedure TClientProductForm.BitBtn1Click(Sender: TObject);
begin
  ProductDataSet.First;
end;

procedure TClientProductForm.BitBtn2Click(Sender: TObject);
begin
  if not ProductDataSet.Bof then begin
    ProductDataSet.Prior;
    ProductDataNavigated;
  end;
end;

procedure TClientProductForm.BitBtn3Click(Sender: TObject);
begin
  if not ProductDataSet.Eof then begin
      ProductDataSet.Next;
      ProductDataNavigated;
  end;
end;

procedure TClientProductForm.BitBtn4Click(Sender: TObject);
begin
  ProductDataSet.Last;
end;

procedure TClientProductForm.FormActivate(Sender: TObject);
begin
  ProductDataSet.Active := True;
  ProductDataNavigated;
  ProductDetailLock(True);
end;

procedure TClientProductForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TClientProductForm.pdButtonApplyClick(Sender: TObject);
begin
  { �Է�ĭ���� ���� DB�� ���� }
  ProductDataSetproduct_num.Value := StrToInt(pdNumber.Text);
  ProductDataSetname.Value := pdName.Text;
  ProductDataSetgenre.AsInteger := pdGenre.ItemIndex;
  ProductDataSetmedia.AsString := IntToStr(pdMedia.ItemIndex);
  ProductDataSetartist.AsString := pdArtist.Text;
  ProductDataSetmaker.AsString := pdProducer.Text;
  ProductDataSetrelease_date.AsDateTime := pdReleaseDate.DateTime;
  ProductDataSetprice.AsInteger := StrToInt(pdPrice.Text);
  ProductDataSetmileage_rate.AsInteger := StrToInt(pdMileage.Text);
  ProductDataSetdetail_infor.AsString := pdDetailInfo.Lines[0];
  ProductDataSetstock_num.AsInteger := StrToInt(pdStock.Text);

  with ProductDataSet do begin
    ApplyUpdates(-1);
  end;

  ProductDetailLock(True);
end;

procedure TClientProductForm.pdButtonCancelClick(Sender: TObject);
begin
  ProductDataSet.CancelUpdates;
  ProductDetailLock(True);
end;

procedure TClientProductForm.pdButtonImageClick(Sender: TObject);
begin
  if ImageOpenDialog.Execute then begin
    ProductDataSet.Edit;
    pdImage.Picture.LoadFromFile(ImageOpenDialog.FileName);
    pdNotImage.Visible := False;
    ProductDataSet.Post;
    ProductDataSet.ApplyUpdates(-1);
  end;
end;

procedure TClientProductForm.pdButtonInsertClick(Sender: TObject);
var
  NewProductNum: Integer;
begin
  // ���ڵ� ������ ���������� �̵�
  ProductDataSet.Last;
  //������ ��ǰ ��ȣ�� 1 ���ؼ�
  NewProductNum := ProductDataSetproduct_num.AsInteger + 1;

  ProductDetailLock(False);
  ProductDataSet.First;
  ProductDataSet.Insert;
    ProductDataNavigated;
  pdNumber.Text := IntToStr(NewProductNum);
  pdPrice.Text := '';
  pdMileage.Text := '';
  pdReleaseDate.DateTime := Now;
  pdName.SetFocus;
end;

procedure TClientProductForm.pdButtonModifyClick(Sender: TObject);
begin
  ProductDetailLock(False);
  ProductDataSet.Edit;
  ProductDataNavigated;
  pdPrice.Text := ProductDataSetprice.AsString;
  pdMileage.Text := ProductDataSetmileage_rate.AsString;
  pdName.SetFocus;
end;

procedure TClientProductForm.pdNumberEnter(Sender: TObject);
begin
  if ProductDataSet.State in [dsEdit, dsInsert] then begin
    ShowMessage('��ǰ ��ȣ�� ������ �� �����ϴ�.');
    pdName.SetFocus;
  end;
end;

procedure TClientProductForm.ProductDetailLock(Locking: Boolean);
begin
  // �߰�, ���� ���°� �ƴ� �� ������Ʈ�� ���
  pdNumber.ReadOnly := Locking;
  pdName.ReadOnly := Locking;
  pdMedia.Enabled := not Locking;
  pdGenre.Enabled := not Locking;
  pdArtist.ReadOnly := Locking;
  pdProducer.ReadOnly := Locking;
  pdReleaseDate.Enabled := not Locking;
  pdPrice.ReadOnly := Locking;
  pdMileage.ReadOnly := Locking;
  pdStock.ReadOnly := Locking;
  pdDetailInfo.ReadOnly := Locking;
//  pdButtonImage.Visible := not Locking;
  pdButtonInsert.Visible := Locking;
  pdButtonModify.Visible := Locking;
  pdButtonApply.Visible := not Locking;
  pdButtonCancel.Visible := not Locking;
  if Locking then
    pdImage.OnDblClick := nil
  else begin
    pdImage.OnDblClick := pdButtonImageClick
  end;
end;

procedure TClientProductForm.ProductSourceDataChange(Sender: TObject;
  Field: TField);
begin
  ProductDataNavigated;
end;

procedure TClientProductForm.ProductSourceStateChange(Sender: TObject);
begin
  if ProductDataSet.State = dsBrowse then begin
    ProductSource.OnDataChange := ProductSourceDataChange;
    Exit;
  end;
  ProductSource.OnDataChange := nil;
end;

procedure TClientProductForm.ProductDataNavigated;
var
  BlobStream: TStream;
begin
  // ���ڵ� ������ ���� ������ �� ���� ���� ��
  pdNotImage.Visible := False;
  pdNumber.Text := ProductDataSetproduct_num.AsString;
  pdName.Text := ProductDataSetname.AsString;

    // insert ��� ���Խ� null ���� itemindex�� �� �� �����Ƿ� �ʱⰪ0���� ����
    if ProductDataSetmedia.IsNull then
      pdMedia.ItemIndex := 0
    else begin
      pdMedia.ItemIndex := ProductDataSetmedia.AsInteger;
    end;
    if ProductDataSetgenre.IsNull then
      pdGenre.ItemIndex := 0
    else begin
      pdGenre.ItemIndex := ProductDataSetgenre.AsInteger;
    end;

  pdArtist.Text := ProductDataSetartist.AsString;
  pdProducer.Text := ProductDataSetmaker.AsString;
  pdReleaseDate.DateTime := ProductDataSetrelease_date.AsDateTime;
  pdPrice.Text := Format('%.0n', [ProductDataSetprice.AsFloat]) + '��';
  pdMileage.Text := ProductDataSetmileage_rate.AsString + '%';
  pdStock.Text := ProductDataSetstock_num.AsString;
  pdDetailInfo.Text := ProductDataSetdetail_infor.AsString;


  { < TImage�� �� ��� ... >

    // �̹����� �ִٸ� ��� (Blob -> TImage)
    if not ProductDataSetimage.IsNull then begin
      BlobStream := ProductDataSet.CreateBlobStream(ProductDataSetimage,bmRead);
      pdImage.Picture.Bitmap.LoadFromStream(BlobStream);
    end else begin
      pdImage.Picture := nil;
      pdNotImage.Visible := True;
    end;
  }
end;

end.
