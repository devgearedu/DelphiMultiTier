
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, StdCtrls, ComCtrls, BandActn, StdActns, ExtActns,
  ActnList, ToolWin, ExtCtrls, ActnMan, ActnCtrls, ActnMenus, Contnrs,
  XPStyleActnCtrls, StdStyleActnCtrls, PlatformDefaultStyleActnCtrls,
  RibbonStyleActnCtrls, System.Actions;

type
  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    ToolActionBar1: TActionToolBar;
    ToolActionBar2: TActionToolBar;
    ToolActionBar3: TActionToolBar;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    RichEditBold1: TRichEditBold;
    RichEditItalic1: TRichEditItalic;
    RichEditUnderline1: TRichEditUnderline;
    RichEditStrikeOut1: TRichEditStrikeOut;
    RichEditBullets1: TRichEditBullets;
    RichEditAlignLeft1: TRichEditAlignLeft;
    RichEditAlignRight1: TRichEditAlignRight;
    RichEditAlignCenter1: TRichEditAlignCenter;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    FileRun1: TFileRun;
    FileExit1: TFileExit;
    SearchFind1: TSearchFind;
    SearchFindNext1: TSearchFindNext;
    SearchReplace1: TSearchReplace;
    SearchFindFirst1: TSearchFindFirst;
    CustomizeActionBars1: TCustomizeActionBars;
    RichEdit1: TRichEdit;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    ShadowActn: TAction;
    ActionList1: TActionList;
    procedure FileOpen1Accept(Sender: TObject);
    procedure FileSaveAs1Accept(Sender: TObject);
    procedure ActionManager1StateChange(Sender: TObject);
    procedure StdStyleActnExecute(Sender: TObject);
    procedure XPStyleActnExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShadowActnExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FActionBarStyles: TObjectList;
    procedure ChangeStyleHandler(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation



{$R *.dfm}

procedure TForm1.ChangeStyleHandler(Sender: TObject);
begin
  ActionManager1.Style := ActionBarStyles.Style[TAction(Sender).Tag];
end;

procedure TForm1.FileOpen1Accept(Sender: TObject);
begin
  RichEdit1.Lines.LoadFromFile(FileOpen1.Dialog.FileName);
end;

procedure TForm1.FileSaveAs1Accept(Sender: TObject);
begin
  RichEdit1.Lines.SaveToFile(FileSaveAs1.Dialog.FileName);
end;

procedure TForm1.ActionManager1StateChange(Sender: TObject);
begin
  RichEdit1.ReadOnly := ActionManager1.State <> asNormal;
end;

procedure TForm1.StdStyleActnExecute(Sender: TObject);
begin
  ActionManager1.Style := StandardStyle;
end;

procedure TForm1.XPStyleActnExecute(Sender: TObject);
begin
  ActionManager1.Style := XPStyle;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FActionBarStyles.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
  LItem: TActionClientItem;
  LAction: TAction;
  LNewItem: TActionClientItem;
begin
  FActionBarStyles := TObjectList.Create(True);
  LItem := ActionManager1.FindItemByCaption('Sty&le');
  for I := ActionBarStyles.Count - 1 downto 0 do
  begin
    LNewItem := LItem.Items.Insert(0) as TActionClientItem;
    LAction := TAction.Create(nil);
    LAction.ActionList := ActionList1;
    LAction.Caption := ActionBarStyles.Style[I].GetStyleName;
    LAction.AutoCheck := True;
    LAction.Checked := ActionManager1.Style = ActionBarStyles.Style[I];
    LAction.Tag := I;
    LAction.GroupIndex := 1;
    LAction.OnExecute := ChangeStyleHandler;
    LNewItem.Action := LAction;
    LNewItem.ChangesAllowed := [];
    FActionBarStyles.Add(LAction);
  end;
  ActionManager1.ResetUsageData;
end;

procedure TForm1.ShadowActnExecute(Sender: TObject);
begin
  ActionMainMenuBar1.Shadows := ShadowActn.Checked;
end;

end.
