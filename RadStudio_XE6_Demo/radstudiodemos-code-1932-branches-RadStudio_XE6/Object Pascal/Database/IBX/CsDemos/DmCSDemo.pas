
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DmCSDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, IBX.IBCustomDataSet, IBX.IBTable, IBX.IBStoredProc, IBX.IBDatabase,
  IBX.IBQuery;

type
  TDmEmployee = class(TDataModule)
    SalesSource: TDataSource;
    CustomerSource: TDataSource;
    EmployeeSource: TDataSource;
    SalaryHistorySource: TDataSource;
    EmployeeDatabase: TIBDatabase;
    IBTransaction1: TIBTransaction;
    ShipOrderProc: TIBStoredProc;
    DeleteEmployeeProc: TIBStoredProc;
    EmployeeLookUp: TIBDataSet;
    SalesTable: TIBDataSet;
    EmployeeTable: TIBDataSet;
    CustomerTable: TIBDataSet;
    SalaryHistoryTable: TIBDataSet;
    EmployeeLookUpEMP_NO: TSmallintField;
    EmployeeLookUpFIRST_NAME: TIBStringField;
    EmployeeLookUpLAST_NAME: TIBStringField;
    EmployeeLookUpPHONE_EXT: TIBStringField;
    EmployeeLookUpHIRE_DATE: TDateTimeField;
    EmployeeLookUpDEPT_NO: TIBStringField;
    EmployeeLookUpJOB_CODE: TIBStringField;
    EmployeeLookUpJOB_GRADE: TSmallintField;
    EmployeeLookUpJOB_COUNTRY: TIBStringField;
    EmployeeLookUpSALARY: TIBBCDField;
    EmployeeLookUpFULL_NAME: TIBStringField;
    procedure EmployeeTableBeforeDelete(DataSet: TDataSet);
    procedure EmployeeTableAfterPost(DataSet: TDataSet);
    procedure DmEmployeeCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmEmployee: TDmEmployee;

implementation

{$R *.dfm}

{ Note: Business rules go in the data model.  Here is an example, used by
  the transaction editing demo.  Deletes for the employee table are done
  with a stored procedure rather than the normal BDE record delete
  mechanism, so an audit trail could be provided, etc... }

{ The database, EmployeeDatabase, is the InterBase example EMPLOYEE.GDB database
  accessed thru the BDE alias IBLOCAL.  This database contains examples
  of stored procedures, triggers, check constraints, views, etc., many of
  which are used within this demo project. }

procedure TDmEmployee.EmployeeTableBeforeDelete(DataSet: TDataSet);
begin
  { Assign the current employee's id to the stored procedure's parameter }
  DeleteEmployeeProc.Params.ParamValues['EMP_NUM'] := EmployeeTable['EMP_NO'];
  DeleteEmployeeProc.ExecProc;          { Trigger the stored proc }
  EmployeeTable.Refresh;                { Refresh the data }
  { Block the EmployeeTable delete since the stored procedure did the work }
  Abort;
end;

procedure TDmEmployee.EmployeeTableAfterPost(DataSet: TDataSet);
begin
  { A change in an employee salary triggers a change in the salary history,
    so if that table is open, it needs to be refreshed now }
  with SalaryHistoryTable do if Active then Refresh;
end;

procedure TDmEmployee.DmEmployeeCreate(Sender: TObject);
begin
  EmployeeDatabase.Open;
end;

end.
