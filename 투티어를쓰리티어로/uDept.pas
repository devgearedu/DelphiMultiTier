unit Udept;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TDeptForm = class(TForm)
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DBGrid2: TDBGrid;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    TabSheet4: TTabSheet;
    StringGrid2: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
   procedure CheckBoxMouseUp(Sender: TObject; Button: TMouseButton;
     Shift: TShiftState; X, Y: integer);
   procedure CheckBoxKeyUp(Sender: TObject; var Key: Word;
     Shift: TShiftState);
    { Public declarations }
  end;

var
  DeptForm: TDeptForm;

implementation

{$R *.dfm}

uses Udm,comobj, Ucheckgrid;
var
  Excel: OleVariant;
  WorkBook: OleVariant;
  WorkSheet: OleVariant;

procedure TDeptForm.Button1Click(Sender: TObject);
begin
   if Edit1.Text = '' then
      raise Exception.Create('부서코드는 반드시 입력하십시오');

   if Edit2.Text = '' then
      raise Exception.Create('부서명는 반드시 입력하십시오');

   if Edit3.Text = '' then
      raise Exception.Create('팀명는 반드시 입력하십시오');

   if DM.Dept.Locate('code', Edit1.Text, []) then
      raise Exception.Create('이미 등록된 부서코드입니다');


   if Demo.Insert_Dept(edit1.text, edit2.text, Edit3.text) = 1 Then
      ShowMessage('등록 실패');

   DM.Dept.Refresh;

end;

procedure TDeptForm.Button2Click(Sender: TObject);
var
  I: Integer;
begin
    Excel := CreateOleObject('Excel.Application');
    Excel.Visible := True;

  // 워크북 추가
   Excel.WorkBooks.Add;
   WorkBook := Excel.ActiveWorkBook;

  // 워크시트 추가
   Workbook.sheets.add;

  try
    // 작업할  워크시트 선택
    WorkSheet := WorkBook.WorkSheets[1];
     for I := 0 to StringGrid1.RowCount do
     begin
       WorkSheet.Cells[i+1,1].value := StringGrid1.Cells[0,i];
       WorkSheet.Cells[i+1,2].value := StringGrid1.Cells[1,i];
       WorkSheet.Cells[i+1,3].value := StringGrid1.Cells[2,i];
     end;
//     WorkBook.SaveAs('d:\ExcelOutputTest.xls');

  finally
    // 워크북 닫기
    WorkBook.close;
    WorkBook:=unAssigned;
    WorkSheet:=unAssigned;
    // 엑셀 종료
    Excel.Quit;
    Excel:=unAssigned;
  end ;


end;

procedure TDeptForm.CheckBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_SPACE then
   with TCheckBox(Sender) do
     Checked := not Checked;
end;

procedure TDeptForm.CheckBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  with TCheckBox(Sender) do
   Checked := not Checked;
end;

procedure TDeptForm.Edit1Change(Sender: TObject);
begin
   if (Sender as TEdit).MaxLength = Length((Sender as TEdit).Text) then
      SelectNext(Sender as TWinControl, True, True);

end;

procedure TDeptForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
end;

procedure TDeptForm.FormCreate(Sender: TObject);
var
  i:integer;
begin
 for  i := 0 to StringGrid2.RowCount - 1 do
 begin
    StringGrid2.Objects[1, i] := TCheckBox.Create(StringGrid2);
    with TCheckBox(StringGrid2.Objects[1, i]) do
    begin
       OnKeyUp := CheckBoxKeyUp;
       OnMouseUp := CheckBoxMouseUp;
       Parent := StringGrid2;
       BoundsRect := StringGrid2.CellRect(1, i);
       Width := StringGrid1.ColWidths[1];
       Height := StringGrid1.RowHeights[1];
       Caption := '체크';
       Checked := false;
    end;
 end;

  StringGrid1.RowCount := DM.Dept.RecordCount + 2;
  for I := 0 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Cells[0,i] := '';
    StringGrid1.Cells[1,i] := '';
    StringGrid1.Cells[2,i] := '';
  end;
  StringGrid1.Cells[0,0] := '부서명';
  StringGrid1.Cells[1,0] := '팀  명';
  StringGrid1.Cells[2,0] := '인원수';
  DM.Dept.First;
  for I := 1 to DM.Dept.RecordCount do
  begin
    StringGrid1.Cells[0,i] := DM.Dept.FieldByName('dept').AsString;
    StringGrid1.Cells[1,i] := DM.Dept.FieldByName('section').AsString;

    StringGrid1.Cells[2,i] :=  IntToStr(demo.GetCount(dm.dept.fields[0].asstring));
    DM.Dept.Next;
  end;
  StringGrid1.Cells[0,i] := '총인원수';

  StringGrid1.Cells[2,i] :=   IntTostr(demo.GetCount('%'));
end;

procedure TDeptForm.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  s:string;
  pos:integer;
  OldAlign:integer;
begin
  s := StringGrid1.Cells[ACol,ARow];
  with StringGrid1.Canvas do
  begin
    FillRect(Rect);
    if ARow = 0 then
    begin
      Font.Color := clBlue;
      Font.Size := Font.Size + 4;
    end;
    if (ACol = 2) and (ARow <> 0) then
    begin
      if (ARow = StringGrid1.RowCount - 1) then
         Brush.color := clyellow;

      Font.Color := clred;
      Font.Size := Font.Size + 4;
      s := s + '명';
      OldAlign := SetTextAlign(Handle,ta_Right);
      TextRect(Rect, Rect.Right, Rect.Top+3, s);
      SetTextAlign(Handle,OldAlign);
    end
    else
    begin
      pos := ((Rect.Right - Rect.Left) - TextWidth(s)) div 2;
      TextRect(Rect, Rect.Left+pos, Rect.Top+3, s);
    end;
  end;
end;

end.
