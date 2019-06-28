
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit RESTClientFormUnit56;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DSClientRest, StdCtrls,
  DSClientMetadata, DSProxyDelphiRest, DBXJSON, AppEvnts,
  Generics.Collections, IPPeerClient, IndyPeerImpl;

type
  TForm56 = class(TForm)
    ComboBoxChannelName: TComboBox;
    Label1: TLabel;
    ComboBoxCallbackName: TComboBox;
    ComboBoxClientName: TComboBox;
    Label3: TLabel;
    ListBoxChannels: TListBox;
    ButtonCreateClientChannel: TButton;
    Memo1: TMemo;
    ButtonCreateCallback: TButton;
    DSRestConnection1: TDSRestConnection;
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
    procedure ChannelStateChange(const EventItem: TDSRESTChannelEventItem);
  private
    function CreateChannel(Connection: TDSRestConnection; const AClientName,
      AServerChannelName: string): TDSRestClientChannel;
    function GetSelectedChannel: TDSRestClientChannel;
    procedure OnChannelDisconnect(Sender: TObject);
    procedure RemoveChannel(AChannel: TDSRestClientChannel);
    procedure CallbackBroadCast(AChannel: TDSRestClientChannel;
    const AMessage: string);
    function ChannelBroadCast(AChannel: TDSRestClientChannel;
      const AMessage: string): Boolean; overload;
    function ChannelBroadCast(const AChannel: string;
      const AMessage: string): Boolean; overload;
    procedure TerminateAllClientChannels;
    procedure RemoveCallback(ACallback: TDSRestClientCallback);
    function GetSelectedCallback(out AChannel: TDSRestClientChannel;
      out ACallback: TDSRestClientCallback): Boolean;
    function FindCallback(AChannel: TDSRestClientChannel; const ACallback: string): TDSRestClientCallback;
    function FindChannel(const AClient, AChannel: string): TDSRestClientchannel;
    function ClientNotify(const AChannel, ACallback, AClient,
      AMessage: string): Boolean;
    { Private declarations }
  public
    FObjectsToFree: TList<TObject>;
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Form56: TForm56;

implementation

{$R *.dfm}

uses System.JSON, DSProxyRest;

type
  TCallbackItem = class
  public
    FCallback: TDSRestClientCallback;
    FChannel: TDSRestClientChannel;
    constructor Create(AChannel: TDSRestClientChannel; ACallback: TDSRestClientCallback);
  end;

// Non-blocking call to write to Memo1.  Avoids possible deadlock when multiple
// threads are using SendMessage (e.g.; SendMessage for button click, SendMessage to
// write to Memo control).
procedure QueueLogValue(const AValue: string);
begin
  TThread.Queue(nil,
    procedure begin if Form56 <> nil then Form56.Memo1.Lines.Add(AValue) end)
end;

procedure LogValue(const AValue: string);
begin
  if Form56 <> nil then Form56.Memo1.Lines.Add(AValue);
end;

constructor TForm56.Create(AOwner: TComponent);
begin
  inherited;
  FObjectsToFree := TObjectList<TObject>.Create;
end;

function TForm56.CreateChannel(Connection: TDSRestConnection; const AClientName, AServerChannelName: string): TDSRestClientChannel;
begin
  Result := TDSRestClientChannel.Create(AClientName, AServerChannelName, Connection);
  Result.OnDisconnect := OnChannelDisconnect;
  Result.OnChannelStateChange := ChannelStateChange;
end;


destructor TForm56.Destroy;
begin
  FObjectsToFree.Free;
  inherited;
end;

procedure TForm56.FormDestroy(Sender: TObject);
begin
  if CheckBoxTerminateWhenClose.Checked then
    TerminateAllClientChannels;
end;

procedure TForm56.OnChannelDisconnect(Sender: TObject);
begin
  if Sender is TDSRestClientCallback then
    RemoveCallback(TDSRestClientCallback(Sender));
  QueueLogValue('Channel disconnect');
end;

function TForm56.GetSelectedChannel: TDSRestClientChannel;
begin
  if ListBoxChannels.ItemIndex >= 0 then
    Result := TDSRestClientChannel(ListBoxChannels.Items.Objects[ListBoxChannels.ItemIndex])
  else
    Result := nil;
end;

function TForm56.GetSelectedCallback(
  out AChannel: TDSRestClientChannel; out ACallback: TDSRestClientCallback): Boolean;
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

procedure TForm56.RemoveChannel(AChannel: TDSRestClientChannel);
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

procedure TForm56.RemoveCallback(ACallback: TDSRestClientCallback);
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

procedure TForm56.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
var
  LHaveChannel: Boolean;
  LHaveCallback: Boolean;
  LTemp: TDSRestClientChannel;
  LTemp2: TDSRestClientCallback;
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

