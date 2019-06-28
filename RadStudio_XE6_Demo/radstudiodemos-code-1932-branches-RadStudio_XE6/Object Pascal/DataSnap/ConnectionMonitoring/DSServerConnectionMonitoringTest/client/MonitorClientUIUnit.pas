unit MonitorClientUIUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IndyPeerImpl, Datasnap.DSHTTPCommon, Vcl.ExtCtrls,
  Vcl.StdCtrls, Data.DbxDataSnap, Data.DBXCommon, Datasnap.DSHTTPLayer, Data.DB, Data.SqlExpr,
  System.JSON, ProxyUnit, IPPeerServer, Data.DbxHTTPLayer, Data.DBXJSON, Datasnap.DSCommon;

type
  TMyCallback = class(TDBXCallback)
  private
    FMemoField: TMemo;
  public
    constructor Create(MemoField: TMemo); virtual;
    function Execute(const Arg: TJSONValue): TJSONValue; overload; override;
  end;

  TForm10 = class(TForm)
    HTTPChannelManager: TDSClientCallbackChannelManager;
    TCPChannelManager: TDSClientCallbackChannelManager;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    ButtonHTTPCallback: TButton;
    ButtonTCPCallback: TButton;
    MemoHTTP: TMemo;
    MemoTCP: TMemo;
    FieldHTTPReverse: TEdit;
    ButtonHTTPReverse: TButton;
    FieldTCPReverse: TEdit;
    ButtonTCPReverse: TButton;
    HTTPConnection: TSQLConnection;
    TCPConnection: TSQLConnection;
    CheckHTTPConnect: TCheckBox;
    CheckTCPConnect: TCheckBox;
    procedure ButtonHTTPCallbackClick(Sender: TObject);
    procedure ButtonTCPCallbackClick(Sender: TObject);
    procedure CheckHTTPConnectClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckTCPConnectClick(Sender: TObject);
    procedure ButtonHTTPReverseClick(Sender: TObject);
    procedure ButtonTCPReverseClick(Sender: TObject);
    procedure HTTPChannelManagerChannelStateChange(Sender: TObject;
      const EventItem: TDSClientChannelEventItem);
    procedure TCPChannelManagerChannelStateChange(Sender: TObject;
      const EventItem: TDSClientChannelEventItem);
    procedure FormDestroy(Sender: TObject);
  private
    FHTTPProxy: TMonitorServerMethodsClient;
    FTCPProxy: TMonitorServerMethodsClient;
    procedure LogMessageToMemo(const Msg: String; const MemoField: TMemo);
    function RandomId: String;
  end;

var
  Form10: TForm10;

implementation

uses Datasnap.DSServer;

{$R *.dfm}

{ TMyCallback }

constructor TMyCallback.Create(MemoField: TMemo);
begin
  inherited Create;
  FMemoField := MemoField;
end;

function TMyCallback.Execute(const Arg: TJSONValue): TJSONValue;
begin
  Form10.LogMessageToMemo(Arg.ToString, FMemoField);
  Exit(TJSONTrue.Create);
end;

{ TForm10 }

procedure TForm10.ButtonHTTPCallbackClick(Sender: TObject);
begin
  if ButtonHTTPCallback.Caption = 'START HTTP Callback' then
  begin
    HTTPChannelManager.RegisterCallback('httpcb1', TMyCallback.Create(MemoHTTP));
    ButtonHTTPCallback.Caption := 'STOP HTTP Callback';
    MemoHTTP.Enabled := True;
  end
  else
  begin
    HTTPChannelManager.UnregisterCallback('httpcb1');
    ButtonHTTPCallback.Caption := 'START HTTP Callback';
    MemoHTTP.Enabled := False;
    MemoHTTP.Clear;
  end;
end;

procedure TForm10.ButtonHTTPReverseClick(Sender: TObject);
begin
  if FHTTPProxy <> nil then
    try
      FieldHTTPReverse.Text := FHTTPProxy.ReverseString(FieldHTTPReverse.Text);
    except
      HTTPConnection.Connected := False;
      CheckHTTPConnect.Checked := HTTPConnection.Connected;
      ShowMessage('The connection has been terminated.');
    end;
end;

