unit MoBileForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  System.Rtti, FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.Grid,
  FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Controls.Presentation;

type
  TForm19 = class(TForm)
    btnLoadData: TButton;
    btnNewData: TButton;
    btnDeleteData: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtTtile: TEdit;
    edtAuthor: TEdit;
    edtISBN: TEdit;
    edtProce: TEdit;
    edtLink: TEdit;
    mmoDescription: TMemo;
    ImageControl1: TImageControl;
    btnSaveData: TButton;
    StringGrid1: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form19: TForm19;

implementation

{$R *.fmx}

uses DataAcessModule;

end.
