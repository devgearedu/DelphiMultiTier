unit uReaderMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Buttons, Grids, jpeg;

type
  StockArray = Array[0..20] of String;
  TReaderfrm = class(TForm)
    Image1: TImage;
    cbRoomNum: TComboBox;
    cbOrderMenu: TComboBox;
    sgOrderList: TStringGrid;
    pnlReset: TPanel;
    pnlOrder: TPanel;
    pnlOrderList: TPanel;
    cbOrderCount: TComboBox;
    MenuTimer: TTimer;
    RoomTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbOrderMenuSelect(Sender: TObject);
    procedure sgOrderListClick(Sender: TObject);
    procedure cbOrderCountClick(Sender: TObject);
    procedure pnlResetClick(Sender: TObject);
    procedure cbOrderMenuClick(Sender: TObject);
    procedure pnlOrderClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure GetOrderMenu;
var
  Readerfrm: TReaderfrm;
  strStock: StockArray; //������ ���ĸ��� ���� �迭
implementation

uses uReaderDM;
var
  i, intRowCount: Integer;
  iCountRowInfo: Integer; // �޺����ڿ��� ������ ���� �ٲ� �� �ش� ���������� Row��.
{$R *.dfm}

procedure GetOrderMenu;
begin
  // FOOD ���̺��� ���� �ֹ����� ����Ʈ�� �ܸ��⿡ �Ѹ���.
  with DM.ReaderQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from Food_INFO where f_check = 1 order by F_NUM');
    Open;

    First;
    for i := 0 to (RecordCount - 1) do
    begin
      Readerfrm.cbOrderMenu.Items.Add(FieldByName('f_name').AsString);
      next;
    end;{for��}
  end;{with~do��}
end;

procedure TReaderfrm.cbOrderCountClick(Sender: TObject);
begin
  sgOrderList.Cells[1,iCountRowInfo] := IntToStr(cbOrderCount.ItemIndex + 1);
end;

procedure TReaderfrm.cbOrderMenuClick(Sender: TObject);
begin
  MenuTimer.OnTimer := TimerTimer;
  if cbRoomNum.ItemIndex = -1 then
  begin
    ShowMessage('���ȣ�� �����ؾ� �ֹ��� �����մϴ�!');
    cbRoomNum.SetFocus;
  end;
  MenuTimer.OnTimer := Nil;
end;

procedure TReaderfrm.cbOrderMenuSelect(Sender: TObject);
var
  iFoodNum: Integer;       //�ĺ��ڽ����� ������ ������ itemIndex��
  intFTTemp: Integer;      //��ϵ� ��ǰ�� �ִ����� ����
  strFoodName: string;
  intRowNumTemp: Integer;  //�ش� ��ǰ�� row��.
begin
  iFoodNum := (Sender as TComboBox).ItemIndex;
  strFoodName := (Sender as TComboBox).Items[iFoodNum];

  intFTTemp := 0;

  for i:=1 to sgOrderList.RowCount + 1 do
  begin
    if strFoodName = sgOrderList.Cells[0,i] then
    begin
      intFTTemp := 1;    //�̹� ��ǰ�� ��ϵǾ��ִٴ� �ǹ�.
      intRowNumTemp := i;
      break;             //��ǰ��Ͽ��θ� üũ������ ����������.
    end
    else
      intFTTemp := 0;   //��ǰ�� ��ϵǾ����� �ʴٴ� �ǹ�.
  end;{for��}

  //���� üũ���ο� ���� ��ǰ����Ʈ�� ���.
  with sgOrderList do
  begin
    if intFTTemp = 1 then              // 1.�̹� ��ǰ�� ��ϵǾ������� ��������.
    begin
      Cells[1,intRowNumTemp] := IntToStr(StrToInt(Cells[1,intRowNumTemp])+1);                  //����
    end
    else
    begin   // 2.���ο� ��ǰ�� ����Ʈ�� ���.
      RowCount := intRowCount + 1;                    //ǥ�� ���� �ø���.
      Cells[0,intRowCount] := strFoodName;            //�����̸�
      Cells[1,intRowCount] := IntToStr(1);            //����
      Inc(intRowCount);
    end;
  end;{if~else��}
end;

procedure TReaderfrm.FormCreate(Sender: TObject);
begin
  DM.SQLConnection.Connected := True;
  intRowCount := 1;
end;

procedure TReaderfrm.FormShow(Sender: TObject);
var
  strTemp: String;
begin
  GetOrderMenu; // �����������̺��� ��� �ִ� ������ ������ �ܸ����� �޴��� �Ѹ���.
  with sgOrderList do
  begin
    Cells[0,0] := '�ֹ����� ����Ʈ';
    Cells[1,0] := '����';
    RowCount := 1;
  end;
end;

procedure TReaderfrm.pnlOrderClick(Sender: TObject);
var
  iSlipNum: Integer;
  osNum: Integer;
  oNum: Integer;
  strFoodTemp: String;
  iFoodNum: Integer;
  iStockCheck: Integer;
