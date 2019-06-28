unit uServerMethodsUnit;

interface

uses
  SysUtils, Classes, DSServer, DBXInterBase, DB, SqlExpr, FMTBcd, Provider, SqlTimSt,IndyPeerImpl;

type
  TServerMethods = class(TDSServerModule)
    SQLConnection: TSQLConnection;
    OrderTable: TSQLTable;
    OrderTableProvider: TDataSetProvider;
    OrderedProductsQuery: TSQLQuery;
    OrderedProductsQueryProvider: TDataSetProvider;
    InvoiceQuery: TSQLQuery;
    InvoiceQueryProvider: TDataSetProvider;
    MemberQuery: TSQLQuery;
    MemberQueryProvider: TDataSetProvider;
    InsertOrderQuery: TSQLQuery;
    GetOrderNumQuery: TSQLQuery;
    InsertInvoiceQuery: TSQLQuery;
    InsertOrderedProductsSQLQuery: TSQLQuery;
    CartQuery: TSQLQuery;
    ProductQuery: TSQLQuery;
    InsertProductToCartQuery: TSQLQuery;
    ProductStockUpdateQuery: TSQLQuery;
    CartDelQuery: TSQLQuery;
    CartUpateQuery: TSQLQuery;
    ProductTable: TSQLTable;
    ProductTableProvider: TDataSetProvider;
    CartQueryProvider: TDataSetProvider;
    CartProductDelQuery: TSQLQuery;
    ProductQueryProvider: TDataSetProvider;
    OrderedProductByMonth: TSQLQuery;
    OrderedProductByMonthProvider: TDataSetProvider;
    VisitCountTable: TSQLTable;
    VisitCountProvider: TDataSetProvider;
    MemberTable: TSQLTable;
    MemberTableProvider: TDataSetProvider;
  private
    function GetOrderNum: String; // �ֹ� ��ȣ �����ؼ� ����
  public
    procedure InsertProductToCart(Id: String; ProductNum, Quantity: Integer); // īƮ�� ��ǰ �߰�
    function InsertOrder(Id, ivcName, ivcTel, ivcAddress: string): Boolean; // �ֹ��� �ۼ�
    procedure CartProductDel(ID: String; ProductNum: Integer);  // īƮ�� ��ǰ ����
  end;

implementation

{$R *.dfm}

uses StrUtils;


{ TServerMethods }

procedure TServerMethods.CartProductDel(ID: String; ProductNum: Integer);
begin
  CartProductDelQuery.Close;
  CartProductDelQuery.ParamByName('pid').AsString := ID;
  CartProductDelQuery.ParamByName('pnum').AsInteger := ProductNum;
  CartProductDelQuery.ExecSQL;
end;

function TServerMethods.GetOrderNum: String;
var
  T, I: Integer;
  Tmp, R: String;
