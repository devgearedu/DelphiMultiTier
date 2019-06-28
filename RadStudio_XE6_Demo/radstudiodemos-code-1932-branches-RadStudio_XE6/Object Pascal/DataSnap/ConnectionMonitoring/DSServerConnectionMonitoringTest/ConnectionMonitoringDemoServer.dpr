program ConnectionMonitoringDemoServer;

uses
//  FastMM4,
  Vcl.Forms,
  MonitorUIUnit in 'MonitorUIUnit.pas' {MonitorForm},
  MonitorServerMethodsUnit in 'MonitorServerMethodsUnit.pas',
  MonitorServerContainerUnit in 'MonitorServerContainerUnit.pas' {MonitorServerContainer: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMonitorForm, MonitorForm);
  Application.CreateForm(TMonitorServerContainer, MonitorServerContainer);
  Application.Run;
end.