begin
  //�ֹ����̺� �ֹ������� �����ϱ� �ռ� ���ȣ�� �����ߴ��� Ȯ���Ѵ�.
  if cbRoomNum.ItemIndex = -1 then
  begin
    ShowMessage('�ֹ� ���� ���ȣ�� �����ϼ���.');
    cbRoomNum.SetFocus;
  end
  else
  begin
    with DM.ReaderQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select Max(slip_num) as slip_num from ORDER_SALES');
      SQL.Add('where open_date = :Popen_date and table_num = :Ptable_num');
      SQL.Add('Group by open_date ');
      ParamByName('Popen_date').AsDateTime := Date;
      ParamByName('PTable_num').AsInteger := cbRoomNum.ItemIndex + 1; //os_num�� ���� select �ϸ� DBError(invalid colum reference)�� ���� ���� ����.
      Open;

      iSlipNum := FieldByName('slip_num').AsInteger; //��ǥ��ȣ

      Close;
      SQL.Clear;
      SQL.Add('select os_num from ORDER_SALES');
      SQL.Add('where open_date = :popen_date and slip_num = :Pslip_num');
      ParamByName('Popen_date').AsDateTime := Date;
      ParamByName('Pslip_num').AsInteger := iSlipNum;
      Open;

      osNum := FieldByName('os_num').AsInteger;

      Close;
      SQL.Clear;
      SQL.Add('select Max(o_num) as o_num from ORDER_INFO');
      Open;
      oNum := FieldByName('o_num').AsInteger;
      Inc(oNum);

      close;
      SQL.Clear;
      SQL.Add('select f_name from FOOD_INFO where f_check = 0');
      Open;

      if NOT IsEmpty then //���� �ֹ��� ���� �� ��� ���� �� �����Ƿ� �ٽ� üũ.
      begin
        First;
        for i := 0 to sgOrderList.RowCount do
        begin
          if sgOrderList.Cells[0,i] = FieldByName('f_name').AsString then
          begin
            strStock[i] := sgOrderList.Cells[0,i];
            sgOrderList.Cells[1,i] := IntToStr(0); //��� ���� �ֹ� ������ ������ 0 ó���Ѵ�.
            iStockCheck := 1;
          end;
        end;
      end;

      for i := 1 to sgOrderList.RowCount-1 do //Order���̺� �ֹ������Է�.
      begin
        Close;
        SQL.Clear;
        SQL.Add('select f_num from FOOD_INFO where f_name = :Pf_name');
        ParamByName('Pf_name').AsString := sgOrderList.Cells[0, i];
        Open;

        iFoodNum := FieldByName('f_num').AsInteger;

        Close;
        SQL.Clear;
        SQL.Add('insert into ORDER_INFO (o_num, open_date, slip_num, f_num, o_count, o_time, os_num, o_check)');
        SQL.Add('values (:Po_num, :Popen_date, :Pslip_num, :Pf_num, :Po_count, :Po_time, :Pos_num, :Po_check)');
        ParamByName('Po_num').AsInteger := oNum;
        ParamByName('Popen_date').AsDateTime := Date;
        ParamByName('Pslip_num').AsInteger := iSlipNum;
        ParamByName('Pf_num').AsInteger := iFoodNum;
        ParamByName('Po_count').AsInteger := StrToInt(sgOrderList.Cells[1, i]);
        ParamByName('Po_time').AsString := FormatDateTime('hh:nn:ss', now());
        ParamByName('Pos_num').AsInteger := osNum;
        ParamByName('Po_check').AsString := '1';
        ExecSQL;
        Inc(oNum);
      end;{for��}
    end;{with~do��}
    pnlResetClick(pnlReset);  //�ֹ��Ϸ� ��, ȭ���� �����Ѵ�.
    ShowMessage('�ֹ��� �Ϸ�Ǿ����ϴ�!');
    if iStockCheck = 1 then
    begin
      for i := 0 to 19 do
      begin
        if (strStock[i] <> '') then
          ShowMessage('['+ strStock[i] +'] ������! �ֹ�����Ʈ���� �����߽��ϴ�.');
      end;{for��}
    end;{if��}
  end;{if~else��}
end;

procedure TReaderfrm.pnlResetClick(Sender: TObject);
begin
  with sgOrderList do
  begin
    for i := 1 to RowCount-1 do
    begin
      Cells[0,i] := '';
      Cells[1,i] := '';
    end;
    RowCount := 1;
    intRowCount := 1;
  end;
  cbOrderMenu.ItemIndex := -1;
end;

procedure TReaderfrm.sgOrderListClick(Sender: TObject);
var
  iTemp: Integer;
begin
  iTemp := sgOrderList.Row;   //Ŭ���� Row�� ���� �ӽ÷� ����.
  cbOrderCount.ItemIndex := StrToInt(sgOrderList.Cells[1, iTemp])-1; // ���� ����.
  iCountRowInfo := iTemp; // �޺����ڿ��� ������ ���� �ٲ� �� �ش� ���������� Row��.
end;

procedure TReaderfrm.TimerTimer(Sender: TObject);
begin
  with DM.ReaderQuery do
  begin
    close;
    SQL.Clear;
    SQL.Add('select * from FOOD_INFO where f_check = 0');
    Open;

    if NOT IsEmpty then
      GetOrderMenu;
  end;
end;

initialization
begin
  for i := 0 to 19 do
  begin
    strStock[i] := ''; // StrStock[i] -> ������ ������ �ֱ�����
  end;{for��}
end;
end.
