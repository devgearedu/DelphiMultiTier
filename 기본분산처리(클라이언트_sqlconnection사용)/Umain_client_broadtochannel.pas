unit Umain_client_broadtochannel;

interface

uses
  SYSTEM.JSON, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,dbxjson, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Data.SqlExpr, Vcl.StdCtrls, IPPeerServer,
  Datasnap.DSHTTPCommon, Datasnap.DSCommon,dsproxy;

type
  TMemoCallBack = class(TDBXCallBack)
    function execute(const arg:tjsonValue):tjsonValue; override;
  end;

  TForm15 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    SQLConnection1: TSQLConnection;
    ChannelManager: TDSClientCallbackChannelManager;
    Label1: TLabel;
    Label2: TLabel;
    Edit_LocalClientID: TEdit;
    Edit_localCallBackID: TEdit;
    Label3: TLabel;
    Edit_RemoteClientID: TEdit;
    Label4: TLabel;
    Edit_RemoteCallBackID: TEdit;
    Button3: TButton;
    Edit1: TEdit;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    CallBackID:string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;

implementation
uses
  DSSession;
{$R *.dfm}

{ TMemoCallBack }

function TMemoCallBack.execute(const arg: tjsonValue): tjsonValue;
var
  MessageStr:string;
begin
  result := TJSonTrue.create;
  if arg is tjsonString then
     MessageStr := TJSonString(arg).Value;

  TThread.Synchronize(nil,
                      procedure
                      begin
                         Form15.Memo1.Lines.Text := Messagestr;
                      end);
end;
procedure TForm15.Button1Click(Sender: TObject);
begin
  if not SqlConnection1.Connected then
     SqlConnection1.Open;

  Button1.Enabled := false;
  Button2.Enabled := TRUE;
  ChannelManager.RegisterCallback(CallBackID,TMemocallBack.create);
end;

procedure TForm15.Button2Click(Sender: TObject);
begin
  Button1.Enabled := true;
  Button2.Enabled := false;
  ChannelManager.UnregisterCallback(callbackid);
end;

procedure TForm15.Button3Click(Sender: TObject);
var
  aClient:TDSAdminClient;
begin

   aClient := TDSAdminClient.Create(SQLConnection1.DBXConnection);
   try
     aClient.BroadcastToChannel('MemoChannel',TJSONString.Create(Edit1.text));
   finally
     aClient.Free;
   end;
end;
procedure TForm15.Button4Click(Sender: TObject);
var
  aClient:TDSAdminClient;
  aResponse:TjSONValue;
begin
   aClient := TDSAdminClient.Create(SQLConnection1.DBXConnection);
   try
     aClient.NotifyCallback(
                             Edit_RemoteClientID.Text,
                             Edit_RemoteCallBackID.Text,
                             TJSONString.Create(Edit1.text),
                             aResponse);
   finally
     aClient.Free;
end;
end;

procedure TForm15.FormCreate(Sender: TObject);
begin
  CallbackID := TDSSession.GenerateSessionId;
  ChannelManager.ManagerId := TDSSession.GenerateSessionId;
  Edit_RemoteClientid.Text := '';
  Edit_RemoteCallbackid.Text := '';
  Edit_LocalClientID.Text := ChannelManager.ManagerId;
  Edit_LocalCallBackID.text :=  CallbackID;
end;

end.
