unit UMain_Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Vcl.StdCtrls, Datasnap.DSCommon, Data.DB, Data.SqlExpr,
  DBXJSon;

type
  TMemoCallback = class(TDBXCallback)
    public
      function Execute(Const arg: TJSonValue): TJSonValue; override;
  end;

  TForm18 = class(TForm)
    Memo1: TMemo;
    SQLConnection1: TSQLConnection;
    channelmanager: TDSClientCallbackChannelManager;
    Button1: TButton;
    Button2: TButton;
    Edit_LocalClientID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit_localCallBackID: TEdit;
    Label4: TLabel;
    Edit_RemoteCallBackID: TEdit;
    Edit_RemoteClientID: TEdit;
    Label3: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    CallBackID: String;
  public
    { Public declarations }
  end;

var
  Form18: TForm18;

implementation

{$R *.dfm}

{ TMemoCallback }

function TMemoCallback.Execute(const arg: TJSonValue): TJSonValue;
var
  MessageStr: String;
begin
  Result := TJSonTrue.Create;
  if arg is TJSonString then
    MessageStr := TJSonString(arg).Value;
    TThread.Synchronize(nil,
                        procedure
                        begin
                          Form18.Memo1.Lines.Text := MessageStr;
                        end);
end;

procedure TForm18.Button1Click(Sender: TObject);
begin
  if Not SQLConnection1.Connected then
    SQLConnection1.Open;

  CallbackID := DateTimeToStr(Now);
  Button1.Enabled := False;
  Button2.Enabled := True;
  channelmanager.RegisterCallback(CallbackID, TMemoCallBack.Create);
end;

procedure TForm18.Button2Click(Sender: TObject);
begin
  Button1.Enabled := True;
  Button2.Enabled := False;
  channelmanager.UnregisterCallback(CallbackID);
end;

end.