procedure TForm10.ButtonTCPCallbackClick(Sender: TObject);
begin
  if ButtonTCPCallback.Caption = 'START TCP/IP Callback' then
  begin
    TCPChannelManager.RegisterCallback('tcpcb1', TMyCallback.Create(MemoTCP));
    ButtonTCPCallback.Caption := 'STOP TCP/IP Callback';
    MemoTCP.Enabled := True;
  end
  else
  begin
    TCPChannelManager.UnregisterCallback('tcpcb1');
    ButtonTCPCallback.Caption := 'START TCP/IP Callback';
    MemoTCP.Enabled := False;
    MemoTCP.Clear;
  end;
end;

procedure TForm10.ButtonTCPReverseClick(Sender: TObject);
begin
  if FTCPProxy <> nil then
    try
      FieldTCPReverse.Text := FTCPProxy.ReverseString(FieldTCPReverse.Text);
    except
      TCPConnection.Connected := False;
      CheckTCPConnect.Checked := TCPConnection.Connected;
      ShowMessage('The connection has been terminated.');
    end;
end;

procedure TForm10.CheckHTTPConnectClick(Sender: TObject);
begin
  try
    HTTPConnection.Connected := CheckHTTPConnect.Checked;
    if HTTPConnection.Connected then
      FHTTPProxy := TMonitorServerMethodsClient.Create(HTTPConnection.DBXConnection)
    else
      FreeAndNil(FHTTPProxy);
  except
    CheckHTTPConnect.Checked := HTTPConnection.Connected;
  end;

  ButtonHTTPReverse.Enabled := HTTPConnection.Connected;
  FieldHTTPReverse.Enabled := HTTPConnection.Connected;
end;

procedure TForm10.CheckTCPConnectClick(Sender: TObject);
begin
  try
    TCPConnection.Connected := CheckTCPConnect.Checked;
    if TCPConnection.Connected then
      FTCPProxy := TMonitorServerMethodsClient.Create(TCPConnection.DBXConnection)
    else
      FreeAndNil(FTCPProxy);
  except
    CheckTCPConnect.Checked := TCPConnection.Connected;
  end;

  ButtonTCPReverse.Enabled := TCPConnection.Connected;
  FieldTCPReverse.Enabled := TCPConnection.Connected;
end;

procedure TForm10.FormActivate(Sender: TObject);
begin
  FHTTPProxy := nil;
  FTCPProxy := nil;

  TCPChannelManager.ManagerId := RandomId;
  HTTPChannelManager.ManagerId := RandomId;
end;

procedure TForm10.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FHTTPProxy);
  FreeAndNil(FTCPProxy);
end;

procedure TForm10.HTTPChannelManagerChannelStateChange(Sender: TObject;
  const EventItem: TDSClientChannelEventItem);
begin
  if (EventItem.EventType = TunnelClose) or (EventItem.EventType = TunnelClosedByServer) then
  begin
    if ButtonHTTPCallback.Caption = 'STOP HTTP Callback' then
    begin
      HTTPChannelManager.UnregisterCallback('httpcb1');
      ButtonHTTPCallback.Caption := 'START HTTP Callback';
      MemoHTTP.Enabled := False;
      MemoHTTP.Clear;
    end;
  end;
end;

procedure TForm10.LogMessageToMemo(const Msg: String; const MemoField: TMemo);
begin
  if (Msg <> EmptyStr) and (MemoField <> nil) then
    TThread.Queue(nil, procedure begin MemoField.Lines.Add(Msg); end);
end;

function TForm10.RandomId: String;
begin
  Result := IntToStr(Random(10000)) + '.' + IntToStr(Random(10000)) + '.' + IntToStr(Random(10000));
end;

procedure TForm10.TCPChannelManagerChannelStateChange(Sender: TObject;
  const EventItem: TDSClientChannelEventItem);
begin
  if (EventItem.EventType = TunnelClose) or (EventItem.EventType = TunnelClosedByServer) then
  begin
    if ButtonTCPCallback.Caption = 'STOP TCP/IP Callback' then
    begin
      TCPChannelManager.UnregisterCallback('tcpcb1');
      ButtonTCPCallback.Caption := 'START TCP/IP Callback';
      MemoTCP.Enabled := False;
      MemoTCP.Clear;
    end;
  end;
end;

end.
