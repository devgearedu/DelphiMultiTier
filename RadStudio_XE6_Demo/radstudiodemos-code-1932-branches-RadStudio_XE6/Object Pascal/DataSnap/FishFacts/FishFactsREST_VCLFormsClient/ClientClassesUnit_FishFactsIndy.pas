
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// 
// Created by the DataSnap proxy generator.
// 11/8/2010 8:41:51 PM
// 

unit ClientClassesUnit_FishFactsIndy;

interface

uses DBXCommon, DBXClient, System.JSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, DBXJSONReflect;

type
  TFishFactsServerMethodsClient = class(TDSAdminClient)
  private
    FReverseStringCommand: TDBXCommand;
    FGetKeysCommand: TDBXCommand;
    FGetImageCommand: TDBXCommand;
    FGetFactsCommand: TDBXCommand;
    FGetNotesCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function ReverseString(Value: string): string;
    function GetKeys: TJSONArray;
    function GetImage(Key: string): TStream;
    function GetFacts(AKey: string; out ASpeciesName: string; out ACategory: string; out ACommonName: string; out ALengthIn: Double; out ALengthCm: Double): Boolean;
    function GetNotes(AKey: string; out ANotes: string): Boolean;
  end;

implementation

function TFishFactsServerMethodsClient.ReverseString(Value: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TFishFactsServerMethods.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TFishFactsServerMethodsClient.GetKeys: TJSONArray;
begin
  if FGetKeysCommand = nil then
  begin
    FGetKeysCommand := FDBXConnection.CreateCommand;
    FGetKeysCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetKeysCommand.Text := 'TFishFactsServerMethods.GetKeys';
    FGetKeysCommand.Prepare;
  end;
  FGetKeysCommand.ExecuteUpdate;
  Result := TJSONArray(FGetKeysCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TFishFactsServerMethodsClient.GetImage(Key: string): TStream;
begin
  if FGetImageCommand = nil then
  begin
    FGetImageCommand := FDBXConnection.CreateCommand;
    FGetImageCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetImageCommand.Text := 'TFishFactsServerMethods.GetImage';
    FGetImageCommand.Prepare;
  end;
  FGetImageCommand.Parameters[0].Value.SetWideString(Key);
  FGetImageCommand.ExecuteUpdate;
  Result := FGetImageCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TFishFactsServerMethodsClient.GetFacts(AKey: string; out ASpeciesName: string; out ACategory: string; out ACommonName: string; out ALengthIn: Double; out ALengthCm: Double): Boolean;
begin
  if FGetFactsCommand = nil then
  begin
    FGetFactsCommand := FDBXConnection.CreateCommand;
    FGetFactsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetFactsCommand.Text := 'TFishFactsServerMethods.GetFacts';
    FGetFactsCommand.Prepare;
  end;
  FGetFactsCommand.Parameters[0].Value.SetWideString(AKey);
  FGetFactsCommand.ExecuteUpdate;
  ASpeciesName := FGetFactsCommand.Parameters[1].Value.GetWideString;
  ACategory := FGetFactsCommand.Parameters[2].Value.GetWideString;
  ACommonName := FGetFactsCommand.Parameters[3].Value.GetWideString;
  ALengthIn := FGetFactsCommand.Parameters[4].Value.GetDouble;
  ALengthCm := FGetFactsCommand.Parameters[5].Value.GetDouble;
  Result := FGetFactsCommand.Parameters[6].Value.GetBoolean;
end;

function TFishFactsServerMethodsClient.GetNotes(AKey: string; out ANotes: string): Boolean;
begin
  if FGetNotesCommand = nil then
  begin
    FGetNotesCommand := FDBXConnection.CreateCommand;
    FGetNotesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetNotesCommand.Text := 'TFishFactsServerMethods.GetNotes';
    FGetNotesCommand.Prepare;
  end;
  FGetNotesCommand.Parameters[0].Value.SetWideString(AKey);
  FGetNotesCommand.ExecuteUpdate;
  ANotes := FGetNotesCommand.Parameters[1].Value.GetWideString;
  Result := FGetNotesCommand.Parameters[2].Value.GetBoolean;
end;


constructor TFishFactsServerMethodsClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TFishFactsServerMethodsClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TFishFactsServerMethodsClient.Destroy;
begin
  FreeAndNil(FReverseStringCommand);
  FreeAndNil(FGetKeysCommand);
  FreeAndNil(FGetImageCommand);
  FreeAndNil(FGetFactsCommand);
  FreeAndNil(FGetNotesCommand);
  inherited;
end;

end.
