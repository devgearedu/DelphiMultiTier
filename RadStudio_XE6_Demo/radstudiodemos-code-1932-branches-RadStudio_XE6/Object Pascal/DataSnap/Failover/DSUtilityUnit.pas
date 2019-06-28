
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DSUtilityUnit;

interface

uses
  SysUtils, Classes, DSServer, System.JSON, DBXPlatform, Generics.Collections, DataBkr,
  Data.DBXJSON, Datasnap.DSProviderDataModuleAdapter;

type
  /// DS Utility class
  TDSUtilityMethods = class(TDSServerModule)
  private
    { Private declarations }
    FStorage: TDBXObjectStore;
    FCount: Integer;
    FDepot: TList<String>;
    FFailureCount: Integer;

  public
    { Public declarations }

    function JSONPing(data: TJSONObject; var ok: TJSONValue): TJSONObject;
    function EchoStr(data: String): String;
    function IncrAndGetInt: Integer;

    procedure AcceptData(JSONValue: TJSONValue);
    procedure FailOn(ACount: string);

    function Storage(const Key: UnicodeString): TJSONValue;
    procedure AcceptStorage(const Key: UnicodeString; const Obj: TJSONValue);
    procedure UpdateStorage(const Key: UnicodeString; const Obj: TJSONValue);
    procedure CancelStorage(const Key: UnicodeString);

    procedure Callback(const PCallback: TDBXCallback);

    function 伴唱(test: string): string;

    function sum(a,b: integer): integer;
    procedure swap(var i: boolean; var j: boolean);
    procedure echoOutStr(i: string; var o: string);

    function strings(str1: ansistring; var str2: ansistring; out str3: ansistring): ansistring;
    function widestrings(str1: string; var str2: string): string;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  DSUtilityMethods: TDSUtilityMethods;

implementation

{$R *.dfm}

uses DBXDatasnap, DBXCommon, Windows;

type
  TParamSetup = reference to procedure (Params: TDBXParameterList);

procedure ExecuteRemote(AHostName, AProtocol, APort: String;
                            AClassName, AMethodName: String;
                            ParamSetup: TParamSetup; ParamCheckup: TParamSetup);
var
  DBXCommand: TDBXCommand;
  DBXConnection: TDBXConnection;
  DBXProperties: TDBXDatasnapProperties;
begin
  DBXProperties := TDBXDatasnapProperties.Create(nil);
  DBXProperties.Values[TDBXPropertyNames.DriverName] := 'Datasnap';
  DBXProperties.Values[TDBXPropertyNames.HostName] := AHostName;
  DBXProperties.Values[TDBXPropertyNames.CommunicationProtocol] := AProtocol;
  DBXProperties.Values[TDBXPropertyNames.Port] := APort;
  try
    DBXConnection := TDBXConnectionFactory.GetConnectionFactory.GetConnection(DBXProperties);
    DBXCommand := DBXConnection.CreateCommand;
    DBXCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    try
        DBXCommand.Text := Format('%s.%s', [AClassName, AMethodName]);
        DBXCommand.Prepare;

        if Assigned(ParamSetup) then
          ParamSetup(DBXCommand.Parameters);

        DBXCommand.ExecuteUpdate;

        if Assigned(ParamCheckup) then
          ParamCheckup(DBXCommand.Parameters);
    finally
      DBXCommand.Close;
      DBXCommand.Free;
    end;
  finally
      if DBXConnection <> nil then
        DBXConnection.Close;
      FreeAndNil(DBXConnection);
      FreeAndNil(DBXProperties);
  end;
end;

constructor TDSUtilityMethods.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStorage := TDBXObjectStore.Create;
  FCount := 0;
  FFailureCount := 0;
end;

destructor TDSUtilityMethods.Destroy;
begin
  FreeAndNil(FStorage);
  inherited;
end;

procedure TDSUtilityMethods.echoOutStr(i: string; var o: string);
begin
  o := i;
end;

procedure TDSUtilityMethods.AcceptData(JSONValue: TJSONValue);
begin
  Inc(FCount);
  try
    if (FFailureCount > 0) and (FCount >= FFailureCount) then
      raise TDBXError.Create('Same internal error');
    if FCount >= 5 then
    begin
      ExecuteRemote('localhost', 'tcp/ip', '212', 'TRepository', 'insert',
      procedure (params: TDBXParameterList) begin
        params[0].Value.AsInt32 := 5;
        FCount := FCount - 5;
      end,
      nil);
    end;
  finally
    JSONValue.Free;
  end;
end;

procedure TDSUtilityMethods.FailOn(ACount: string);
begin
  FFailureCount := StrToInt(ACount);
end;

function TDSUtilityMethods.EchoStr(data: String): String;
begin
  Result := data;
end;

function TDSUtilityMethods.JSONPing(data: TJSONObject; var ok: TJSONValue): TJSONObject;
var
  answer: TJSONObject;
begin
  if data = nil then
  begin
    answer := TJSONObject.Create;
    answer.AddPair( TJSONPair.Create( TJSONString.Create('Received'),
                        TJSONTrue.Create ) );
    FDepot := TList<String>.Create();
  end
  else
    answer := TJSONObject(data.Clone);

  Result := answer;

  ok := TJSONTrue.Create;
end;

function TDSUtilityMethods.Storage(const Key: UnicodeString): TJSONValue;
begin
  if not FStorage.ContainsKey(Key) then
    raise Exception.Create('No object was stored with the key ' + Key);
  Result := TJSONValue(TJSONValue(FStorage[Key]).Clone());
end;

function TDSUtilityMethods.strings(str1: ansistring; var str2: ansistring;
  out str3: ansistring): ansistring;
begin
  Result := str1;

  str2 := Result;
  str3 := Result;
end;

function TDSUtilityMethods.widestrings(str1: string; var str2: string): string;
begin
  str2 := str1;
  Result := '1';
end;

function TDSUtilityMethods.sum(a, b: integer): integer;
begin
  Result := a+ b;
end;

procedure TDSUtilityMethods.swap(var i: boolean; var j: boolean);
var
  temp: boolean;
begin
  temp := i;
  i := j;
  j := temp;
end;

procedure TDSUtilityMethods.AcceptStorage(const Key: UnicodeString; const Obj: TJSONValue);
begin
  if not FStorage.ContainsKey(Key) then
  begin
    FStorage[Key] := Obj.Clone;
  end
  else
    raise Exception.Create('Object already exists with key ' + Key + '. Use update or use a different key.');
end;

procedure TDSUtilityMethods.UpdateStorage(const Key: UnicodeString; const Obj: TJSONValue);
begin
  if not FStorage.ContainsKey(Key) then
    raise Exception.Create('No object was stored with the key ' + Key);
  FStorage[Key].Free;
  FStorage[Key] := Obj.Clone;
end;

function TDSUtilityMethods.伴唱(test: string): string;
begin
  Result := test;
end;

function TDSUtilityMethods.IncrAndGetInt: Integer;
begin
  Inc(FCount);
  Result := FCount;
end;

procedure TDSUtilityMethods.Callback(const PCallback: TDBXCallback);
begin
  PCallback.Execute(TJSONString.Create('test'));
end;

procedure TDSUtilityMethods.CancelStorage(const Key: UnicodeString);
begin
  if not FStorage.ContainsKey(Key) then
    raise Exception.Create('No object found with the key ' + Key);
  FStorage[Key].Free;
  FStorage.Delete(Key);
end;

end.
