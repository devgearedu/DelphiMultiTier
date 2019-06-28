
//---------------------------------------------------------------------------

// This software is Copyright (c) 2012 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit BindingsConsoleUtils;

interface

uses
  System.Classes, System.SysUtils, System.Bindings.EvalProtocol, System.Bindings.Methods,
  System.Rtti, Generics.Collections, System.Bindings.Outputs,
  System.Bindings.Manager, System.TypInfo;

type

  TObjectWithProperties = class
  private
    FIntegerProp: Integer;
    FDoubleProp: Double;
    FStringProp: string;
    FDateProp: TDate;
    FStrings: TStrings;
    FList: TList<string>;
    FPair: TPair<integer, string>;
    function GetListArrayProp: TArray<string>;   // record
  public
    constructor Create;
    destructor Destroy; override;
    // Test array
    property Pair: TPair<integer, string> read FPair write FPair;
    property List: TList<string> read FList;
    property Strings: TStrings read FStrings;
    property DateProp: TDate read FDateProp write FDateProp;
    property StringProp: string read FStringProp write FStringProp;
    property DoubleProp: Double read FDoubleProp write FDoubleProp;
    property IntegerProp: Integer read FIntegerProp write FIntegerProp;
    // Test record
    property ListArray: TArray<string> read GetListArrayProp;
  end;

  TObjectWithPropertiesAndMethods = class(TObjectWithProperties)
  public
    function AppendString(const AValue: string): string;
    procedure ClearStrings;
    function IncInteger(AValue: Integer): Integer;
  end;

  TTestObject = class(TObjectWithPropertiesAndMethods)
  private
    FChildObject1: TTestObject;
    FChildObject2: TTestObject;
    function GetChildObject1: TTestObject;
    function GetChildObject2: TTestObject;
  public
    destructor Destroy; override;
    property ChildObject1: TTestObject read GetChildObject1;
    property ChildObject2: TTestObject read GetChildObject2;
  end;

  TEventsObject = class
  public
    procedure OnAssignedValue(AssignValueRec: TBindingAssignValueRec;
     var Value: TValue; var Handled: Boolean); virtual;
    procedure OnAssigningValue(AssignValueRec: TBindingAssignValueRec;
     const Value: TValue); virtual;
    procedure OnEvalError(AException: Exception); virtual;
  end;

  TManagerObject = class
  private
    function GetCount: Integer;
  public
    procedure Display;
    procedure Clear;
    property Count: Integer read GetCount;
    procedure Notify(AObject: TObject; const APropName: string);
    procedure NotifyAll;
  end;

procedure DisplayTestObjectLayout(AObject: TTestObject; AUseScopeName: Boolean; const AScopeName: string); forward;
procedure DisplayManagerObjectLayout(AObject: TManagerObject; const AScopeName: string;
  AUseDataObjectScopeName: Boolean; const ADataObjectScopeName: string); forward;
procedure DisplayMethods; forward;
procedure DisplayConverters; forward;
procedure DisplayValue(AValue: IValue; AIndent: Boolean = True); forward; overload;
procedure DisplayValue(AType: PTypeInfo; AValue: TValue; AIndent: Boolean = True); overload; forward;
procedure ClearBindings(AManager: TBindingManager = nil); forward;

implementation

uses StrUtils, System.Bindings.Factories, System.Bindings.Expression,
  System.Bindings.Helper;

procedure DisplayBindings(AManager: TBindingManager = nil); forward;

{ TObjectWithProperties }

constructor TObjectWithProperties.Create;
begin
  FStrings := TStringList.Create;
  FStrings.Text := 'one'#13#10'two'#13#10'three';
  FList := TList<string>.Create;
  FList.AddRange(['one', 'two', 'three']);
  FDateProp := Now;
  FIntegerProp := 1234;
  FDoubleProp := 1234.567;
  FStringProp := 'Hello World!';
  FPair.Key := 5678;
  FPair.Value := 'Pair Value';
end;


function TObjectWithPropertiesAndMethods.AppendString(const AValue: string): string;
begin
  FStringProp := FStringProp + AValue;
  FStrings.Append(AValue);
  FList.Add(AValue);
  Result := FStringProp;
end;

procedure TObjectWithPropertiesAndMethods.ClearStrings;
begin
  FStrings.Clear;
  FList.Clear;
  FStringProp := '';
