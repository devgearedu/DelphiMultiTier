unit MonitorUIUnit;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  DataSnap.DSCommon, Datasnap.DSSession, Datasnap.DSServer,  Vcl.Menus;

type
  TMonitorForm = class(TForm)
    MyTabSheet: TPageControl;
    ConnectionsTab: TTabSheet;
    Label1: TLabel;
    ConnectionsList: TListBox;
    Label2: TLabel;
    SessionsList: TListBox;
    Label3: TLabel;
    ChannelsList: TListBox;
    Label4: TLabel;
    BroadcastField: TEdit;
    HTTPLogTab: TTabSheet;
    Label5: TLabel;
    HTTPTrafficMemo: TMemo;
    ClearHTTPLogButton: TButton;
    LogHTTPTrafficCheck: TCheckBox;
    OpenInBrowserButton: TButton;
    Label6: TLabel;
    KillSessionMenu: TPopupMenu;
    CloseSelectedSession1: TMenuItem;
    ChannelMenu: TPopupMenu;
    BroadcastMessage1: TMenuItem;
    KillConnMenu: TPopupMenu;
    closeConnItem: TMenuItem;
    LogFileDispatch: TCheckBox;
    procedure ClearHTTPLogButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OpenInBrowserButtonClick(Sender: TObject);
    procedure closeConnItemClick(Sender: TObject);
    procedure CloseSelectedSession1Click(Sender: TObject);
    procedure BroadcastMessage1Click(Sender: TObject);
    procedure ConnectionsListClick(Sender: TObject);
    procedure SessionsListClick(Sender: TObject);
  private
    procedure AddSessionToList(const SessionId: String);
    procedure RemoveSessionFromList(const SessionId: String);
    procedure HandleChannelOpened(const ChannelName: String);
    procedure HandleChannelClosed(const ChannelName: String);
    function GetSelectedConnection: TDSMonitoredConnection;
    function GetSelectedSession: TDSSession;
    function GetSelectedServerChannelName: String;
  public
    procedure AddConnection(const Connection: TDSMonitoredConnection);
    procedure RemoveConnection(const Connection: TDSMonitoredConnection);
    procedure LogTraceEvent(const Event: TDSHTTPTraceEvent);
  end;

var
  MonitorForm: TMonitorForm;

implementation

uses Winapi.ShellAPI, MonitorServerContainerUnit, System.JSON;

{$R *.dfm}

type
  //used to keep track of how many registered clients are listening on the specified ChannelName.
  TChannelRef = class
  private
    FChannelName: String;
    FRefCount: Integer;
  public
    constructor Create(const ChannelName: String; RefCount: Integer = 1);

    property ChannelName: String read FChannelName;
    property RefCount: Integer read FRefCount write FRefCount;
  end;

  TAnonymousWorker = reference to procedure;

  TAnonymousThread = class(TThread)
  private
    FWorker: TAnonymousWorker;
  public
    constructor Create(Worker: TAnonymousWorker);
    procedure Execute; override;
  end;

{ TChannelRef }

constructor TChannelRef.Create(const ChannelName: String; RefCount: Integer);
begin
  inherited Create;
  FChannelName := ChannelName;
  FRefCount := RefCount;
end;

{ TAnonymousThread }

constructor TAnonymousThread.Create(Worker: TAnonymousWorker);
begin
  FWorker := Worker;
  FreeOnTerminate := true;
  inherited Create;
end;

procedure TAnonymousThread.Execute;
begin
  FWorker;
end;

{ TMonitorForm }

procedure TMonitorForm.OpenInBrowserButtonClick(Sender: TObject);
var
  LURL: String;
