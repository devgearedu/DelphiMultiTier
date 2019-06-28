unit SettingsForm;

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls, FMX_Forms,
  FMX_Dialogs, FMX_Edit, FMX_Objects;

type
  TfrmSettings = class(TForm)
    Rectangle1: TRectangle;
    btnCancel: TButton;
    edtHost: TEdit;
    Label1: TLabel;
    edtPort: TEdit;
    Label2: TLabel;
    btnOK: TButton;
    StyleBook1: TStyleBook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.lfm}

end.
