
//---------------------------------------------------------------------------

// This software is Copyright (c) 2012 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit LookupFormUnit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, System.Rtti, Vcl.ExtCtrls, Vcl.DBCtrls, Data.Bind.Components, Data.Bind.DBScope, Vcl.StdCtrls,
  Vcl.AppEvnts, Vcl.Mask, Data.DB, System.Generics.Collections, Vcl.DBCGrids, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Editors, Datasnap.DBClient,
  System.Bindings.Outputs;

type
  TLookupForm1 = class(TForm)
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    DBNavigator1: TDBNavigator;
    ApplicationEvents1: TApplicationEvents;
    CheckBoxDataSetActive: TCheckBox;
    ImageWithHandler: TImage;
    BindLinkImageHandler: TBindLink;
    LabelBind: TLabel;
    BindLinkLabel: TBindLink;
    ListBoxLookupWithHandler: TListBox;
    Label7: TLabel;
    BindListBoxFill: TBindList;
    BindLookupScrollBar: TBindPosition;
    ScrollBar1: TScrollBar;
    BindListBoxLookupHandler: TBindPosition;
    Label1: TLabel;
    DataSource1: TDataSource;
    ClientDataSet2: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    StringField3: TStringField;
    MemoField1: TMemoField;
    BlobField1: TBlobField;
    procedure CheckBoxDataSetActiveClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
  private
    FChecking: Boolean;
  end;

var
  LookupForm1: TLookupForm1;

implementation

uses
  System.Bindings.EvalProtocol, System.Bindings.Methods;

{$R *.dfm}

procedure TLookupForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  FChecking := True;
  try
    CheckBoxDataSetActive.Checked := DataSource1.Enabled;
  finally
    FChecking := False;
  end;

end;

procedure TLookupForm1.CheckBoxDataSetActiveClick(Sender: TObject);
begin
  if not FChecking then
    DataSource1.Enabled := not DataSource1.Enabled;
end;



end.
