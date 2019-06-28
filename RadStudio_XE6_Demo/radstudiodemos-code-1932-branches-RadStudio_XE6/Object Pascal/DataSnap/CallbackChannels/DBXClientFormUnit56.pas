
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DBXClientFormUnit56;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  DSClientMetadata, DSProxyDelphiRest, DBXJSON, AppEvnts, System.JSON,
  Generics.Collections, DSHTTPLayer, DbxDataSnap, DBXCommon, DB,
  SqlExpr, DSServer, DSService, DSHTTPCommon, IPPeerClient, IndyPeerImpl,
  IPPeerServer, Data.DbxHTTPLayer, Datasnap.DSCommon;

type
  TCallbackClient = class;

  TDBXClientForm56 = class(TForm)
    ComboBoxChannelName: TComboBox;
    Label1: TLabel;
    ComboBoxCallbackName: TComboBox;
    ComboBoxClientName: TComboBox;
    Label3: TLabel;
    ListBoxChannels: TListBox;
    ButtonCreateClientChannel: TButton;
    Memo1: TMemo;
    ButtonCreateCallback: TButton;
    ApplicationEvents1: TApplicationEvents;
    ListBoxCallbacks: TListBox;
    ButtonTerminateClientChannel: TButton;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    ComboBoxBroadcastToChannel: TComboBox;
    Label6: TLabel;
    ButtonBroadcastToChannel: TButton;
    EditChannelBroadcastMessage: TEdit;
    ButtonTerminateAllClientChannels: TButton;
    ButtonTerminateCallback: TButton;
    Label2: TLabel;
    ComboBoxClientBroadcast: TComboBox;
    Label7: TLabel;
    ComboBoxCallbackBroadcast: TComboBox;
    Label8: TLabel;
    ButtonNotifyClient: TButton;
    Label9: TLabel;
    ButtonClearLog: TButton;
    DSHTTPClientCallbackChannelManager1: TDSClientCallbackChannelManager;
    Label10: TLabel;
    ComboBoxProtocol: TComboBox;
    DSTCPIPClientCallbackChannelManager1: TDSClientCallbackChannelManager;
    ComboBoxProtocolBroadcast: TComboBox;
    Label11: TLabel;
    SQLConnectionHTTP: TSQLConnection;
    SQLConnectionTCPIP: TSQLConnection;
    CheckBoxTerminateWhenClose: TCheckBox;
    EventMessagesCheck: TCheckBox;
    procedure ButtonCreateClientChannelClick(Sender: TObject);
    procedure ButtonCreateCallbackClick(Sender: TObject);
    procedure ButtonTerminateClientChannelClick(Sender: TObject);
    procedure ButtonBroadcastToChannelClick(Sender: TObject);
    procedure ButtonTerminateAllClientChannelsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonTerminateCallbackClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonNotifyClientClick(Sender: TObject);
    procedure ButtonClearLogClick(Sender: TObject);
    procedure DSHTTPClientCallbackChannelManager1ChannelStateChange(Sender: TObject; const EventItem: TDSClientChannelEventItem);
  private
    function CreateChannel(const AClientName,
      AServerChannelName: string): TDSClientCallbackChannelManager;
    function GetSelectedChannel: TDSClientCallbackChannelManager;
    procedure RemoveChannel(AChannel: TDSClientCallbackChannelManager);
    procedure CallbackBroadCast(AChannel: TDSClientCallbackChannelManager;
    const AMessage: string);
    function ChannelBroadCast(AChannel: TDSClientCallbackChannelManager;
      const AMessage: string): Boolean; overload;
    function ChannelBroadCast(const AChannel: string;
      const AMessage: string): Boolean; overload;
    procedure TerminateAllClientChannels;
    procedure RemoveCallback(ACallback: TCallbackClient);
    function GetSelectedCallback(out AChannel: TDSClientCallbackChannelManager;
      out ACallback: TCallbackClient): Boolean;
    function FindCallback(AChannel: TDSClientCallbackChannelManager; const ACallback: string): TCallbackClient;
    function FindChannel(const AClient, AChannel: string): TDSClientCallbackChannelManager;
    function ClientNotify(const AChannel, ACallback, AClient,
      AMessage: string): Boolean;
    procedure OnServerConnectionTerminate(Sender: TObject);
    function GetClientConnection: TDBXConnection;
    procedure OnServerConnectionError(Sender: TObject);
  public
    FObjectsToFree: TList<TObject>;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TCallbackClient = class(TDBXCallback)
  private
    FChannelName: string;
    FClientName: string;
    FCallbackName: string;
  public
    constructor Create(const AChannelName, ACallbackName, AClientName: string);
    destructor Destroy; override;
    function Execute(const Arg: TJSONValue): TJSONValue; overload; override;
  end;

