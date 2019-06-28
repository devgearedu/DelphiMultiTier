
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ValField;

interface
uses
  Classes, DB;

type

  {$REGION 'Anonymous function for getting the value of a TValueField object'}
  ///	<summary>Anonymous function for getting the value of a <c>TValueField</c>
  ///	object</summary>
  ///	<param name="Sender">The instance of the object making the call</param>
  {$ENDREGION}
  TGetValueField = reference to function(Sender: TObject): Variant;

  {$REGION 'Anonymous method for setting the value of a TValueField object'}
  ///	<summary>Anonymous method for setting the value of a <c>TValueField</c>
  ///	object</summary>
  ///	<param name="Sender">The instance of the object making the call</param>
  ///	<param name="Value">Value to assign</param>
  {$ENDREGION}
  TSetValueField = reference to procedure(Sender: TObject; Value: Variant);

  ///	<summary><c>TField</c> descendant that can be used for virtual
  ///	fields</summary>
  TValueField = class(TField)
  private
    FGetValueFunc: TGetValueField;
    FSetValueProc: TSetValueField;
    FValue: Variant;
    FValueDataSet: TDataSet;
  protected

    ///	<summary>Retrieves the value of the instance by using the anonymous
    ///	getter method if set, or simply returning the assigned <c>Variant</c>
    ///	value for the field</summary>
    function GetAsVariant: Variant; override;

    function GetAsString: string; override;

    ///	<summary>Uses the anonymous setter method if it is assigned, or just
    ///	assigns the value of the introduced <c>Variant</c></summary>
    ///	<param name="Value">Value to assign</param>
    procedure SetAsVariant(const Value: Variant); override;

    {$REGION 'Overrides the default getter for the DataSet property to use the simplifi...'}
    ///	<summary>Overrides the default getter for the DataSet property to use
    ///	the simplified accessor required by <c>TValueField</c></summary>
    ///	<remarks><c>FDataSet</c> is private to <c>TField</c>, so we need to
    ///	override its setter and introduce a new variable</remarks>
    {$ENDREGION}
    function GetDataSet: TDataSet;

    {$REGION 'Overrides default setter for the DataSet property to use the simplified o...'}
    ///	<summary>Overrides default setter for the DataSet property to use the
    ///	simplified one required by <c>TValueField</c></summary>
    ///	<param name="Value">DataSet to assign</param>
    ///	<remarks>Since <c>FDataSet</c> is private to <c>TField</c> and not
    ///	available here, we have to introduce <c>FValueDataSet</c>
    ///	instead.</remarks>
    {$ENDREGION}
    procedure SetDataSet(ADataSet: TDataSet); override;
  public

    ///	<summary>Reintroduces the DataSet property so GetDataSet is used to
    ///	access it</summary>
    property DataSet read GetDataSet write SetDataSet stored False;

    ///	<summary>Property accessor for the anonymous getter method for the
    ///	value</summary>
    property GetValueFunc: TGetValueField read FGetValueFunc write FGetValueFunc;

    ///	<summary>Property accessor for the anonymous setter method</summary>
    property SetValueProc: TSetValueField read FSetValueProc write FSetValueProc;

    {$REGION 'Overloaded class function to create a "default" field if the named field ...'}
    ///	<summary>Overloaded class function to create a "default" field if the
    ///	named field is not found in the passed DataSet</summary>
    ///	<param name="ADataSet">DataSet to search for the named field</param>
    ///	<param name="AName">Name of the field to find</param>
    ///	<param name="AOwner">Optional. Owner of the created <c>TValueField</c>,
    ///	if one is indeed created. Defaults to <c>nil</c>.</param>
    ///	<remarks>
    ///	  <para>This class can be used to assign a default constant value for
    ///	  <c>TField.Value</c> when the requested field may not exist in the
    ///	  active <c>TDataSet</c>.</para>
    ///	  <para>This overload sets the default constant value to an empty
    ///	  string.</para>
    ///	  <note type="caller">If no owner is assigned, the object returned by
    ///	  this function must be freed in the calling code.</note>
    ///	</remarks>
    {$ENDREGION}
    class function DefaultField(ADataSet: TDataSet; AName: string; AOwner:
      TComponent = nil): TField; overload;

    {$REGION 'Overloaded class function to create a "default" field if the named field ...'}
    ///	<summary>Overloaded class function to create a "default" field if the
    ///	named field is not found in the passed DataSet</summary>
    ///	<param name="ADataSet">DataSet to search for the named field</param>
    ///	<param name="AName">Name of the field to find</param>
    ///	<param name="ADefault">Default value to assign to the replacement
    ///	<c>TValueField</c> if the named field is not found</param>
    ///	<param name="AOwner">Optional. Owner of the created <c>TValueField</c>,
    ///	if one is indeed created. Defaults to <c>nil</c>.</param>
    ///	<remarks>
    ///	  This class can be used to assign a default constant value for
    ///	  <c>TField.Value</c> when the requested field may not exist in the
    ///	  active <c>TDataSet</c>.
    ///	  <note type="caller">If no owner is assigned, the object returned by
    ///	  this function must be freed in the calling code.</note>
    ///	</remarks>
    {$ENDREGION}
    class function DefaultField(ADataSet: TDataSet; AName: string;
      ADefault: Variant; AOwner: TComponent = nil): TField; overload;

    {$REGION 'Overloaded class function to create a "default" field if the named field ...'}
    ///	<summary>Overloaded class function to create a "default" field if the
    ///	named field is not found in the passed DataSet</summary>
    ///	<param name="ADataSet">DataSet to search for the named field</param>
    ///	<param name="AName">Name of the field to find</param>
    ///	<param name="AGetValue">Anonymous method to retrieve
    ///	<c>TField.Value</c></param>
    ///	<param name="ASetValue"><b>Optional</b>. Anonymous method to set
    ///	<c>TField.Value.</c> Defaults to <c>nil</c>.</param>
    ///	<param name="AOwner"><b>Optional</b>. Owner of the created
    ///	<c>TValueField</c>, if one is indeed created. Default to
    ///	<c>nil</c>.</param>
    ///	<remarks>
    ///	  This class can be used to assign a default constant value for
    ///	  <c>TField.Value</c> when the requested field may not exist in the
    ///	  active <c>TDataSet</c>.
    ///	  <note type="caller">If no owner is assigned, the object returned by
    ///	  this function must be freed in the calling code.</note>
    ///	</remarks>
    {$ENDREGION}
    class function DefaultField(ADataSet: TDataSet; AName: string;
      AGetValue: TGetValueField; ASetValue: TSetValueField = nil;
      AOwner: TComponent = nil): TField; overload;

    {$REGION 'Overloaded class function to create a "default" field if the named field ...'}
    ///	<summary>Overloaded class function to create a "default" field if the
    ///	named field is not found in the passed DataSet</summary>
    ///	<param name="ADataSet">DataSet to search for the named field</param>
    ///	<param name="AName">Name of the field to find</param>
    ///	<param name="ADefault">Default value to assign to the replacement
    ///	<c>TValueField</c> if the named field is not found</param>
    ///	<param name="AGetValue">Anonymous method to retrieve
    ///	<c>TField.Value</c></param>
    ///	<param name="ASetValue"><b>Optional</b>. Anonymous method to set
    ///	<c>TField.Value.</c> Defaults to <c>nil</c>.</param>
    ///	<param name="AOwner"><b>Optional</b>. Owner of the created
    ///	<c>TValueField</c>, if one is indeed created. Default to
    ///	<c>nil</c>.</param>
    ///	<remarks>
    ///	  This class can be used to assign a default constant value for
    ///	  <c>TField.Value</c> when the requested field may not exist in the
    ///	  active <c>TDataSet</c>.
    ///	  <note type="caller">If no owner is assigned, the object returned by
    ///	  this function must be freed in the calling code.</note>
    ///	</remarks>
    {$ENDREGION}
    class function DefaultField(ADataSet: TDataSet; AName: string;
      ADefault: Variant; AGetValue: TGetValueField;
      ASetValue: TSetValueField = nil;
      AOwner: TComponent = nil): TField; overload;
  end;

