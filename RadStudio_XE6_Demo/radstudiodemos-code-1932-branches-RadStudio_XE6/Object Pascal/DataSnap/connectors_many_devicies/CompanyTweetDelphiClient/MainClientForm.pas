
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit MainClientForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  Datasnap.DSHTTPLayer,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  ClientModuleUnit,
  Vcl.CheckLst,
  Datasnap.DSHTTPCommon,
  System.Generics.Collections,
  TweetCallbackUnit,
  Vcl.AppEvnts, Vcl.ExtCtrls, IndyPeerImpl, Vcl.Menus,
  Data.DbxHTTPLayer, Datasnap.DSCommon, IPPeerClient;

type
  TForm8 = class(TForm)
    ButtRefresh: TButton;
    ChannelManager: TDSClientCallbackChannelManager;
    UsersList: TListBox;
    LabelUsers: TLabel;
    LabelTweets: TLabel;
    Timer1: TTimer;
    Bevel1: TBevel;
    StartButton: TButton;
    PortField: TEdit;
    PortLabel: TLabel;
    TweetsMemo: TMemo;
    ClearMenu: TPopupMenu;
    Clear1: TMenuItem;
    StopButton: TButton;
    procedure ButtRefreshClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ChannelManagerServerConnectionError(
      Sender: TObject);
    procedure ChannelManagerServerConnectionTerminate(
      Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FChannelManagerInst: TDSClientCallbackChannelManager;
    procedure RegisterCallbackOnChannel;
    procedure UpdateUserList;
    procedure UpdateUserListWithUser(const UserName: String);
    procedure EnableUI(const DoEnable: Boolean);
    procedure StartConnection(const DoStart: Boolean);
  end;

var
  Form8: TForm8;

implementation

uses
  Data.DBXJSON,
  System.JSON,
  Winapi.ShellAPI,
  System.SyncObjs;

{$R *.dfm}

procedure TForm8.ButtRefreshClick(Sender: TObject);
begin
  UpdateUserList;
end;

procedure TForm8.Button3Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PCHAR(Application.ExeName), '', '', SW_SHOWNORMAL);
end;

procedure TForm8.ChannelManagerServerConnectionError(
  Sender: TObject);
begin
  TweetsMemo.Lines.Add(Sender.ClassName);
end;

procedure TForm8.ChannelManagerServerConnectionTerminate(
  Sender: TObject);
begin
  TweetsMemo.Lines.Add('TERMINTE: ' + Sender.ClassName);
end;

procedure TForm8.Clear1Click(Sender: TObject);
begin
  TweetsMemo.Clear;
end;

procedure TForm8.EnableUI(const DoEnable: Boolean);
begin
  PortLabel.Enabled := not DoEnable;
  PortField.Enabled := not DoEnable;
  StartButton.Enabled := not DoEnable;

  StopButton.Enabled := DoEnable;
  ButtRefresh.Enabled := DoEnable;
  LabelTweets.Enabled := DoEnable;
  LabelUsers.Enabled := DoEnable;
  TweetsMemo.Enabled := DoEnable;
  UsersList.Enabled := DoEnable;
end;

procedure TForm8.FormActivate(Sender: TObject);
begin
  FChannelManagerInst := nil;
end;

procedure TForm8.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    if FChannelManagerInst <> nil then
      FChannelManagerInst.CloseClientChannel;
    ChannelManager.CloseClientChannel;
  except
  end;
end;

procedure TForm8.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FChannelManagerInst);
  ChannelManager.CloseClientChannel;
end;

procedure TForm8.RegisterCallbackOnChannel;
begin
  Assert(FChannelManagerInst <> nil);

  FChannelManagerInst.CommunicationProtocol := 'http';
  FChannelManagerInst.DSHostname := ClientModule1.DSRestConnection1.Host;
  FChannelManagerInst.DSPort := inttostr(ClientModule1.DSRestConnection1.Port);
  FChannelManagerInst.ChannelName := 'ctconsole'; // ChannelName;
  FChannelManagerInst.ManagerId := FChannelManagerInst.ManagerId + inttostr(GetTickCount);
  FChannelManagerInst.RegisterCallback(
    TTweetCallback.Create('cbconsole',
    procedure(UserName, Tweet: string)
  begin
    TweetsMemo.Lines.Add(UserName + ' says: ' + Tweet);
    UpdateUserListWithUser(UserName);
  end));
end;

procedure TForm8.StartButtonClick(Sender: TObject);
begin
  StartConnection(True);
end;

procedure TForm8.StartConnection(const DoStart: Boolean);
var
  LPort: String;
begin

  if DoStart then
  begin
    LPort := PortField.Text;
    ClientModule1.DSRestConnection1.Port := StrToInt(LPort);

    FChannelManagerInst := ChannelManager.Copy;
    RegisterCallbackOnChannel;
  end
  else
  begin
    FChannelManagerInst.CloseClientChannel;
    FreeAndNil(FChannelManagerInst);
  end;

  EnableUI(DoStart);
end;

procedure TForm8.StopButtonClick(Sender: TObject);
begin
  StartConnection(False);
end;

procedure TForm8.Timer1Timer(Sender: TObject);
begin
  UpdateUserList;
end;

procedure TForm8.UpdateUserList;
var
  Users: TJSONArray;
  I: Integer;
begin
  UsersList.Clear;
  Users := ClientModule1.CompanyTweetClient.ConnectedUsers;
  for I := 0 to Users.Size - 1 do
    UsersList.Items.Add(Users.Get(I).Value);
end;

procedure TForm8.UpdateUserListWithUser(const UserName: String);
begin
  if AnsiSameText(UserName, 'ADMIN') then
    Exit;

  TThread.Queue(nil,
    procedure
    var
      LUsers: TStrings;
      LUser: String;
    begin
      LUsers := UsersList.Items;
      for LUser In LUsers do
      begin
        if AnsiSameStr(UserName, LUser) then
          Exit;
      end;
      UsersList.Items.Add(UserName);
    end);
end;

end.
