unit umain_client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dbxjson,system.json, Datasnap.DSCommon,
  Data.DB, Data.SqlExpr, Vcl.StdCtrls, Data.DbxDatasnap, Data.DBXCommon,
  IPPeerClient;

type
  TMemoCallBack = class(TDBXCallBack)
     function Execute(const Arg:TJSONValue):TJSONValue; override;
  end;

  TMainForm_Client = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    SQLConnection1: TSQLConnection;
    ChannelManager: TDSClientCallbackChannelManager;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit_RemoteClientID: TEdit;
    Edit_RemoteCallBackID: TEdit;
    Edit_localCallBackID: TEdit;
    Edit_LocalClientID: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    CallBackID:string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm_Client: TMainForm_Client;

implementation

{$R *.dfm}

{ TMemoCallBack }

function TMemoCallBack.Execute(const Arg: TJSONValue): TJSONValue;
var
  MessageStr : string;
begin
  result := TJSONTrue.Create;
  if Arg is TJSONString then
     MessageStr := TJSONString(Arg).Value;
     TThread.Synchronize(nil, procedure
                              begin
                                mainform_Client.Memo1.Lines.Text := MessageStr;
                              end);
end;

procedure TMainForm_Client.Button1Click(Sender: TObject);
begin
   if not SqlConnection1.Connected then
      SqlConnection1.Open;

   CallBackid := DateTimeTostr(Now);
   Button1.enabled := false;
   Button2.enabled := True;
   ChannelManager.RegisterCallback( CallBackid, TMemoCallBack.Create);
end;

procedure TMainForm_Client.Button2Click(Sender: TObject);
begin
   Button1.enabled := true;
   Button2.enabled := false;
   ChannelManager.unRegisterCallback( CallBackid);
end;

end.
