unit uCounterMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCntFms, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, GIFImg, jpeg,
  ActnList, PlatformDefaultStyleActnCtrls, ActnMan, Menus, SqlTimSt;

type
  RoomArray = Array[0..20] of Integer;
  TCntFrm = class(TForm)
    grpRoom: TGridPanel;
    pnlRoom2: TPanel;
    pnlRoom3: TPanel;
    pnlRoom4: TPanel;
    pnlRoom5: TPanel;
    pnlRoom6: TPanel;
    pnlRoom7: TPanel;
    pnlRoom8: TPanel;
    pnlRoom9: TPanel;
    pnlRoom10: TPanel;
    pnlRoom11: TPanel;
    pnlRoom12: TPanel;
    pnlRoom13: TPanel;
    pnlRoom14: TPanel;
    pnlRoom15: TPanel;
    pnlRoom16: TPanel;
    pnlRoom17: TPanel;
    pnlRoom18: TPanel;
    pnlRoom19: TPanel;
    pnlRoom20: TPanel;
    grpOrder: TGridPanel;
    btnPay: TBitBtn;
    btnCancle: TBitBtn;
    pnlStart: TPanel;
    RsrListBtn: TPanel;
    SalesBtn: TPanel;
    FdBtn: TPanel;
    AdjBtn: TPanel;
    pnlRoom1: TPanel;
    Image1: TImage;
    Image2: TImage;
    sgOrderList: TStringGrid;
    pmRoom: TPopupMenu;
    Actionmanager: TActionManager;
    OdListAction: TAction;
    OdList: TMenuItem;
    sgCalculation: TStringGrid;
    edtGetMoney: TEdit;
    edtOutMoney: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure RsrListBtnClick(Sender: TObject);
    procedure SalesBtnClick(Sender: TObject);
    procedure FdBtnClick(Sender: TObject);
    procedure AdjBtnClick(Sender: TObject);
    procedure pnlRoom1Click(Sender: TObject);
    procedure pnlStartClick(Sender: TObject);
    procedure btnPayClick(Sender: TObject);
    procedure edtGetMoneyChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CntFrm: TCntFrm;
  RoomInfo: RoomArray;

procedure OrderListOutput(iSlipNum: Integer; sgOrderList: TStringGrid; sgCalculation: TStringGrid);
procedure RoomIsEmpty(iSlipNum: Integer);
procedure OrderlistReset;
procedure RoomColorChange;
implementation

uses uBarDM, uRsrvListFms, uSalesInfoFms, uFoodListFms, uAdjustmentFms;
var
  i, j: byte;{for���� �ӽú���}
  h: String;
  iInit: Integer; //���ȣ
  osNum: Integer;  //���� create�� �� Order_Sales���̺��� os_num�� ���� ū ���� �ֱ� ����
  oNum: Integer;   //���� create�� �� Order_Info���̺��� o_num�� ���� ū ���� �ֱ� ����
  sNum: Integer;   //���� create�� �� Sales_Info���̺��� s_num�� ���� ū ���� �ֱ� ����
  slipNum: Integer;
  iRowCount: Integer; //�ֹ�����Ʈ�� Row��.
{$R *.dfm}

procedure OrderlistReset;  //�ֹ������� �ʱ�ȭ ��Ų��.
begin
  with CntFrm do
  begin
    for i := 1 to iRowCount do
      for j := 0 to 3 do
        sgOrderList.Cells[j,i] := '';
    sgOrderList.RowCount := 1;
    sgOrderList.ColCount := 4;
    sgCalculation.Cells[1,0] := '';
    edtGetMoney.Text := '0';
    edtOutMoney.Text := '0';
  end;
end;

procedure OrderListOutput(iSlipNum:Integer; sgOrderList: TStringGrid; sgCalculation: TStringGrid);
var
  strTemp: String;
  iSumTemp: Integer;
