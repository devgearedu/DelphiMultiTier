unit uHomeForm;

interface

uses
  Classes, Graphics, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWHTMLControls,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, DBXDataSnap, DBXCommon, DB, IWGrids, IWDBGrids, DBClient,
  DSConnect, SqlExpr, FMTBcd, IWCompButton, IWCompEdit, IWCompCheckbox,
  IWDBStdCtrls, IWExtCtrls, IWDBExtCtrls, jpeg, IWCompListbox,IndyPeerImpl;

type
  THomeForm = class(TIWAppForm)
    SQLConnection: TSQLConnection;
    DSProvider: TDSProviderConnection;
    ProductData: TClientDataSet;
    ProductDataproduct_num: TIntegerField;
    ProductDataname: TStringField;
    ProductDataimage: TBlobField;
    ProductDatagenre: TIntegerField;
    ProductDatamedia: TStringField;
    ProductDatascreen: TStringField;
    ProductDataaudio: TStringField;
    ProductDataartist: TStringField;
    ProductDatamaker: TStringField;
    ProductDatarelease_date: TDateField;
    ProductDataprice: TIntegerField;
    ProductDatamileage_rate: TSmallintField;
    ProductDatadetail_infor: TStringField;
    ProductDatastock_num: TIntegerField;
    ProductDatagenretext: TStringField;
    ProductDatamediatext: TStringField;
    AddToCartMethod: TSqlServerMethod;
    lkOrder: TIWButton;
    TitleImage: TIWImage;
    ItemCountPerAPage: TIWComboBox;
    TitleLabel: TIWLabel;
    lkLogin: TIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure lkLoginClick(Sender: TObject);
    procedure ProductDataCalcFields(DataSet: TDataSet);
    procedure lkOrderClick(Sender: TObject);
    procedure PlusMinusClick(Sender: TObject);
    procedure AddToCartClick(Sender: TObject);
    procedure PageNumberClick(Sender: TObject);
    procedure ItemCountPerAPageChange(Sender: TObject);
  private
    miPageNum       : Array[1..100] of TIWLink;      // ������ ��ȣ
    miProductNum    : Array[1.. 20] of Integer;      // ��ǰ ��ȣ
    miImage         : Array[1.. 20] of TIWImage;     // ��ǰ �̹���
    miName          : Array[1.. 20] of TIWLabel;     // ��ǰ��
    miEtcInfo       : Array[1.. 20] of TIWLabel;     // ��ǰ ��Ÿ ����
    miPrice         : Array[1.. 20] of TIWLabel;     // ��ǰ ����
    miInput         : Array[1.. 20] of TIWLabel;     // ���� �ؽ�Ʈ
    miInputQuantity : Array[1.. 20] of TIWEdit;      // ���� �Է�ĭ
    miInputPlus     : Array[1.. 20] of TIWButton;    // ���� +
    miInputMinus    : Array[1.. 20] of TIWButton;    // ���� -
    miAddToCart     : Array[1.. 20] of TIWButton;    // 'īƮ�� �߰�' ��ư
    procedure ReDrawPage;
  end;

implementation

uses uLoginForm, uVars, uOrderForm;

const
  PLUS_BTN = 100;
  MINUS_BTN = 101;

var
  HomeForm: THomeForm;

{$R *.dfm}

procedure THomeForm.IWAppFormCreate(Sender: TObject);
var
  I : Integer;
  BlobStream : TStream;
  LastPage : Integer;
