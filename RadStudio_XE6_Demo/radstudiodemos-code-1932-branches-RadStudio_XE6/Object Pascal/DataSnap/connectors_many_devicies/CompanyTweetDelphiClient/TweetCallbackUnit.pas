
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit TweetCallbackUnit;

interface

uses
  Data.DBXJSON,
  System.JSON,
  System.SysUtils,
  System.Generics.Defaults,
  System.Generics.Collections;

type
  TTweetCallback = class(TDBXNamedCallback)
  private
    FProc: TProc<string, string>;
  public
    constructor Create(const name: UnicodeString; Proc: TProc<string, string>);
    function Execute(const Arg: TJSONValue): TJSONValue; override;
  end;

implementation

{ TTweetCallback }

constructor TTweetCallback.Create(const name: UnicodeString; Proc: TProc<string, string>);
begin
  inherited Create(name);
  FProc := Proc;
end;

function TTweetCallback.Execute(const Arg: TJSONValue): TJSONValue;
begin
  FProc(
    TJSONObject(Arg).Get('username').JsonValue.Value,
    TJSONObject(Arg).Get('message').JsonValue.Value);
  Result := TJSONTrue.Create;
end;

end.