end;

function TObjectWithPropertiesAndMethods.IncInteger(AValue: Integer): Integer;
begin
  Inc(FIntegerProp, AValue);
  Result := FIntegerProp;
end;

var
  GIndent: string = '';
const
  cIndent = '  ';

procedure Indent;
begin
  GIndent := GIndent + cIndent;
end;

procedure OutDent;
begin
  SetLength(GIndent, Length(GIndent) - Length(cIndent));
end;

procedure Write(const AValue: string);
begin
  WriteLn(GIndent + AValue);
end;

procedure DisplayValue(AValue: IValue; AIndent: Boolean);
begin
  DisplayValue(AValue.GetType, AValue.GetValue, True);
end;

procedure DisplayValue(AType: PTypeInfo; AValue: TValue; AIndent: Boolean);

  // Display values in an enumerable type like TStrings or TList<>
  procedure Enumerate(AObject: TObject; AProc: TProc<TValue>);
  var
    LGetEnumerator: TRttiMethod;
    LMoveNext: TRttiMethod;
    LCurrent: TRttiProperty;
    LArgs: TArray<TValue>;
    LValue: TValue;
    LRttiType: TRttiType;
    LContext: TRttiContext;
    LEnumerator: TObject;
  begin
    LRttiType := LContext.GetType(AObject.ClassType);
    LGetEnumerator := LRttiType.GetMethod('GetEnumerator');
    if Assigned(LGetEnumerator) then
    begin
      LValue := LGetEnumerator.Invoke(AObject, LArgs);
      if LValue.IsObject then
      begin
        LEnumerator := LValue.AsObject;
        LRttiType := LContext.GetType(LEnumerator.ClassType);
        LMoveNext := LRttiType.GetMethod('MoveNext');
        LCurrent := LRttiType.GetProperty('Current');
        if Assigned(LMoveNext) and Assigned(LCurrent) then
        begin
          while True do
          begin
            LValue := LMoveNext.Invoke(LEnumerator, LArgs);
            if LValue.IsType<Boolean>  then
              if not LValue.AsBoolean then
                Exit;
            LValue := LCurrent.GetValue(LEnumerator);
            AProc(LValue);
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
begin
  if AIndent then
    Indent;
  try
  if AValue.IsEmpty then
    Write('Empty')
  else if AValue.IsObject then
  begin
    Write('ClassName: ' + AValue.AsObject.ClassName);
    I := 0;
    Indent;
    try
      Enumerate(AValue.AsObject,
        procedure(AValue: TValue)
        begin
          Write(Format('[%d]', [I]));
          DisplayValue(nil, AValue, True);
          Inc(I);
        end);
    finally
      OutDent;
    end;

  end
  else if AValue.IsArray then
  begin
    Write('Array: ' + AType.Name);
    Indent;
    try
      for I := 0 to AValue.GetArrayLength - 1 do
      begin
        Write(Format('[%d]', [I]));
        DisplayValue(nil, AValue.GetArrayElement(I));
      end;
    finally
      OutDent;
    end;
  end
  else
  begin
    if AType <> nil then
      Write(Format('%s ToString: "%s"', [AType.Name, AValue.ToString]))
    else
      Write(Format('ToString: "%s"', [AValue.ToString]))
  end;
  finally
    if AIndent then
      OutDent;
  end;

end;

procedure DisplayTestObjectLayout(AObject: TTestObject; AUseScopeName: Boolean; const AScopeName: string);
begin
  Write('// Data object to uses in expressions.');
  Write('// Examples: ');
  if AUseScopeName and (AScopeName <> '')then
  begin
    Write(Format('// %s.AppendString("abc") ', [AScopeName]));
    Write(Format('// %s.StringProp', [AScopeName]));
    Write(Format('// %s.Strings.Strings[0]', [AScopeName]));
    Write(Format('// %s.List.Items[0]', [AScopeName]));
    Write(Format('// %s.ClearStrings()', [AScopeName]));
    Write(Format('%s = class', [AObject.ClassName]));
  end
  else
  begin
    Write('// Self.AppendString("abc") ');
    Write('// AppendString(''abc'') ');
    Write('// StringProp');
    Write('// Strings.Strings[0]');
    Write('// List.Items[0]');
    Write('// ClearStrings()');
    Write('%s = class');
  end;
  Write('public');
  Indent;
  try
    Write('function AppendString(S: string); // Append to StringProp, Strings and List');
    Write('procedure ClearStrings; // Clear StringProp, Strings and List');
    Write('procedure IncInteger(I: Integer); // Add to IntegerProp');
    Write('property ListArray: TArray<string>; // List.ToArray ');
    Write('property Pair: TPair<integer, string>; // Record ');
    Write('property List: TList<string> read FList; // Use List.Items[0]');
    Write('property Strings: TStrings read FStrings; // Use Strings.String[0]');
    Write('property DateProp: TDate');
    Write('property StringProp: string');
    Write('property DoubleProp: Double');
    Write('property IntegerProp: Integer');
    Write('property ChildObject1: TTestObject');
    Write('property ChildObject2: TTestObject');
  finally
    OutDent;
  end;
  Write('end');
