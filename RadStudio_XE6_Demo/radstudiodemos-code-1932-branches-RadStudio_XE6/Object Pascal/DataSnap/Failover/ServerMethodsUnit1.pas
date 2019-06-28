
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ServerMethodsUnit1;

interface

uses
  SysUtils, Classes, DSServer, Datasnap.DSProviderDataModuleAdapter, ServerContainerUnit1;

type
  TServerMethods1 = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
  end;

var
  ServerMethods1: TServerMethods1;

implementation

{$R *.dfm}

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value + ' - Port: ' + InttoStr(ServerContainer1.DSTCPServerTransport1.Port);
end;

end.