var
  DBXClientForm56: TDBXClientForm56;

implementation

{$R *.dfm}

uses DSProxyRest, DSProxy;

type

  TCallbackItem = class
  public
    FCallback: TCallbackClient;
    FChannel: TDSClientCallbackChannelManager;
    constructor Create(AChannel: TDSClientCallbackChannelManager; ACallback: TCallbackClient);
  end;


// Non-blocking call to write to Memo1.  Avoids possible deadlock when multiple
// threads are using SendMessage (e.g.; SendMessage for button click, SendMessage to
// write to Memo control).
procedure QueueLogValue(const AValue: string);
begin
  TThread.Queue(nil,
    procedure begin if DBXClientForm56 <> nil then DBXClientForm56.Memo1.Lines.Add(AValue) end)
end;

procedure LogValue(const AValue: string);
begin
  if DBXClientForm56 <> nil then DBXClientForm56.Memo1.Lines.Add(AValue);
end;

constructor TDBXClientForm56.Create(AOwner: TComponent);
begin
  inherited;
  FObjectsToFree := TObjectList<TObject>.Create;
end;

function TDBXClientForm56.CreateChannel(const AClientName, AServerChannelName: string): TDSClientCallbackChannelManager;
var
  LChannelManager: TDSClientCallbackChannelManager;
begin
  Result := TDSClientCallbackChannelManager.Create(nil);
  Result.ChannelName := AServerChannelName;
  Result.ManagerId := AClientName;
  if ComboBoxProtocol.Text = 'http' then
    LChannelManager := DSHTTPClientCallbackChannelManager1
  else
    LChannelManager := DSTCPIPClientCallbackChannelManager1;

  // Just use component for connection parameters because this sample creates multiple
  // channel manager instances
  Result.DSHostname := LChannelManager.DSHostname;
  Result.DSPort := LChannelManager.DSPort;
  Result.DSPath := LChannelManager.DSPath;
  Result.CommunicationProtocol := LChannelManager.CommunicationProtocol;
  Result.OnServerConnectionTerminate := OnServerConnectionTerminate;
  Result.OnServerConnectionError := OnServerConnectionError;
  Result.OnChannelStateChange := LChannelManager.OnChannelStateChange;
  Result.UserName := LChannelManager.UserName;
  Result.Password := LChannelManager.Password;
end;


destructor TDBXClientForm56.Destroy;
begin
  FObjectsToFree.Free;
  inherited;
end;

procedure TDBXClientForm56.DSHTTPClientCallbackChannelManager1ChannelStateChange(
  Sender: TObject; const EventItem: TDSClientChannelEventItem);
var
  LEventItem: TDSClientChannelEventItem;
begin
  LEventItem := EventItem;
  //Synchronize instead of Queue so that the objects in the event don't get freed by the caller thread
  //before the UI task (especially the call to RemoveChannel) finish running.
  TThread.Synchronize(nil,
    procedure
    begin
      if (LEventItem.EventType = TunnelClose) or (LEventItem.EventType = TunnelClosedByServer) then
        RemoveChannel(LEventItem.Tunnel);

      if EventMessagesCheck.Checked then
      begin
        case LEventItem.EventType of
          TunnelCreate:
          begin
            if LEventItem.CallbackId <> EmptyStr then
              ShowMessage(Format('Tunnel was created: %s, with initial callback: %s',
                                 [LEventItem.TunnelId, LEventItem.CallbackId]))
            else
              ShowMessage('Tunnel was created: ' + LEventItem.TunnelId);
          end;
          TunnelClose: ShowMessage('Tunnel was closed: ' + LEventItem.TunnelId);
          CallbackAdded: ShowMessage('Callback was added: ' + LEventItem.CallbackId);
          CallbackRemoved: ShowMessage('Callback was removed: ' + LEventItem.CallbackId);
          TunnelClosedByServer: ShowMessage('Tunnel closed by server: ' + LEventItem.TunnelId);
          else
            ShowMessage('Unknown Event!');
        end;
      end;
    end);
