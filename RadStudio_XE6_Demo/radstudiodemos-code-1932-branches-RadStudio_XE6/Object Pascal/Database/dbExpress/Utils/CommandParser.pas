{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Components                                  }
{                                                                             }
// Copyright (c) 1995-2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.
{                                                                             }
{ *************************************************************************** }
unit CommandParser;

interface

uses Classes, SysUtils;

type

  TSwitchType = (stString, stInteger, stDate, stDateTime, stFloat, stBoolean);

  ECommandParser = class(Exception);

  TCommandSwitch = record
    Name: string;
    Kind: TSwitchType;
    Required: boolean;
    Default: string;
    LongName: string;
    PropertyName: string;
    Description: string;
    Value: string;
    function SwitchSyntax(const ADefSwitch: char): string;
    function Syntax(const ADefSwitch, ADefArg: char): string;
    function Assigned: boolean;
    function Named: boolean;
    function Positional: boolean;
    function ParamName: string;
    function Optional: boolean;
    function HasDefault: boolean;
    function CurrentValue: string;
    function HasValue: boolean;
    function HasProperty: boolean;
    procedure SetProperty(const AObject: TPersistent);
    function GetProperty(const AObject: TPersistent): string;
    procedure SetBoolean(const AObject: TPersistent; ATrueVals: string = '');
  end;

  TCommandSwitches = array of TCommandSwitch;

  TCommandParser = class
  private
    FCaseSensitive: boolean;
    FTrueValues: string;
    FArgChars: string;
    FFalseValues: string;
    FSwitchChars: string;
    FSwitches: TCommandSwitches;
    FDefSwitch: char;
    FDescription: string;
    FRaiseErrors: boolean;
    FUnknown: string;
    FToggleChars: string;
    FValidation: string;
    FOwner: TPersistent;
    FArguments: TStrings;
    FEnvArg: string;
    procedure ProcessEnvironment;
    procedure SetSwitchChars(const Value: string);
  protected
    procedure ProcessFile(const AOption: string; const AInsertAt: Integer);
    procedure ProcessOption(const AOption: string);
    procedure FlagUnknown(const AOption: string);
    procedure ShowErrors;
    procedure InsertArguments(const AArgs: TStrings; const AInsertAt: integer);
  public
    property CaseSensitive: boolean read FCaseSensitive write FCaseSensitive
      default False;
    property SwitchChars: string read FSwitchChars write SetSwitchChars;
    property ArgChars: string read FArgChars write FArgChars;
    property ToggleChars: string read FToggleChars write FToggleChars;
    property TrueValues: string read FTrueValues write FTrueValues;
    property FalseValues: string read FFalseValues write FFalseValues;
    property Description: string read FDescription write FDescription;
    property RaiseErrors: boolean read FRaiseErrors write FRaiseErrors
      default True;
    property EnvArg: string read FEnvArg write FEnvArg;
    property Switches: TCommandSwitches read FSwitches write FSwitches;

    constructor Create; overload;
    constructor Create(const ACaseSensitive: boolean;
      ADescription: string = ''; AEnvArg: string = ''); overload;
    constructor Create(const AOwner: TPersistent;
      ACaseSensitive: boolean = false; ADescription: string = '';
      AEnvArg: string = ''); overload;
    destructor Destroy; override;

    function Validate: boolean;
    function ProcessCommandLine(ACommandLine: string = '') : boolean;
    procedure AddSwitch(const AName: string; AKind: TSwitchType = stString;
      ARequired: Boolean = False; ADefault: string = '';
      ADescription: string = ''; ALongName: string = '';
      APropertyName: string = ''); overload;
    procedure AddSwitch(AKind: TSwitchType; ALongName: string;
      ADescription: string = ''; ARequired: Boolean = True;
      ADefault: string = ''; APropertyName: string = ''); overload;
    function Syntax: string;
    function HelpText: string;
    function Options(const ALongNames: Boolean = true): UnicodeString;
    function SaveOptions(const AFileName: UnicodeString;
      const ALongName: Boolean = true): boolean;
    function IndexOf(AOption: string): integer;
    function ArgumentCount: integer;
  end;

procedure ProcessCommandLine(ACommandText: String; ACommandList: TStrings);
function ProcessEnvArgs(const AEnvName: string): TStrings;
function ProcessFileArgs(const AFileName: string): TStrings;

implementation

uses
  PropertyHelpers, Windows;

