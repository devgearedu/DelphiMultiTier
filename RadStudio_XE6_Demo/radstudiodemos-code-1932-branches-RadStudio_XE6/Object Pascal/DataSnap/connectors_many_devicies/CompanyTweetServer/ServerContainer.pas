
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ServerContainer;

interface

uses
  SysUtils,
  Classes,
  HTTPApp,
  DSHTTPCommon,
  DSHTTPWebBroker,
  DSServer,
  DSAuth,
  DSCommonServer,
  ExtCtrls,
  ctManager, DSProxyJavaAndroid, DSProxyDispatcher, DSClientMetadata;

type
  TWebModule8 = class(TWebModule)
    DSServer1: TDSServer;
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServerClass1: TDSServerClass;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    DSProxyDispatcher1: TDSProxyDispatcher;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModule8DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule8;

implementation

uses
  ctServerMethods,
  WebReq,
  DBXJSON;

{$R *.dfm}


procedure TWebModule8.WebModule8DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '<html><heading/><body>DataSnap Server</body></html>';
end;

procedure TWebModule8.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  TctManager.Instance.SetDSServer(DSServer1); //TODO
  PersistentClass := ctServerMethods.TCompanyTweet;
end;

end.
