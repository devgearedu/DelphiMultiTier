
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Frmviews;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, Buttons, Grids, ExtCtrls,
  IBX.IBDatabase, IBX.IBCustomDataSet, IBX.IBTable;

type
  TFrmViewDemo = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    VaryingTableSource: TDataSource;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BtnShowEmployee: TSpeedButton;
    BtnShowPhoneList: TSpeedButton;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    VaryingTable: TIBDataSet;
    procedure BtnShowEmployeeClick(Sender: TObject);
    procedure BtnShowPhoneListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
    procedure ShowTable(ATable: string);
  public
    { public declarations }
  end;

var
  FrmViewDemo: TFrmViewDemo;

implementation

{$R *.dfm}

procedure TFrmViewDemo.ShowTable( ATable: string );
begin
  Screen.Cursor := crHourglass;      { show user something's happening }
  VaryingTable.DisableControls;      { hide data changes from user }
  VaryingTable.Active := FALSE;      { close the table }
  VaryingTable.SelectSQL.Text := 'SELECT * FROM '+ ATable;
  VaryingTable.Open;                 { open the table }
  VaryingTable.EnableControls;       { paint the changes }
  Screen.Cursor := crDefault;        { reset the pointer }
end;

procedure TFrmViewDemo.FormShow(Sender: TObject);
begin
  VaryingTable.Open;
end;

procedure TFrmViewDemo.BtnShowEmployeeClick(Sender: TObject);
begin
  ShowTable('EMPLOYEE');
end;

procedure TFrmViewDemo.BtnShowPhoneListClick(Sender: TObject);
begin
  ShowTable('PHONE_LIST');
end;

end.