begin
  //for���� ������ �ֹ�����Ʈ�� �Ѹ���. (����Ʈ���) *Order_Sales ���̺��� iSlipNum

  with DM.BarQuery, sgOrderList do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ORDER_INFO where slip_num = :Pslip_num and open_date = :Popen_date');
    Params[0].AsInteger := iSlipNum;
    Params[1].AsDateTime := Date;
    Open;

    First;
    i := 0;
    while not EOF do //���ڵ� ����������?
    begin
      Inc(i);
      RowCount := RowCount + 1;
      sgOrderList.cells[0, i] := IntToStr(i);                       //������
      cells[2, i] := IntToStr(FieldByName('o_count').AsInteger);      //����
      strTemp := IntToStr(FieldByName('f_num').AsInteger);
      next;
    end;

    Close;
    SQL.Clear;
    SQL.Add('select f.f_name, f.f_price from food_info f, order_info o');
    SQL.Add('where o.f_num = f.f_num and o.open_date=:Popen_date and o.slip_num = :Pslip_num');
    ParambyName('Popen_date').AsDatetime := date;
    ParambyName('Pslip_num').AsInteger := iSlipNum;
    Open;

    i := 0;
    First;
    while not EOF do
    begin
      Inc(i);
      cells[3, i] := IntToStr(FieldByName('f_price').AsInteger);
      cells[1, i] := FieldByName('f_name').AsString;
      iSumTemp := iSumTemp + (StrToInt(Cells[2,i])*StrToInt(Cells[3,i]));
      Next;
    end;{while��}
  end;{with~do��}
  sgCalculation.Cells[1,0] := IntToStr(iSumTemp);
  iRowCount := i;
end;

procedure RoomIsEmpty(iSlipNum: Integer);
begin
  with DM.BarQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('delete from ORDER_SALES where open_date = :Popen_date and slip_num = :Pslip_Num');
    ParamByName('Popen_date').AsDateTime := Date;
    ParamByName('Pslip_num').AsInteger := iSlipNum;
    ExecSQL;
  end;{with~do��}
end;

procedure TCntFrm.AdjBtnClick(Sender: TObject);
begin
  AdjFrm := TAdjFrm.Create(Application);
  AdjFrm.Show;
end;

procedure TCntFrm.btnCancleClick(Sender: TObject);
begin
  OrderlistReset;
end;

procedure TCntFrm.btnPayClick(Sender: TObject);
var
  iTableNum: Integer; //table_num�� ��� �־�δ� �ӽ� ����
  iOsNum: Integer;    //os_Num�� ��� �־�δ� �ӽ� ����
begin
  //���� ��ƾ
  if edtGetMoney.Text = '' then
  begin
    ShowMessage('���� ���� �Է��ϼ���. �Ž������� ���˴ϴ�.');
    edtGetMoney.SetFocus;
    exit;
  end;

  Inc(sNum);
  with DM.BarQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select table_num, os_num from ORDER_SALES where slip_num = :Pslip_num');
    ParamByName('Pslip_num').AsInteger := SlipNum;
    Open;

    iTableNum := FieldByName('table_num').AsInteger;
    iOsNum := FieldByName('os_num').AsInteger;

    Close;
    SQL.Clear;
    SQL.Add('insert into SALES_INFO (s_num, open_date, slip_num, table_num, s_sum, s_time, os_num) values');
    SQL.Add('(:Ps_num, :Popen_date, :Pslip_num, :Ptable_num, :Ps_sum, :Ps_time, :Pos_num);');
    ParamByName('Ps_num').AsInteger := sNum;
    ParamByName('Popen_date').AsDateTime := Date;
    ParamByName('Pslip_num').AsInteger := SlipNum;
    ParamByName('Ptable_num').AsInteger := iTableNum;
    ParamByName('Ps_sum').AsInteger := StrToInt(sgCalculation.Cells[1,0]);
    ParamByName('Ps_time').AsString := FormatDateTime('hh:nn:ss', Now());
    ParamByName('Pos_num').AsInteger := iOsNum;
    ExecSQL;

    ShowMessage('�����Ǿ����ϴ�.');
    OrderlistReset; //�ֹ��� �ʱ�ȭ.
    RoomColorChange;
  end;
end;

procedure TCntFrm.edtGetMoneyChange(Sender: TObject);
begin
  if edtGetMoney.Text <> '0' then
    edtOutMoney.Text := IntToStr(StrToInt(edtGetMoney.Text) - StrToInt(sgCalculation.Cells[1,0]));
end;

procedure TCntFrm.FdBtnClick(Sender: TObject);
begin
  FdFrm := TFdFrm.Create(CntFrm);
  FdFrm.Show;
end;

procedure TCntFrm.FormCreate(Sender: TObject);
begin
  //�ֹ�����Ʈ�� ������ ���� ���.
  with sgOrderList do
  begin
    RowCount := 1; // �ʱ� ����.
    ColCount := 4;
    cells[0,0] := '����';
    cells[1,0] := '���ĸ�';
    cells[2,0] := '����';
    cells[3,0] := '����';

  end;{with~do}
  //��긮��Ʈ�� ������ ���� ���.
  with sgCalculation do
  begin
    RowCount := 1; // �ʱ� ����.
    ColCount := 2;
    cells[0,0] := '�� �ݾ�';
  end;{with~do}
