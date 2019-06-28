program ConnectionMonitoringDemoClient;

uses
//  FastMM4,
  Vcl.Forms,
  MonitorClientUIUnit in 'MonitorClientUIUnit.pas' {Form10},
  ProxyUnit in 'ProxyUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm10, Form10);
  Application.Run;
end.
