
//---------------------------------------------------------------------------

// This software is Copyright (c) 2012 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// LiveBindings Sample Project
// Managed Expressions
program SimpleManagedBindingsConsole;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.Bindings.EvalProtocol,
  System.Bindings.EvalSys,
  System.Bindings.Expression,
  System.Bindings.Methods,
  System.Bindings.ObjEval,
  System.Bindings.Helper,
  System.Bindings.Outputs,
  System.Bindings.Consts,
  System.Bindings.Manager,
  System.Bindings.Factories,
  System.StrUtils,
  System.Rtti,
  System.TypInfo,
  Generics.Collections;

// Write an expression evaluation value to the console
procedure DisplayValue(AType: PTypeInfo; AValue: TValue);
begin
  if AValue.IsEmpty then
    WriteLn('Empty')
  else
  begin
    if AValue.IsObject then
      WriteLn(Format('ClassName: %s', [AValue.AsObject.ClassName]))
    else
      try
        if AType <> nil then
          WriteLn(Format('%s ToString: "%s"', [AType.Name, AValue.ToString]))
        else
          WriteLn(Format('ToString: "%s"', [AValue.ToString]))
      except
        on E: Exception do
          Writeln(E.ClassName, ': ', E.Message);
      end;
  end;
end;

// Write registered methods to the console
procedure DisplayMethods;
var
  LDescription: TMethodDescription;
  LStrings: TStringList;
begin
  LStrings := TStringList.Create;
  try
    for LDescription in TBindingMethodsFactory.GetRegisteredMethods do
      if LDescription.DefaultEnabled then
        LStrings.Add(LDescription.Name)
      else
        LStrings.Add(LDescription.Name + ' (disabled)');
    LStrings.Sort;
    WriteLn('Methods: ', ReplaceStr(LStrings.DelimitedText, LStrings.Delimiter, ', '));
    WriteLn;
  finally
    LStrings.Free;
  end;
end;


// Write registered output converters to the console
procedure DisplayConverters;
var
  LDescription: TConverterDescription;
  LStrings: TStringList;
begin
  LStrings := TStringList.Create;
  try
    for LDescription in TValueRefConverterFactory.GetConverterDescriptions do
      if LDescription.DefaultEnabled then
        LStrings.Add(LDescription.DisplayName)
      else
        LStrings.Add(LDescription.DisplayName + ' (disabled)');
    LStrings.Sort;
    WriteLn('Converters: ', ReplaceStr(LStrings.DelimitedText, LStrings.Delimiter, ', '));
    WriteLn;
  finally
    LStrings.Free;
  end;

end;

type
  // Provide some properties and methods to use with expressions
  TTestObject = class
  private
    FStringProp: string;
    FIntegerProp: Integer;
    FDoubleProp: Double;
    FStrings: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    function IncInteger(I: Integer): Integer;
    property Strings: TStrings read FStrings;
    property StringProp: string read FStringProp write FStringProp;
    property IntegerProp: Integer read FIntegerProp write FIntegerProp;
    property DoubleProp: Double read FDoubleProp write FDoubleProp;
  end;

constructor TTestObject.Create;
begin
  FStrings := TStringList.Create;
  FStringProp := 'Hello World!';
  FIntegerProp := 1234;
  FDoubleProp := 56.789;
end;

destructor TTestObject.Destroy;
begin
  FStrings.Free;
  inherited;
end;

function TTestObject.IncInteger(I: Integer): Integer;
begin
  Inc(FIntegerProp, I);
  Result := FIntegerProp;
end;

type
  // Provide methods to display, clear and notify managed bindings
  TManagerObject = class
  private
    function GetCount: Integer;
  public
    procedure Display;
    procedure Clear;
    property Count: Integer read GetCount;
    procedure Notify(AObject: TObject; const APropName: string);
  end;

procedure TManagerObject.Clear;
var
  LManager: TBindingManager;
begin
  LManager := TBindingManagerFactory.AppManager;
  LManager.Clear;
  WriteLn(Format('Managed Bindings have been cleared)', [LManager.ExprCount]));
  WriteLn;
end;

procedure TManagerObject.Display;
var
  I: Integer;
  LExpression: TBindingExpression;
  LOutputExpr: string;
  LInputExpr: string;
  LManager: TBindingManager;
begin
  LManager := TBindingManagerFactory.AppManager;
  WriteLn(Format('Managed Bindings (%d)', [LManager.ExprCount]));
  for I := 0 to LManager.ExprCount - 1 do
  begin
    LExpression := LManager.Expressions[i];
    LInputExpr := LExpression.Source;
    LOutputExpr := LExpression.Outputs.Destinations.ToArray[0].Value.Value;
    WriteLn(Format('[%d] %s => %s', [I, LInputExpr, LOutputExpr]));
  end;
end;

function TManagerObject.GetCount: Integer;
begin
  Result := TBindingManagerFactory.AppManager.ExprCount;
end;

procedure TManagerObject.Notify(AObject: TObject; const APropName: string);
begin
  TBindings.Notify(AObject, APropName);
end;

