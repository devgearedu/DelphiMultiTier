
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// Version of PC1 filter that generates random keys.

unit PC1DynamicKey;

interface

uses Data.DBXTransport, System.SysUtils, Data.DBXPlatform, Data.DBXEncryption;

type
  TTransportCypherFilterDynamicKey = class sealed(TTransportFilter)
  private
    FDelegateFilter: TTransportCypherFilter;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetParameterValue(const ParamName: UnicodeString): UnicodeString; override;
    function ProcessInput(const Data: TBytes): TBytes; override;
    function ProcessOutput(const Data: TBytes): TBytes; override;
    function SetParameterValue(const ParamName: UnicodeString; const ParamValue: UnicodeString): Boolean; override;
    function SetConfederateParameter(const ParamName: UnicodeString; const ParamValue: UnicodeString): Boolean; override;
    function Id: UnicodeString; override;
  protected
    function GetUserParameters: TDBXStringArray; override;
    function GetParameters: TDBXStringArray; override;

  end;

implementation

function TTransportCypherFilterDynamicKey.GetParameterValue(const ParamName: UnicodeString): UnicodeString;
begin
  Result := FDelegateFilter.GetParameterValue(ParamName);
end;

function RandomKey: string;
var
  i: Integer;
begin
  SetLength(Result, 16);
  for i := 1 to 16 do
    Result[i] := Char(Random(255 - Ord(' '))+ Ord(' '));
end;

constructor TTransportCypherFilterDynamicKey.Create;
var
  LCypherKey: string;
begin
  inherited;
  FDelegateFilter := TTransportCypherFilter.Create;
  LCypherKey := RandomKey;
  FDelegateFilter.SetParameterValue('Key', LCypherKey);
end;

destructor TTransportCypherFilterDynamicKey.Destroy;
begin
  FDelegateFilter.Free;
  inherited;
end;

function TTransportCypherFilterDynamicKey.GetUserParameters: TDBXStringArray;
begin
  Result := FDelegateFilter.UserParameters;
end;

function TTransportCypherFilterDynamicKey.GetParameters: TDBXStringArray;
begin
  Result := FDelegateFilter.Parameters;
end;

function TTransportCypherFilterDynamicKey.ProcessInput(const Data: TBytes): TBytes;
begin
  Result := FDelegateFilter.ProcessInput(Data);
end;

function TTransportCypherFilterDynamicKey.ProcessOutput(const Data: TBytes): TBytes;
begin
  Result := FDelegateFilter.ProcessOutput(Data);
end;

function TTransportCypherFilterDynamicKey.SetParameterValue(const ParamName: UnicodeString; const ParamValue: UnicodeString): Boolean;
begin
  Result := FDelegateFilter.SetParameterValue(ParamName, ParamValue);
end;

function TTransportCypherFilterDynamicKey.SetConfederateParameter(const ParamName: UnicodeString; const ParamValue: UnicodeString): Boolean;
begin
  Result := FDelegateFilter.SetConfederateParameter(ParamName, ParamValue);
end;

function TTransportCypherFilterDynamicKey.Id: UnicodeString;
begin
  Result := 'PC1DynamicKey';
end;

initialization
  TTransportFilterFactory.RegisterFilter(TTransportCypherFilterDynamicKey);

finalization
  TTransportFilterFactory.UnregisterFilter(TTransportCypherFilterDynamicKey);

end.

