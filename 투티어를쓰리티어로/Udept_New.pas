unit Udept_New;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList, System.Actions,
  Vcl.ActnList, Vcl.WinXPanels, Vcl.CategoryButtons, Vcl.WinXCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  Vcl.Grids, Vcl.DBGrids, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.CDataExcel,
  FireDAC.Phys.CDataExcelDef, FireDAC.Comp.UI;

type
  TDeptForm_New = class(TForm)
    ActionList1: TActionList;
    actHome: TAction;
    actDetail: TAction;
    actCount: TAction;
    imlIcons: TImageList;
    Panel1: TPanel;
    imgMenu: TImage;
    grpDisplayMode: TRadioGroup;
    grpPlacement: TRadioGroup;
    grpCloseStyle: TRadioGroup;
    chkUseAnimation: TCheckBox;
    SV: TSplitView;
    catMenuItems: TCategoryButtons;
    CardPanel1: TCardPanel;
    chkClose: TCheckBox;
    SplitViewPanel: TPanel;
    DBGrid1: TDBGrid;
    Card1: TCard;
    DBGrid2: TDBGrid;
    Card2: TCard;
    StringGrid1: TStringGrid;
    Card3: TCard;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Tot_Query: TFDQuery;
    FDStoredProc1: TFDStoredProc;
    Card4: TCard;
    ActInsert: TAction;
    ActExcel: TAction;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Excel_Query: TFDQuery;
    DBGrid3: TDBGrid;
    Panel2: TPanel;
    DataSource1: TDataSource;
    Button2: TButton;
    Button5: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit4: TEdit;
    procedure grpDisplayModeClick(Sender: TObject);
    procedure grpPlacementClick(Sender: TObject);
    procedure grpCloseStyleClick(Sender: TObject);
    procedure chkUseAnimationClick(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure SVClosed(Sender: TObject);
    procedure SVOpened(Sender: TObject);
    procedure SVOpening(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure actDetailExecute(Sender: TObject);
    procedure actCountExecute(Sender: TObject);
    procedure ActInsertExecute(Sender: TObject);
    procedure ActExcelExecute(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure actHomeExecute(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DeptForm_New: TDeptForm_New;

implementation

{$R *.dfm}

uses uDM;

procedure TDeptForm_New.actCountExecute(Sender: TObject);
begin
  CardPanel1.Visible := true;
  CardPanel1.ActiveCard := card2;
   if Sv.Opened and chkClose.Checked then
    Sv.Close;
end;

procedure TDeptForm_New.actDetailExecute(Sender: TObject);
begin
  CardPanel1.Visible := true;
  CardPanel1.ActiveCard := card1;
  if Sv.Opened and chkClose.Checked then
     Sv.Close;
end;

procedure TDeptForm_New.ActExcelExecute(Sender: TObject);
begin
  CardPanel1.Visible := true;
  CardPanel1.ActiveCard := card4;
   if Sv.Opened and chkClose.Checked then
    Sv.Close;
end;

procedure TDeptForm_New.actHomeExecute(Sender: TObject);
begin
 if SV.Opened and chkClose.Checked then
    SV.Close;
 cardPanel1.Visible := false;
end;

procedure TDeptForm_New.ActInsertExecute(Sender: TObject);
begin
  CardPanel1.Visible := true;
  CardPanel1.ActiveCard := card3;
  if Sv.Opened and chkClose.Checked then
     Sv.Close;
end;

procedure TDeptForm_New.Button1Click(Sender: TObject);
begin
   if Edit1.Text = '' then
      raise Exception.Create('부서코드는 반드시 입력하십시오');

   if Edit2.Text = '' then
      raise Exception.Create('부서명는 반드시 입력하십시오');

   if Edit3.Text = '' then
      raise Exception.Create('팀명는 반드시 입력하십시오');

   if DM.Dept.Locate('code', Edit1.Text, []) then
      raise Exception.Create('이미 등록된 부서코드입니다');

   FDStoredProc1.Close;
   FDStoredProc1.params[0].asstring := Edit1.Text;
   FDStoredProc1.params[1].asstring := Edit2.Text;
   FDStoredProc1.params[2].asstring := Edit3.Text;
   FDStoredProc1.ExecProc;

   DM.Dept.Refresh;

end;

procedure TDeptForm_New.Button2Click(Sender: TObject);
const
  SQL_Stament = 'select * from sheet4';
begin
  Excel_Query.Close;
  Excel_Query.SQL.Text := SQL_Stament;
  Excel_Query.Open;
end;

procedure TDeptForm_New.Button3Click(Sender: TObject);
const
  SQL_Stament = 'insert into Sheet4 (a,b,c) values(:pa, :pb, :pc)';
begin
  Excel_Query.Close;
  Excel_Query.SQL.Text := SQL_Stament;
  Excel_Query.Params[0].AsString := 'Test';
  Excel_Query.Params[1].AsString := 'Test';
  Excel_Query.Params[2].AsString := 'Test';
  Excel_Query.Execsql;
  Button2Click(sender);
end;

procedure TDeptForm_New.Button4Click(Sender: TObject);
const
  SQL_Stament =  'SELECT * FROM Sheet4#A3:B10';
begin
  Excel_Query.Close;
  Excel_Query.SQL.Text := SQL_Stament;
  Excel_Query.Open;
end;

procedure TDeptForm_New.Button5Click(Sender: TObject);
const
  SQL_Statement =  'SELECT * FROM Sheet4 where A >=:pcode';
begin
  Excel_Query.Close;
  Excel_Query.SQL.Text :=  SQL_Statement;
  Excel_Query.Params[0].AsString := edit1.text;
  Excel_Query.Open;
end;

procedure TDeptForm_New.chkUseAnimationClick(Sender: TObject);
begin
  SV.UseAnimation := chkUseAnimation.Checked;
end;

procedure TDeptForm_New.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDeptForm_New.FormCreate(Sender: TObject);
var
  i:byte;
begin
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
    Tot_Query.Close;
    Tot_Query.Params[0].AsString := DM.Dept.FieldByName('code').AsString;
    Tot_Query.Open;
    StringGrid1.Cells[2,i] := Tot_Query.FieldByName('Total').AsString;
    DM.Dept.Next;
  end;
  StringGrid1.Cells[0,i] := '총인원수';
  Tot_Query.Close;
  Tot_Query.Params[0].AsString := '%';
  Tot_Query.Open;
  StringGrid1.Cells[2,i] := Tot_Query.FieldByName('Total').AsString;
  cardPanel1.visible := false;
end;

procedure TDeptForm_New.grpCloseStyleClick(Sender: TObject);
begin
  SV.CloseStyle := TSplitViewCloseStyle(grpCloseStyle.ItemIndex);

end;

procedure TDeptForm_New.grpDisplayModeClick(Sender: TObject);
begin
  SV.DisplayMode := TSplitViewDisplayMode(grpDisplayMode.ItemIndex);
end;

procedure TDeptForm_New.grpPlacementClick(Sender: TObject);
begin
  SV.Placement := TSplitViewPlacement(grpPlacement.ItemIndex);

end;

procedure TDeptForm_New.imgMenuClick(Sender: TObject);
begin
  if SV.Opened then
    SV.Close
  else
    SV.Open;
end;

procedure TDeptForm_New.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
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

procedure TDeptForm_New.SVClosed(Sender: TObject);
begin
  // When TSplitView is closed, adjust ButtonOptions and Width
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions - [boShowCaptions];
  if SV.CloseStyle = svcCompact then
    catMenuItems.Width := SV.CompactWidth;

end;

procedure TDeptForm_New.SVOpened(Sender: TObject);
begin
  // When not animating, change size of catMenuItems when TSplitView is opened
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions + [boShowCaptions];
  catMenuItems.Width := SV.OpenedWidth;

end;

procedure TDeptForm_New.SVOpening(Sender: TObject);
begin
  // When animating, change size of catMenuItems at the beginning of open
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions + [boShowCaptions];
  catMenuItems.Width := SV.OpenedWidth;

end;

end.
