unit Datasnap.ServerConnectionMonitoringReg;

interface

procedure Register;

implementation

uses
  System.Classes,
  Datasnap.ServerConnectionMonitoring;

procedure Register;
begin
  RegisterComponents('DataSnap Server', [TDSServerConnectionMonitor]);
end;

end.
