program Pweb;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormUnit in 'FormUnit.pas' {Form7},
  WebModuleUnit in 'WebModuleUnit.pas' {WebModule8: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
