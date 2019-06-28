
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ServerContainerUnit8;

interface

uses
  SysUtils, Classes, 
  DSTCPServerTransport,
  DSHTTPCommon, DSHTTP,
  DSServer, DSCommonServer, DSAuth, IPPeerServer, IndyPeerImpl;

type
  TServerContainer8 = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
  end;

var
  ServerContainer8: TServerContainer8;

implementation

uses Windows, ServerMethodsUnit2;

{$R *.dfm}

procedure TServerContainer8.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit2.TServerMethods2;
end;

end.

