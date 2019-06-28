
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Frmtrigg;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, Buttons, Grids, ExtCtrls;

type
  TFrmTriggerDemo = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmTriggerDemo: TFrmTriggerDemo;

implementation

uses DmCSDemo;

{$R *.dfm}

procedure TFrmTriggerDemo.FormShow(Sender: TObject);
begin
  DmEmployee.EmployeeTable.Open;
  DmEmployee.SalaryHistoryTable.Open;
end;

end.
