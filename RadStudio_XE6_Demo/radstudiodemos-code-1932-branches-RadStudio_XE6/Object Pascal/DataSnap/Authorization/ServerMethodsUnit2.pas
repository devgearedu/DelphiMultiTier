
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ServerMethodsUnit2;

interface


uses
  SysUtils, Classes, DSServer;

procedure RegisterServerMethods(AOwner: TComponent; AServer: TDSServer);

type
{$METHODINFO ON}
  TServerMethods2 = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
  end;
{$METHODINFO OFF}

implementation


uses StrUtils, SimpleServerClass;


procedure RegisterServerMethods(AOwner: TComponent; AServer: TDSServer);
begin
  TSimpleServerClass.Create(AOwner, AServer, TServerMethods2);
end;

function TServerMethods2.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods2.ReverseString(Value: string): string;
begin
  Result := StrUtils.ReverseString(Value);
end;
end.