const
  SValSep = '|';
  SSwitchCharDefaults = '/-';
  SArgCharDefaults = ':=';
  STrueDefaults = '|y|t|on|yes|true|+|';
  SFalseDefaults = '|n|f|off|no|false|-|';
  SToggleDefaults = '+-';
  NL = #13#10;

procedure ProcessCommandLine(ACommandText: String; ACommandList: TStrings);
const
  QuoteSet = ['"',#39];
var
  I: Integer;
  L: Integer;
  LastPos: Integer;
  Temp: String;
  CurChar,
  Quote: char;
  function InQuote: boolean;
  begin
    Result := Quote <> #0;
  end;

begin
  if ACommandList = NIL then
    raise ECommandParser.Create('CommandList is NIL!');

  LastPos := 1;
  Quote := #0;

  I := 1;
  L := Length(ACommandText);
	while I <= L do
  begin
    CurChar := ACommandText[I];
		if CharInSet(CurChar, QuoteSet) then
    begin
      if (CurChar = Quote) then // Implicitly InQuote
        Quote := #0
      else
        Quote := CurChar;
    end
		else if (CharInSet(CurChar, [#10, #13, ' '])) and (not InQuote) then
    begin
			Temp := Trim(Copy(ACommandText, LastPos, I - LastPos));
      if Length(Temp) > 0 then
        ACommandList.Add(Temp);
			LastPos := I + 1;
    end;

    Inc(I);
  end;

	if LastPos < I then
  begin
		Temp := Trim(Copy(ACommandText, LastPos, i - LastPos));
		ACommandList.Add(Temp);
  end;
end;

function ProcessEnvArgs(const AEnvName: string): TStrings;
begin
  Result := TStringList.Create;
  ProcessCommandLine(GetEnvironmentVariable(AEnvName), Result);
end;

function ProcessFileArgs(const AFileName: string): TStrings;
var
  s: string;
begin
  Result := TStringList.Create;
  if not FileExists(AFileName) then
    Raise ECommandParser.CreateFmt('File "%s" was not found', [AFileName]);
  Result.LoadFromFile(AFileName);
  s := Result.Text;
  Result.Clear;
  ProcessCommandLine(s, Result);
end;

{ TCommandSwitch }

function TCommandSwitch.Assigned: boolean;
begin
  Result := Length(Value) > 0;
end;

function TCommandSwitch.CurrentValue: string;
begin
  if Length(Value) > 0 then
    Result := Value
  else
    Result := Default;
end;

function TCommandSwitch.HasDefault: boolean;
begin
  Result := Length(Default) > 0;
end;

function TCommandSwitch.HasProperty: boolean;
begin
  Result := Length(PropertyName) > 0;
end;

function TCommandSwitch.HasValue: boolean;
begin
  Result := Length(CurrentValue) > 0;
end;

function TCommandSwitch.Named: boolean;
begin
  Result := Length(Name) > 0;
end;

function TCommandSwitch.Optional: boolean;
begin
  Result := not Required;
end;

procedure TCommandSwitch.SetBoolean(const AObject: TPersistent;
  ATrueVals: string = '');
var
  toggle: string;
begin
  if HasProperty then
  begin
    if Length(ATrueVals) = 0 then
      ATrueVals := STrueDefaults;
    if Pos(SValSep + LowerCase(CurrentValue) + SValSep,
      LowerCase(ATrueVals)) > 0 then
      toggle := 'true'
    else
      toggle := 'false';
    SetPropertyValue(AObject, PropertyName, toggle, true);
  end;
end;

procedure TCommandSwitch.SetProperty(const AObject: TPersistent);
var
  v: string;
begin
  if HasProperty then
  begin
    v := CurrentValue;
    case Kind of
      stDate:
        SetPropertyValue(AObject, PropertyName, StrToDate(v), true);
      stDateTime:
        SetPropertyValue(AObject, PropertyName, StrToDateTime(v),
          true);
      else
        SetPropertyValue(AObject, PropertyName, v, true);
    end;
  end;
end;

function TCommandSwitch.GetProperty(const AObject: TPersistent): string;
begin
  if HasProperty then
  begin
    Value := GetPropertyValue(AObject, PropertyName, true);
    Result := Value;
  end;
end;

function TCommandSwitch.SwitchSyntax(const ADefSwitch: Char): string;
const
  SOr = ' | ';
  function iif(const Test: boolean; const TrueVal: string;
    const FalseVal: string): string;
  begin
    if Test then
      Result := TrueVal
    else
      Result := FalseVal;
  end;

  function OpenOpt: string;
  begin
    if Optional then
      Result := '['
    else
      Result := '';
  end;

  function CloseOpt: string;
  begin
    if Optional then
      Result := ']'
    else
      Result := '';

  end;
begin
  if Positional then
  begin
    Result := OpenOpt + ParamName + CloseOpt;
  end
  else if Length(LongName) > 0 then
    Result := OpenOpt + ADefSwitch + Name + sOr + ADefSwitch + LongName
      + CloseOpt
  else
    Result := OpenOpt + ADefSwitch + Name + CloseOpt;
end;

function TCommandSwitch.ParamName: string;
begin
  if Length(Name) > 0 then
    Result := Name
  else if Length(LongName) > 0 then
    Result := LongName
  else
    Result := Description;
end;

function TCommandSwitch.Positional: boolean;
begin
  Result := not Named;
end;

function TCommandSwitch.Syntax(const ADefSwitch, ADefArg: char): string;
begin
  Result := SwitchSyntax(ADefSwitch);

  if Length(Description) > 0 then
    Result := Result + ' (' + Description + ')';

  Result := Result + NL;
  
  if Length(Default) > 0 then
    Result := Result + '  Default: ' + Default + NL
      + '  Example: ' + ADefSwitch + Name + ADefArg + Default + NL;

end;

{ TCommandParser }

procedure TCommandParser.AddSwitch(const AName: string;
  AKind: TSwitchType = stString; ARequired: Boolean = False;
  ADefault: string = ''; ADescription: string = ''; ALongName: string = '';
  APropertyName: string = '');
var
  i: integer;
begin
  i := Length(FSwitches);
  SetLength(FSwitches, i + 1);
  // if Name is blank, switch is positional
  if (Length(AName) = 0) and (i>0) and (FSwitches[i-1].Named) then
    Raise ECommandParser.Create(
      'Positional switches must be declared before named switches');

  FSwitches[i].Name := AName;
  FSwitches[i].Kind := AKind;
  FSwitches[i].Required := ARequired;
  FSwitches[i].Default := ADefault;
  FSwitches[i].Description := ADescription;
  FSwitches[i].LongName := ALongName;
  FSwitches[i].PropertyName := APropertyName;
end;

procedure TCommandParser.AddSwitch(AKind: TSwitchType; ALongName,
  ADescription: string; ARequired: Boolean; ADefault, APropertyName: string);
begin
  AddSwitch('', AKind, ARequired, ADefault, ADescription, ALongName,
    APropertyName);
end;

function TCommandParser.ArgumentCount: integer;
begin
  Result := FArguments.Count;
end;

procedure TCommandParser.ProcessFile(const AOption: string;
  const AInsertAt: Integer);
var
  NewArgs: TStrings;
begin
  // Add arguments in the file
  NewArgs := ProcessFileArgs(AOption);
  try
    InsertArguments(NewArgs, AInsertAt);
  finally
    FreeAndNil(NewArgs);
  end;
end;

procedure TCommandParser.ProcessEnvironment;
var
  NewArgs: TStrings;
begin
  if Length(FEnvArg) > 0 then
  // process environment variables
  begin
    NewArgs := ProcessEnvArgs(FEnvArg);
    try
      // Put these arguments first so they can be overridden with subsequent
      // switch value assignments
      InsertArguments(NewArgs, 0);
    finally
      FreeAndNil(NewArgs);
    end;
  end;
end;

constructor TCommandParser.Create(const AOwner: TPersistent;
  ACaseSensitive: boolean = False; ADescription: string = '';
  AEnvArg: string = '');
begin
  Create(ACaseSensitive, ADescription, AEnvArg);
  FOwner := AOwner;
end;

constructor TCommandParser.Create(const ACaseSensitive: boolean;
  ADescription: string = ''; AEnvArg: string = '');
begin
  Create;
  FCaseSensitive := ACaseSensitive;
  FDescription := ADescription;
  FEnvArg := AEnvArg;
end;

constructor TCommandParser.Create;
begin
  inherited;
  FCaseSensitive := False;
  SetSwitchChars(SSwitchCharDefaults);
  FArgChars := SArgCharDefaults;
  FToggleChars := SToggleDefaults;
  FTrueValues := STrueDefaults;
  FFalseValues := SFalseDefaults;
  FRaiseErrors := False;
  SetLength(FSwitches, 0);
  FArguments := TStringList.Create;
end;

destructor TCommandParser.Destroy;
begin
  // Don't think there's anything to destroy yet, but does the voodoo
  // about setting dynamic array length to zero explicitly matter?
  SetLength(FSwitches, 0);
  FreeAndNil(FArguments);
  inherited;
end;

function TCommandParser.IndexOf(AOption: string): integer;
var
  i: integer;
  switch: TCommandSwitch;
begin
  if FCaseSensitive then
  begin
    for i := 0 to Length(FSwitches) - 1 do
    begin
      Switch := FSwitches[i];
      if (AOption = Switch.Name)
        or ((Length(Switch.LongName) > 0) and (AOption = Switch.Name)) then
      begin
        Result := i;
        exit;
      end;
    end;
  end
  else
  begin
    for i := 0 to Length(FSwitches) - 1 do
    begin
      Switch := FSwitches[i];
      if SameText(AOption,Switch.Name) or ((Length(Switch.LongName) > 0)
        and SameText(AOption, Switch.LongName)) then
      begin
        Result := i;
        exit;
      end;
    end;

  end;
  Result := -1;
end;

procedure TCommandParser.InsertArguments(const AArgs: TStrings;
  const AInsertAt: integer);
var
  I: integer;
begin
  if AInsertAt >= Argumentcount then
    for I := 0 to AArgs.Count - 1 do
      FArguments.Add(AArgs[i])
  else
    for I := 0 to AArgs.Count - 1 do
      FArguments.Insert(AInsertAt + I, AArgs[i]);
end;

function TCommandParser.Options(const ALongNames: Boolean = True): UnicodeString;
var
  switch: TCommandSwitch;
begin
  Result := '';
  if ALongNames then
    for switch in FSwitches do
    begin
      Switch.GetProperty(FOwner);
      if Length(Switch.CurrentValue) > 0 then
        if ALongNames then
          Result := Result + FDefSwitch + Switch.LongName + '='
            + Switch.CurrentValue + NL
        else
          Result := Result + FDefSwitch + Switch.Name + '='
            + Switch.CurrentValue + NL;
    end;
end;

procedure TCommandParser.FlagUnknown(const AOption: string);
begin
  FUnknown := FUnknown + AOption + NL;
end;

function TCommandParser.HelpText: string;
begin
  Result := '';
  if (Length(FValidation) > 0) then
    Result := FValidation + NL;
  if (Length(FUnknown) > 0) then
    Result := 'Unrecognized options:' + NL + FUnknown + NL;
  Result := Result + Syntax;

end;

function TCommandParser.ProcessCommandLine(ACommandLine: string = ''): boolean;
var
  LoadCommandLine: boolean;
  SwitchCount,
  i: integer;
  option: string;
begin
  FUnknown := '';
  LoadCommandLine := Length(ACommandLine) = 0;
  if LoadCommandLine then
    ACommandLine := GetCommandLine;
  SwitchCount := Length(FSwitches);
  FArguments.Clear;
  CommandParser.ProcessCommandLine(ACommandLine, FArguments);
  if LoadCommandLine then
    // Get rid of executable name
    FArguments.Delete(0);
  ProcessEnvironment;
  i := 0;
  while i < ArgumentCount do
  begin
    option := FArguments[i];
    if option[1] = '@' then // Process a file
    begin
      // Replace file argument in argument list to retain positional switches
      FArguments.Delete(i);
      ProcessFile(Copy(option, 2), i);
    end
    else if (i < SwitchCount) and FSwitches[i].Positional then
    begin
      { TODO : Answer question: If positional argument looks like it's a switch,
should an exception be raised? }
      FSwitches[i].Value := option;
      Inc(i);
    end
    else
    begin
      ProcessOption(option);
      Inc(i);
    end;
  end;
  Result := Validate;
  if (not Result) and RaiseErrors then
    ShowErrors;

end;

procedure TCommandParser.ProcessOption(const AOption: string);
var
  i, j,
  ArgPos: integer;
  Opt,
  ArgValue: string;
begin
  Opt := AOption;
  if Pos(Opt[1], FSwitchChars) = 0 then
    FlagUnknown(AOption)
  else
  begin
    Opt := Copy(Opt, 2);
    ArgValue := '';
    ArgPos := 0;
    // Look for argument specifier
    j := Length(FArgChars);
    for i := 1 to j do
    begin
      ArgPos := Pos(FArgChars[i], Opt);
      if ArgPos > 1 then
        break; // found ArgPos
    end;

    if ArgPos > 1 then // found a value
    begin
      ArgValue := Copy(Opt, ArgPos + 1);
      Opt := Copy(Opt, 1, ArgPos - 1);
    end
    else
    begin
      j := Length(Opt);
      if Pos(Opt[j], FToggleChars) > 0 then // Found a toggle
      begin
        ArgValue := Opt[j];
        Opt := Copy(Opt, 1, j - 1);
      end;
    end;
    i := IndexOf(Opt);
    if i < 0 then
      FlagUnknown(AOption)
    else
    begin
      if Length(ArgValue) > 0 then
        FSwitches[i].Value := ArgValue
      else if Length(FSwitches[i].Default) > 0 then
        FSwitches[i].Value := FSwitches[i].Default;
    end;
  end;
end;

function TCommandParser.SaveOptions(const AFileName: UnicodeString;
  const ALongName: Boolean): boolean;
var
  Output: TStrings;
begin
  Output := TStringList.Create;
  try
    try
      Output.Text := Options(ALongName);
      Output.SaveToFile(AFileName);
      Result := True;
    except
      Result := False;
      Raise;
    end;
  finally
    FreeAndNil(Output);
  end;
end;

procedure TCommandParser.SetSwitchChars(const Value: string);
begin
  FSwitchChars := Value;
  if Length(FSwitchChars) > 0 then
    FDefSwitch := FSwitchChars[1]
  else
    FDefSwitch := '/';

end;

procedure TCommandParser.ShowErrors;
begin
  if Length(FValidation + FUnknown) > 0 then
    Raise ECommandParser.Create(HelpText);
end;

function TCommandParser.Syntax: string;
const
  SIndent = '  ';
  SSyntax = 'Syntax:' + NL;
var
  switch: TCommandSwitch;
  defarg: char;
begin
  if Length(FDescription) > 0 then
    Result := FDescription + NL + SSyntax
  else
    Result := SSyntax;

  defarg := FArgChars[1];
  Result := Result + SIndent +ExtractFileName( ParamStr(0) );
  for switch in FSwitches do
    Result := Result + ' ' + Switch.SwitchSyntax(FDefSwitch);

  Result := Result + NL + 'Parameters:' + NL;
  for switch in FSwitches do
    Result := Result + SIndent + Switch.Syntax(FDefsWitch, defarg);

end;

function TCommandParser.Validate;
var
  switch: TCommandSwitch;
  TestInt: int64;
  TestFloat: Double;
  TestDate: TDateTime;

  procedure BadFormat(AParam, AValue, AType: string);
  begin
    FValidation := FValidation + 'Invalid format for "' + AParam
      + '". Expected ' + AType + ' and got "' + AValue + '"' + NL;
  end;

begin
  if ArgumentCount = 0 then
  begin
    Result := True;
    exit;
  end;
  FValidation := '';
  for switch in FSwitches do
  begin
    if Switch.Required and not Switch.Assigned then
      FValidation := FValidation + Format('Switch "%s" is required'+ NL,
        [Switch.ParamName])
    else if Switch.Assigned then
      case Switch.Kind of
        stString: Switch.SetProperty(FOwner);
        stInteger:
          if not TryStrToInt64(Switch.CurrentValue, TestInt) then
            BadFormat(Switch.ParamName, Switch.CurrentValue, 'integer')
          else
            Switch.SetProperty(FOwner);

        stDate:
          if not TryStrToDate(Switch.CurrentValue, TestDate) then
            BadFormat(Switch.ParamName, Switch.CurrentValue, 'date')
          else
            Switch.SetProperty(FOwner);

        stDateTime:
          if not TryStrToDateTime(Switch.CurrentValue, TestDate) then
            BadFormat(Switch.ParamName, Switch.CurrentValue, 'datetime')
          else
            Switch.SetProperty(FOwner);

        stFloat:
          if not TryStrToFloat(Switch.CurrentValue, TestFloat) then
            BadFormat(Switch.ParamName, Switch.CurrentValue, 'float')
          else
            Switch.SetProperty(FOwner);

        stBoolean:
          if Pos(SValSep + LowerCase(Switch.CurrentValue) + SValSep,
            FFalseValues + FTrueValues) = 0 then
            BadFormat(Switch.ParamName, Switch.CurrentValue, 'boolean')
          else
            Switch.SetBoolean(FOwner, FTrueValues);

      end;
  end;
  Result := Length(FValidation + FUnknown) = 0;
end;

end.
