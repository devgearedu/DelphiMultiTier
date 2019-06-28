
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit MainServerForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Datasnap.DSProxyJavaAndroid,
  Datasnap.DSCommon,
  Datasnap.DSProxyJavaBlackBerry,
  Datasnap.DSProxyCsharpSilverlight,
  Datasnap.DSProxyObjectiveCiOS,
  ctManager,
  Vcl.ActnList,
  IndyPeerImpl,
  IdStack,
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.ExtCtrls, System.Actions;

type
  TForm9 = class(TForm)
    ButtSend: TButton;
    MessageArea: TEdit;
    ButtRing: TButton;
    ActionList1: TActionList;
    actSend: TAction;
    actRing: TAction;
    actVibrate: TAction;
    ButtVibrate: TButton;
    Bevel1: TBevel;
    PortLabel: TLabel;
    PortField: TEdit;
    StartButton: TButton;
    BootUserMenu: TPopupMenu;
    BootUserItem: TMenuItem;
    ConnectionPages: TPageControl;
    UsersPage: TTabSheet;
    LogArea: TListBox;
    SessionsPage: TTabSheet;
    SessionsList: TListBox;
    CloseSessionMenu: TPopupMenu;
    Closeselectedsession1: TMenuItem;
    StopButton: TButton;
    AutoStartCheck: TCheckBox;
    AutoStartTimer: TTimer;
    procedure MessageAreaKeyPress(Sender: TObject; var Key: Char);
    procedure actSendExecute(Sender: TObject);
    procedure actRingExecute(Sender: TObject);
    procedure actVibrateExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure BootUserItemClick(Sender: TObject);
    procedure Closeselectedsession1Click(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure AutoStartTimerTimer(Sender: TObject);
  private
    function GetSelectedUser: String;
    function GetSelectedSessionId: String;
    procedure UpdateUserList;
    procedure AddSessionToList(const SessionId: String);
    procedure RemoveSessionFromList(const SessionId: String);
    procedure StartServer(const DoStart: Boolean);
    procedure ActivateUI(const IsActive: Boolean);
    procedure CloseSessionForTunnelId(const TunnelId: String);
  end;

var
  Form9: TForm9;

implementation

uses
  Datasnap.DSService,
  Datasnap.DSServer,
  Datasnap.DSSession,
  DataSnap.DSHTTPCommon,
  System.Generics.Collections,
  CompanyTweetServerContainer;

{$R *.dfm}


procedure TForm9.ActivateUI(const IsActive: Boolean);
begin
  if IsActive then
    Caption := 'CompanyTweet Server   (' + GStack.LocalAddress + ':' + PortField.Text + ')'
  else
    Caption := 'CompanyTweet Server';

  PortLabel.Enabled := not IsActive;
  StartButton.Enabled := not IsActive;
  PortField.Enabled := not IsActive;
  AutoStartCheck.Enabled := not IsActive;
  AutoStartTimer.Enabled := not IsActive;

  StopButton.Enabled := IsActive;
  ButtSend.Enabled := IsActive;
  ButtRing.Enabled := IsActive;
  ButtVibrate.Enabled := IsActive;
  LogArea.Enabled := IsActive;
  SessionsList.Enabled := IsActive;
  MessageArea.Enabled := IsActive;
end;

procedure TForm9.actRingExecute(Sender: TObject);
begin
  ServerContainer1.BroadcastCommand('ring');
end;

procedure TForm9.actSendExecute(Sender: TObject);
begin
  ServerContainer1.BroadcastAdminMessage(MessageArea.Text);
  MessageArea.Text := '';
end;

procedure TForm9.actVibrateExecute(Sender: TObject);
begin
  ServerContainer1.BroadcastCommand('vibrate');
end;

procedure TForm9.AddSessionToList(const SessionId: String);
begin
  TThread.Queue(nil,
    procedure
    begin
      SessionsList.Items.Add(SessionId);
    end);
end;

procedure TForm9.AutoStartTimerTimer(Sender: TObject);
begin
  //disable timer. It will be enabled again if the user starts and then stops the server
  AutoStartTimer.Enabled := False;
  if AutoStartCheck.Checked then
    //server isn't running
    if (not StopButton.Enabled) and (not ServerContainer1.DSServer1.Started) then
      StartServer(True);
end;

procedure TForm9.RemoveSessionFromList(const SessionId: String);
var
  LIndex: Integer;
begin
  TThread.Queue(nil,
    procedure
    begin
      LIndex := SessionsList.Items.IndexOf(SessionId);
      if LIndex >= 0 then
        SessionsList.Items.Delete(LIndex);
    end);
end;

procedure TForm9.BootUserItemClick(Sender: TObject);
var
  LUser: String;
  LSession: TDSSession;
begin
  LUser := GetSelectedUser;
  LSession := nil;

  if (LUser <> EmptyStr) then
  begin
    TDSSessionManager.Instance.ForEachSession(
      procedure(const Session: TDSSession)
      begin
        if (LUser = Session.GetData('username')) then
          LSession := Session;
      end);

    if LSession <> nil then
      TDSSessionManager.Instance.CloseSession(LSession.SessionName);
  end;
end;

procedure TForm9.Closeselectedsession1Click(Sender: TObject);
var
  LSessionId: String;
begin
  LSessionId := GetSelectedSessionId;

  if (LSessionId <> EmptyStr) then
  begin
    TDSSessionManager.Instance.CloseSession(LSessionId);
  end;
end;

procedure TForm9.MessageAreaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    actSend.Execute;
    Key := #0;
  end;
end;

procedure TForm9.StartButtonClick(Sender: TObject);
begin
  StartServer(True);
end;

procedure TForm9.StartServer(const DoStart: Boolean);
var
  LPort: String;
begin
  if DoStart then
  begin
    LPort := PortField.Text;
    ServerContainer1.DSHTTPService1.HttpPort := StrToInt(LPort);
    ServerContainer1.DSServer1.Start;
  end
  else
  begin
    LogArea.Items.Clear;
    SessionsList.Items.Clear;
    TctManager.Instance.GetUsers.Clear;
    ServerContainer1.DSServer1.Stop;
  end;

  ActivateUI(DoStart);
end;

procedure TForm9.StopButtonClick(Sender: TObject);
begin
  StartServer(False);
end;

procedure TForm9.FormActivate(Sender: TObject);
begin
  //Hide the tabs for now. Can bring them back if you want.
  UsersPage.TabVisible := False;
  SessionsPage.TabVisible := False;
  ConnectionPages.ActivePage := UsersPage;

  TctManager.Instance.UserHook := UpdateUserList;
  TDSSessionManager.Instance.AddSessionEvent(
    procedure(Sender: TObject;
              const EventType: TDSSessionEventType;
              const Session: TDSSession)
    begin
      if EventType = TDSSessionEventType.SessionCreate then
        AddSessionToList(Session.SessionName)
      else
        RemoveSessionFromList(Session.SessionName);
    end);

  TDSCallbackTunnelManager.Instance.AddTunnelEvent(
    procedure(Sender: TObject; const EventItem: TDSCallbackTunnelEventItem)
    begin
      case EventItem.EventType of
        TunnelClose,
        TunnelClosedByServer: CloseSessionForTunnelId(EventItem.TunnelId);
      end;
    end);
end;

procedure TForm9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CompanyTweetServerContainer.ServerContainer1.DSServer1.Stop;
end;

function TForm9.GetSelectedSessionId: String;
var
  I, Count: Integer;
begin
  Result := EmptyStr;

  Count := SessionsList.Count - 1;

  for I := 0 to Count do
  begin
    if SessionsList.Selected[I] then
    begin
      Exit(SessionsList.Items.Strings[I]);
    end;
  end;
end;

function TForm9.GetSelectedUser: String;
var
  I, Count: Integer;
begin
  Result := EmptyStr;

  Count := LogArea.Count - 1;

  for I := 0 to Count do
  begin
    if LogArea.Selected[I] then
    begin
      Exit(LogArea.Items.Strings[I]);
    end;
  end;
end;

procedure TForm9.UpdateUserList;
begin
  TThread.Queue(nil,
    procedure
    begin
      LogArea.Items.Clear;
      ServerContainer1.GetConnectedClients(LogArea.Items);
    end);
end;

procedure TForm9.CloseSessionForTunnelId(const TunnelId: String);
var
  TempObj: TObject;
  TunnelList: TList<TDSSessionTunnelInfo>;
  Info: TDSSessionTunnelInfo;
  FoundSession: TDSSession;
begin
  FoundSession := nil;

  //Iterate the sessions and look for one with a tunnel with the given id
  TDSSessionManager.Instance.ForEachSession(procedure(const Session: TDSSession)
      var
        I, Count: Integer;
      begin
        //get the tunnel info list from the session
        if (Session.HasObject('tunnelinfolist')) then
        begin
          TempObj := Session.GetObject('tunnelinfolist');
          if (TempObj Is TList<TDSSessionTunnelInfo>) then
          begin
            TunnelList := TList<TDSSessionTunnelInfo>(TempObj);
            Count := TunnelList.Count;

            //iterate the list of tunnels, looking for one with the specified ID
            for I := 0 to (Count - 1) do
            begin
              Info := TunnelList.Items[I];

              //if the current tunnel ID is the same as the ID of the tunnel ID passed in,
              //then this session had that tunnel. No more iteration is required, and this
              //session should be terminated.
              if AnsiSameStr(Info.ClientChannelId, TunnelId) then
              begin
                //delete the tunnel just so the sesison closing doesn't attempt to close the tunnel again
                TunnelList.Delete(I);
                FoundSession := Session;
                break;
              end;
            end;
          end;
        end;
      end);

  //close the session the tunnel ID was found on, if any.
  if FoundSession <> nil then
    TDSSessionManager.Instance.CloseSession(FoundSession.SessionName);
end;
end.