begin
  LURL := Format('http://localhost:%s/WebClient.html',
                 [IntToStr(Integer(MonitorServerContainer.DSHTTPService1.HttpPort))]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TMonitorForm.ClearHTTPLogButtonClick(Sender: TObject);
begin
  HTTPTrafficMemo.Lines.Clear;
end;

procedure TMonitorForm.FormActivate(Sender: TObject);
begin
  //add event for keeping track of sessions
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

  //add event for keeping track of registered server channels
  TDSCallbackTunnelManager.Instance.AddTunnelEvent(
    procedure(Sender: TObject; const EventItem: TDSCallbackTunnelEventItem)
    begin
      case EventItem.EventType of
        TunnelClose,
        TunnelClosedByServer: HandleChannelClosed(EventItem.TunnelChannelName);
        TunnelCreate: HandleChannelOpened(EventItem.TunnelChannelName);
      end;
    end);
end;

function TMonitorForm.GetSelectedConnection: TDSMonitoredConnection;
var
  I, Count, Index: Integer;
  LObj: TObject;
begin
  Result := nil;
  Index := -1;
  System.TMonitor.Enter(ConnectionsList.Items);
  try
    Count := ConnectionsList.Count;

    //Find the selected row in the list box
    if Count > 0 then
    begin
      for I := 0 to Count - 1 do
      begin
        if ConnectionsList.Selected[I] then
        begin
          Index := I;
          break;
        end;
      end;

      //Get the stored object for the selected row, if any.
      if Index > -1 then
      begin
        LObj := ConnectionsList.Items.Objects[Index];
        if LObj Is TDSMonitoredConnection then
          Exit(TDSMonitoredConnection(LObj));
      end;
    end;
  finally
    System.TMonitor.Exit(ConnectionsList.Items);
  end;
end;

function TMonitorForm.GetSelectedServerChannelName: String;
var
  I, Count, Index: Integer;
begin
  Result := EmptyStr;
  Index := -1;
  System.TMonitor.Enter(ChannelsList.Items);
  try
    Count := ChannelsList.Count;

    //Find the selected row in the list box
    if Count > 0 then
    begin
      for I := 0 to Count - 1 do
      begin
        if ChannelsList.Selected[I] then
        begin
          Index := I;
          break;
        end;
      end;

      //Get the stored object for the selected row, if any.
      if Index > -1 then
        Exit(ChannelsList.Items.Strings[Index]);
    end;
  finally
    System.TMonitor.Exit(ChannelsList.Items);
  end;
end;

function TMonitorForm.GetSelectedSession: TDSSession;
var
  I, Count, Index: Integer;
  SessionId: String;
begin
  Result := nil;
  Index := -1;
  System.TMonitor.Enter(SessionsList.Items);
  try
    Count := SessionsList.Count;

    //Find the selected row in the list box
    if Count > 0 then
    begin
      for I := 0 to Count - 1 do
      begin
        if SessionsList.Selected[I] then
        begin
          Index := I;
          break;
        end;
      end;

      //Get the stored object for the selected row, if any.
      if Index > -1 then
      begin
        SessionId := SessionsList.Items.Strings[Index];
        if SessionId <> EmptyStr then
          Exit(TDSSessionManager.Instance.Session[SessionId]);
      end;
    end;
  finally
    System.TMonitor.Exit(SessionsList.Items);
  end;
end;

procedure TMonitorForm.AddSessionToList(const SessionId: String);
begin
  TThread.Queue(nil,
    procedure
    begin
      SessionsList.Items.Add(SessionId);
    end);
end;

procedure TMonitorForm.RemoveSessionFromList(const SessionId: String);
begin
  TThread.Queue(nil,
    procedure
    var
      LIndex: Integer;
    begin
      LIndex := SessionsList.Items.IndexOf(SessionId);
      if LIndex >= 0 then
        SessionsList.Items.Delete(LIndex);
    end);
end;

procedure TMonitorForm.SessionsListClick(Sender: TObject);
var
  I, Count, Index: Integer;
  SessionId: String;
  LConn: TDSMonitoredConnection;
begin
  //Keeps the selection of the two list boxes in sync.

  Index := -1;
  Count := SessionsList.Count;

  //Clear the selection on the connection list
  ConnectionsList.ClearSelection;

  if Count > 0 then
  begin
    for I := 0 to Count - 1 do
    begin
      //Find the selected Session Id
      if SessionsList.Selected[I] then
      begin
        Index := I;
        break;
      end;
    end;

    //Use the selected Session Id to find the appropriate connection, and then select it.
    if Index > -1 then
    begin
      SessionId := SessionsList.Items.Strings[Index];
      if SessionId <> EmptyStr then
      begin
        //get connection for selected session
        LConn := MonitorServerContainer.DSServerConnectionMonitor1.GetConnectionForSession(SessionId);
        if LConn <> nil then
        begin
          Index := ConnectionsList.Items.IndexOfObject(LConn);
          if Index > -1 then
            ConnectionsList.Selected[Index] := True;
        end;
      end;
    end;
  end;
end;

procedure TMonitorForm.HandleChannelClosed(const ChannelName: String);
begin
  TThread.Queue(nil,
    procedure
    var
      I, Count: Integer;
      Obj: TObject;
      ChanRef: TChannelRef;
    begin
      System.TMonitor.Enter(ChannelsList.Items);
      try
        //iterate over existing items. If one exists with channelName, dec reference. if 0, remove.
        Count := ChannelsList.Items.Count;

        for I := 0 to Count - 1 do
        begin
          Obj := ChannelsList.Items.Objects[i];
          if Obj Is TChannelRef then
          begin
            ChanRef := TChannelRef(Obj);

            if ChanRef.ChannelName = ChannelName then
            begin
              ChanRef.RefCount := ChanRef.RefCount - 1;
              if ChanRef.RefCount < 1 then
              begin
                ChanRef.Free;
                ChannelsList.Items.Objects[i] := nil;
                ChannelsList.Items.Delete(i);
              end;
              Exit;
            end;
          end;
        end;
      finally
        System.TMonitor.Exit(ChannelsList.Items);
      end;
    end);

end;

procedure TMonitorForm.HandleChannelOpened(const ChannelName: String);
begin
  TThread.Queue(nil,
    procedure
    var
      I, Count: Integer;
      Obj: TObject;
      ChanRef: TChannelRef;
    begin
      System.TMonitor.Enter(ChannelsList.Items);
      try
        //iterate over existing items. If one exists with channelName, inc reference. Otherwise, add one
        Count := ChannelsList.Items.Count;

        for I := 0 to Count - 1 do
        begin
          Obj := ChannelsList.Items.Objects[i];
          if Obj Is TChannelRef then
          begin
            ChanRef := TChannelRef(Obj);

            if ChanRef.ChannelName = ChannelName then
            begin
              ChanRef.RefCount := ChanRef.RefCount + 1;
              Exit;
            end;
          end;
        end;

        ChannelsList.Items.AddObject(ChannelName, TChannelRef.Create(ChannelName));
      finally
        System.TMonitor.Exit(ChannelsList.Items);
      end;
    end);
end;

procedure TMonitorForm.AddConnection(const Connection: TDSMonitoredConnection);
var
  LProtocol, LClientIp, LConnStr, LSessionId: String;
begin
  if (Connection = nil) then
    Exit;

  if Connection.Protocol = pTCPIP then
    LProtocol := 'tcp/ip'
  else if Connection.Protocol = pHTTPtunnel then
    LProtocol := 'http (tunnel)'
  else if Connection.Protocol = pHTTPrest then
    LProtocol := 'http (rest)';

  LClientIp := Connection.ClientIP;
  LSessionId := Connection.SessionId;

  //create an anonamous background thread, which updates the UI after a small time has passed
  TAnonymousThread.Create(procedure
    begin
      //Temporary workaround to populate the client info, until fixed in DataSnap
      if (LClientIp = EmptyStr) then
      begin
        //wait some time before updating the UI, to give the connection time to store client information
        //NOTE: this is a workaround until RAD Studio stores this information before firing a connection event
        Sleep(500);

        //checking availability of connection and session helps ruduce change of AV on server shutdown
        if (MonitorServerContainer.DSServerConnectionMonitor1.GetConnectionForSession(LSessionId) <> nil) and
            (TDSSessionManager.Instance.Session[LSessionId] <> nil) then
          //internally, Connection.ClientIP refreshes its data from the corresponding session
          LClientIp := Connection.ClientIP;
      end;

      //build the connection string to display in the list
      LConnStr := Format('%s - %s', [LClientIp, LProtocol]);

      TThread.Queue(nil,
        procedure
        begin
          System.TMonitor.Enter(ConnectionsList.Items);
          try
            ConnectionsList.Items.AddObject(LConnStr, Connection);
          finally
            System.TMonitor.Exit(ConnectionsList.Items);
          end;
        end);
    end);
end;

procedure TMonitorForm.RemoveConnection(const Connection: TDSMonitoredConnection);
begin
  if (Connection = nil) then
    Exit;

  //create an anonamous background thread, which updates the UI after a small time has passed
  TAnonymousThread.Create(procedure
    begin
      //This is a temporary workaround while TMonitorForm.AddConnection uses a sleep value
      Sleep(800);

      TThread.Queue(nil,
        procedure
        var
          Index: Integer;
        begin
          System.TMonitor.Enter(ConnectionsList.Items);
          try
            Index := ConnectionsList.Items.IndexOfObject(Connection);
            if Index > -1 then
              ConnectionsList.Items.Delete(Index);
          finally
            System.TMonitor.Exit(ConnectionsList.Items);
          end;
        end);
      end);
end;

procedure TMonitorForm.LogTraceEvent(const Event: TDSHTTPTraceEvent);
var
  RequestURI: String;
  SessionId: String;
begin
  RequestURI := Event.Request.URI;

  //get the session ID for the connection this event is for
  if Event.Connection <> nil then
    SessionId := Event.Connection.SessionId
  else
    SessionId := EmptyStr;

  TThread.Queue(nil,
    procedure
    begin
      if SessionId = EmptyStr then
      begin
        //should be a file dispatching event, if there is no session ID and it isn't a tunnel request
        if LogFileDispatch.Checked or (RequestURI = '/datasnap/tunnel') then
          HTTPTrafficMemo.Lines.Add(Format('[%s] URL: %s', [DateTimeToStr(Now), RequestURI]));
      end
      else
        HTTPTrafficMemo.Lines.Add(Format('[%s] URL: %s  -  SESSION: %s',
                                         [DateTimeToStr(Now), RequestURI, SessionId]));
    end);
end;

procedure TMonitorForm.closeConnItemClick(Sender: TObject);
var
  LConnection: TDSMonitoredConnection;
begin
  LConnection := GetSelectedConnection;
  if LConnection <> nil then
    LConnection.Close;
end;

procedure TMonitorForm.CloseSelectedSession1Click(Sender: TObject);
var
  LSession: TDSSession;
begin
  LSession := GetSelectedSession;
  if LSession <> nil then
    TDSSessionManager.Instance.CloseSession(LSession.SessionName);
end;

procedure TMonitorForm.ConnectionsListClick(Sender: TObject);
var
  Index: Integer;
  Connection: TDSMonitoredConnection;
  SessionId: String;
begin
  //Keeps the selection of the TCP Connection and session list boxes in sync
  Connection := GetSelectedConnection;

  System.TMonitor.Enter(SessionsList.Items);
  try
    //clear the selected Session Id before continuing
    SessionsList.ClearSelection;

    if Connection <> nil then
    begin
      SessionId := Connection.SessionId;

      if SessionId <> EmptyStr then
      begin
        Index := SessionsList.Items.IndexOf(SessionId);
        if Index > -1 then
          SessionsList.Selected[Index] := True;
      end;
    end;
  finally
    System.TMonitor.Exit(SessionsList.Items);
  end;
end;

procedure TMonitorForm.BroadcastMessage1Click(Sender: TObject);
var
  MsgStr: String;
  ChannelName: String;
  Msg: TJSONString;
begin
  ChannelName := GetSelectedServerChannelName;
  MsgStr := BroadcastField.Text;
  if (ChannelName <> EmptyStr) and (MsgStr <> EmptyStr) then
  begin
    Msg := TJSONString.Create(MsgStr);
    MonitorServerContainer.DSServer1.BroadcastMessage(ChannelName, Msg);
  end;
end;

end.