begin

  { ���� ��¥�� �ش��ϴ� �ֹ� �Ϸù�ȣ�� �޾ƿ� }

  // ���� ��¥�� �ش��ϴ� Serial ����
  GetOrderNumQuery.Close;
  GetOrderNumQuery.SQL.Clear;
  GetOrderNumQuery.SQL.Add('SELECT "serial" FROM "ordernum" WHERE "date" = '+ FormatDateTime('yymmdd', Now));
  GetOrderNumQuery.Open;

  // ���� ��¥�� ���� ���ڵ尡 ������ ����
  if GetOrderNumQuery.IsEmpty then begin
    GetOrderNumQuery.Close;
    GetOrderNumQuery.SQL.Clear;
    GetOrderNumQuery.SQL.Add('INSERT INTO "ordernum" ("date", "serial") VALUES ('''+ FormatDateTime('yymmdd', Now) +''', 0)');
    GetOrderNumQuery.ExecSQL;
  end;

  // ���� ��¥�� �ش��ϴ� Serial �����ؼ� T�� ���
  GetOrderNumQuery.Close;
  GetOrderNumQuery.SQL.Clear;
  GetOrderNumQuery.SQL.Add('SELECT "serial" FROM "ordernum" WHERE "date" = '+ FormatDateTime('yymmdd', Now));
  GetOrderNumQuery.Open;
  T := GetOrderNumQuery.FieldByName('serial').AsInteger;

  // 6�ڸ��� ���� 0ä�� ���ڿ��� ��ȯ
  Tmp := IntToStr(T);
  if Length(Tmp) < 6 then begin
    for I := 1 to 6-Length(Tmp) do
      R := R + '0';
  end;
  R := R + Tmp;

  // Serial 1 ���� ��Ŵ
  GetOrderNumQuery.Close;
  GetOrderNumQuery.SQL.Clear;
  GetOrderNumQuery.SQL.Add('UPDATE "ordernum" SET "serial" = '+ IntToStr(T+1)
                        + ' WHERE "date" = ' + FormatDateTime('yymmdd', Now));
  GetOrderNumQuery.ExecSQL;

  // ��¥ �ٿ��� ����
  Result := FormatDateTime('yymmdd', Now) + R;

end;

function TServerMethods.InsertOrder(Id, ivcName, ivcTel, ivcAddress: string): Boolean;
var
  OrderNumber: String;
  Mileage, TotalCharge, A_Unit_Mileage: Integer;
  Stock: Integer;
  TransDesc: TTransactionDesc;
begin
  Mileage := 0;
  TotalCharge := 0;
  Stock := 0;


    { �ֹ� ��ȣ �޾ƿ��� }
    OrderNumber := GetOrderNum;

    { īƮ�� ��� ���� ��ȸ }
    CartQuery.Close;
    CartQuery.ParamByName('pid').AsString := Id;
    CartQuery.Open;


    { �ֹ� ��ǰ ��� �ۼ�  --------------------------------------------------- }
    while not CartQuery.Eof do begin

      // īƮ�� ��� ��ǰ ��ȣ�� ��ǰ ������ ��ȸ
      ProductQuery.Close;
      ProductQuery.ParamByName('pproduct_num').AsInteger := CartQuery.FieldByName('product_num').AsInteger;
      ProductQuery.Open;
      Stock := ProductQuery.FieldByName('stock_num').AsInteger;   // ��� ����

      // �ۼ� ����
      with InsertOrderedProductsSQLQuery do begin
        Close;
        ParamByName('porder_num').AsString := OrderNumber;
        ParamByName('pdate').AsSQLTimeStamp := DateTimeToSQLTimeStamp(Now);
        ParamByName('pproduct_num').AsInteger := CartQuery.FieldByName('product_num').AsInteger;
        ParamByName('pname').AsString := ProductQuery.FieldByName('name').AsString;
        ParamByName('pprice').AsInteger := ProductQuery.FieldByName('price').AsInteger;
        A_Unit_Mileage := ProductQuery.FieldByName('price').AsInteger * ProductQuery.FieldByName('mileage_rate').AsInteger div 100;
        ParamByName('pa_unit_mileage').AsInteger := A_Unit_Mileage;
        ParamByName('pquantity').AsInteger := CartQuery.FieldByName('quantity').AsInteger;
        ParamByName('preturn').AsBoolean := False;
        ExecSQL;
      end;

      // ��ǰ �ֹ� ������ŭ ����� ����
    
      
      Stock := Stock - CartQuery.FieldByName('quantity').AsInteger;
      ProductStockUpdateQuery.Close;
      ProductStockUpdateQuery.ParamByName('pnewstock').AsInteger := Stock;
      ProductStockUpdateQuery.ParamByName('pproduct_num').AsInteger := CartQuery.FieldByName('product_num').AsInteger;
      ProductStockUpdateQuery.ExecSQL;  
     
 

      // �ֹ� ��ǰ ����, ���ϸ��� ����
      TotalCharge := TotalCharge + (ProductQuery.FieldByName('price').AsInteger * CartQuery.FieldByName('quantity').AsInteger);
      Mileage := Mileage +  A_Unit_Mileage * CartQuery.FieldByName('quantity').AsInteger;

      // ���� ��ǰ~
      CartQuery.Next;
    end;

    { �ֹ��� �ۼ� ------------------------------------------------------------ }
    with InsertOrderQuery do begin
      Close;
      ParamByName('porder_num').AsString := OrderNumber;
      ParamByName('pid').AsString := Id;
      ParamByName('pdate').AsSQLTimeStamp := DateTimeToSQLTimeStamp(Now);
      ParamByName('pdelivery_charge').AsInteger := 2500;
      TotalCharge := TotalCharge + 2500;
      ParamByName('pdelivery_state').AsString := '0';
      ParamByName('ptotal_mileage').AsInteger := Mileage;
      ParamByName('ptotal_charge').AsInteger := TotalCharge;
      ExecSQL;
    end;

    { ����� �ۼ� ------------------------------------------------------------ }
    with InsertInvoiceQuery do begin
      Close;
      ParamByName('porder_num').AsString := OrderNumber;
      ParamByName('pinvoice_num').AsString := OrderNumber;
      ParamByName('pname').AsString := ivcName;
      ParamByName('ptel').AsString := ivcTel;
      ParamByName('paddress').AsString := ivcAddress;
      ExecSQL;
    end;

    { īƮ ���� }
    with CartDelQuery do begin
      Close;
      ParamByName('pid').AsString := Id;
      ExecSQL;
    end;
    
    Result := True;

end;

procedure TServerMethods.InsertProductToCart(Id: String; ProductNum, Quantity: Integer);
var
  NewQuantity: Integer;
begin
  { īƮ�� �ִ� ��ǰ�̶�� ������ �ջ� }
  // �ش� ID īƮ�� ��� ���� ��ȸ
  CartQuery.Close;
  CartQuery.ParamByName('pid').AsString := Id;
  CartQuery.Open;
  
  while not CartQuery.Eof do begin
    if CartQuery.FieldByName('product_num').AsInteger = ProductNum then begin
      NewQuantity := CartQuery.FieldByName('quantity').AsInteger;
      NewQuantity := NewQuantity + Quantity;
      with CartUpateQuery do begin
        Close;
        ParamByName('pquantity').AsInteger := NewQuantity;
        ParamByName('pproduct_num').AsInteger := ProductNum;
        ExecSQL;
      end;      
      exit;
    end; //if
    
    CartQuery.Next
  end; // while


  { īƮ�� ���� ��ǰ�̶�� �� ���ڵ� �߰� }
  with InsertProductToCartQuery do begin
    Close;
    ParamByName('pid').AsString := Id;
    ParamByName('pproduct_num').AsInteger := ProductNum;
    ParamByName('quantity').AsInteger := Quantity;
    ExecSQL;
  end;
end;

end.

