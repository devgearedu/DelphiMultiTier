unit Unit1;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit,vcl.dialogs;

type
  TIWForm1 = class(TIWAppForm)
    IWEdit1: TIWEdit;
    IWButton1: TIWButton;
    procedure IWButton1Click(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}


procedure TIWForm1.IWButton1Click(Sender: TObject);
begin
   showMessage('hi');
end;

end.
