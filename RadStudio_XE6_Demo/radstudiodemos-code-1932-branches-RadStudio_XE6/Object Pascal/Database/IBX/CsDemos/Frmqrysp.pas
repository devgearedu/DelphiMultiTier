
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Frmqrysp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, Grids, ExtCtrls,
  Dialogs, Buttons, Mask, ComCtrls, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TFrmQueryProc = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    EmployeeProjectsSource: TDataSource;
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    EmployeeSource: TDataSource;
    EmployeeProjectsQuery: TIBQuery;
    procedure EmployeeDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { private declarations }
    procedure writeMsg( strWrite : String );
  public
    { public declarations }
  end;

var
  FrmQueryProc: TFrmQueryProc;

implementation

uses DmCSDemo;

{$R *.dfm}

procedure TFrmQueryProc.WriteMsg(StrWrite: String);
begin
   StatusBar1.SimpleText := StrWrite;
end;

procedure TFrmQueryProc.FormShow(Sender: TObject);
begin
  DmEmployee.EmployeeTable.Open;
  { Allow data flow from the EmployeeTable to the local EmployeeSource.  This
    will allow DataChange events to execute the query procedure }
  EmployeeSource.Enabled := True;
  { Explicit query preparation is not required, but gives the best possible
    performance }
  with EmployeeProjectsQuery do if not Active then Prepare;
end;

procedure TFrmQueryProc.EmployeeDataChange(Sender: TObject; Field: TField);
begin
  { Execute the ProjectsQuery, which uses a query procedure }
  EmployeeProjectsQuery.Close;
  EmployeeProjectsQuery.Params[0].AsInteger :=
    DmEmployee.EmployeeTable.FieldByName('EMP_NO').AsInteger;
  EmployeeProjectsQuery.Open;

  WriteMsg('Employee ' + DmEmployee.EmployeeTable.FieldByName('EMP_NO').AsString +
           ' is assigned to ' + IntToStr(EmployeeProjectsQuery.RecordCount) +
           ' project(s).');
end;

procedure TFrmQueryProc.FormHide(Sender: TObject);
begin
  { Turn off the DataChange event for our form, since DmEmployee.EmployeeTable
    is used elsewhere }
  EmployeeSource.Enabled := False;
end;

end.
