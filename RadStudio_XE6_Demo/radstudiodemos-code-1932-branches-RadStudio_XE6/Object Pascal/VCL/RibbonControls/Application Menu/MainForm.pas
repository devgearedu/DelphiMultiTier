
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
  Dialogs, ToolWin, ActnMan, ActnCtrls, ActnMenus, RibbonActnMenus, Ribbon,
  RibbonStyleActnCtrls, ActnList, ImgList, ExtCtrls, AppEvnts,
  StdCtrls, RibbonLunaStyleActnCtrls, System.Actions;

type
  TForm52 = class(TForm)
    ActionManager1: TActionManager;
    Ribbon1: TRibbon;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    ImageList4: TImageList;
    RibbonPage1: TRibbonPage;
    SaveActn: TAction;
    SaveAsActn: TAction;
    DeleteActn: TAction;
    MoveActn: TAction;
    PermissionActn: TAction;
    PrintActn: TAction;
    PropertiesActn: TAction;
    CloseActn: TAction;
    PermissionNoRestrictionsActn: TAction;
    PermissionDoNotForward: TAction;
    PermissionManageCredentials: TAction;
    PrintQuickPrintActn: TAction;
    PrintPrintPreviewActn: TAction;
    PrintDefinePrintStylesActn: TAction;
    PrintMemoStyle: TAction;
    NewMailMessageActn: TAction;
    RibbonPage2: TRibbonPage;
    RibbonPage3: TRibbonPage;
    RibbonGroup1: TRibbonGroup;
    RibbonQuickAccessToolbar1: TRibbonQuickAccessToolbar;
    ImageList5: TImageList;
    CreateAppointmentActn: TAction;
    ExitDemoActn: TAction;
    Memo1: TMemo;
    ApplicationEvents1: TApplicationEvents;
    procedure SaveActnExecute(Sender: TObject);
    procedure PermissionNoRestrictionsActnExecute(Sender: TObject);
    procedure PrintQuickPrintActnExecute(Sender: TObject);
    procedure ExitDemoActnExecute(Sender: TObject);
    procedure NewMailMessageActnExecute(Sender: TObject);
    procedure CreateAppointmentActnExecute(Sender: TObject);
    procedure ApplicationEvents1ActionExecute(Action: TBasicAction;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form52: TForm52;

implementation

{$R *.dfm}

procedure TForm52.ApplicationEvents1ActionExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  Memo1.Lines.Add('Executed: ' + Action.Name);
end;

procedure TForm52.CreateAppointmentActnExecute(Sender: TObject);
begin
  //
end;

procedure TForm52.ExitDemoActnExecute(Sender: TObject);
begin
  close;
end;

procedure TForm52.NewMailMessageActnExecute(Sender: TObject);
begin
  //
end;

procedure TForm52.PermissionNoRestrictionsActnExecute(Sender: TObject);
begin
  // Permission handlers
end;

procedure TForm52.PrintQuickPrintActnExecute(Sender: TObject);
begin
  // Print handlers
end;

procedure TForm52.SaveActnExecute(Sender: TObject);
begin
  //
end;

end.