end;

procedure TDBXClientForm56.FormDestroy(Sender: TObject);
begin
  if CheckBoxTerminateWhenClose.Checked then
    TerminateAllClientChannels;
end;

procedure TDBXClientForm56.OnServerConnectionTerminate(Sender: TObject);
begin
  QueueLogValue('Server connection terminate');
end;

procedure TDBXClientForm56.OnServerConnectionError(Sender: TObject);
begin
  QueueLogValue('Server connection error');
end;

function TDBXClientForm56.GetSelectedChannel: TDSClientCallbackChannelManager;
begin
  if ListBoxChannels.ItemIndex >= 0 then
    Result := TDSClientCallbackChannelManager(ListBoxChannels.Items.Objects[ListBoxChannels.ItemIndex])
  else
    Result := nil;
end;

function TDBXClientForm56.GetSelectedCallback(
  out AChannel: TDSClientCallbackChannelManager; out ACallback: TCallbackClient): Boolean;
var
  LItem: TCallbackItem;
begin
  if ListBoxCallbacks.ItemIndex >= 0 then
  begin
    LItem := TCallbackItem(ListBoxCallbacks.Items.Objects[ListBoxCallbacks.ItemIndex]);
    ACallback := LItem.FCallback;
    AChannel := LItem.FChannel;
    Result := True;
  end
  else
  begin
    ACallback := nil;
    AChannel := nil;
    Result := False;
  end;
end;

procedure TDBXClientForm56.RemoveChannel(AChannel: TDSClientCallbackChannelManager);
var
  I: Integer;
  LItem: TCallbackItem;
begin
  // Remove callbacks
  for I := ListBoxCallbacks.Count - 1 downto 0 do
  begin
    LItem := TCallbackItem(ListBoxCallbacks.Items.Objects[I]);
    if LItem.FChannel = AChannel then
      ListBoxCallbacks.Items.Delete(I);
  end;
  I := ListBoxChannels.Items.IndexOfObject(AChannel);
  if I >= 0 then
    ListBoxChannels.Items.Delete(I);
end;

procedure TDBXClientForm56.RemoveCallback(ACallback: TCallbackClient);
var
  I: Integer;
  LItem: TCallbackItem;
begin
  for I := 0 to ListBoxCallbacks.Count - 1 do
  begin
    LItem := TCallbackItem(ListBoxCallbacks.Items.Objects[I]);
    if LItem.FCallback = ACallback then
    begin
      ListBoxCallbacks.Items.Delete(I);
      break;
    end;
  end;
end;

procedure TDBXClientForm56.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
var
  LHaveChannel: Boolean;
  LHaveCallback: Boolean;
  LTemp: TDSClientCallbackChannelManager;
  LTemp2: TCallbackClient;
begin
  LHaveChannel := GetSelectedChannel <> nil;
  LHaveCallback := GetSelectedCallback(LTemp, LTemp2);
  ButtonCreateCallback.Enabled := LHaveChannel;
  ButtonTerminateClientChannel.Enabled := LHaveChannel;
  ButtonTerminateAllClientChannels.Enabled := ListBoxChannels.Count > 0;
  ButtonTerminateCallback.Enabled := LHaveCallback;
  ButtonCreateCallback.Caption := 'Create ' + ComboBoxCallbackName.Text;
  ButtonCreateClientChannel.Caption := 'Create ' + ComboBoxChannelName.Text;
  ButtonBroadcastToChannel.Caption := 'Broadcast to ' + ComboBoxBroadcastToChannel.Text;
  ButtonNotifyClient.Caption := 'Notify ' + ComboBoxClientBroadcast.Text;
end;

procedure TDBXClientForm56.ButtonBroadcastToChannelClick(Sender: TObject);
begin
  if not ChannelBroadcast(ComboBoxBroadcastToChannel.Text,
    EditChannelBroadcastMessage.Text) then
    LogValue('ChannelBroadcast failed');

end;

function TDBXClientForm56.ChannelBroadCast(AChannel: TDSClientCallbackChannelManager; const AMessage: string): Boolean;
var
  LMessage: TJSONString;
begin
  Result := False;
  if AChannel <> nil then
  begin
    LMessage := TJSONString.Create(Format('Client broadcast Channel: %s, Message: %s',
      [AChannel.ChannelName, AMessage]));
    try
      Result := AChannel.BroadcastToChannel(LMessage)
    finally
      LMessage.Free;
    end;
  end;
