
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, DBCtrls, DB, StdCtrls, Menus;

type
  TFmMain = class(TForm)
    DBNavigator1: TDBNavigator;
    GridCustomers: TDBGrid;
    GridOrders: TDBGrid;
    GridItems: TDBGrid;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    About1: TMenuItem;
    procedure GridOrdersEnter(Sender: TObject);
    procedure GridCustomersEnter(Sender: TObject);
    procedure GridItemsEnter(Sender: TObject);
    procedure GridCustomersExit(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

uses DM1, About;

  {$R *.dfm}

procedure TFmMain.GridOrdersEnter(Sender: TObject);
begin
  DBNavigator1.DataSource := Dm.OrdersSource;
end;

procedure TFmMain.GridCustomersEnter(Sender: TObject);
begin
  DBNavigator1.DataSource := Dm.CustomerSource;
end;

procedure TFmMain.GridItemsEnter(Sender: TObject);
begin
  DBNavigator1.DataSource := Dm.ItemsSource;
end;

procedure TFmMain.GridCustomersExit(Sender: TObject);
begin
  if Dm.Customer.State in [dsEdit,dsInsert] then
    Dm.Customer.Post; {required if user clicks onto details
                       after changing key so that cascaded
                       update displays properly}
end;

procedure TFmMain.About1Click(Sender: TObject);
var
  fmAboutBox : TFmAboutBox;
begin
  FmAboutBox := TFmAboutBox.Create(self);
  try
    FmAboutBox.showModal;
  finally
    FmAboutBox.free;
  end;
end;

end.
