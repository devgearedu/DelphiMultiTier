unit Umain_client;

interface

uses
  system.json,Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Data.SqlExpr, Vcl.StdCtrls, data.dbxjson,
  Datasnap.DSCommon;

type

  TMemoCallBack = class(TDBXCallBack)
     function execute(const arg:TJSONValue):TJSONValue; override;
  end;

  TMainForm_Client = class(TForm)
    Memo1: TMemo;
    button1: TButton;
    Button2: TButton;
    SQLConnection1: TSQLConnection;
    ChannelManager: TDSClientCallbackChannelManager;
    procedure button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    Callbackid:string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm_Client: TMainForm_Client;

implementation

{$R *.dfm}

procedure TMainForm_Client.Button2Click(Sender: TObject);
begin
  button1.enabled := true;
  button2.Enabled := false;
  channelmanager.UnregisterCallback(callbackid);
end;

procedure TMainForm_Client.button1Click(Sender: TObject);
begin
  if not SQLconnection1.Connected then
     SQLconnection1.Open;
  Callbackid := datetimetostr(now);
  button1.Enabled := false;
  button2.Enabled := true;
  channelManager.RegisterCallback(callbackid, TMemocallback.create);
end;

{ TMemoCallBack }

function TMemoCallBack.execute(const arg: TJSONValue): TJSONValue;
var
  MessageStr:String;
begin
  result := TJSONTrue.Create;
  if arg is TjsonString then
     MessageStr := TJSONString(arg).Value;
     TThread.Synchronize(nil,
             procedure
             begin
                MainForm_Client.memo1.Lines.text := messagestr;
             end);
end;
end.