end;

function TDBXClientForm56.GetClientConnection: TDBXConnection;
begin
  if ComboBoxProtocolBroadcast.Text = 'http' then
  begin
    SQLConnectionHTTP.Close;
    SQLConnectionHTTP.Open;
    Result := SQLConnectionHTTP.DBXConnection;
  end
  else
  begin
    SQLConnectionTCPIP.Close;
    SQLConnectionTCPIP.Open;
    Result := SQLConnectionTCPIP.DBXConnection;
  end;
end;

function TDBXClientForm56.ChannelBroadCast(const AChannel: string; const AMessage: string): Boolean;
var
  LClient: TDSAdminClient;
  LMessage: TJSONString;
  LConnection: TDBXConnection;
begin
  Result := False;
  LConnection := GetClientConnection;
  // Clear session in case server was restarted while client is running
  LClient := TDSAdminClient.Create(LConnection, False);
  try
    LMessage := TJSONString.Create(Format('Client broadcast Channel: %s, Message: %s',
      [AChannel, AMessage]));
    try
      Result := LClient.BroadcastToChannel(AChannel, LMessage)
    finally
      LMessage.Free;
    end;
  finally
    LClient.Free;
  end;
end;

function TDBXClientForm56.ClientNotify(const AChannel, ACallback, AClient: string; const AMessage: string): Boolean;
var
  LClient: TDSAdminClient;
  LMessage: TJSONString;
  LResponse: TJSONValue;
  LConnection: TDBXConnection;
begin
  Result := False;
  LConnection := GetClientConnection;
  LClient := TDSAdminClient.Create(LConnection, False);
  try
    LMessage := TJSONString.Create(Format('Client notify Channel: %s, Callback: %s, Client: %s, Message: %s',
      [AChannel, ACallback, AClient, AMessage]));
    try
      Result := LClient.NotifyCallback(AChannel, AClient, ACallback, LMessage,
        LResponse);
      try
        if LResponse <> nil then
          LogValue(Format('Client response: %s', [LResponse.ToString]))
        else
          LogValue(Format('Client response: %s', ['nil']))
      finally
        LResponse.Free;
      end;
    finally
      LMessage.Free;
    end;
  finally
    LClient.Free;
  end;
end;

procedure TDBXClientForm56.CallbackBroadCast(AChannel: TDSClientCallbackChannelManager; const AMessage: string);
var
  LMessage: TJSONString;
begin
  if AChannel <> nil then
  begin
    LMessage := TJSONString.Create(Format('ServerChannelName: %s, ClientChannelId: %s',
      [AChannel.ChannelName, AChannel.ManagerId]));
    try
      AChannel.BroadcastToChannel(LMessage)
    finally
      LMessage.Free;
    end;
  end;
end;

function TDBXClientForm56.FindCallback(AChannel: TDSClientCallbackChannelManager; const ACallback: string): TCallbackClient;
var
  I: Integer;
  LItem: TCallbackItem;
begin
  Result := nil;
  for I := 0 to ListBoxCallbacks.Count - 1 do
  begin
    LItem := TCallbackItem(ListBoxCallbacks.Items.Objects[I]);
    if LItem.FChannel = AChannel then
      if LItem.FCallback.FCallbackName = ACallback then
        Exit(LItem.FCallback);
  end;
end;

function TDBXClientForm56.FindChannel(const AClient, AChannel: string): TDSClientCallbackChannelManager;
var
  I: Integer;
  LItem: TDSClientCallbackChannelManager;
begin
  Result := nil;
  for I := 0 to ListBoxChannels.Count - 1 do
  begin
    LItem := TDSClientCallbackChannelManager(ListBoxChannels.Items.Objects[I]);
    if LItem.ChannelName = AChannel then
      if LItem.ManagerId = AClient then
        Exit(LItem);
  end;
end;

procedure TDBXClientForm56.ButtonClearLogClick(Sender: TObject);
begin
  Memo1.Clear;
end;


procedure TDBXClientForm56.ButtonCreateCallbackClick(Sender: TObject);
var
  LChannel: TDSClientCallbackChannelManager;
  LItem: TCallbackItem;
  LIndex: Integer;
  LCallbackName: string;
  LChannelName: string;
  LClientName: string;
  LCallback: TCallbackClient;
