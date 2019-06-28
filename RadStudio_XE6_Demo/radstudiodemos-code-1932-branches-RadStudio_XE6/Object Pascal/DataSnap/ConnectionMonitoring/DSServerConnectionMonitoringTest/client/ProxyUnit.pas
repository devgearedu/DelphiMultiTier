unit ProxyUnit;

interface

uses Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, System.JSON, DSProxy, Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXJSONReflect;

type
  TMonitorServerMethodsClient = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
  end;

implementation

function TMonitorServerMethodsClient.EchoString(Value: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TMonitorServerMethods.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.ExecuteUpdate;
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TMonitorServerMethodsClient.ReverseString(Value: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TMonitorServerMethods.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;


constructor TMonitorServerMethodsClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TMonitorServerMethodsClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TMonitorServerMethodsClient.Destroy;
begin
  FreeAndNil(FEchoStringCommand);
  FreeAndNil(FReverseStringCommand);
  inherited;
end;

end.