begin
  BlobStream  := nil;

  { �α��� ���¿� ���� ��ư ĸ�� ��ȯ }
  if LogInState then lkLogin.Caption := '�α׾ƿ�'
                else lkLogin.Caption := '�α���';

  { ��� ���� ���� �޺��ڽ� ���� }
  with ItemCountPerAPage do begin
    Left := miLeft + 420;
    Top  := miTop + miTerm - 52;
    case ItemViewCount of
       5 : ItemIndex := 0;
      10 : ItemIndex := 1;
      20 : ItemIndex := 2;
    end;
  end;

  { ---  ��ǰ ����Ʈ ���  -----------------------------------------------------
      * ���� ������(uVars.pas)�� �����ؼ� ������Ʈ���� �������� ����.
      * ������Ʈ���� �ʵ� ������ �迭�� ������.
          ��) ��ǰ���� miName�̶�� �̸��� TIWLabel �迭�� ����.
      * Ŭ�� �̺�Ʈ�� �ʿ��� ������Ʈ��(������ ��ȣ ��ũ, ���� ���� ��ư, īƮ��
        �߰� ��ư)�� Tag ������Ƽ���� �ڽ��� ���� �迭�� ÷�ڸ� �����ؼ� �̺�Ʈ
        �� �߻��� ������Ʈ�� ã�� �� �ֵ��� ��.
    ---------------------------------------------------------------------------}

  // ������ ��ȣ
  LastPage := ProductData.RecordCount div ItemViewCount;
  if ProductData.RecordCount mod ItemViewCount > 0 then
    Inc(LastPage);

  for I := 1 to LastPage do begin
    miPageNum[I] := TIWLink.Create(WebApplication);
    with miPageNum[I] do begin
      Caption    := '[ ' + IntToStr(I) + ' ]';
      Left       := miLeft + I * 30 + 100;
      Top        := miTop + miTerm - 50;
      Tag        := I;
      Font.Color := clBlack;
      OnClick    := PageNumberClick;
      Parent     := Self;
    end;
  end;
  miPageNum[ClickedNumber].Font.Style :=
    miPageNum[ClickedNumber].Font.Style + [fsBold];   // ���� ������ ��ȣ Bold

  // ���ڵ� �����Ͱ� ��ó���� �ƴ϶�� ����Ű�� ��ġ��ŭ �̵�
  if RecordPointer > 0 then begin
    for I := 1 to RecordPointer do
      ProductData.Next;
  end;

  // ���м�
  with TIWLabel.Create(WebApplication) do begin
    Caption   := '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ';
    Left      := miLeft;
    Top       := miTop + miTerm - 20;
    Width     := 600;
    Font.Size := 8;
    Parent    := Self;
  end;

  // �� ���� ����� ��ǰ��������(ItemViewCount)��ŭ ���
  for I := 1 to ItemViewCount do begin

    // ��ǰ ��ȣ ����
    miProductNum[I] := ProductDataproduct_num.AsInteger;

    // �̹���
    miImage[I] := TIWImage.Create(WebApplication);
    with miImage[I] do begin
      Left    := miLeft ;
      Top     := miTop + I * miTerm;
      UseSize := True;
      Width   := 100;
      Height  := 100;
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

    // ��ǰ��, ��Ƽ��Ʈ
    miName[I] := TIWLabel.Create(WebApplication);
    with miName[I] do begin
      Caption       := ProductDataname.AsString + ' (' + ProductDataartist.AsString + ')';
      Left          := miLeft + 120;
      Top           := miTop + I * miTerm + 5;
      Width         := 400;
      Font.FontName := '����';
      Font.Size     := 10;
      Font.Style    := Font.Style + [fsBold];
      Parent        := Self;
    end;

    // ���ۻ�, �߸���, ��� ����
    miEtcInfo[I] := TIWLabel.Create(WebApplication);
    with miEtcInfo[I] do begin
      Caption := ' | ���� : ' + ProductDatamaker.AsString +
                 ' | �߸��� : ' + ProductDatarelease_date.AsString +
                 ' | ��� : ' + ProductDatastock_num.AsString + ' |';
      Left    := miLeft + 130;
      Top     := miTop + I * miTerm + 32;
      Width   := 400;
      Parent  := Self;
    end;

    // ����, ���ϸ���
    miPrice[I] := TIWLabel.Create(WebApplication);
    with miPrice[I] do begin
      Caption := ' | ���� : '
                 + Format('%.0n', [ProductDataprice.AsFloat])
                 + '�� | ���ϸ��� : '
                 + Format('%.0n', [(ProductDatamileage_rate.AsFloat * ProductDataprice.AsFloat / 100)])
                 + '�� |';
      Left    := miLeft + 130;
      Top     := miTop + I * miTerm + 48;
      Width   := 400;
      Parent  := Self;
    end;

    // ����
    miInput[I] := TIWLabel.Create(WebApplication);
    with miInput[I] do begin
      Caption := ' ���� :';
      Left    := miLeft + 400;
      Top     := miTop + I * miTerm + 60;
      Width   := 400;
      Parent  := Self;
    end;

    // ���� �Է�ĭ
    miInputQuantity[I] := TIWEdit.Create(WebApplication);
    with miInputQuantity[I] do begin
      Text      := '1';
      ReadOnly  := True;
      Font.Size := 9;
      Width     := 25;
      Height    := 20;
      Left      := miLeft + 435;
      Top       := miTop + I * miTerm + 57;
      Parent    := Self;
    end;

    // ���� ���� ��ư
      // + ��ư
    miInputPlus[I] := TIWButton.Create(WebApplication);
    with miInputPlus[I] do begin
      Text       := '+';
      Font.Size  := 7;
      Width      := 20;
      Height     := 20;
      Left       := miLeft + 460;
      Top        := miTop + I * miTerm + 57;
      Tag        := I;
      OnClick    := PlusMinusClick;
      StatusText := IntToStr(PLUS_BTN);
      Parent     := Self;
    end;
      // - ��ư
    miInputMinus[I] := TIWButton.Create(WebApplication);
    with miInputMinus[I] do begin
      Text       := '-';
      Font.Size  := 7;
      Width      := 20;
      Height     := 20;
      Left       := miLeft + 480;
      Top        := miTop + I * miTerm + 57;
      Tag        := I;
      OnClick    := PlusMinusClick;
      StatusText := IntToStr(MINUS_BTN);
      Parent     := Self;
    end;

    // īƮ�� �߰� ��ư
    miAddToCart[I] := TIWButton.Create(WebApplication);
    with miAddToCart[I] do begin
      Text       := 'īƮ�� �߰�';
      Font.Size  := 10;
      Width      := 110;
      Height     := 20;
      Left       := miLeft + 395;
      Top        := miTop + I * miTerm + 80;
      Tag        := I;
      OnClick    := AddToCartClick;
      Parent     := Self;
      // ��� 0�̸� ��ư ��Ȱ��ȭ
      if ProductDatastock_num.AsInteger = 0 then begin
        Text     := 'ǰ  ��';
        Enabled  := False;
      end;
    end;

    // ���м�
    with TIWLabel.Create(WebApplication) do begin;
      Caption   := '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ';
      Left      := miLeft;
      Top       := miTop + I * miTerm + 100;
      Width     := 600;
      Font.Size := 8;
      Parent    := Self;
    end;

    ProductData.Next;
    // DB�� ����� ������ ��ǰ�̾��ٸ� �׸� ���
    if ProductData.Eof then
      break;
  end;
