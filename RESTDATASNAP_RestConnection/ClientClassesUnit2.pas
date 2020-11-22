// 
// Created by the DataSnap proxy generator.
// 2020-11-20 ¿ÀÀü 7:36:29
// 

unit ClientClassesUnit2;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetDeptsCommand: TDSRestCommand;
    FGetDeptsCommand_Cache: TDSRestCommand;
    FGetInsasCommand: TDSRestCommand;
    FGetInsasCommand_Cache: TDSRestCommand;
    FGetDeptJSONCommand: TDSRestCommand;
    FGetDeptJSONCommand_Cache: TDSRestCommand;
    FGetInsaJSONCommand: TDSRestCommand;
    FGetInsaJSONCommand_Cache: TDSRestCommand;
    FApplyChangesDeptInsaCommand: TDSRestCommand;
    FApplyChangesDeptInsaJSONCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetDepts(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetDepts_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetInsas(code: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetInsas_Cache(code: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetDeptJSON(const ARequestFilter: string = ''): TJSONObject;
    function GetDeptJSON_Cache(const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    function GetInsaJSON(code: string; const ARequestFilter: string = ''): TJSONObject;
    function GetInsaJSON_Cache(code: string; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    procedure ApplyChangesDeptInsa(ADeltaList: TFDJSONDeltas);
    procedure ApplyChangesDeptInsaJSON(AJSONObject: TJSONObject);
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetDepts: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_GetDepts_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetInsas: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'code'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_GetInsas_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'code'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetDeptJSON: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TServerMethods1_GetDeptJSON_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetInsaJSON: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'code'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TServerMethods1_GetInsaJSON_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'code'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_ApplyChangesDeptInsa: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'ADeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas')
  );

  TServerMethods1_ApplyChangesDeptInsaJSON: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'AJSONObject'; Direction: 1; DBXType: 37; TypeName: 'TJSONObject')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetDepts(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetDeptsCommand = nil then
  begin
    FGetDeptsCommand := FConnection.CreateCommand;
    FGetDeptsCommand.RequestType := 'GET';
    FGetDeptsCommand.Text := 'TServerMethods1.GetDepts';
    FGetDeptsCommand.Prepare(TServerMethods1_GetDepts);
  end;
  FGetDeptsCommand.Execute(ARequestFilter);
  if not FGetDeptsCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetDeptsCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetDeptsCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetDeptsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetDepts_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetDeptsCommand_Cache = nil then
  begin
    FGetDeptsCommand_Cache := FConnection.CreateCommand;
    FGetDeptsCommand_Cache.RequestType := 'GET';
    FGetDeptsCommand_Cache.Text := 'TServerMethods1.GetDepts';
    FGetDeptsCommand_Cache.Prepare(TServerMethods1_GetDepts_Cache);
  end;
  FGetDeptsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetDeptsCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.GetInsas(code: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetInsasCommand = nil then
  begin
    FGetInsasCommand := FConnection.CreateCommand;
    FGetInsasCommand.RequestType := 'GET';
    FGetInsasCommand.Text := 'TServerMethods1.GetInsas';
    FGetInsasCommand.Prepare(TServerMethods1_GetInsas);
  end;
  FGetInsasCommand.Parameters[0].Value.SetWideString(code);
  FGetInsasCommand.Execute(ARequestFilter);
  if not FGetInsasCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetInsasCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetInsasCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetInsasCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetInsas_Cache(code: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetInsasCommand_Cache = nil then
  begin
    FGetInsasCommand_Cache := FConnection.CreateCommand;
    FGetInsasCommand_Cache.RequestType := 'GET';
    FGetInsasCommand_Cache.Text := 'TServerMethods1.GetInsas';
    FGetInsasCommand_Cache.Prepare(TServerMethods1_GetInsas_Cache);
  end;
  FGetInsasCommand_Cache.Parameters[0].Value.SetWideString(code);
  FGetInsasCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetInsasCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethods1Client.GetDeptJSON(const ARequestFilter: string): TJSONObject;
begin
  if FGetDeptJSONCommand = nil then
  begin
    FGetDeptJSONCommand := FConnection.CreateCommand;
    FGetDeptJSONCommand.RequestType := 'GET';
    FGetDeptJSONCommand.Text := 'TServerMethods1.GetDeptJSON';
    FGetDeptJSONCommand.Prepare(TServerMethods1_GetDeptJSON);
  end;
  FGetDeptJSONCommand.Execute(ARequestFilter);
  Result := TJSONObject(FGetDeptJSONCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TServerMethods1Client.GetDeptJSON_Cache(const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FGetDeptJSONCommand_Cache = nil then
  begin
    FGetDeptJSONCommand_Cache := FConnection.CreateCommand;
    FGetDeptJSONCommand_Cache.RequestType := 'GET';
    FGetDeptJSONCommand_Cache.Text := 'TServerMethods1.GetDeptJSON';
    FGetDeptJSONCommand_Cache.Prepare(TServerMethods1_GetDeptJSON_Cache);
  end;
  FGetDeptJSONCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FGetDeptJSONCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.GetInsaJSON(code: string; const ARequestFilter: string): TJSONObject;
begin
  if FGetInsaJSONCommand = nil then
  begin
    FGetInsaJSONCommand := FConnection.CreateCommand;
    FGetInsaJSONCommand.RequestType := 'GET';
    FGetInsaJSONCommand.Text := 'TServerMethods1.GetInsaJSON';
    FGetInsaJSONCommand.Prepare(TServerMethods1_GetInsaJSON);
  end;
  FGetInsaJSONCommand.Parameters[0].Value.SetWideString(code);
  FGetInsaJSONCommand.Execute(ARequestFilter);
  Result := TJSONObject(FGetInsaJSONCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TServerMethods1Client.GetInsaJSON_Cache(code: string; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FGetInsaJSONCommand_Cache = nil then
  begin
    FGetInsaJSONCommand_Cache := FConnection.CreateCommand;
    FGetInsaJSONCommand_Cache.RequestType := 'GET';
    FGetInsaJSONCommand_Cache.Text := 'TServerMethods1.GetInsaJSON';
    FGetInsaJSONCommand_Cache.Prepare(TServerMethods1_GetInsaJSON_Cache);
  end;
  FGetInsaJSONCommand_Cache.Parameters[0].Value.SetWideString(code);
  FGetInsaJSONCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FGetInsaJSONCommand_Cache.Parameters[1].Value.GetString);
end;

procedure TServerMethods1Client.ApplyChangesDeptInsa(ADeltaList: TFDJSONDeltas);
begin
  if FApplyChangesDeptInsaCommand = nil then
  begin
    FApplyChangesDeptInsaCommand := FConnection.CreateCommand;
    FApplyChangesDeptInsaCommand.RequestType := 'POST';
    FApplyChangesDeptInsaCommand.Text := 'TServerMethods1."ApplyChangesDeptInsa"';
    FApplyChangesDeptInsaCommand.Prepare(TServerMethods1_ApplyChangesDeptInsa);
  end;
  if not Assigned(ADeltaList) then
    FApplyChangesDeptInsaCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FApplyChangesDeptInsaCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FApplyChangesDeptInsaCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ADeltaList), True);
      if FInstanceOwner then
        ADeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FApplyChangesDeptInsaCommand.Execute;
end;

procedure TServerMethods1Client.ApplyChangesDeptInsaJSON(AJSONObject: TJSONObject);
begin
  if FApplyChangesDeptInsaJSONCommand = nil then
  begin
    FApplyChangesDeptInsaJSONCommand := FConnection.CreateCommand;
    FApplyChangesDeptInsaJSONCommand.RequestType := 'POST';
    FApplyChangesDeptInsaJSONCommand.Text := 'TServerMethods1."ApplyChangesDeptInsaJSON"';
    FApplyChangesDeptInsaJSONCommand.Prepare(TServerMethods1_ApplyChangesDeptInsaJSON);
  end;
  FApplyChangesDeptInsaJSONCommand.Parameters[0].Value.SetJSONValue(AJSONObject, FInstanceOwner);
  FApplyChangesDeptInsaJSONCommand.Execute;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetDeptsCommand.DisposeOf;
  FGetDeptsCommand_Cache.DisposeOf;
  FGetInsasCommand.DisposeOf;
  FGetInsasCommand_Cache.DisposeOf;
  FGetDeptJSONCommand.DisposeOf;
  FGetDeptJSONCommand_Cache.DisposeOf;
  FGetInsaJSONCommand.DisposeOf;
  FGetInsaJSONCommand_Cache.DisposeOf;
  FApplyChangesDeptInsaCommand.DisposeOf;
  FApplyChangesDeptInsaJSONCommand.DisposeOf;
  inherited;
end;

end.
