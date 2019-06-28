unit CTCallback;

interface

uses

{$IFNDEF FPC}
  DBXJSON, ClientClassesUnit1, ProxyRegister, DSHTTPLayer,
{$ELSE}
  FPCProxyRegister, DBXFPCJSON, DBXFPCCallback,iPhoneAll,
{$ENDIF}
   LockedStringListU;

type
{$IFNDEF FPC}
  TCMDCallback = class(TDBXCallback)
{$ELSE}
  TCMDCallback = class(TDBXFPCCallback)
{$ENDIF}
  private
    _cmd: string;
    _value: string;
    FStringList: TCMDLockedStringList;
  public
    constructor Create(StringList: TCMDLockedStringList);
{$IFNDEF FPC}
    function Execute(const Arg: TJSONValue): TJSONValue; override;
{$ELSE}
    function Execute(Value: TJSONValue; JSONType: Integer): TJSONValue; override;
{$ENDIF}

  end;
  {$IFNDEF FPC}

  TCTCallback = class(TDBXCallback)
{$ELSE}
  TCTCallback = class(TDBXFPCCallback)
{$ENDIF}
  private
    FStringList: TLockedStringList;
  public
    constructor Create(StringList: TLockedStringList);
    destructor Destroy; override;
{$IFNDEF FPC}
    function Execute(const Arg: TJSONValue): TJSONValue; override;
{$ELSE}
    function Execute(Value: TJSONValue; JSONType: Integer): TJSONValue;
      override;
{$ENDIF}
  end;


implementation

uses
  Classes,FPCSound;

{ TCMDCallback }

constructor TCMDCallback.Create(StringList: TCMDLockedStringList);
begin
  inherited Create;
  FStringList := StringList;
end;

{$IFNDEF FPC}
function TCMDCallback.Execute(const Arg: TJSONValue): TJSONValue;
begin
  _cmd := TJSONObject(Arg).Get('cmd').JsonValue.Value;
  _value := TJSONObject(Arg).Get('value').JsonValue.Value;
  FStringList.Add(_cmd);
  Result := TJSONTrue.Create;
end;

{$ENDIF}

{$IFDEF FPC}
function TCMDCallback.Execute(Value: TJSONValue; JSONType: Integer): TJSONValue;
begin
  _cmd := TJSONObject(Value).GetString('cmd');
  _value := TJSONObject(Value).GetString('value');
  FStringList.Add(_cmd);
  Result := TJSONTrue.Create;
end;
{$ENDIF}

{ TCTCallback }

constructor TCTCallback.Create(StringList: TLockedStringList);
begin
  inherited Create;
  FStringList := StringList;
end;

destructor TCTCallback.Destroy;
begin
  inherited;
end;

{$IFNDEF FPC}

function TCTCallback.Execute(const Arg: TJSONValue): TJSONValue;
var
  _username: string;
  _value: string;
begin
  _username := TJSONObject(Arg).Get('username').JsonValue.Value;
  _value := TJSONObject(Arg).Get('message').JsonValue.Value;
  FStringList.Add(_username + ': ' + _value);
  Result := TJSONTrue.Create;
end;

{$ENDIF}
{$IFDEF FPC}

function TCTCallback.Execute(Value: TJSONValue; JSONType: Integer): TJSONValue;
var
  _username: string;
  _value: string;
begin
  _username := TJSONObject(Value).GetString('username');
  _value := TJSONObject(Value).GetString('message');
  FStringList.Add(_username + ': ' + _value);
{$IFNDEF WINDOWS}
  PlaySound(NSSTR('/tweet.mp3'));
{$ENDIF}
  Result := TJSONTrue.Create;
end;
{$ENDIF}

end.
