unit MonitorServerContainerUnit;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSHTTPCommon, Datasnap.DSHTTP,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSServerMetadata, Datasnap.DSHTTPServiceProxyDispatcher,
  Datasnap.DSProxyJavaAndroid, Datasnap.DSProxyJavaBlackBerry,
  Datasnap.DSProxyObjectiveCiOS, Datasnap.DSProxyCsharpSilverlight,
  Datasnap.DSAuth, IndyPeerImpl, Datasnap.DSProxyJavaScript, Datasnap.ServerConnectionMonitoring,
  IPPeerServer, Datasnap.DSMetadata, Datasnap.DSClientMetadata;

type
  TMonitorServerContainer = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    DSHTTPServiceFileDispatcher1: TDSHTTPServiceFileDispatcher;
    DSServerClass1: TDSServerClass;
    DSServerConnectionMonitor1: TDSServerConnectionMonitor;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
    procedure DSServerConnectionMonitor1Connect(Event: TDSConnectionEvent);
    procedure DSServerConnectionMonitor1Disconnect(Event: TDSDisconnectionEvent);
    procedure DSServerConnectionMonitor1HTTPTrace(Event: TDSHTTPTraceEvent);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  MonitorServerContainer: TMonitorServerContainer;

implementation

uses Winapi.Windows, MonitorServerMethodsUnit, MonitorUIUnit;

{$R *.dfm}

procedure TMonitorServerContainer.DataModuleCreate(Sender: TObject);
begin
  //write the JavaScript proxy on startup
  DSProxyGenerator1.Write;

  //start the connection monitor
  DSServerConnectionMonitor1.Start;
end;

procedure TMonitorServerContainer.DataModuleDestroy(Sender: TObject);
begin
  DSServerConnectionMonitor1.Stop;
  DSServer1.Stop;
end;

procedure TMonitorServerContainer.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := MonitorServerMethodsUnit.TMonitorServerMethods;
end;

procedure TMonitorServerContainer.DSServerConnectionMonitor1Connect(Event: TDSConnectionEvent);
begin
  MonitorForm.AddConnection(Event.Connection);
end;

procedure TMonitorServerContainer.DSServerConnectionMonitor1Disconnect(
  Event: TDSDisconnectionEvent);
begin
  MonitorForm.RemoveConnection(Event.Connection);
end;

procedure TMonitorServerContainer.DSServerConnectionMonitor1HTTPTrace(Event: TDSHTTPTraceEvent);
begin
  MonitorForm.LogTraceEvent(Event);
end;

end.

