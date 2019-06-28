
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ProxyGeneratorSettings;

interface

uses
  SysUtils;

type
  // Save/load proxy generator settings to/from registry
  TProxyGeneratorSettings = class
  private
  const
    sOutputDirectory: string = 'OutputDirectory';
    sProtocol: string = 'Protocol';
    sPort: string = 'Port';
    sURLPath: string = 'URLPath';
    sHost: string = 'Host';
    sExcludeClasses: string = 'ExcludeClasses';
    sExcludeMethods: string = 'ExcludeMethods';
    sIncludeClasses: string = 'IncludeClasses';
    sIncludeMethods: string = 'IncludeMethods';
    sWriteToFile: String = 'WriteToFile';
    sWriteToTextBox: String = 'WriteToTextBox';
    sUnitName: String = 'UnitName';
    sLanguage: String = 'Language';
  var
    FHost: string;
    FProtocol: string;
    FPort: LongWord;
    FURLPath: string;
    FExcludeClasses: string;
    FExcludeMethods: string;
    FUnitName: string;
    FOutputDirectory: string;
    FWriteToFile: Boolean;
    FWriteToMemo: Boolean;
    FWriter: string;
    FIncludeMethods: String;
    FIncludeClasses: String;
  public
    class function LoadSettings(ARegistryKey: string): TProxyGeneratorSettings;
    class procedure SaveSettings(ARegistryKey: string; ASettings: TProxyGeneratorSettings);
    property Host: String read FHost write FHost;
    property Protocol: String read FProtocol write FProtocol;
    property Port: LongWord read FPort write FPort;
    property URLPath: String read FURLPath write FURLPath;
    property ExcludeClasses: String read FExcludeClasses write FExcludeClasses;
    property ExcludeMethods: String read FExcludeMethods write FExcludeMethods;
    property IncludeClasses: String read FIncludeClasses write FIncludeClasses;
    property IncludeMethods: String read FIncludeMethods write FIncludeMethods;
    property UnitName: String read FUnitName write FUnitName;
    property OutputDirectory: String read FOutputDirectory write FOutputDirectory;
    property Writer: string read FWriter write FWriter;
    property WriteToFile: Boolean read FWriteToFile write FWriteToFile;
    property WriteToMemo: Boolean read FWriteToMemo write FWriteToMemo;
  end;


implementation

uses Registry;


{ TProxyGeneratorSettings }

class function TProxyGeneratorSettings.LoadSettings(ARegistryKey: String): TProxyGeneratorSettings;
var
 LRegistry: TRegistry;

   function GetStringValue(const AName: string; const ADefaultValue: string): string;
   begin
      if LRegistry.ValueExists(AName) then
        Result := LRegistry.ReadString(AName)
      else
        Result := ADefaultValue;
   end;

   function GetIntegerValue(const AName: string; ADefaultValue: Integer): Integer;
   begin
        if LRegistry.ValueExists(AName) then
          try
            Result := LRegistry.ReadInteger(AName)
          except
            Result := ADefaultValue;
          end
        else
          Result := ADefaultValue;
   end;
   function GetBoolValue(const AName: string; ADefaultValue: Boolean): Boolean;
   begin
      if LRegistry.ValueExists(AName) then
        try
          Result := LRegistry.ReadBool(AName)
        except
          Result := ADefaultValue;
        end
      else
        Result := ADefaultValue;
    end;
begin
  Result := nil;
  LRegistry := TRegistry.Create;
  try
    if LRegistry.OpenKey(ARegistryKey, False) then
    begin
      Result := TProxyGeneratorSettings.Create;
      Result.Host := LRegistry.ReadString(sHost);
      Result.Host := GetStringValue(sHost, '');
      Result.Protocol := GetStringValue(sProtocol, 'tcp/ip');
      Result.Port := GetIntegerValue(sPort, 0);
      Result.URLPath := GetStringValue(sURLPath, '');
      Result.OutputDirectory := GetStringValue(sOutputDirectory, '');
      Result.WriteToFile := GetBoolValue(sWriteToFile, False);
      Result.WriteToMemo := GetBoolValue(sWriteToTextBox, True);
      Result.Writer := GetStringValue(sLanguage, '');
      Result.IncludeClasses := GetStringValue(sIncludeClasses, '');
      Result.IncludeMethods := GetStringValue(sIncludeMethods, '');
      Result.ExcludeClasses := GetStringValue(sExcludeClasses, '');
      Result.ExcludeMethods := GetStringValue(sExcludeMethods, '');
      Result.UnitName := GetStringValue(sUnitName, '');
    end;
  finally
    LRegistry.Free;
  end;
end;

class procedure TProxyGeneratorSettings.SaveSettings(ARegistryKey: String; ASettings: TProxyGeneratorSettings);
var
 LRegistry: TRegistry;
begin
  LRegistry := TRegistry.Create;
  try
    if LRegistry.OpenKey(ARegistryKey, True) then
    begin
      LRegistry.WriteString(sHost, ASettings.Host);
      LRegistry.WriteString(sURLPath, ASettings.URLPath);
      LRegistry.WriteInteger(sPort, ASettings.Port);
      LRegistry.WriteString(sProtocol, ASettings.Protocol);
      LRegistry.WriteString(sIncludeClasses, ASettings.IncludeClasses);
      LRegistry.WriteString(sIncludeMethods, ASettings.IncludeMethods);
      LRegistry.WriteString(sExcludeClasses, ASettings.ExcludeClasses);
      LRegistry.WriteString(sExcludeMethods, ASettings.ExcludeMethods);
      LRegistry.WriteString(sUnitName, ASettings.UnitName);
      LRegistry.WriteBool(sWriteToFile, ASettings.WriteToFile);
      LRegistry.WriteBool(sWriteToTextBox, ASettings.WriteToMemo);
      LRegistry.WriteString(sLanguage, ASettings.Writer);
      LRegistry.WriteString(sOutputDirectory, ASettings.OutputDirectory);
    end;
  finally
    LRegistry.Free;
  end;
end;


end.
