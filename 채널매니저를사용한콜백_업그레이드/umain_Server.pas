unit umain_Server;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,system.JSON, Vcl.AppEvnts,Datasnap.DSServer,System.Generics.Collections;

type
  TCallbackDictionary = TObjectDictionary<String, TObjectList<TDSCallbackTunnel>>;
  TCallbackDictionaryPair = TPair<String, TObjectList<TDSCallbackTunnel>>;

  TForm18 = class(TForm)
    Memo1: TMemo;
    Channels: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ListBoxChannels: TListBox;
    ListBoxCallbacks: TListBox;
    ListBoxClients: TListBox;
    ApplicationEvents1: TApplicationEvents;
    ButtonBroadcastChannel: TButton;
    ButtonBroadCastCallback: TButton;
    ButtonSendMessage: TButton;
    ButtonListChannels: TButton;
    ButtonListCallbacks: TButton;
    ButtonListClients: TButton;
    ButtonListAll: TButton;
    Button3: TButton;
    AutoUpdateCheck: TCheckBox;
    procedure Memo1Change(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonListAllClick(Sender: TObject);
    procedure ButtonListChannelsClick(Sender: TObject);
    procedure ButtonListCallbacksClick(Sender: TObject);
    procedure ButtonListClientsClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonBroadcastChannelClick(Sender: TObject);
    procedure ButtonBroadCastCallbackClick(Sender: TObject);
    procedure ButtonSendMessageClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AutoUpdateCheckClick(Sender: TObject);
  private
    FObjectsToFree: TList<TObject>;
    procedure ListChannels;
    function GetAllServerChannels: TList<string>;
    procedure ListCallbacks;
    procedure ListClients;
    function GetSelectedChannel(var LChannel: string): Boolean;
    function GetSelectedCallback(var AChannel, ACallback: string): Boolean;
    function GetSelectedClient(var AChannel, AClient: string): Boolean;
    procedure UpdateList(Sender: TObject; const EventItem: TDSCallbackTunnelEventItem);

    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  Form18: TForm18;

implementation

{$R *.dfm}

uses ServerContainerUnit1;
type

 TCallbackItem = class
  public
    FCallback: string;
    FChannel: string;
    constructor Create(const AChannel, ACallback: string);
  end;

  TClientItem = class
  public
    FClient: string;
    FChannel: string;
    constructor Create(const AChannel, AClient: string);
  end;

procedure TForm18.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
var
  LTemp: string;
  LTemp2: string;
begin
  ButtonBroadcastChannel.Enabled := GetSelectedChannel(LTemp);
  ButtonBroadCastCallback.Enabled := GetSelectedCallback(LTemp, LTemp2);
  ButtonSendMessage.Enabled := GetSelectedClient(LTemp, LTemp2)
end;

procedure TForm18.AutoUpdateCheckClick(Sender: TObject);
var
  AutoUpdate: Boolean;
begin
  AutoUpdate := AutoUpdateCheck.Checked;
  ButtonListChannels.Enabled := not AutoUpdate;
  ButtonListCallbacks.Enabled := not AutoUpdate;
  ButtonListClients.Enabled := not AutoUpdate;
  ButtonListAll.Enabled := not AutoUpdate;

end;

procedure TForm18.Button3Click(Sender: TObject);
begin
  ServerContainer1.DSServer1.Stop;
  ServerContainer1.DSServer1.Start;
end;

procedure TForm18.ButtonBroadCastCallbackClick(Sender: TObject);
var
  LChannel: string;
  LCallback: string;
begin
  if GetSelectedCallback(LChannel, LCallback) then
    ServerContainer1.DSServer1.BroadcastMessage(LChannel, LCallback,
      TJSONString.Create(Format('Server broadcast to channel %s, callback: %s', [LChannel,
        LCallback])));
end;

procedure TForm18.ButtonBroadcastChannelClick(Sender: TObject);
var
  LChannel: string;
begin
  if GetSelectedChannel(LChannel) then
  if LChannel <> '' then
    ServerContainer1.DSServer1.BroadcastMessage(LChannel,
      TJSONString.Create(Format('Server broadcast to channel %s', [LChannel])));
end;

procedure TForm18.ButtonListAllClick(Sender: TObject);
begin
  ListChannels;
  ListCallbacks;
  ListClients;
end;

procedure TForm18.ButtonListCallbacksClick(Sender: TObject);
begin
 ListCallbacks;
end;

procedure TForm18.ButtonListChannelsClick(Sender: TObject);
begin
 ListChannels;
end;

procedure TForm18.ButtonListClientsClick(Sender: TObject);
begin
 ListClients;
end;

procedure TForm18.ButtonSendMessageClick(Sender: TObject);
var
  LChannel: string;
  LClient: string;
  LCallbacks: TList<string>;
  LCallback: string;
  LResponse: TJSONValue;
begin
  if GetSelectedClient(LChannel, LClient) then
  begin
    // Send to all callbacks on the channel
    LCallbacks := ServerContainer1.DSServer1.GetAllChannelCallbackId(LChannel);
    try
      if LCallbacks <> nil then
        for LCallback in LCallbacks do
        begin
          //if ServerContainer1.DSServer1.NotifyCallback(LChannel, LClient,
          if ServerContainer1.DSServer1.NotifyCallback(LClient,
                            LCallback,
                            TJSONString.Create(
                            Format('Server notify callback: %s, callback: %s, client: %s',
                             [LChannel, LCallback, LClient])),
                             LResponse) then
          begin
            ShowMessage(Format('OK, channel: %s, callback: %s, response: %s', [LChannel, LCallback, LResponse.ToString]));
            LResponse.Free;
          end
          else
            ShowMessage(Format('FAIL: channel: %s, callback: %s', [LChannel, LCallback]));
        end;
    finally
      LCallbacks.Free;
    end;
  end;
end;

constructor TForm18.Create(AOwner: TComponent);
begin
  inherited;
  FObjectsToFree := TObjectList<TObject>.Create;
end;

destructor TForm18.Destroy;
begin
  FObjectsToFree.Free;
  inherited;
end;

procedure TForm18.FormActivate(Sender: TObject);
begin
  TDSCallbackTunnelManager.Instance.AddTunnelEvent(UpdateList);
end;

function TForm18.GetAllServerChannels: TList<string>;
begin
  Result := ServerContainer1.DSServer1.GetAllChannelNames;
end;

function TForm18.GetSelectedCallback(var AChannel, ACallback: string): Boolean;
  var
  LItem: TCallbackItem;
begin
  Result := False;
  if ListBoxCallbacks.ItemIndex >= 0 then
  begin
    LItem := TCallbackItem(ListBoxCallbacks.Items.Objects[ListBoxCallbacks.ItemIndex]);
    AChannel := LItem.FChannel;
    ACallback := LItem.FCallback;
    Result := True;
  end
end;

function TForm18.GetSelectedChannel(var LChannel: string): Boolean;
begin
  Result := False;
  if ListBoxChannels.ItemIndex >= 0 then
  begin
    LChannel := ListBoxChannels.Items[ListBoxChannels.ItemIndex];
    Result := True;
  end
end;

function TForm18.GetSelectedClient(var AChannel, AClient: string): Boolean;
var
  LItem: TClientItem;
begin
  if ListBoxClients.ItemIndex >= 0 then
  begin
    LItem := TClientItem(ListBoxClients.Items.Objects[ListBoxClients.ItemIndex]);
    AChannel := LItem.FChannel;
    AClient := LItem.FClient;
    Result := True;
  end
  else
    Result := False;
end;

procedure TForm18.ListCallbacks;
var
  LChannelName: string;
  LChannels: TList<string>;
  LCallbacks: TList<string>;
  LCallbackName: string;
  LItem: TObject;
begin
  ListBoxCallbacks.Clear;
  LChannels := GetAllServerChannels;
  try
    for LChannelName in LChannels do
    begin
      LCallbacks := ServerContainer1.DSServer1.GetAllChannelCallbackId(LChannelName);
      try
        if LCallbacks <> nil then
          for LCallbackName in LCallbacks do
          begin
            LItem := TCallbackItem.Create(LChannelName, LCallbackName);
            FObjectsToFree.Add(LItem);
            ListBoxCallbacks.Items.AddObject(Format('Channel: %s, Callback: %s',
              [LChannelName, LCallbackName]),
              LItem);
          end;
      finally
        LCallbacks.Free;
      end;
    end;
  finally
    LChannels.Free;
  end;

end;

procedure TForm18.ListChannels;
var
  LKey: string;
  LChannels: TList<string>;
begin
  ListBoxChannels.Clear;
  LChannels := GetAllServerChannels;
  try
    for LKey in LChannels do
      ListBoxChannels.Items.Add(LKey);
  finally
    LChannels.Free;
  end;
end;

procedure TForm18.ListClients;
var
  LChannelName: string;
  LChannels: TList<string>;
  LClients: TList<string>;
  LClientName: string;
  LItem: TObject;
begin
  ListBoxClients.Clear;
  LChannels := GetAllServerChannels;
  try
    for LChannelName in LChannels do
    begin
      LClients := ServerContainer1.DSServer1.GetAllChannelClientId(LChannelName);
      try
        if LClients <> nil then
        begin
          for LClientName in LClients do
          begin
            LItem := TClientItem.Create(LChannelName, LClientName);
            FObjectsToFree.Add(LItem);
            ListBoxClients.Items.AddObject(Format('Channel: %s, Client: %s',
              [LChannelName, LClientName]),
              LItem);
          end;
        end;
      finally
        LClients.Free;
      end;
    end;
  finally
    LChannels.Free;
  end;

end;

procedure TForm18.Memo1Change(Sender: TObject);
var
   value:TJSONString;
begin
   value := TJSONString.Create(Memo1.Lines.Text);
   ServerContainer1.DSServer1.BroadcastMessage('MemoChannel', value);
end;

procedure TForm18.UpdateList(Sender: TObject;
  const EventItem: TDSCallbackTunnelEventItem);
begin
  if AutoUpdateCheck.Checked then
    ButtonListAllClick(nil);
end;

{ TCallbackItem }

constructor TCallbackItem.Create(const AChannel, ACallback: string);
begin
  FCallback := ACallback;
  FChannel := AChannel;
end;

{ TClientItem }

constructor TClientItem.Create(const AChannel, AClient: string);
begin
  FChannel := AChannel;
  FClient := AClient;
end;

end.

