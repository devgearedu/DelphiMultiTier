
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Ffactwin;

{ This application shows how to display Paradox style memo and graphic
 fields in a form. Table1's DatabaseName property should point to the
 Delphi sample database. Table1's TableName property should be set to
 the BIOLIFE table. }

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, StdCtrls, DBCtrls, DBGrids, DB, Buttons, Grids, ExtCtrls,
  IBX.IBDatabase, IBX.IBCustomDataSet, IBX.IBTable, Vcl.Styles, Vcl.Themes;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBImage1: TDBImage;
    DBLabel1: TDBText;
    DBMemo1: TDBMemo;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    Panel5: TPanel;
    lbStyle: TLabel;
    cbStyles: TComboBox;
    IBDataSet1: TIBDataSet;
    procedure FormCreate(Sender: TObject);
    procedure cbStylesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cbStylesClick(Sender: TObject);
begin
  TStyleManager.SetStyle(TComboBox(Sender).Items[TComboBox(Sender).ItemIndex]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  cbStyles.Items.AddStrings(TStyleManager.StyleNames);
  cbStyles.ItemIndex := cbStyles.Items.IndexOf(TStyleManager.ActiveStyle.Name);
end;

end.
