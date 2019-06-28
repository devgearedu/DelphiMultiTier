
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Frmtrans;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, Buttons, Grids, ExtCtrls,
  Dialogs, System.UITypes;

type
  TFrmTransDemo = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BtnUndoEdits: TSpeedButton;
    BtnCommitEdits: TSpeedButton;
    procedure BtnCommitEditsClick(Sender: TObject);
    procedure BtnUndoEditsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmTransDemo: TFrmTransDemo;

implementation

uses DmCSDemo;

{$R *.dfm}

procedure TFrmTransDemo.FormShow(Sender: TObject);
begin
  if not DmEmployee.IBTransaction1.Active then
    DmEmployee.IBTransaction1.StartTransaction;
  if DmEmployee.EmployeeTable.Active = False then
    DmEmployee.EmployeeTable.Open;
end;

procedure TFrmTransDemo.FormHide(Sender: TObject);
begin
  DmEmployee.IBTransaction1.Commit;
end;

procedure TFrmTransDemo.BtnCommitEditsClick(Sender: TObject);
begin
  if DmEmployee.IBTransaction1.InTransaction and
     (MessageDlg('Are you sure you want to commit your changes?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    DmEmployee.IBTransaction1.Commit;
    DmEmployee.IBTransaction1.StartTransaction;
    DmEmployee.EmployeeTable.Open;
    DmEmployee.EmployeeTable.Refresh;
  end else
    MessageDlg('Can''t Commit Changes: No Transaction Active', mtError, [mbOk], 0);
end;

procedure TFrmTransDemo.BtnUndoEditsClick(Sender: TObject);
begin
  if DmEmployee.IBTransaction1.InTransaction and
    (MessageDlg('Are you sure you want to undo all changes made during the ' +
       'current transaction?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
   begin
     DmEmployee.IBTransaction1.Rollback;
     DmEmployee.IBTransaction1.StartTransaction;
     DmEmployee.EmployeeTable.Open;
     DmEmployee.EmployeeTable.Refresh;
   end else
     MessageDlg('Can''t Undo Edits: No Transaction Active', mtError, [mbOk], 0);
end;

end.
