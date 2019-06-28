program Pweb_Leture;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormUnit in 'FormUnit.pas' {Form7},
  UWebModule in 'UWebModule.pas' {WebModule8: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
