
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScreenTips, StdCtrls, StdActns, ActnList, ImgList, XPStyleActnCtrls,
  ActnMan, ToolWin, ActnCtrls, System.Actions;

type
  TfrmMain = class(TForm)
    ScreenTipsManager1: TScreenTipsManager;
    ActionList1: TActionList;
    SmallImages: TImageList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    Memo1: TMemo;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    ScreenTipsPopup1: TScreenTipsPopup;
    DisabledImages: TImageList;
    FontDialog1: TFontDialog;
    bChangeFont: TButton;
    ScreenTipsPopup2: TScreenTipsPopup;
    SampleActn: TAction;
    CheckBox1: TCheckBox;
    procedure bChangeFontClick(Sender: TObject);
    procedure SampleActnExecute(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.bChangeFontClick(Sender: TObject);
begin
  FontDialog1.Font := Memo1.Font;
  if FontDialog1.Execute then
    Memo1.Font := FontDialog1.Font;
end;

procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
  SampleActn.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmMain.SampleActnExecute(Sender: TObject);
begin
  Memo1.Lines.Add('Sample action clicked');
end;

end.
