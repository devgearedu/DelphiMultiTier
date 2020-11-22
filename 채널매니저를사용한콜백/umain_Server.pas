unit umain_Server;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,system.JSON;

type
  TForm18 = class(TForm)
    Memo1: TMemo;
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form18: TForm18;

implementation

{$R *.dfm}

uses ServerContainerUnit1;

procedure TForm18.Memo1Change(Sender: TObject);
var
   value:TJSONString;
begin
   value := TJSONString.Create(Memo1.Lines.Text);
   ServerContainer1.DSServer1.BroadcastMessage('MemoChannel', value);
end;

end.

