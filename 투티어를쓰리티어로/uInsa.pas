unit uinsa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.ExtDlgs, FireDAC.Stan.Error,FireDAC.Phys.IBWrapper,System.DateUtils,Firedac.Stan.ExprFuncs,
  UmyFrame,VCLTee.Series,FireDAC.Stan.Option;

type
  TInsaForm = class(TForm)
    PageControl1: TPageControl;
    tabsheet1: TTabSheet;
    tabsheet2: TTabSheet;
    tabsheet3: TTabSheet;
    TabControl1: TTabControl;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Edit1: TEdit;
    사번: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    Label9: TLabel;
    DBImage1: TDBImage;
    DBRadioGroup1: TDBRadioGroup;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    RadioGroup1: TRadioGroup;
    TFrame11: TFrame1;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure TabControl1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure PageControl1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure PageControl1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PageControl1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PageControl1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PageControl1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PageControl1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
  private
    FDraging: Boolean;
    FDragPos: TPoint;
    FDragTop: Integer;
    FDragLeft:Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InsaForm: TInsaForm;

implementation
uses udm;
{$R *.dfm}
type
  TTabDragObject = class(TBaseDragControlObject)
  private
    PageControl: TPageControl;
    DragImageList: TImageList;
    PageIndex: Integer;
    CurrentWnd: HWnd;
  protected
    procedure WndProc(var Msg: TMessage); override;
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  end;
var
   Newseries:TBarSeries;

procedure TInsaForm.PageControl1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button = mbLeft then FDraging := False;
end;
procedure TInsaForm.PageControl1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  DragObject := TTabDragObject.Create( TPageControl(Sender) );
  TTabDragObject(DragObject).PageControl := TPageControl(Sender);
  TTabDragObject(DragObject).PageIndex := TPageControl(Sender).ActivePageIndex;
//  TTabDragObject(DragObject).DragImageList := ImageList_Drag;
end;


procedure TInsaForm.Button1Click(Sender: TObject);
begin
  dm.Insa.Insert;    //append;
end;

