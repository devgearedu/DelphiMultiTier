
//---------------------------------------------------------------------------

// This software is Copyright (c) 2012 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit BindingsConsoleCustom;

interface

procedure RegisterCustomMethods;
procedure RegisterCustomConverters;

implementation

uses System.Bindings.Factories, System.Bindings.Expression, System.Bindings.Outputs,
  System.Bindings.Helper, System.StrUtils, System.Bindings.Consts, System.Rtti,
  System.Classes, System.SysUtils, System.Bindings.EvalProtocol, System.Bindings.Methods;


procedure RegisterCustomMethods;
  function MakeReverseString: IInvokable;
  begin
    Result := MakeInvokable(function(Args: TArray<IValue>): IValue
    var
      v: IValue;
    begin
      if Length(Args) <> 1 then
        raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [1, Length(Args)]));
      v := Args[0];
      if v.GetValue.IsEmpty then
        Exit(TValueWrapper.Create(nil))
      else
        Exit(TValueWrapper.Create(ReverseString(v.GetValue.AsString)));
    end);
  end;
const
  cReverseString = 'CustomReverseString';
begin
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeReverseString,
      cReverseString,
      cReverseString, '', True,
      '',
      nil));
end;

procedure RegisterCustomConverters;
const
  cFloatToInt = 'CustomFloatToInt';
begin
  // Convert float types to integer
  TValueRefConverterFactory.RegisterConversion(
  [TypeInfo(Extended), TypeInfo(Single), TypeInfo(Double)],
  [TypeInfo(Integer), TypeInfo(Int64)],
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
      begin
        O := Round(I.AsExtended);
      end,
      cFloatToInt,
      cFloatToInt,
      '', True, '', nil)
  );
end;

end.