procedure TForm56.ButtonBroadcastToChannelClick(Sender: TObject);
begin
  if not ChannelBroadcast(ComboBoxBroadcastToChannel.Text,
    EditChannelBroadcastMessage.Text) then
    LogValue('ChannelBroadcast failed');

end;

function TForm56.ChannelBroadCast(AChannel: TDSRestClientChannel; const AMessage: string): Boolean;
var
  LMessage: TJSONString;
begin
  Result := False;
  if AChannel <> nil then
  begin
    LMessage := TJSONString.Create(Format('Client broadcast Channel: %s, Message: %s',
      [AChannel.ServerChannelName, AMessage]));
    try
      Result := AChannel.Broadcast(LMessage);
    finally
      LMessage.Free;
    end;
  end;
end;

function TForm56.ChannelBroadCast(const AChannel: string; const AMessage: string): Boolean;
var
  LClient: TDSAdminRestClient;
  LMessage: TJSONString;
begin
  Result := False;
  // Clear session in case server was restarted while client is running
  DSRestConnection1.SessionId := '';
  LClient := TDSAdminRestClient.Create(DSRestConnection1, False);
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

procedure TForm56.ChannelStateChange(const EventItem: TDSRESTChannelEventItem);
var
  LEventItem: TDSRESTChannelEventItem;
begin
  LEventItem := EventItem;
  //Synchronize instead of Queue so that the objects in the event don't get freed by the caller thread
  //before the UI task (especially the call to RemoveChannel) finish running.
  TThread.Synchronize(nil,
    procedure
    begin
      if (LEventItem.EventType = rChannelClose) or (LEventItem.EventType = rChannelClosedByServer) then
        RemoveChannel(LEventItem.ClientChannel);
    end);

  TThread.Queue(nil,
    procedure
    begin
      if EventMessagesCheck.Checked then
      begin
        case LEventItem.EventType of
          rChannelCreate:
          begin
            if LEventItem.CallbackId <> EmptyStr then
              ShowMessage(Format('Tunnel was created: %s, with initial callback: %s',
                                 [LEventItem.ClientChannelId, LEventItem.CallbackId]))
            else
              ShowMessage('Tunnel was created: ' + LEventItem.ClientChannelId);
          end;
          rChannelClose: ShowMessage('Tunnel was closed: ' + LEventItem.ClientChannelId);
          rCallbackAdded: ShowMessage('Callback was added: ' + LEventItem.CallbackId);
          rCallbackRemoved: ShowMessage('Callback was removed: ' + LEventItem.CallbackId);
          rChannelClosedByServer: ShowMessage('Channel closed by server: ' + LEventItem.ClientChannelId);
          else
            ShowMessage('Unknown Event!');
        end;
      end;
    end);
end;

function TForm56.ClientNotify(const AChannel, ACallback, AClient: string; const AMessage: string): Boolean;
var
  LClient: TDSAdminRestClient;
  LMessage: TJSONString;
  LResponse: TJSONValue;
begin
  Result := False;
  // Clear session in case server was restarted while client is running
  DSRestConnection1.SessionId := '';
  LClient := TDSAdminRestClient.Create(DSRestConnection1, False);
  try
    LMessage := TJSONString.Create(Format('Client notify Channel: %s, Callback: %s, Client: %s, Message: %s',
      [AChannel, ACallback, AClient, AMessage]));
    try
//      Result := LClient.NotifyCallback(AChannel, AClient, ACallback, LMessage,
//        LResponse);
      Result := LClient.NotifyCallback(AClient, ACallback, LMessage,
        LResponse);
      try
        if LResponse <> nil then
          LogValue(Format('Client response: %s', [LResponse.ToString]))
        else
          LogValue(Format('Client response: %s', ['nil']));
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

procedure TForm56.CallbackBroadCast(AChannel: TDSRestClientChannel; const AMessage: string);
var
  LMessage: TJSONString;
begin
  if AChannel <> nil then
  begin
    LMessage := TJSONString.Create(Format('ServerChannelName: %s, ClientChannelId: %s',
      [AChannel.ServerChannelName, AChannel.ChannelId]));
    try
      AChannel.Broadcast(LMessage);
    finally
      LMessage.Free;
    end;
  end;
end;

function TForm56.FindCallback(AChannel: TDSRestClientChannel; const ACallback: string): TDSRestClientCallback;
var
  I: Integer;
  LItem: TCallbackItem;
begin
  Result := nil;
  for I := 0 to ListBoxCallbacks.Count - 1 do
  begin
    LItem := TCallbackItem(ListBoxCallbacks.Items.Objects[I]);
    if LItem.FChannel = AChannel then
      if LItem.FCallback.CallbackId = ACallback then
        Exit(LItem.FCallback);
  end;
end;

function TForm56.FindChannel(const AClient, AChannel: string): TDSRestClientchannel;
var
  I: Integer;
  LItem: TDSRestClientchannel;
