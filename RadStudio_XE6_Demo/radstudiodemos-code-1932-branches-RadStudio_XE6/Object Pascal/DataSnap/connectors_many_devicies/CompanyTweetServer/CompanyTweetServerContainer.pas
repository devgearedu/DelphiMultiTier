
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit CompanyTweetServerContainer;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DSHTTPCommon,
  Datasnap.DSHTTP,
  Datasnap.DSServer,
  Datasnap.DSCommonServer,
  Datasnap.DSAuth,
  ctServerMethods,
  Datasnap.DSService,
  DataSnap.DSCommon,
  DataSnap.DSSession,
  ctManager,
  Web.HTTPApp,
  Datasnap.DSProxyDispatcher,
  Datasnap.DSClientMetadata,
  Datasnap.DSHTTPServiceProxyDispatcher, IndyPeerImpl, IPPeerServer,
  Datasnap.DSMetadata, Datasnap.DSServerMetadata;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSHTTPService1: TDSHTTPService;
    DSServerClass1: TDSServerClass;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    DSHTTPServiceProxyDispatcher1: TDSHTTPServiceProxyDispatcher;
    DSHTTPServiceFileDispatcher1: TDSHTTPServiceFileDispatcher;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    procedure GetConnectedClients(Clients: TStrings);
    procedure BroadcastAdminMessage(message: string);
    procedure BroadcastCommand(cmd: string; value: string = '');
  end;

var
  ServerContainer1: TServerContainer1;

implementation

uses
  Winapi.Windows,
  System.Generics.Collections,
  System.JSON,
  Data.DBXJSON;

{$R *.dfm}


procedure TServerContainer1.GetConnectedClients(Clients: TStrings);
begin
  TctManager.Instance.ForEachUser(
    procedure(usr: string)begin
    Clients.Add(usr)
  end
    );
end;

procedure TServerContainer1.BroadcastAdminMessage(message: string);
var
  msg: TJSONObject;
begin
  msg := TJSONObject.Create;
  try
    msg.AddPair(TJSONPair.Create('username', 'ADMIN'));
    msg.AddPair(TJSONPair.Create('message', message));
    DSServer1.BroadcastMessage('ctconsole', msg.Clone as TJSONValue);
    DSServer1.BroadcastMessage('ct', msg.Clone as TJSONValue);
  finally
    msg.Free;
  end;
end;

procedure TServerContainer1.BroadcastCommand(cmd, value: string);
var
  msg: TJSONObject;
begin
  msg := TJSONObject.Create;
  try
    msg.AddPair(TJSONPair.Create('cmd', cmd));
    msg.AddPair(TJSONPair.Create('value', value));
    DSServer1.BroadcastMessage('cmd', msg.Clone as TJSONValue);
  finally
    msg.Free;
  end;
end;

procedure TServerContainer1.DataModuleCreate(Sender: TObject);
begin
  TDSSessionManager.Instance
    .AddSessionEvent( procedure(Sender: TObject;
    const EventType: TDSSessionEventType;
    const Session: TDSSession)
  var
    usr: string;
  begin
    if EventType = TDSSessionEventType.SessionClose then
    begin
      usr := Session.GetData('username');
      TctManager.Instance.RemoveUser(usr);
    end;
  end);
end;

procedure TServerContainer1.DataModuleDestroy(Sender: TObject);
begin
  DSServer1.Stop;
end;

procedure TServerContainer1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ctServerMethods.TCompanyTweet;
end;

end.
