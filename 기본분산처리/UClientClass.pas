//
// Created by the DataSnap proxy generator.
// 2019-06-19 ���� 3:35:05
//

unit UClientClass;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
    FGetCountCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; CallBackid: TDBXCallback): string;
    function ReverseString(Value: string): string;
    function GetCount(value: string): Integer;
  end;

implementation

function TServerMethods1Client.EchoString(Value: string; CallBackid: TDBXCallback): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Parameters[1].Value.SetCallbackValue(CallBackid);
  FEchoStringCommand.ExecuteUpdate;
  Result := FEchoStringCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetCount(value: string): Integer;
begin
  if FGetCountCommand = nil then
  begin
    FGetCountCommand := FDBXConnection.CreateCommand;
    FGetCountCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetCountCommand.Text := 'TServerMethods1.GetCount';
    FGetCountCommand.Prepare;
  end;
  FGetCountCommand.Parameters[0].Value.SetWideString(value);
  FGetCountCommand.ExecuteUpdate;
  Result := FGetCountCommand.Parameters[1].Value.GetInt32;
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetCountCommand.DisposeOf;
  inherited;
end;

end.

