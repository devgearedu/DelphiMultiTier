unit UMain_Server;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, DBXJson, ServerContainerUnit2, SYSTEM.JSON;

type
  TForm17 = class(TForm)
    Memo1: TMemo;
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form17: TForm17;

implementation

{$R *.dfm}

procedure TForm17.Memo1Change(Sender: TObject);
var
  Value: TJSonString;
begin
  Value := TJSonString.Create(memo1.Lines.Text);
  ServerContainer2.DSServer1.BroadcastMessage('MemoChannel', Value);
end;

end.