end;

procedure TCntFrm.FormShow(Sender: TObject);
begin
  pnlRoom1.Enabled := false;
  pnlRoom2.Enabled := false;
  pnlRoom3.Enabled := false;
  pnlRoom4.Enabled := false;
  pnlRoom5.Enabled := false;
  pnlRoom6.Enabled := false;
  pnlRoom7.Enabled := false;
  pnlRoom8.Enabled := false;
  pnlRoom9.Enabled := false;
  pnlRoom10.Enabled := false;
  pnlRoom11.Enabled := false;
  pnlRoom12.Enabled := false;
  pnlRoom13.Enabled := false;
  pnlRoom14.Enabled := false;
  pnlRoom15.Enabled := false;
  pnlRoom16.Enabled := false;
  pnlRoom17.Enabled := false;
  pnlRoom18.Enabled := false;
  pnlRoom19.Enabled := false;
  pnlRoom20.Enabled := false;

  btnPay.Enabled := false;
  btnCancle.Enabled := false;
  RsrListBtn.Enabled := false;
  SalesBtn.Enabled := false;
  FdBtn.Enabled := false;
  AdjBtn.Enabled := false;

end;

procedure TCntFrm.pnlStartClick(Sender: TObject);
var
  islipNum: Integer; //�����մ��� ���ÿ� �ֹ��� ���� �ø� �����ؼ�.
begin
  DM.SQLConnection.Connected := True; // "����"��ư�� ������
                                      // ��� ����Ǹ鼭 ������ ���۵ȴ�.

  DM.BarQuery.Close;
  DM.BarQuery.SQL.Clear;
  // ���۹�ư�� ������ ������ ��ư�� Ȱ��ȭ�ȴ�.
  pnlRoom1.Enabled := True;
  pnlRoom2.Enabled := True;
  pnlRoom3.Enabled := True;
  pnlRoom4.Enabled := True;
  pnlRoom5.Enabled := True;
  pnlRoom6.Enabled := True;
  pnlRoom7.Enabled := True;
  pnlRoom8.Enabled := True;
  pnlRoom9.Enabled := True;
  pnlRoom10.Enabled := True;
  pnlRoom11.Enabled := True;
  pnlRoom12.Enabled := True;
  pnlRoom13.Enabled := True;
  pnlRoom14.Enabled := True;
  pnlRoom15.Enabled := True;
  pnlRoom16.Enabled := True;
  pnlRoom17.Enabled := True;
  pnlRoom18.Enabled := True;
  pnlRoom19.Enabled := True;
  pnlRoom20.Enabled := True;

  btnPay.Enabled := True;
  btnCancle.Enabled := True;
  RsrListBtn.Enabled := True;
  SalesBtn.Enabled := True;
  FdBtn.Enabled := True;
  AdjBtn.Enabled := True;

  //������ ���̺��� ������ȣ�� ���� ���������� ����
  with DM.BarQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select Max(os_num) as os_num from ORDER_SALES');
    Open;

    osNum := FieldByName('os_num').AsInteger;

    Close;
    SQL.Clear;
    SQL.Add('select Max(o_num) as o_num from ORDER_INFO');
    Open;

    oNum := FieldByName('o_num').AsInteger;

    Close;
    SQL.Clear;
    SQL.Add('select Max(s_num) as s_num from SALES_INFO');
    Open;

    sNum := FieldByName('s_num').AsInteger;

    Close;
    SQL.Clear;
    SQL.Add('select * from ORDER_SALES where open_date = :Popen_date');
    ParamByName('Popen_date').AsDatetime := Date;
    Open;

    if Not IsEmpty then //������ ������ ������
    begin
      ShowMessage('������ �Ǹ������� �����մϴ�. ���� ��, �����ư�� ��������.');