end;

procedure THomeForm.ItemCountPerAPageChange(Sender: TObject);
begin
  // �� �������� ����� ������ ���� ����
  case ItemCountPerAPage.ItemIndex of
    0 : ItemViewCount := 5;
    1 : ItemViewCount := 10;
    2 : ItemViewCount := 20;
  end;
  ClickedNumber := 1;
  RecordPointer := 0;
  ReDrawPage;
end;

{ īƮ�� ��ǰ �߰� ��ư }
procedure THomeForm.AddToCartClick(Sender: TObject);
var
  I, ProductNum, Quantity : Integer;
begin
  if not LogInState then begin
    WebApplication.ShowMessage('�α��� �� �̿��ϼ���.');
    Exit;
  end;

  // ���� ��ư�� ����Ű�� ��ǰ ��ȣ�� ������ ã��
  I := (Sender as TIWButton).Tag;
  ProductNum := miProductNum[I];
  Quantity := StrToInt(miInputQuantity[I].Text);
  // īƮ�� �߰� �޼ҵ� ����
  with AddToCartMethod do begin
    ParamByName('Id'        ).AsString  := UserID;
    ParamByName('ProductNum').AsInteger := ProductNum;
    ParamByName('Quantity'  ).AsInteger := Quantity;
    ExecuteMethod;
  end;
  WebApplication.ShowMessage('īƮ�� �߰��Ǿ����ϴ�.');
