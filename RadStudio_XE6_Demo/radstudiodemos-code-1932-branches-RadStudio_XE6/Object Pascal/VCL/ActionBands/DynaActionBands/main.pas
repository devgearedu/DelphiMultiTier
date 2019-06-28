
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
  Dialogs, ActnMan, ActnList, ToolWin, ActnCtrls, ActnMenus, StdCtrls,
  StdActns, ExtCtrls, ComCtrls, XPStyleActnCtrls, PlatformDefaultStyleActnCtrls,
  System.Actions;

type
  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    Memo1: TMemo;
    Panel1: TPanel;
    Button4: TButton;
    Button1: TButton;
    Button3: TButton;
    Button2: TButton;
    AddCategoryAction: TAction;
    AddActionAction: TAction;
    AddSeparatorAction: TAction;
    DeleteItemsAction: TAction;
    StatusBar1: TStatusBar;
    DisableBtn: TButton;
    ActionList1: TActionList;
    EditDelete2: TEditDelete;
    procedure DeleteItemsActionExecute(Sender: TObject);
    procedure AddSeparatorActionExecute(Sender: TObject);
    procedure AddCategoryActionExecute(Sender: TObject);
    procedure AddActionActionExecute(Sender: TObject);
    procedure DisableBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DeleteItemsActionExecute(Sender: TObject);
begin
  ActionManager1.DeleteActionItems([Action1]);
end;

procedure TForm1.AddSeparatorActionExecute(Sender: TObject);
var
  Item: TActionClientItem;
begin
  Item := ActionManager1.FindItemByAction(Action1);
  if Assigned(Item) then
    ActionManager1.AddSeparator(Item);
end;

procedure TForm1.AddCategoryActionExecute(Sender: TObject);
var
  Item: TActionClientItem;
begin
  Item := ActionManager1.FindItemByCaption('&test');
  if Assigned(Item) then
    ActionManager1.AddCategory('Edit', Item);
end;

procedure TForm1.AddActionActionExecute(Sender: TObject);
var
  Item: TActionClientItem;
begin
  Item := ActionManager1.FindItemByCaption('&Action1');
  if Assigned(Item) then
    ActionManager1.AddAction(EditCut1, Item);
end;

procedure TForm1.DisableBtnClick(Sender: TObject);
var
  Item: TActionClientItem;
begin
  Item := ActionManager1.FindItemByCaption('&test');
  if Assigned(Item) then
    Item.Control.Enabled := not Item.Control.Enabled;
end;

end.
