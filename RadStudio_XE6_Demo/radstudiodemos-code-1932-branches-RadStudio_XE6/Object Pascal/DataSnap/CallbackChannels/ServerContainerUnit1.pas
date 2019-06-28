
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ServerContainerUnit1;

interface

uses SysUtils, Classes, DSHTTPCommon, DSHTTP, DSServer, DSCommonServer,
  DSTCPServerTransport, IPPeerServer, IndyPeerImpl;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSHTTPService1: TDSHTTPService;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPServiceFileDispatcher1: TDSHTTPServiceFileDispatcher;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  ServerContainer1: TServerContainer1;

implementation

uses Windows;

{$R *.dfm}

procedure TServerContainer1.DataModuleDestroy(Sender: TObject);
begin
  DSServer1.Stop;
end;

end.
