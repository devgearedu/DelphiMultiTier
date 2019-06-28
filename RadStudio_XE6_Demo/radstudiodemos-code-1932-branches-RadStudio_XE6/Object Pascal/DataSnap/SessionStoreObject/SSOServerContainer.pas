
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit SSOServerContainer;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSHTTPCommon, Datasnap.DSHTTP,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSClientMetadata, Datasnap.DSProxyJavaScript,
  Datasnap.DSAuth, IPPeerClient, IPPeerServer, IndyPeerImpl,
  Datasnap.DSMetadata, Datasnap.DSServerMetadata;

type
  TServerContainer3 = class(TDataModule)
    DSServer1: TDSServer;
    DSHTTPService1: TDSHTTPService;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    DSHTTPServiceFileDispatcher1: TDSHTTPServiceFileDispatcher;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  ServerContainer3: TServerContainer3;

implementation

uses Winapi.Windows, SSOServerMethodsUnit;

{$R *.dfm}

procedure TServerContainer3.DataModuleCreate(Sender: TObject);
begin
  //write the JavaScript proxy on startup
  DSProxyGenerator1.Write;
end;

procedure TServerContainer3.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := SSOServerMethodsUnit.TServerMethods1;
end;


end.

