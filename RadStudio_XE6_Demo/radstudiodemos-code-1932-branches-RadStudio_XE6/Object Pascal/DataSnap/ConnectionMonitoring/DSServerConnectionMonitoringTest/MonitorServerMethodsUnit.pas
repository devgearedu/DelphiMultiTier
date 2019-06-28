unit MonitorServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
{$METHODINFO ON}
  TMonitorServerMethods = class(TComponent)
  public
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils;

function TMonitorServerMethods.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TMonitorServerMethods.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

