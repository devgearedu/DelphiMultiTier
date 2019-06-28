program Project_Server;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UMain_Server in 'UMain_Server.pas' {MainForm_Server},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDSServerModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm_Server, MainForm_Server);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

