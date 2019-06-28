
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Mainform;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, Data.DB, Data.DBXOdbc,
  Datasnap.DBClient, SimpleDS, Data.SqlExpr, FMX.Layouts, FMX.Grid,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Editors, FMX.Effects,
  Data.Bind.Components, Data.Bind.DBScope, Data.Bind.DBLinks, Fmx.Bind.DBLinks,
  FMX.Objects, Fmx.Bind.Navigator, FMX.Edit, System.Rtti,
  System.Bindings.Outputs, FMX.StdCtrls, Data.Bind.Controls;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    SimpleDataSet1: TSimpleDataSet;
    DataSource1: TDataSource;
    StringGrid1: TStringGrid;
    SimpleDataSet1country: TWideStringField;
    SimpleDataSet1currency: TWideStringField;
    BindingsList1: TBindingsList;
    BindScopeDB1: TBindScopeDB;
    DBLinkStringGrid11: TBindDBGridLink;
    StyleBook1: TStyleBook;
    Button1: TButton;
    Edit1: TEdit;
    DBLinkEdit1Country1: TBindDBEditLink;
    Label1: TLabel;
    BindNavigator1: TBindNavigator;
    Rectangle1: TRectangle;
    Edit2: TEdit;
    Label2: TLabel;
    Rectangle2: TRectangle;
    DBLinkEdit2Currency1: TBindDBEditLink;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    Image1: TImage;
    ReflectionEffect1: TReflectionEffect;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  SimpleDataSet1.Open;
end;

end.
