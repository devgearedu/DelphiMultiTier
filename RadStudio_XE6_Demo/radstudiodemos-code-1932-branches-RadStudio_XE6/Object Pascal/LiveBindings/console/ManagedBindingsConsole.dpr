
//---------------------------------------------------------------------------

// This software is Copyright (c) 2012 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program ManagedBindingsConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Bindings.EvalProtocol,
  System.Bindings.EvalSys,
  System.Bindings.Expression,
  System.Bindings.Methods,
  System.Bindings.ObjEval,
  System.Bindings.Helper,
  System.Bindings.Outputs,
  System.Bindings.Consts,
  System.StrUtils,
  System.Rtti,
  Generics.Collections,
  BindingsConsoleCustom in 'BindingsConsoleCustom.pas',
  BindingsConsoleUtils in 'BindingsConsoleUtils.pas';

type
  TOption = (optNamedObject, optUseMethods, optUseConverters, optCustomConverters, optCustomMethods);
  TOptions = set of TOption;
const
  cAllOptions = [optNamedObject, optUseMethods, optUseConverters, optCustomConverters, optCustomMethods];
  cDefaultOptions = [optUseMethods, optUseConverters];
  cTestObjectName = 'TestObject';
  cManagerObjectName = 'Manager';
var
  // Options
  GOptions: TOptions = cDefaultOptions;
  GTestObject: TTestObject;
  GManagerObject: TManagerObject;
  GEventsObject: TEventsObject;

procedure ProcessExpressions;

  procedure DisplayInfo;
  begin
    DisplayTestObjectLayout(GTestObject, (optNamedObject in GOptions), cTestObjectName);
    WriteLn;
    DisplayManagerObjectLayout(GManagerObject, cManagerObjectName, (optNamedObject in GOptions), cTestObjectName);
    WriteLn;
    if optUseMethods in GOptions then
    begin
      DisplayMethods;
      WriteLn;
    end;
    if optUseConverters in GOptions then
    begin
      DisplayConverters;
      WriteLn;
    end
  end;

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
  LValue: IValue;
  LScope: IScope;
  LOutputSuffix: string;
  LConverters: IValueRefConverter;
begin
  DisplayInfo;
  LOutputSuffix := ' (optional): ';
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
        // Create object scope
        if optNamedObject in GOptions then
          // Create dictionary scope
          LScope := TBindings.CreateAssociationScope(
              [Associate(GTestObject, cTestObjectName)])
        else
          LScope := WrapObject(GTestObject);
        // Add 'Bindings' object to scope in order to Display, Clear, and Notify
        LScope := TNestedScope.Create(LScope,
          TBindings.CreateAssociationScope([Associate(GManagerObject, cManagerObjectName)]));
        if optUseMethods in GOptions then
          // Add global methods to scope
          LScope := TNestedScope.Create(LScope, TBindingMethodsFactory.GetMethodScope);
        // Get optional output expression
        System.Write('Output expression' + LOutputSuffix);
        LOutputSuffix := ': ';
        ReadLn(LOutputExpr);
        if LOutputExpr = '' then
        begin
          // Evaluate input expression only
          WriteLn(Format('Eval Expression: "%s"', [LInputExpr]));
          WriteLn;
          LBindingExpression := TBindings.CreateExpression(
            LScope,
            LInputExpr);
          try
            LValue := LBindingExpression.Evaluate;
            if LValue.GetType <> nil then
              DisplayValue(LValue);
          finally
            LBindingExpression.Free;
          end;
        end
        else
        begin
          // Create managed binding with input and output expressions

          // Setup output converters
          if optUseConverters in GOptions then
            LConverters := nil // Default to all converters
          else
            LConverters := TValueRefConverter.Create; // No converters
          WriteLn(Format('Eval Expression: "%s => %s"', [LInputExpr, LOutputExpr]));
          WriteLn;
          // Create managed binding and evaluate
          LBindingExpression := TBindings.CreateManagedBinding(
            LScope,
            LInputExpr,
            LScope,  // Output scope same as input
            LOutputExpr,
            LConverters,
            // Monitor assignments
            TBindingEventRec.Create(GEventsObject.OnEvalError,
                   GEventsObject.OnAssignedValue, GEventsObject.OnAssigningValue),
            nil   // Use default manager
            );
          try
            LValue := LBindingExpression.Evaluate;
            DisplayValue(LValue);
          except
            // If evaluation failed, delete the binding
            LBindingExpression.Free;
            raise;
          end;
        end
      except
        on E: Exception do
          Writeln(E.ClassName, ': ', E.Message);
      end;
      WriteLn;
    end;
  finally
    LScope := nil;
  end;
