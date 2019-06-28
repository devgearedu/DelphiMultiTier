
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
{
   NOTE: To add more items to the reopen menu simply add more actions to the
         ReopenActionList and set their OnExecute event to the ReopenActionExecute
         event.

         Also, in order for the settings file to be saved you must run and
         close this application at least one time.  So, to see the reopen
         items working run the application and shut it down first then use
         it normally.

   ISSUE: If you allow customizations in your application there is potential
          for the user to delete the Reopen menu item or the Open toolbar button
          which this application does NOT take into account.
}
unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdActns, ToolWin, ActnMan, ActnCtrls, ActnMenus,
  StdCtrls, ImgList, ComCtrls, ExtActns, XPStyleActnCtrls, BandActn,
  StdStyleActnCtrls, System.Actions;

type
  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    ReopenActionList1: TActionList;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    ActionToolBar1: TActionToolBar;
    ImageList1: TImageList;
    FileOpen1: TFileOpen;
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
    SearchFind1: TSearchFind;
    SearchFindNext1: TSearchFindNext;
    SearchReplace1: TSearchReplace;
    SearchFindFirst1: TSearchFindFirst;
    FileSaveAs1: TFileSaveAs;
    FilePrintSetup1: TFilePrintSetup;
    FileRun1: TFileRun;
    FileExit1: TFileExit;
    Action9: TAction;
    RichEdit1: TRichEdit;
    CustomizeActionBars1: TCustomizeActionBars;
    procedure FormCreate(Sender: TObject);
    procedure FileOpen1Accept(Sender: TObject);
    procedure ReopenActionExecute(Sender: TObject);
  private
    { Private declarations }
    ReopenMenuItem: TActionClientItem;
    OpenToolItem: TActionClientItem;
    procedure FindReopenMenuItem(AClient: TActionClient);
    procedure FindOpenToolItem(AClient: TActionClient);
    procedure UpdateReopenItem(ReopenItem: TActionClientItem);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FindReopenMenuItem(AClient: TActionClient);
begin
  // Find the Reopen item by looking at the item caption
  if AClient is TActionClientItem then
    if Pos('Reopen...', TActionClientItem(AClient).Caption) <> 0 then
      ReopenMenuItem := AClient as TActionClientItem
end;

procedure TForm1.FindOpenToolItem(AClient: TActionClient);
begin
  // Find the Open item by looking at the item caption
  if AClient is TActionClientItem then
    if Pos('Open', TActionClientItem(AClient).Caption) <> 0 then
      OpenToolItem := AClient as TActionClientItem;
end;

procedure TForm1.FormCreate(Sender: TObject);

  procedure SetupItemCaptions(AnItem: TActionClientItem);
  var
    I: Integer;
  begin
    if Assigned(AnItem) then
      for I := 0 to AnItem.Items.Count - 1 do
        TCustomAction(ReopenActionList1.Actions[I]).Caption :=
          Copy(AnItem.Items[I].Caption, 5, MaxInt);
  end;

begin
  RichEdit1.Align := alClient;
  // Find the Reopen... menu item on the ActionMainMenu
  ActionManager1.ActionBars.IterateClients(ActionManager1.ActionBars[0].Items,
    FindReopenMenuItem);
  // Find the Reopen... menu item on the ActionToolBar
  ActionManager1.ActionBars.IterateClients(ActionManager1.ActionBars[1].Items,
    FindOpenToolItem);
  // Set the captions of the actions since they are used to open the file
  SetupItemCaptions(ReopenMenuItem);
  SetupItemCaptions(OpenToolItem);
end;

procedure TForm1.FileOpen1Accept(Sender: TObject);
var
  I: Integer;
  Found: Boolean;
begin
  Found := False;
  // If the filename is already in the list then do not add it again
  for I := 0 to ReopenActionList1.ActionCount - 1 do
    if CompareText(TCustomAction(ReopenActionList1.Actions[I]).Caption,
       FileOpen1.Dialog.FileName) = 0 then
    begin
      Found := True;
      break;
    end;
  if not Found then
  begin
    // Update the Reopen menu...
    UpdateReopenItem(ReopenMenuItem);
    UpdateReopenItem(OpenToolItem);
  end;
  // ...then actually open the file
  RichEdit1.Lines.LoadFromFile(FileOpen1.Dialog.FileName);
end;

procedure TForm1.UpdateReopenItem(ReopenItem: TActionClientItem);
var
  I: Integer;
begin
  if ReopenItem = nil then exit;
  // Add thew new filename to the beginning of the list and move other items down
  for I := ReopenActionList1.ActionCount - 1 downto 0 do
    if I = 0 then
      TCustomAction(ReopenActionList1.Actions[I]).Caption := FileOpen1.Dialog.FileName
    else
      TCustomAction(ReopenActionList1.Actions[I]).Caption :=
        TCustomAction(ReopenActionList1.Actions[I - 1]).Caption;
  // Add new items to the reopen item if necessary
  if ReopenItem.Items.Count < ReopenActionList1.ActionCount then
    ReopenItem.Items.Add;
  // Set the item captions by appending a number for use as the shortcut
  // This change will cause them to be streamed which allows us to store the
  // filenames when the application is shutdown
  for I := 0 to ReopenItem.Items.Count - 1 do
  begin
    ReopenItem.Items[I].Action := ReopenActionList1.Actions[I];
    ReopenItem.Items[I].Caption := Format('&%d: %s', [I,
      TCustomAction(ReopenActionList1.Actions[I]).Caption]);
  end;
end;

procedure TForm1.ReopenActionExecute(Sender: TObject);
begin
  // Set the reopened filename into the FileOpen action and call OnAccept to open the file normally
  FileOpen1.Dialog.FileName := (Sender as TCustomAction).Caption;
  // Execute the action's OnAccept logic
  FileOpen1.OnAccept(nil);
end;

end.