begin
  LChannel := GetSelectedChannel;
  if FindCallback(LChannel, ComboBoxCallbackName.Text) <> nil then
    raise Exception.CreateFmt('Callback already registered channel: %s, callback: %s',
      [LChannel.ChannelName,ComboBoxCallbackName.Text]);
  LCallbackName := ComboBoxCallbackName.Text;
  LChannelName := LChannel.ChannelName;
  LClientName := LChannel.ManagerId;
  LCallback := TCallbackClient.Create(LChannelName, LCallbackName, LClientName);
  LChannel.RegisterCallback(LCallbackName, LCallback);
  LItem := TCallbackItem.Create(LChannel, LCallback);
  FObjectsToFree.Add(LItem);
  LIndex := ListBoxCallbacks.Items.AddObject(Format('Callback: %s, Channel: %s, Client: %s',
    [LCallback.FCallbackName, LChannel.ChannelName, LChannel.ManagerId]), LItem);
  ListBoxCallbacks.ItemIndex := LIndex;
end;

procedure TDBXClientForm56.ButtonCreateClientChannelClick(Sender: TObject);
var
  LChannel: TDSClientCallbackChannelManager;
  LIndex: Integer;
begin
  if FindChannel(Self.ComboBoxClientName.Text, ComboBoxChannelName.Text) <> nil then
    raise Exception.CreateFmt('Channel already registered client: %s, channel: %s',
      [Self.ComboBoxClientName.Text, ComboBoxChannelName.Text]);
  LChannel := CreateChannel(Self.ComboBoxClientName.Text,
    Self.ComboBoxChannelName.Text);
  if LChannel <> nil then
  begin
    LIndex := ListBoxChannels.Items.AddObject(Format('Channel: %s, Client: %s', [LChannel.ChannelName, LChannel.ManagerId]),
      LChannel);
    ListBoxChannels.ItemIndex := LIndex;
  end;
end;

procedure TDBXClientForm56.ButtonNotifyClientClick(Sender: TObject);
begin
  if not ClientNotify(ComboBoxBroadcastToChannel.Text,
    ComboBoxCallbackBroadcast.Text, ComboBoxClientBroadcast.Text,
    EditChannelBroadcastMessage.Text) then
    LogValue('Client notify failed');


end;

procedure TDBXClientForm56.ButtonTerminateAllClientChannelsClick(Sender: TObject);
begin
  TerminateAllClientChannels;
end;

procedure TDBXClientForm56.TerminateAllClientChannels;
var
  I: Integer;
  LChannel: TDSClientCallbackChannelManager;
begin
  for I := ListBoxChannels.Count - 1 downto 0 do
  begin
    LChannel := TDSClientCallbackChannelManager(ListBoxChannels.Items.Objects[I]);
    RemoveChannel(LChannel);
    LChannel.Free;
  end;
end;

procedure TDBXClientForm56.ButtonTerminateCallbackClick(Sender: TObject);
var
  LCallback: TCallbackClient;
  LChannel: TDSClientCallbackChannelManager;
begin
  if GetSelectedCallback(LChannel, LCallback) then
  begin
    RemoveCallback(LCallback);
    LChannel.UnregisterCallback(LCallback.FCallbackName);
  end;
end;

procedure TDBXClientForm56.ButtonTerminateClientChannelClick(Sender: TObject);
var
  LChannel: TDSClientCallbackChannelManager;
begin
  LChannel := GetSelectedChannel;
  RemoveChannel(LChannel);
  LChannel.Free;
end;

{ TCallbackItem }

constructor TCallbackItem.Create(AChannel: TDSClientCallbackChannelManager;
  ACallback: TCallbackClient);
begin
  FCallback := ACallback;
  FChannel := AChannel;
end;

{ TCallbackClient }

constructor TCallbackClient.Create(const AChannelName, ACallbackName,
  AClientName: string);
begin
  inherited Create;
  FChannelName := AChannelName;
  FCallbackName := ACallbackName;
  FClientName := AClientName;
end;

destructor TCallbackClient.Destroy;
begin
  //
  inherited;
end;

function TCallbackClient.Execute(const Arg: TJSONValue): TJSONValue;
begin
    QueueLogValue(Format('Channel: %s, Callback: %s, Client: %s received %s', [
      FChannelName, FCallbackName, FClientName, Arg.ToString]));
    Result := TJSONTrue.Create;

end;

end.