end;

procedure DisplayManagerObjectLayout(AObject: TManagerObject; const AScopeName: string;
  AUseDataObjectScopeName: Boolean; const ADataObjectScopeName: string);
begin
  Write('// Manager object to uses in expressions.');
  Write('// Examples: ');
  Write(Format('// %s.Display() ', [AScopeName]));
  if AUseDataObjectScopeName and (ADataObjectScopeName <> '') then
  begin
    Write(Format('// %s.Notify(%s, "StringProp")', [AScopeName, ADataObjectScopeName]));
    Write(Format('// %s.Notify(%s, "")', [AScopeName, ADataObjectScopeName]));
  end
  else
  begin
    Write(Format('// %s.Notify(Self, "StringProp")', [AScopeName]));
    Write(Format('// %s.Notify(Self, "")', [AScopeName]));
  end;
  Write(Format('// %s.NotifyAll()', [AScopeName]));
  Write(Format('// %s.Strings[0]', [AScopeName]));
  Write(Format('// %s.ClearStrings()', [AScopeName]));
  Write(Format('%s = class', [AObject.ClassName]));
  Write('public');
  Indent;
  try
    Write('procedure Display; // Display managed bindings');
    Write('procedure Clear;   // Clear managed bindings');
    Write('procedure Notify(const APropName: string); // Notify of property change');
    Write('procedure NotifyAll; // Notify all source objects in all scopes in all expressions');
    Write('property Count: Integer;');
  finally
    OutDent;
  end;
  Write('end');
end;

procedure WriteStrings(AStrings: TStrings);
var
  S: string;
begin
  S := AStrings.DelimitedText;
  S := ReplaceStr(S, AStrings.Delimiter, ', ');
  Write(S);
end;

procedure DisplayMethods;
var
  LDescription: TMethodDescription;
  LStrings: TStringList;
begin
  System.Write(GIndent + 'Global Methods: ');
  LStrings := TStringList.Create;
  try
    for LDescription in TBindingMethodsFactory.GetRegisteredMethods do
      if LDescription.DefaultEnabled then
        LStrings.Add(LDescription.Name)
      else
        LStrings.Add(LDescription.Name + ' (disabled)');
    LStrings.Sort;
    WriteStrings(LStrings);
  finally
    LStrings.Free;
  end;
end;

procedure DisplayConverters;
var
  LDescription: TConverterDescription;
  LStrings: TStringList;
begin
  System.Write(GIndent + 'Output Converters: ');
  LStrings := TStringList.Create;
  try
    for LDescription in TValueRefConverterFactory.GetConverterDescriptions do
      if LDescription.DefaultEnabled then
        LStrings.Add(LDescription.DisplayName)
      else
        LStrings.Add(LDescription.DisplayName + ' (disabled)');
    LStrings.Sort;
    WriteStrings(LStrings);
  finally
    LStrings.Free;
  end;
end;

type
  TBindingExpressionCracker = class(TBindingExpression)

  end;

procedure EnumScopeObjects(AScope: IScope; ACallback: TProc<TObject>);
var
  LScopeEnumerable: IScopeEnumerable;
  LScopeEnumerator: IScopeEnumerator;
  LValue: IValue;
  LScope: IScope;