end;

{ ���� ���� ��ư }
procedure THomeForm.PlusMinusClick(Sender: TObject);
var
  I : Integer;
begin
  // ���� ��ư�� �ش��ϴ� ���� �Է�ĭ�� ã��
  I := (Sender as TIWButton).Tag;

  with miInputQuantity[I] do begin
    case StrToInt((Sender as TIWButton).StatusText) of
      PLUS_BTN  : Text := IntToStr(StrToInt(Text) + 1);
      MINUS_BTN : if StrToInt(Text) > 1 then
                    Text := IntToStr(StrToInt(Text) - 1);
    end;
  end;
end;

{ �α���/�α׾ƿ� ��ư }
procedure THomeForm.lkLoginClick(Sender: TObject);
begin
  // �α� �ƿ�
  if LogInState = True then begin
    LogInState := False;
    UserID := '';
    lkLogin.Caption := '�α���';
    Exit;
  end;

  // �α��� �������� �̵�
  Release;
  TLoginForm.Create(WebApplication).Show;
end;

{ īƮ����/�ֹ� ��ư }
procedure THomeForm.lkOrderClick(Sender: TObject);
begin
  if not LogInState then begin
    WebApplication.ShowMessage('�α��� �� �̿��ϼ���.');
    Exit;
  end;

  TOrderForm.Create(WebApplication).Show;
end;

{ ������ ��ȣ ��ũ }
procedure THomeForm.PageNumberClick(Sender: TObject);
begin
  // ���� ������ ��ȣ�� �� ���� ����� ������ ������ ���� ��ǰ ���ڵ� ������ ����
  ClickedNumber := (Sender as TIWLink).Tag;

  RecordPointer := (ClickedNumber - 1) * ItemViewCount;
  ReDrawPage;
end;

procedure THomeForm.ProductDataCalcFields(DataSet: TDataSet);
var
  GenreName : String;
  MediaName : String;
begin
  { DB�� �ڵ�� ����� �帣, �̵�� ������ ��¿� �ؽ�Ʈ�� ���� }
  case ProductData.FieldByName('genre').AsInteger of
     0 : GenreName := '����';
     1 : GenreName := 'POP';
     2 : GenreName := 'J-POP';
     3 : GenreName := 'ROCK';
     4 : GenreName := 'Ŭ����';
     5 : GenreName := '����';
     6 : GenreName := 'JAZZ';
     7 : GenreName := 'NEW AGE';
     8 : GenreName := 'WORLD MUSIC';
     9 : GenreName := '��������';
    10 : GenreName := 'SOUNDTRACK';
    11 : GenreName := '����/���';
  end;

  case ProductData.FieldByName('media').AsInteger of
     0 : MediaName := 'CD';
     1 : MediaName := 'DVD';
  end;

  ProductDatagenretext.AsString := GenreName;
  ProductDatamediatext.AsString := MediaName;
end;

procedure THomeForm.ReDrawPage;
begin
  Release;
  HomeForm := THomeForm.Create(WebApplication);
  HomeForm.Show;
end;

initialization
  THomeForm.SetAsMainForm;
end.