begin
  Result := nil;
  for I := 0 to ListBoxChannels.Count - 1 do
  begin
    LItem := TDSRestClientChannel(ListBoxChannels.Items.Objects[I]);
    if LItem.ServerChannelName = AChannel then
      if LItem.ChannelId = AClient then
        Exit(LItem);
  end;
end;

procedure TForm56.ButtonClearLogClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm56.ButtonCreateCallbackClick(Sender: TObject);
var
  LChannel: TDSRestClientChannel;
  LCallback: TDSRestClientCallback;
  LItem: TCallbackItem;
  LIndex: Integer;
  LCallbackName: string;
  LChannelName: string;
  LClientName: string;
begin
  LChannel := GetSelectedChannel;
  if FindCallback(LChannel, ComboBoxCallbackName.Text) <> nil then
    raise Exception.CreateFmt('Callback already registered channel: %s, callback: %s',
      [LChannel.ServerChannelName,ComboBoxCallbackName.Text]);

  LCallbackName := ComboBoxCallbackName.Text;
  LChannelName := LChannel.ServerChannelName;
  LClientName := LChannel.ChannelId;
  LCallback := TDSRestClientCallback.Create(LChannel, ComboBoxCallbackName.Text,
    function(AValue: TJSONValue; ADataType: string): boolean
    begin
      // Current thread is not main, so use queue to avoid SendMessage
      // deadlock.
      QueueLogValue(Format('Channel: %s, Callback: %s, Client: %s received %s', [
        LChannelName, LCallbackName, LClientName, AValue.ToString]));
      Result := True;
    end);
  if not LChannel.Connected then
    // Only call connect if a previous callback was not already connected
    LChannel.Connect(LCallback);
  if not LChannel.Connected then
    Assert(false, 'not connected');
  LChannel.RegisterCallback(LCallback);
  LItem := TCallbackItem.Create(LChannel, LCallback);
  FObjectsToFree.Add(LItem);
  LIndex := ListBoxCallbacks.Items.AddObject(Format('Callback: %s, Channel: %s, Client: %s',
    [LCallback.CallbackId, LChannel.ServerChannelName, LChannel.ChannelId,
      LChannel.ChannelId]), LItem);
  ListBoxCallbacks.ItemIndex := LIndex;
end;

procedure TForm56.ButtonCreateClientChannelClick(Sender: TObject);
var
  LChannel: TDSRestClientChannel;
  LIndex: Integer;
begin
  if FindChannel(Self.ComboBoxClientName.Text, ComboBoxChannelName.Text) <> nil then
    raise Exception.CreateFmt('Channel already registered client: %s, channel: %s',
      [Self.ComboBoxClientName.Text, ComboBoxChannelName.Text]);
  // Reset session id in case server has been restarted
  DSRestConnection1.SessionID := '';
  LChannel := CreateChannel(DSRestConnection1, Self.ComboBoxClientName.Text,
    Self.ComboBoxChannelName.Text);
  if LChannel <> nil then
  begin
    LIndex := ListBoxChannels.Items.AddObject(Format('Channel: %s, Client: %s', [LChannel.ServerChannelName, LChannel.ChannelId]),
      LChannel);
    ListBoxChannels.ItemIndex := LIndex;
  end;
end;

procedure TForm56.ButtonNotifyClientClick(Sender: TObject);
begin
  if not ClientNotify(ComboBoxBroadcastToChannel.Text,
    ComboBoxCallbackBroadcast.Text, ComboBoxClientBroadcast.Text,
    EditChannelBroadcastMessage.Text) then
    LogValue('Client notify failed');


end;

procedure TForm56.ButtonTerminateAllClientChannelsClick(Sender: TObject);
begin
  TerminateAllClientChannels;
end;

procedure TForm56.TerminateAllClientChannels;
var
  I: Integer;
  LChannel: TDSRestClientChannel;
begin
  for I := ListBoxChannels.Count - 1 downto 0 do
  begin
    LChannel := TDSRestClientChannel(ListBoxChannels.Items.Objects[I]);
    RemoveChannel(LChannel);
    LChannel.Free;
  end;
end;

procedure TForm56.ButtonTerminateCallbackClick(Sender: TObject);
var
  LCallback: TDSRestClientCallback;
  LChannel: TDSRestClientChannel;
begin
  if GetSelectedCallback(LChannel, LCallback) then
  begin
    RemoveCallback(LCallback);
    LChannel.UnRegisterCallback(LCallback);
  end;
end;

procedure TForm56.ButtonTerminateClientChannelClick(Sender: TObject);
var
  LChannel: TDSRestClientChannel;
begin
  LChannel := GetSelectedChannel;
  if LChannel <> nil then
  begin
    RemoveChannel(LChannel);

    // Free should terminate channel and remove from list
    LChannel.Free;
  end;
end;

{ TCallbackItem }

constructor TCallbackItem.Create(AChannel: TDSRestClientChannel;
  ACallback: TDSRestClientCallback);
begin
  FCallback := ACallback;
  FChannel := AChannel;
end;

end.