begin
  if Supports(AScope, IScopeEnumerable, LScopeEnumerable) then
  begin
    LScopeEnumerator := LScopeEnumerable.GetEnumerator;
    while LScopeEnumerator.MoveNext do
      if Supports(LScopeEnumerator.Current, IValue, LValue) then
      begin
        if LValue.GetValue.IsObject then
          ACallback(LValue.GetValue.AsObject);
      end
      else if Supports(LScopeEnumerator.Current, IScope, LScope) then
        EnumScopeObjects(LScope, ACallback);
  end;
end;

// Notify all objects in all input scopes
procedure NotifyAll;
var
  I: Integer;
  LExpression: TBindingExpression;
  LManager: TBindingManager;
  LScope: IScope;
begin
  LManager := TBindingManagerFactory.AppManager;
  for I := 0 to LManager.ExprCount - 1 do
  begin
    LExpression := LManager.Expressions[i];
    for LScope in TBindingExpressionCracker(LExpression).FScopes do
    begin
      EnumScopeObjects(LScope,
        procedure(AObject: TObject)
        begin
          TBindings.Notify(AObject, '');
        end);
    end;
  end;
end;

procedure DisplayBindings(AManager: TBindingManager);
var
  I: Integer;
  LExpression: TBindingExpression;
  LOutputExpr: string;
  LInputExpr: string;
begin
  if AManager = nil then
    AManager := TBindingManagerFactory.AppManager;
  Write(Format('Managed Bindings (%d)', [AManager.ExprCount]));
  Indent;
  try
    for I := 0 to AManager.ExprCount - 1 do
    begin
      LExpression := AManager.Expressions[i];
      LInputExpr := LExpression.Source;
      LOutputExpr := LExpression.Outputs.Destinations.ToArray[0].Value.Value;
      Write(Format('[%d] %s => %s', [I, LInputExpr, LOutputExpr]));
    end;
  finally
    OutDent;
  end;

end;

procedure ClearBindings(AManager: TBindingManager);
begin
  if AManager = nil then
    AManager := TBindingManagerFactory.AppManager;
  AManager.Clear;
end;

destructor TObjectWithProperties.Destroy;
begin
  FList.Free;
  FStrings.Free;
  inherited;
end;

function TObjectWithProperties.GetListArrayProp: TArray<string>;
begin
  Result := FList.ToArray;
end;

{ TTestObject }


destructor TTestObject.Destroy;
begin
  FChildObject1.Free;
  FChildObject2.Free;
  inherited;
end;

function TTestObject.GetChildObject1: TTestObject;
begin
  if FChildObject1 = nil then
    FChildObject1 := TTestObject.Create;
  Result := FChildObject1;
end;

function TTestObject.GetChildObject2: TTestObject;
begin
  if FChildObject2 = nil then
    FChildObject2 := TTestObject.Create;
  Result := FChildObject2;
end;

{ TEventsObject }

procedure TEventsObject.OnAssignedValue(AssignValueRec: TBindingAssignValueRec;
  var Value: TValue; var Handled: Boolean);
begin

end;

procedure TEventsObject.OnEvalError(AException: Exception);
begin

end;

procedure TEventsObject.OnAssigningValue(
  AssignValueRec: TBindingAssignValueRec; const Value: TValue);
var
  LBindingExpression: TBindingExpression;
begin
  Indent;
  try
    LBindingExpression := AssignValueRec.Expression as TBindingExpression;
    Write('Engine is assigning a value');
    Indent;
    try
      Write(Format('Source Expression: %s', [LBindingExpression.Source]));
      DisplayValue(nil, Value, True);
      Write(Format('Out Object: %s', [AssignValueRec.OutObj.ClassName]));
      Write(Format('Out Property: %s', [AssignValueRec.OutProp]));
    finally
      OutDent;
    end;
    WriteLn;
  finally
    OutDent;
  end;
end;

{ TBindingsMethodsObject }

procedure TManagerObject.Clear;
begin
  ClearBindings;
  Write(Format('Managed Bindings (Count: %d)', [TBindingManagerFactory.AppManager.ExprCount]));
end;

procedure TManagerObject.Display;
begin
  DisplayBindings;
end;

function TManagerObject.GetCount: Integer;
begin
  Result := TBindingManagerFactory.AppManager.ExprCount
end;

procedure TManagerObject.Notify(AObject: TObject; const APropName: string);
begin
  TBindings.Notify(AObject, APropName);
end;

procedure TManagerObject.NotifyAll;
begin
  BindingsConsoleUtils.NotifyAll;
end;

end.

