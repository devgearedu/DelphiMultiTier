unit uAdjustmentFms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, DBGrids, jpeg, ExtCtrls;

type
  TAdjFrm = class(TForm)
    AdjTop: TImage;
    AdjBottom: TImage;
    sgAdjust: TStringGrid;
    pnlAdjustment: TPanel;
    pnlCancel: TPanel;
    sgSalesList: TStringGrid;
    lblAdjustTitle: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnlAdjustmentClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AdjFrm: TAdjFrm;

implementation

uses uBarDM, uCounterMain;

{$R *.dfm}

procedure TAdjFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AdjFrm.Free;
end;

procedure TAdjFrm.FormCreate(Sender: TObject);
var
  i: Integer;
  iSumTemp: Integer;
begin
  with DM.SalesQuery, sgSalesList do
  begin
    Close;
    DataSet.Params[0].AsDateTime := Date;
    Open;

    Cells[0,0] := '����';
    Cells[1,0] := '�ݾ�';
    Cells[2,0] := '�ð�';

    First;
    for i := 1 to RecordCount-1 do
    begin
      Cells[0, i] := IntToStr(i);
      Cells[1, i] := IntToStr(FieldByName('s_sum').AsInteger);
      Cells[2, i] := FieldByName('s_time').AsString;
      Next;
    end; {for��}
    // �� �ֹ����ıݾ�
    iSumTemp := 0;
    for i := 1 to DM.SalesQuery.RecordCount-1 do
      iSumTemp := iSumTemp + StrToInt(Cells[1,i]);
  end;{with~do��}
  with sgAdjust do
  begin
    Cells[0,0] := '�ѱݾ�';
    Cells[1,0] := IntToStr(iSumTemp);
  end;
end;

procedure TAdjFrm.pnlAdjustmentClick(Sender: TObject);
begin
  with DM.BarQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into ADJUSTMENT_INFO (open_date, total_amount)');
    SQL.Add('values (:Popen_date, :Ptotal_amount)');
    ParamByName('Popen_date').AsDateTime := Date;
    ParamByName('Ptotal_amount').AsInteger := StrToInt(sgAdjust.Cells[1,0]);
    ExecSQL;

    ShowMessage('����Ǿ����ϴ�.');
    CntFrm.Close;
  end;
end;

procedure TAdjFrm.pnlCancelClick(Sender: TObject);
begin
  Close;
end;

end.
