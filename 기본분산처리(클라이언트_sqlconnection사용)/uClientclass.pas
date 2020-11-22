//
// Created by the DataSnap proxy generator.
// 2020-11-17 ¿ÀÈÄ 3:31:24
//

unit uClientclass;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FGet_CountCommand: TDBXCommand;
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function Get_Count(value: string): Integer;
    function EchoString(Value: string; callback: TDBXCallback): string;
    function ReverseString(Value: string): string;
  end;

implementation

function TServerMethods1Client.Get_Count(value: string): Integer;
begin
  if FGet_CountCommand = nil then
  begin
    FGet_CountCommand := FDBXConnection.CreateCommand;
    FGet_CountCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGet_CountCommand.Text := 'TServerMethods1.Get_Count';
    FGet_CountCommand.Prepare;
  end;
  FGet_CountCommand.Parameters[0].Value.SetWideString(value);
  FGet_CountCommand.ExecuteUpdate;
  Result := FGet_CountCommand.Parameters[1].Value.GetInt32;
end;

function TServerMethods1Client.EchoString(Value: string; callback: TDBXCallback): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Parameters[1].Value.SetCallbackValue(callback);
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
  FGet_CountCommand.DisposeOf;
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  inherited;
end;

end.