//      iSlipNum := FieldByName('slip_num').AsInteger; //��ǥ��ȣ
//      Inc(iSlipNum); //������ �մ��� ��ǥ��ȣ�� +1 �������� ���α׷��� ���� �ٽ�
                     //�ѵ� �� ���� �ֽ������� append�� �����ϵ��� �ϱ� ����.
      Exit;
    end
    else
    begin //������ Order_Sales ���̺� ������ ��¥�� �ʱ����.
      ShowMessage('������ �����մϴ�.');
      Inc(osNum);
      Close;
      SQL.Clear;
      SQL.Add('insert into order_sales (open_date, slip_num, os_num, table_num) values');
      SQL.Add('(:Popen_date, :Pslip_num, :Pos_num, :Ptable_num)');
      ParamByName('Popen_date').AsDateTime := date;
      ParamByName('Pslip_num').AsInteger := 0;
      ParamByName('Pos_num').AsInteger := osNum;
      ParamByName('Ptable_num').AsInteger := 0;

      ExecSQL;
    end;
  end;{with~do��}
  pnlStart.Enabled := false;
end;

procedure TCntFrm.pnlRoom1Click(Sender: TObject);
var
  iSlipNum: Integer; //��ǥ��ȣ-sql�� ���ؼ� ���� �������� ������ ���������� �� �ʿ����.(�򰥸�����!)
//  pnlColor: Tcolor;
begin
  h := (Sender as TPanel).Caption;
  iInit := StrToInt(((Sender as TPanel).Caption)[3]); //���̺� ��ȣ."�� 3"�� ������ ����°�� ������ �Է�.
  i := Length(((Sender as Tpanel).Caption));
  // ���� ���ڰ� 2���� ��츦 ����ؼ� �г� ĸ���� ���̸� ���Ѵ�.
  if i = 4 then
    iInit := StrToInt(IntToStr(iInit) + (Sender as TPanel).Caption[4]);
  if RoomInfo[iInit] = 0 then //�� ���� ������ �Ķ����̸�, Ȥ�� �� ���� �� ���̸�
  begin
    RoomInfo[iInit] := 1; // �� ���� ������ ����������, Ȥ�� �� ���� ����Ѵ�.
    (Sender as TPanel).Color := clRed; //RoomInfo[i]-> i�� ���� ������ �����ϱ�����. i:=0�̸� �Ķ�, i:=1�̸� ����

    with DM.BarQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select Max(slip_num) as slip_num from ORDER_SALES where open_date = :popen_date;');
      ParamByName('Popen_date').AsDateTime := Date;
      Open;

      iSlipNum := FieldByName('slip_num').AsInteger; //��ǥ��ȣ

      Inc(iSlipNum); //������ �մ��� ��ǥ��ȣ�� +1 �������� ���α׷��� ���� �ٽ�
                     //�ѵ� �� ���� �ֽ������� append�� �����ϵ��� �ϱ� ����.
      Inc(osNum);
      Close;
      SQL.Clear;
      SQL.Add('insert into ORDER_SALES ');
      SQL.Add('(open_date, slip_num, os_num, table_num) values ');
      SQL.Add('(:Popen_date, :Pslip_num, :Po_num, :Ptable_num); ');

      ParamByName('Popen_date').AsDateTime := Date;
      ParamByName('Pslip_num').AsInteger := iSlipNum; //Order_Sales���̺� ���ο� �մ��� ������ ��Ͻ�Ű�� ���� insert�Ѵ�.
      ParamByName('Po_num').AsInteger := osNum; //Order_Sales���̺� ���ο� �մ��� ������ ��Ͻ�Ű�� ���� insert�Ѵ�.
      ParamByName('Ptable_num').AsInteger := iInit; //Order_Sales���̺� ���ο� �մ��� ������ ��Ͻ�Ű�� ���� insert�Ѵ�.

      ExecSQL;

    end;{with~do��}
  end