end;


const
  sCustomMethodsDescription = 'Register custom methods %s';
  sCustomConvertersDescription = 'Register custom output converters %s';
  sNamedObjectDescription = 'When creating the scope, associate the test object with a name %s';
  sUseMethodsDescription = 'Use global methods %s';
  sUseConvertersDescription = 'Use output converters %s';
  sAllOptionsDescription = 'Enable all options';
  sNoOptionsDescription = 'Disable all options';
  sDefault = '(default)';

  sCustomMethods = 'custommethods';
  sCustomConverters = 'customconverters';
  sNamedObject = 'namedobject';
  sUseMethods = 'usemethods';
  sUseConverters = 'useconverters';
  sAllOptions = 'alloptions';
  sNoOptions = 'nooptions';

type
  TOptionInfo = record
    FOption: TOption;
    FProc: TProc;
    FDescription: string;
  end;

function ProcessParams: Boolean;
var
  LDict: TDictionary<string, TOptionInfo>;

  procedure DictAdd(const AOptionName, AOptionDescription: string; AOption: TOption); overload;
  var
    LOptionInfo: TOptionInfo;
  begin
    LOptionInfo.FOption := AOption;
    if AOption in cDefaultOptions  then
      LOptionInfo.FDescription := Format(AOptionDescription, [sDefault])
    else
      LOptionInfo.FDescription := Format(AOptionDescription, ['']);
    LOptionInfo.FProc := procedure begin Include(GOptions, AOption) end;
    LDict.Add(AOptionName, LOptionInfo);
  end;

  procedure DictAdd(const AOptionName, AOptionDescription: string; AProc: TProc); overload;
  var
    LOptionInfo: TOptionInfo;
  begin
    LOptionInfo.FDescription := AOptionDescription;
    LOptionInfo.FProc := AProc;
    LDict.Add(AOptionName, LOptionInfo);
  end;
var
  I: Integer;
  LOptionInfo: TOptionInfo;
  LPair: TPair<string, TOptionInfo>;
begin
  Result := True;
  LDict := TDictionary<string, TOptionInfo>.Create;
  try
    DictAdd(sCustomMethods, sCustomMethodsDescription, optCustomMethods);
    DictAdd(sCustomConverters, sCustomConvertersDescription, optCustomConverters);
    DictAdd(sNamedObject, sNamedObjectDescription, optNamedObject);
    DictAdd(sUseMethods, sUseMethodsDescription, optUseMethods);
    DictAdd(sUseConverters, sUseConvertersDescription, optUseConverters);
    DictAdd(sAllOptions, sAllOptionsDescription, procedure begin GOptions := cAllOptions end);
    DictAdd(sNoOptions, sNoOptionsDescription, procedure begin GOptions := [] end);
    for I := 1 to ParamCount do
    begin
      if LDict.TryGetValue(LowerCase(ParamStr(I)), LOptionInfo) then
        LOptionInfo.FProc()
      else
      begin
        WriteLn('Command line options:');
        for LPair in LDict do
          WriteLn(Format('%s - %s', [LPair.Key, LPair.Value.FDescription]));
        Result := False;
        ReadLn;
      end;
    end;
  finally
    LDict.Free;
  end;
end;

begin
  GTestObject := TTestObject.Create;
  GEventsObject := TEventsObject.Create;  // Monitor assignments
  GManagerObject := TManagerObject.Create;  // Methods to Display, Clear, Notify bindings
  try
    if not ProcessParams then
      Exit;
    if optCustomMethods in GOptions then
      RegisterCustomMethods;
    if optCustomConverters in GOptions then
      RegisterCustomConverters;
    ProcessExpressions;
  finally
    ClearBindings;
    GTestObject.Free;
    GEventsObject.Free;
    GManagerObject.Free;
  end;

end.
