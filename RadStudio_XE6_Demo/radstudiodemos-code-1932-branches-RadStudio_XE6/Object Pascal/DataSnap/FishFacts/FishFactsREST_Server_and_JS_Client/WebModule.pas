
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit WebModule;

interface

uses
  SysUtils, Classes, HTTPApp, DSHTTPCommon, DSHTTPWebBroker, DSServer, WebFileDispatcher, HTTPProd,
  DSProxyJavaScript, DSAuth, DSClientMetadata, DSCommonServer,
  IPPeerClient, IPPeerServer, IndyPeerImpl, Datasnap.DSMetadata,
  Datasnap.DSServerMetadata;

type
  TFishFactsWebModule = class(TWebModule)
    DSServer1: TDSServer;
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServerClass1: TDSServerClass;
    WebFileDispatcher1: TWebFileDispatcher;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    FishFacts: TPageProducer;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebFileDispatcher1BeforeDispatch(Sender: TObject;
      const AFileName: string; Request: TWebRequest; Response: TWebResponse;
      var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure FishFactsHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings;
      var ReplaceText: string);
  private
    { Private declarations }
    FServerFunctionInvokerAction: TWebActionItem;
    function AllowServerFunctionInvoker: Boolean;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TFishFactsWebModule;

implementation

uses FishFactsServerMethods, WebReq;

{$R *.dfm}

procedure TFishFactsWebModule.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := FishFactsServerMethods.TFishFactsServerMethods;
end;

procedure TFishFactsWebModule.FishFactsHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
  TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString, 'serverfunctionsjs') then
    ReplaceText := string(Request.InternalScriptName) + '/js/serverfunctions.js'
  else
    ReplaceText := '';
end;

procedure TFishFactsWebModule.WebFileDispatcher1BeforeDispatch(Sender: TObject;
  const AFileName: string; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
var
  D1, D2: TDateTime;
begin
  Handled := False;
  if SameFileName(ExtractFileName(AFileName), 'serverfunctions.js') then
    if FileAge(AFileName, D1) and FileAge(WebApplicationFileName, D2) and (D1 < D2) then
    begin
      DSProxyGenerator1.TargetDirectory := ExtractFilePath(AFileName);
      DSProxyGenerator1.TargetUnitName := ExtractFileName(AFileName);
      DSProxyGenerator1.Write;
    end;
end;

procedure TFishFactsWebModule.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if FServerFunctionInvokerAction <> nil then
    FServerFunctionInvokerAction.Enabled := AllowServerFunctionInvoker;
end;

function TFishFactsWebModule.AllowServerFunctionInvoker: Boolean;
begin
  Result := (Request.RemoteAddr = '127.0.0.1') or
    (Request.RemoteAddr = '0:0:0:0:0:0:0:1') or (Request.RemoteAddr = '::1');
end;

procedure TFishFactsWebModule.WebModuleCreate(Sender: TObject);
begin
  FServerFunctionInvokerAction := ActionByName('ServerFunctionInvokerAction');
end;

initialization
finalization
  WebReq.FreeWebModules;

end.

