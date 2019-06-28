
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Unit2;

interface

uses
  SysUtils, Classes, HTTPApp, DSHTTPCommon, DSHTTPWebBroker, DSServer, WebFileDispatcher, HTTPProd,
  DSProxyJavaScript, DSAuth, DSClientMetadata, DSCommonServer, IndyPeerImpl,
  IPPeerServer, Datasnap.DSMetadata, Datasnap.DSServerMetadata;

type
  TWebModule2 = class(TWebModule)
    DSServer1: TDSServer;
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServerClass1: TDSServerClass;
    ReverseString: TPageProducer;
    WebFileDispatcher1: TWebFileDispatcher;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    DSAuthenticationManager1: TDSAuthenticationManager;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModuleDefaultAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebFileDispatcher1BeforeDispatch(Sender: TObject;
      const AFileName: string; Request: TWebRequest; Response: TWebResponse;
      var Handled: Boolean);
    procedure ReverseStringHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject; const Protocol, Context,
      User, Password: string; var valid: Boolean; UserRoles: TStrings);
  end;

const
  sUserLogonInits = 'UserLogonInits';
var
  WebModuleClass: TComponentClass = TWebModule2;

implementation

uses ServerMethodsUnit2, WebReq, DSSession;

{$R *.dfm}

procedure TWebModule2.DSAuthenticationManager1UserAuthenticate(Sender: TObject; const Protocol,
  Context, User, Password: string; var valid: Boolean; UserRoles: TStrings);
begin
  TDSSessionManager.GetThreadSession.PutData(sUserLogonInits, User);
end;

procedure TWebModule2.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit2.TServerMethods2;
end;

procedure TWebModule2.ReverseStringHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
  TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString, 'urlpath') then
    ReplaceText := string(Request.InternalScriptName)
  else if SameText(TagString, 'port') then
    ReplaceText := IntToStr(Request.ServerPort)
  else if SameText(TagString, 'host') then
    ReplaceText := string(Request.Host)
  else if SameText(TagString, 'classname') then
    ReplaceText := ServerMethodsUnit2.TServerMethods2.ClassName
  else if SameText(TagString, 'loginrequired') then
    if DSHTTPWebDispatcher1.AuthenticationManager <> nil then
      ReplaceText := 'true'
    else
      ReplaceText := 'false'
  else if SameText(TagString, 'serverfunctionsjs') then
    ReplaceText := string(Request.InternalScriptName) + '/js/serverfunctions.js'
  else if SameText(TagString, 'servertime') then
    ReplaceText := DateTimeToStr(Now)
end;

procedure TWebModule2.WebModuleDefaultAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if (Request.InternalPathInfo = '') or (Request.InternalPathInfo = '/')then
    Response.Content := ReverseString.Content
  else
    Response.SendRedirect(Request.InternalScriptName + '/');
end;

procedure TWebModule2.WebFileDispatcher1BeforeDispatch(Sender: TObject;
  const AFileName: string; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
var
  D1, D2: TDateTime;
begin
  Handled := False;
  if SameFileName(ExtractFileName(AFileName), 'serverfunctions.js') then
    if not FileExists(AFileName) or (FileAge(AFileName, D1) and FileAge(WebApplicationFileName, D2) and (D1 < D2)) then
    begin
      DSProxyGenerator1.TargetDirectory := ExtractFilePath(AFileName);
      DSProxyGenerator1.TargetUnitName := ExtractFileName(AFileName);
      DSProxyGenerator1.Write;
    end;
end;

initialization
finalization
  WebReq.FreeWebModules;

end.

