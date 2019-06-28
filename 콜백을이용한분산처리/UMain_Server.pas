unit UMain_Server;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, system.json,Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, ServerContainerUnit1;

type
  TMainForm_Server = class(TForm)
    Memo1: TMemo;
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm_Server: TMainForm_Server;

implementation

{$R *.dfm}

procedure TMainForm_Server.Memo1Change(Sender: TObject);
var
  Value:TJSONString;
begin
  value := tjsonstring.Create(memo1.Lines.Text);
  ServerContainer1.DSServer1.BroadcastMessage('MemoChannel', value);
end;

end.

