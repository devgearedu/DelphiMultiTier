
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

uses
  SysUtils, Classes, 
  DSHTTPCommon, DSHTTP,
  DSServer, DSCommonServer, DSTCPServerTransport, IPPeerServer, IndyPeerImpl;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    DSTCPServerTransport1: TDSTCPServerTransport;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
  end;

var
  ServerContainer1: TServerContainer1;

implementation

uses Windows, ServerMethodsUnit1;

{$R *.dfm}

procedure TServerContainer1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit1.TServerMethods1;
end;

end.