procedure TInsaForm.Button2Click(Sender: TObject);
begin
  if messageDlg('정말 삭제 할래?', mtconfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
     dm.Insa.Delete;
     dm.insa.ApplyUpdates(-1);
  end;

end;

procedure TInsaForm.Button3Click(Sender: TObject);
begin
  dm.Insa.Cancel;
  dm.insa.CancelUpdates;
end;

procedure TInsaForm.Button4Click(Sender: TObject);
begin
//   if dm.Insa.State = DsBrowse then
//      raise Exception.Create('조회중');

    DM.Insa.Post;
    dm.insa.ApplyUpdates(-1);

end;

procedure TInsaForm.ComboBox1Change(Sender: TObject);
begin
   case ComboBox1.itemindex of
     0:
       begin
         dm.Insa.IndexName := 'i_id';
         dm.insaid.index := 0;
         dm.insaName.index := 1;
       end;
     1:
       begin
         dm.Insa.IndexName := 'i_name';
         dm.insaid.index := 1;
         dm.insaName.index := 0;
       end;
     2:
       dm.Insa.IndexName := 'i_dept';
   end;
 end;

procedure TInsaForm.Edit1Change(Sender: TObject);
begin
  dm.Insa.IndexFieldNames := 'Name';
  dm.Insa.FindNearest([edit1.text]);
end;

procedure TInsaForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
//     if not dm.Insa.FindKey([edit1.Text]) then
//        showmessage('그런 사람 없음');
 if not dm.insa.locate('name', edit1.text, []) then
   showmessage('그런 사람 없음');
// [locaseinsensitive, lopartialkey])
end;

procedure TInsaForm.FormActivate(Sender: TObject);
begin
  dm.InsaSourceStateChange(dm.InsaSource);
  dm.InsaSourceDataChange(dm.insasource, dm.insaid);
end;

procedure TInsaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   dm.InsaSource.OnStateChange :=  nil;
   DM.InsaSource.OnDataChange :=  nil;
   action := cafree;
end;

procedure TInsaForm.FormCreate(Sender: TObject);
begin
   TFrame11.dbchart1.title.Text.Clear;
   TFrame11.dbchart1.title.Text.Add( '사원별 급여&세금 현황');
   NewSeries := TBarSeries.Create(TFrame11.dbchart1);
   NewSeries.ParentChart := TFrame11.dbchart1;
   NewSeries.DataSource := DM.Insa;
   NewSeries.CheckDataSource;
   NewSeries.Color := clBlue;
   NewSeries.XLabelsSource := 'tax';
   NewSeries.YValues.ValueSource := 'tax';
   dm.InsaSource.OnStateChange :=  dm.InsaSourceStateChange;
   DM.InsaSource.OnDataChange := dm.InsaSourceDataChange;
end;

procedure TInsaForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case KEY of
    vk_return: selectnext(activecontrol, true, true);
    vk_up: selectnext(activecontrol,false, true);
    vk_down:  selectnext(activecontrol, true, true);
  end;
end;

procedure TInsaForm.Label9Click(Sender: TObject);
begin
   if openpictureDialog1.Execute then
      dbimage1.Picture.LoadFromFile(openpicturedialog1.filename);
end;

procedure TInsaForm.PageControl1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  HitTests: THitTests;
  SourceIndex, DestIndex: Integer;
begin
  HitTests := TPageControl(Sender).GetHitTestInfoAt( X, Y );
  if ( htOnItem in HitTests ) and ( Source is TTabDragObject ) and ( TTabDragObject(Source).PageControl = Sender ) then
   begin
     SourceIndex := TTabDragObject(Source).PageIndex;
     DestIndex := TPageControl(Sender).IndexOfTabAt( X, Y );

     TPageControl(Sender).Pages[ SourceIndex ].PageIndex := DestIndex;
   end;
end;

procedure TInsaForm.PageControl1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  HitTests: THitTests;
  DestIndex: Integer;
begin
  HitTests := TPageControl(Sender).GetHitTestInfoAt( X, Y );
  DestIndex := TPageControl(Sender).IndexOfTabAt( X, Y );
  Accept :=  ( htOnItem in HitTests ) and
             ( Source is TTabDragObject ) and
             ( TTabDragObject(Source).PageControl = Sender ) and
             ( TTabDragObject(Source).PageIndex <> TPageControl(Sender).Pages[ DestIndex ].PageIndex );

//  ImageList_Drag.DragMove( X - FDragLeft, FDragTop );
//  ImageList_Drag.ShowDragImage;

end;

procedure TInsaForm.PageControl1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDraging := Button = mbLeft;
  if FDraging then
  FDragPos := Mouse.CursorPos;
end;

procedure TInsaForm.PageControl1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Bitmap: TBitmap;
  Rect: TRect;
  DC: HDC;
begin
  if FDraging and ( TPageControl(Sender).ActivePage <> nil ) then
   begin
     if ( Abs( FDragPos.X -  Mouse.CursorPos.X ) >= 5 ) or ( Abs( FDragPos.Y -  Mouse.CursorPos.Y ) >= 5 ) then
      begin
        TControl(Sender).BeginDrag( False );

        Bitmap := TBitmap.Create;
        Bitmap.PixelFormat := pf32Bit;

        Rect := TPageControl(Sender).TabRect( TPageControl(Sender).ActivePageIndex );

        InflateRect( Rect, 2, 2 );
        FDragTop := Rect.Top;
        FDragLeft := X - Rect.Left;
        Bitmap.Width := Rect.Right - Rect.Left;
        Bitmap.Height := Rect.Bottom - Rect.Top;

        DC := GetDC( TWinControl(Sender).Handle );
        BitBlt( Bitmap.Canvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height, DC, Rect.Left, Rect.Top, SRCCOPY );
        ReleaseDC( TWinControl(Sender).Handle, DC );

//        Dark( Bitmap );
        ShowCursor( True );
      end;

end;
end;

procedure TInsaForm.RadioGroup1Click(Sender: TObject);
var
  From_date:TDateTime;
  to_Date:TDateTime;
begin
     From_Date := incYear(now -1);
     to_date := incYear(now, 1);
     case radiogroup1.ItemIndex of
       0: dm.Insa.Filtered := false;
       1: begin
     //       dm.Insa.Filtered :=  true;
     //       dm.Insa.Filter := '(sysdate - ipsa_date) + 1) / 365) <  1';
          end;
       3: begin
//            dm.Insa.Filtered :=  true;

          end;

       4: begin
//            dm.Insa.Filtered :=  true;
           end;
      end;

end;

procedure TInsaForm.SpeedButton1Click(Sender: TObject);
begin
  dm.Insa.First;
end;
procedure TInsaForm.SpeedButton2Click(Sender: TObject);
begin
  if not dm.Insa.Bof then
     dm.Insa.Prior;
end;

procedure TInsaForm.SpeedButton3Click(Sender: TObject);
begin
  if not dm.Insa.Eof then
     dm.Insa.Next;
end;

procedure TInsaForm.SpeedButton4Click(Sender: TObject);
begin
  dm.Insa.Last;
end;

procedure TInsaForm.TabControl1Change(Sender: TObject);
begin
  if tabcontrol1.TabIndex = 0 then
     dm.Insa.Filtered := false
  else
  begin
     dm.Insa.Filtered := true;
     dm.Insa.Filter :=
     'class =' + '''' +  tabcontrol1.tabs[tabcontrol1.tabindex] + '''';
  end;
end;

{ TTabDragObject }

function TTabDragObject.GetDragCursor(Accepted: Boolean; X,
  Y: Integer): TCursor;
begin
  if Accepted then Result := crArrow
              else Result := crNoDrop;
end;

procedure TTabDragObject.WndProc(var Msg: TMessage);
var
  Wnd: HWnd;
begin
  inherited;

  case Msg.Msg of
  WM_MOUSEMOVE: begin
                  Wnd := WindowFromPoint( Mouse.CursorPos );

                  if Wnd <> CurrentWnd then
                   begin
                     if Wnd <> TWinControl(Control).Handle then
                      DragImageList.HideDragImage;

                     CurrentWnd := Wnd;
                   end;
                end;
  end;

end;
end.
