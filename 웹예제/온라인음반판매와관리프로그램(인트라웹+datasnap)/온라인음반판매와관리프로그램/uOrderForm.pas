unit uOrderForm;

interface

uses
  Classes, Graphics, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, FMTBcd,
  DBXDataSnap, DBXCommon, DBClient, DSConnect, DB, SqlExpr, IWGrids, IWDBGrids,
  IWCompButton, IWCompEdit, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, jpeg, IWExtCtrls, IWCompCheckbox;

type
  TOrderForm = class(TIWAppForm)
    DelSelectedItemButton: TIWButton;
    CartData: TClientDataSet;
    CartItemDelMethod: TSqlServerMethod;
    SQLConnection: TSQLConnection;
    DSProvider: TDSProviderConnection;
    ProductData: TClientDataSet;
    BackToHomeButton: TIWButton;
    OrderButton: TIWButton;
    TitleLabel: TIWLabel;
    TitleImage: TIWImage;
    procedure DelSelectedItemButtonClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure BackToHomeButtonClick(Sender: TObject);
    procedure OrderButtonClick(Sender: TObject);
  private
    CartItemCount : Integer;                      // īƮ ������ ����
    miProductNum  : Array[1..20] of Integer;      // ��ǰ ��ȣ
    miImage       : Array[1..20] of TIWImage;     // ��ǰ �̹���
    miName        : Array[1..20] of TIWLabel;     // ��ǰ��
    miPrice       : Array[1..20] of TIWLabel;     // ��ǰ����
    miDelCheck    : Array[1..20] of TIWCheckBox;  // ���� ���� üũ�ڽ�
    miTotalCharge : TIWLabel;                     // ���� �հ�
    procedure ReDrawPage;
    procedure CartRefresh;
    procedure ProductQuery(PNum: Integer);
  end;

implementation

uses uVars, uHomeForm, uOrderFinalForm;

var
  OrderForm: TOrderForm;

{$R *.dfm}

procedure TOrderForm.IWAppFormCreate(Sender: TObject);
var
  I : Integer;
  ItemCharge, TotalCharge : Real;
  BlobStream : TStream;
  miTermCart, miTopCart : Integer;
begin
  BlobStream  := nil;
  miTermCart  := miTerm - 50;
  miTopCart   := miTop + 50;
  TotalCharge := 0;
  CartRefresh;
  CartItemCount := CartData.RecordCount;

  // ���м�
  with TIWLabel.Create(WebApplication) do begin
    Caption   := '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ';
    Left      := miLeft;
    Top       := miTopCart + miTermCart - 20;
    Width     := 600;
    Font.Size := 8;
    Parent    := Self;
  end;

  for I := 1 to CartItemCount do begin
    miProductNum[I] := CartData.FieldByName('product_num').AsInteger;
    // ��ǰ ���� ����
    ProductQuery(miProductNum[I]);

    // �̹���
    miImage[I] := TIWImage.Create(WebApplication);
    with miImage[I] do begin
      Left    := miLeft ;
      Top     := miTopCart + I * miTermCart;
      UseSize := True;
      Width   := 50;
      Height  := 50;
      if not ProductData.FieldByName('image').IsNull then begin
        try
          BlobStream := ProductData.CreateBlobStream(ProductData.FieldByName('image'), bmRead);
          Picture.Bitmap.LoadFromStream(BlobStream);
        finally
          BlobStream.Free;
        end;
      end;
      Parent  := Self;
    end;

    // ��ǰ��
    miName[I] := TIWLabel.Create(WebApplication);
    with miName[I] do begin
      Caption       := ProductData.FieldByName('name').AsString;
      Left          := miLeft + 70;
      Top           := miTopCart + I * miTermCart + 5;
      Width         := 400;
      Font.FontName := '����';
      Font.Size     := 10;
      Font.Style    := Font.Style + [fsBold];
      Parent        := Self;
    end;

    // ����, ����, �����۴� ���� ���
      // ��ǰ ���� x ����
    ItemCharge := ProductData.FieldByName('price').AsFloat * CartData.FieldByName('quantity').AsFloat;
      // ���� ����
    TotalCharge := TotalCharge + ItemCharge;

    miPrice[I] := TIWLabel.Create(WebApplication);
    with miPrice[I] do begin
      Caption := ' | ' + Format('%.0n', [ProductData.FieldByName('price').AsFloat]) + '�� x ' +
                 CartData.FieldByName('quantity').AsString + '�� = ' + Format('%.0n', [ItemCharge]) + '��';
      Left    := miLeft + 70;
      Top     := miTopCart + I * miTermCart + 28;
      Width   := 400;
      Parent  := Self;
    end;

    // ���� üũ�ڽ�
    miDelCheck[I] := TIWCheckBox.Create(WebApplication);
    with miDelCheck[I] do begin
      Caption    := ': ����';
      StatusText := CartData.FieldByName('product_num').AsString;
      Left       := miLeft + 340;
      Top        := miTopCart + I * miTermCart + 26;
      Parent     := Self;
    end;

    // ���м�
    with TIWLabel.Create(WebApplication) do begin
      Caption   := '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ';
      Left      := miLeft;
      Top       := miTopCart + I * miTermCart + 50;
      Width     := 600;
      Font.Size := 8;
      Parent    := Self;
    end;

    CartData.Next;
  end;

  // �� ����
  miTotalCharge := TIWLabel.Create(WebApplication);
  with miTotalCharge do begin
    Caption    := '�Ѱ� : ' + Format('%.0n', [TotalCharge]) + '��';
    Left       := miLeft + 330;
    Top        := miTopCart + (CartItemCount + 1) * miTermCart + 5;
    Width      := 400;
    Font.Style := Font.Style + [fsBold];
    Parent     := Self;
  end;
end;

procedure TOrderForm.ReDrawPage;
begin
  Release;
  OrderForm := TOrderForm.Create(WebApplication);
  OrderForm.Show;
end;

procedure TOrderForm.CartRefresh;
begin
  CartData.Close;
  CartData.Params[0].AsString := UserID;
  CartData.Open;
end;

procedure TOrderForm.ProductQuery(PNum: Integer);
begin
  ProductData.Close;
  ProductData.Params[0].AsInteger := PNum;
  ProductData.Open;
end;

procedure TOrderForm.BackToHomeButtonClick(Sender: TObject);
begin
  Release;
  THomeForm.Create(WebApplication).Show;
end;

procedure TOrderForm.OrderButtonClick(Sender: TObject);
begin
  Release;
  TOrderFinalForm.Create(WebApplication).Show;
end;

procedure TOrderForm.DelSelectedItemButtonClick(Sender: TObject);
var
  I : Integer;
begin
  for I := 1 to CartItemCount do begin
    if miDelCheck[I].Checked = True then begin
      CartItemDelMethod.ParamByName('ID'        ).AsString  := UserID;
      CartItemDelMethod.ParamByName('ProductNum').AsInteger := miProductNum[I];
      CartItemDelMethod.ExecuteMethod;
    end;
  end;
  ReDrawPage;
end;

end.