implementation

uses
  SysUtils, Variants;

{ TValueField }

class function TValueField.DefaultField(ADataSet: TDataSet; AName: string;
  ADefault: Variant; AOwner: TComponent = nil): TField;
begin
  Result := DefaultField(ADataSet, AName, ADefault, nil, nil, AOwner);
end;

class function TValueField.DefaultField(ADataSet: TDataSet; AName: string;
  AOwner: TComponent): TField;
begin
  Result := DefaultField(ADataSet, AName, '', nil, nil, AOwner);
end;

class function TValueField.DefaultField(ADataSet: TDataSet; AName: string;
  AGetValue: TGetValueField; ASetValue: TSetValueField = nil; AOwner: TComponent = nil): TField;
begin
  Result := DefaultField(ADataSet, AName, '', AGetValue, ASetValue, AOwner);
end;

class function TValueField.DefaultField(ADataSet: TDataSet; AName: string;
  ADefault: Variant; AGetValue: TGetValueField; ASetValue: TSetValueField;
  AOwner: TComponent): TField;
begin
  if Length(Trim(AName)) > 0 then
    Result := ADataSet.FindField(AName)
  else
    Result := nil;
  if not Assigned(Result) then
  begin
    Result := TValueField.Create(AOwner);
    with Result as TValueField do
    begin
      Name := AName;
      Value := ADefault;
      GetValueFunc := AGetValue;
      SetValueProc := ASetValue;
      DataSet := ADataSet;
    end;
  end;
end;

function TValueField.GetAsString: string;
begin
  Result := AsVariant;
end;

function TValueField.GetAsVariant: Variant;
begin
  if Assigned(FGetValueFunc) then
    Result := FGetValueFunc(Self)
  else
    Result := FValue;
end;

function TValueField.GetDataSet: TDataSet;
begin
  Result := FValueDataSet;
end;

procedure TValueField.SetAsVariant(const Value: Variant);
begin
  if Assigned(FSetValueProc) then
    FSetValueProc(Self, Value)
  else
    FValue := Value;
end;

procedure TValueField.SetDataSet(ADataSet: TDataSet);
begin
  FValueDataSet := ADataSet;
end;

end.
