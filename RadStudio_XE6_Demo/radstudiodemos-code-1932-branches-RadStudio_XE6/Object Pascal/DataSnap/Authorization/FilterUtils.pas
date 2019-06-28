
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FilterUtils;

interface

uses Data.DBXTransport, Data.DBXCompressionFilter, System.JSon;

procedure ClearServerFilters(AFilters: TTransportFilterCollection);
procedure AddRSAServerFilter(AFilters: TTransportFilterCollection;
  AUseGlobalKey: Boolean = True; AKeyLength: Integer = 1024; AKeyExponent: Integer = 3);
procedure AddPC1ServerFilter(AFilters: TTransportFilterCollection;
  const AKey: string; const AName: string = 'PC1');
procedure AddZLibServerFilter(AFilters: TTransportFilterCollection);
function CreateClientPC1FilterParams(const AKey: string): TJSONPair;
function CreateClientRSAFilterParams(
  const AUseGlobalKey: Boolean = True; AKeyLength: Integer = 1024; AKeyExponent: Integer = 3): TJSONPair;
function CreateClientZLibFilterParams: TJSONPair;

//var
//  nRSAFilterKeyLength: Integer = 1024;
//  nRSAFilterKeyExponent: Integer = 3;

implementation

uses System.SysUtils;

procedure ClearServerFilters(AFilters: TTransportFilterCollection);
begin
  AFilters.Clear;
end;

procedure AddRSAServerFilter(AFilters: TTransportFilterCollection;
  AUseGlobalKey: Boolean; AKeyLength: Integer; AKeyExponent: Integer);
const
  LFalseTrue: array[false..true] of string = ('false', 'true');
var
  I: Integer;
  LFilter: TTransportFilter;
begin
  I := AFilters.AddFilter('RSA');
  LFilter := AFilters.GetFilter(I);
  LFilter.SetParameterValue('UseGlobalKey', LFalseTrue[AUseGlobalKey]);
  LFilter.SetParameterValue('KeyLength', IntToStr(AKeyLength));
  LFilter.SetParameterValue('KeyExponent', IntToStr(AKeyExponent));
end;

procedure AddPC1ServerFilter(AFilters: TTransportFilterCollection;
  const AKey: string; const AName: string);
var
  I: Integer;
begin
  I := AFilters.AddFilter(AName);
  if AKey <> '' then
    AFilters.GetFilter(I).SetParameterValue('Key', AKey);
end;

procedure AddZLibServerFilter(AFilters: TTransportFilterCollection);
begin
  AFilters.AddFilter('ZLibCompression');
end;

function CreateClientPC1FilterParams(const AKey: string): TJSONPair;
var
  LFilterParams: TJSONObject;
begin
  LFilterParams := TJSONObject.Create;
  try
    LFilterParams.AddPair(TJSONPair.Create('Key', AKey));
    Result := TJSONPair.Create('PC1', LFilterParams);
    LFilterParams := nil;
  finally
    FreeAndNil(LFilterParams);
  end;
end;

function CreateClientRSAFilterParams(
  const AUseGlobalKey: Boolean; AKeyLength, AKeyExponent: Integer): TJSONPair;
const
  sFalseTrue: array[false..true] of string = ('false', 'true');
var
  LFilterParams: TJSONObject;
begin
  LFilterParams := TJSONObject.Create;
  try
    LFilterParams.AddPair(TJSONPair.Create('UseGlobalKey', sFalseTrue[AUseGlobalKey]));
    LFilterParams.AddPair(TJSONPair.Create('KeyLength', IntToStr(AKeyLength)));
    LFilterParams.AddPair(TJSONPair.Create('KeyExponent', IntToStr(AKeyExponent)));
    Result := TJSONPair.Create('RSA', LFilterParams);
    LFilterParams := nil;
  finally
    FreeAndNil(LFilterParams);
  end;
end;

function CreateClientZLibFilterParams: TJSONPair;
var
  LFilterParams: TJSONObject;
begin
  LFilterParams := TJSONObject.Create;
  try
    Result := TJSONPair.Create('ZLibCompression', LFilterParams);
    LFilterParams := nil;
  finally
    FreeAndNil(LFilterParams);
  end;
end;

end.