type
  // Monitor binding engine events such as OnAssigningValue
  TEventsObject = class
  public
    procedure OnAssignedValue(AssignValueRec: TBindingAssignValueRec;
     var Value: TValue; var Handled: Boolean); virtual;
    procedure OnAssigningValue(AssignValueRec: TBindingAssignValueRec;
     const Value: TValue); virtual;
    procedure OnEvalError(AException: Exception); virtual;
  end;

{ TEventsObject }

procedure TEventsObject.OnAssignedValue(
  AssignValueRec: TBindingAssignValueRec; var Value: TValue;
  var Handled: Boolean);
begin
end;

procedure TEventsObject.OnAssigningValue(
  AssignValueRec: TBindingAssignValueRec; const Value: TValue);
var
  LBindingExpression: TBindingExpression;
begin
  LBindingExpression := AssignValueRec.Expression as TBindingExpression;
  WriteLn('Engine is assigning a value');
  WriteLn(Format('  Source: %s', [LBindingExpression.Source]));
  Write('  Value ');
  DisplayValue(nil, Value);
  WriteLn(Format('  Out Object: %s', [AssignValueRec.OutObj.ClassName]));
  WriteLn(Format('  Out Property: %s', [AssignValueRec.OutProp]));
  WriteLn;
end;

procedure TEventsObject.OnEvalError(AException: Exception);
begin
end;

procedure ProcessExpressions;
  function PromptQuit: Boolean;
  var
    LInput: string;
  begin
    while True do
    begin
      System.Write('Quit (y/n)? ');
      ReadLn(LInput);
      if Length(LInput) > 0 then
        case LInput[1] of
          'y', 'Y': Exit(True);
          'n', 'N': Exit(False);
        end;
    end;
  end;

var
  LInputExpr: string;
  LOutputExpr: string;
  LBindingExpression: TBindingExpression;
  LScope: IScope;
  LTestObject: TObject;
  LManagerObject: TObject;
  LEventsObject: TEventsObject;
  LValue: IValue;
begin
  LTestObject := nil;
  LManagerObject := nil;
  LEventsObject := nil;
  // Create test object
  LTestObject := TTestObject.Create;
  WriteLn(Format('Object class: %s', [LTestObject.ClassName]));
  // Create object to display, clear and notify managed bindings
  LManagerObject := TManagerObject.Create;
  // Create object to monitor engine events
  LEventsObject := TEventsObject.Create;
  try
    while True do
    begin
      try
        // Get input expression
        System.Write('Input expression: ');
        ReadLn(LInputExpr);
        if LInputExpr = '' then
          if PromptQuit then
            Exit
          else
            Continue;

        // Get output expression
        System.Write('Output expression: ');
        ReadLn(LOutputExpr);

        // Create empty scope
        LScope := TDictionaryScope.Create;
        // Add object with methods to display, clean and notify managed bindings
        TDictionaryScope(LScope).Map.Add('Manager', WrapObject(LManagerObject));
//        // Map object to a name
//        TDictionaryScope(LScope).Map.Add('TestObject', WrapObject(LTestObject));
        // Or, Create "Self" scope
        LScope := TNestedScope.Create(WrapObject(LTestObject), LScope);
        // Add registered global methods to the scope
        LScope := TNestedScope.Create(LScope, TBindingMethodsFactory.GetMethodScope);

        if LOutputExpr = '' then
        begin
          WriteLn(Format('Evaluating Expression: "%s"', [LInputExpr]));
          WriteLn;
          // Evaluate input expression
          LBindingExpression := TBindings.CreateExpression(
            LScope,
            LInputExpr);
          try
            LValue := LBindingExpression.Evaluate;
            if not LValue.GetValue.IsEmpty then
              DisplayValue(LValue.GetType, LValue.GetValue);
          finally
            LBindingExpression.Free;
          end;
        end
        else
        begin
          WriteLn(Format('Adding binding: "%s => %s"', [LInputExpr, LOutputExpr]));
          WriteLn;
          // Create managed binding with input and output expressions
          LBindingExpression := TBindings.CreateManagedBinding(
            LScope,
            LInputExpr,
            LScope,  // Output scope same as input
            LOutputExpr,
            nil,    // Use default output converters
            TBindingEventRec.Create(LEventsObject.OnEvalError, // Monitor assignments
                   LEventsObject.OnAssignedValue, LEventsObject.OnAssigningValue)
            );
          try
            LValue := LBindingExpression.Evaluate;
          except
            LBindingExpression.Free; // Delete if can't evaluate
            raise;
          end;
          WriteLn(Format('Result of binding: "%s => %s"', [LInputExpr, LOutputExpr]));
          DisplayValue(LValue.GetType, LValue.GetValue);
        end
      except
        on E: Exception do
          Writeln(E.ClassName, ': ', E.Message);
      end;
      WriteLn;
    end;
  finally
    LScope := nil;
    LManagerObject.Free;
    LTestObject.Free;
    LEventsObject.Free;
  end;
end;

begin
  try
    // Display registered methods
    DisplayMethods;
    // Display output converters
    DisplayConverters;
    // Prompt for expression strings and evaluate
    ProcessExpressions;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
