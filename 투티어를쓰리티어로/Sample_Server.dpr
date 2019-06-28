program Sample_Server;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Umain_Server in 'Umain_Server.pas' {Form195},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDSServerModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm195, Form195);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