//================================================================================
  else // �� ���� ������ �������̸�
  begin
    with DM.BarQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select Max(slip_num) as slip_num from ORDER_SALES');
      SQL.Add('where open_date = :popen_date and table_num = :Ptable_num');
      SQL.Add('Group by open_date ');
      ParamByName('Popen_date').AsDateTime := Date;
      ParamByName('PTable_num').AsInteger := iInit;

      Open;
      //
      //�ֱ��� ���̺� ��ȣ�� �������ڰ� ��ġ�ϴ� ��ǥ��ȣ�� ã��
      //�� ��ǥ��ȣ�� ���� order_info ���̺��� �������ڿ� ���� �˻�.

      iSlipNum := FieldByName('slip_num').AsInteger; //��ǥ��ȣ

      Close;
      SQL.Clear;
      SQL.Add('select * from ORDER_INFO where slip_num = :Pslip_num and open_date = :Popen_date');
      ParamByName('Pslip_num').AsInteger := iSlipNum;
      ParamByName('Popen_date').AsDateTime := Date;
      Open;

      if Not IsEmpty then //��ǥ��ȣ�� ������, 1.�����ϴ� ��(������ưŬ��), Ȥ�� 2. Ŭ���� ���� �ֹ����� ���� ��.(���� �� ��ҹ�ư-��������) �� ���� �ϳ�
      begin
        //�ֹ�����Ʈ ����ϴ� �Լ� ȣ��.
        SlipNum := iSlipNum;
        OrderListOutput(iSlipNum, sgOrderList, sgCalculation); //�ֹ��� ���.

      end
      else //��ǥ��ȣ�� ������ , 1. ���� �ֹ��� ���� ���� ��(������ưŬ��-��������), Ȥ�� 2. �ֹ��ʰ� ���Ը� ������ ���(��ҹ�ư-�� �մ��� ��ȣ ����)
      begin
        if Dialogs.MessageDlg(' �ֹ� ������ �����ϴ�! ���� ������ [OK]��ư��, ���� ���·� ���ư����� [NO]�� �����ּ���.', mtConfirmation, [mbOK, mbNo], 0, mbOK) = mrOK then
        begin
          RoomIsEmpty(iSlipNum); //���� ���� ���� Order_Sales ���̺� ����� �ش� ���� ������ �����.
          RoomInfo[iInit] := 0; // �� ���� ������ �Ķ�������, Ȥ�� �� ������ ǥ��.
          (Sender as TPanel).Color := clGradientInactiveCaption;
        end{if��}
      end;{if��}
    end;{with~do��}
  end;{if~else��}
end;

procedure TCntFrm.RsrListBtnClick(Sender: TObject);
begin
  RvFrm := TRvFrm.Create(CntFrm);
  RvFrm.Show;
end;

procedure TCntFrm.SalesBtnClick(Sender: TObject);
begin
  SalesFrm := TSalesFrm.Create(CntFrm);
  SalesFrm.Show;
end;
procedure RoomColorChange;
begin
  if iInit = 1 then
    CntFrm.pnlRoom1.Color := clGradientInactiveCaption
  else if iInit = 2 then
    CntFrm.pnlRoom2.Color := clGradientInactiveCaption
  else if iInit = 3 then
    CntFrm.pnlRoom3.Color := clGradientInactiveCaption
  else if iInit = 4 then
    CntFrm.pnlRoom4.Color := clGradientInactiveCaption
  else if iInit = 5 then
    CntFrm.pnlRoom5.Color := clGradientInactiveCaption
  else if iInit = 6 then
    CntFrm.pnlRoom6.Color := clGradientInactiveCaption
  else if iInit = 7 then
    CntFrm.pnlRoom7.Color := clGradientInactiveCaption
  else if iInit = 8 then
    CntFrm.pnlRoom8.Color := clGradientInactiveCaption
  else if iInit = 9 then
    CntFrm.pnlRoom9.Color := clGradientInactiveCaption
  else if iInit = 10 then
    CntFrm.pnlRoom10.Color := clGradientInactiveCaption
  else if iInit = 11 then
    CntFrm.pnlRoom11.Color := clGradientInactiveCaption
  else if iInit = 12 then
    CntFrm.pnlRoom12.Color := clGradientInactiveCaption
  else if iInit = 13 then
    CntFrm.pnlRoom13.Color := clGradientInactiveCaption
  else if iInit = 14 then
    CntFrm.pnlRoom14.Color := clGradientInactiveCaption
  else if iInit = 15 then
    CntFrm.pnlRoom15.Color := clGradientInactiveCaption
  else if iInit = 16 then
    CntFrm.pnlRoom16.Color := clGradientInactiveCaption
  else if iInit = 17 then
    CntFrm.pnlRoom17.Color := clGradientInactiveCaption
  else if iInit = 18 then
    CntFrm.pnlRoom18.Color := clGradientInactiveCaption
  else if iInit = 19 then
    CntFrm.pnlRoom19.Color := clGradientInactiveCaption
  else
    CntFrm.pnlRoom20.Color := clGradientInactiveCaption;
end;

initialization
begin
  for i := 0 to 20 do
  begin
    RoomInfo[i] := 0; // RoomInfo[i] -> i�� ���� ������ �����ϱ�����. 0�̸� �Ķ�, 1�̸� ����
  end;{for��}
end;

end.
