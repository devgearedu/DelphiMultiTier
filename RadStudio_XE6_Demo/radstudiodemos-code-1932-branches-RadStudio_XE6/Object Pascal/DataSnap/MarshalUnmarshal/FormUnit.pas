
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXJSON, Generics.Collections, StdCtrls, StrUtils, RTTI, DBXJSONReflect, 
//  FastMM4,
  AppEvnts, TestTypeFactory;

type
  TForm56 = class(TForm)
    ButtonMarshal: TButton;
    Memo1: TMemo;
    ButtonClearLog: TButton;
    CheckBoxWordWrap: TCheckBox;
    ListBox1: TListBox;
    MemoJSONValue: TMemo;
    ButtonUnmarshalJson: TButton;
    ApplicationEvents1: TApplicationEvents;
    Label1: TLabel;
    JSONValue: TLabel;
    ButtonClearJSON: TButton;
    Label2: TLabel;
    ButtonAll: TButton;
    ButtonLogType: TButton;
    ComboBoxTypeNames: TComboBox;
    Label3: TLabel;
    ButtonTypeDetails: TButton;
    procedure ButtonMarshalClick(Sender: TObject);
    procedure ButtonClearLogClick(Sender: TObject);
    procedure CheckBoxWordWrapClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ButtonClearJSONClick(Sender: TObject);
    procedure ButtonUnmarshalJsonClick(Sender: TObject);
    procedure ButtonAllClick(Sender: TObject);
    procedure ButtonListTypesClick(Sender: TObject);
    procedure ButtonLogTypeClick(Sender: TObject);
    procedure ButtonTypeDetailsClick(Sender: TObject);
  private
    function GetSelectedType: TTypeFactory;
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
  end;


var
  Form56: TForm56;

implementation

{$R *.dfm}

uses TypInfo;

function IsIgnoredType(const AName: string): Boolean;
const
  sIgnoredUnits: array[0..39] of string =
  ('actnlist', 'appevnts', 'system', 'windows', 'activex', 'variants', 'rtti', 'typinfo',
  'classes', 'rtti', 'controls', 'sysutils', 'dbxjsonreflect', 'contnrs',
  'sqltimst', 'dateutils', 'themes', 'graphics', 'forms', 'menus',
  'StdCtrls', 'ExtCtrls', 'Dialogs', 'imglist', 'comctrls', 'printers',
  'StdActns', 'registry', 'helpintfs', 'dbxjson', 'fmtbcd', 'dbxplatform',
  'messages', 'timespan', 'syncobjs', 'excutils', 'types', 'formunit',
  'multimon', 'testtypefactory');
var
  s: string;
begin
  for s in sIgnoredUnits do
    if StartsText(s + '.', AName) then
      exit(True);
  exit(False);
end;

procedure EnumerateTypes(AProc: TProc<TRttiType>);
var
  LRttiContext: TRttiContext;
  LTypes: TArray<TRttiType>;
  LType: TRttiType;
begin
  LTypes := LRttiContext.GetTypes;
  for LType in LTypes do
  begin
    if IsIgnoredType(LType.QualifiedName) then
      continue;
    AProc(LType);
  end;
end;

var
  FIndent: string = '';

procedure LogLine(const ALine: string);
begin
  Form56.Memo1.Lines.Add(FIndent + ALine);
end;

procedure Indent;
begin
  FIndent := FIndent + '   ';
end;

procedure OutDent;
begin
  if Length(FIndent) >= 3 then
    SetLength(FIndent, Length(FIndent)-3);
end;

procedure LogTypeDetails(AType: TRttiType; AParentType: TRttiType; AParentTypes: TList<TRttiType>); forward; overload;
procedure LogTypeDetails(const AQualifiedName: string); forward; overload;

procedure LogField(LField: TRttiField; AParentType: TRttiType; AParentTypes: TList<TRttiType>);
begin
  LogLine(Format('Field: %s', [LField.Name]));
  Indent;
  try
    try
      // QualifiedName not always available
      LogLine(Format('Type: %s', [LField.FieldType.QualifiedName]));
    except
      LogLine(Format('Type: %s', [LField.FieldType.Name]));
    end;
    LogLine(Format('Kind: %s', [GetEnumName(TypeInfo(TTypeKind), Integer(LField.FieldType.TypeKind))]));
    case LField.FieldType.TypeKind of
      TTypeKind.tkDynArray, TTypeKind.tkArray, TTypeKind.tkClass, TTypeKind.tkRecord:
        LogTypeDetails(LField.FieldType, AParentType, AParentTypes);
    end;
  finally
    OutDent;
  end;
end;

procedure LogAttributes(AAttributes: TArray<TCustomAttribute>);
var
  LAttribute: TCustomAttribute;
begin
  if Length(AAttributes) > 0 then
  begin
    LogLine('Attributes');
    try
      Indent;
      for LAttribute in AAttributes do
        LogLine(Format('%s', [LAttribute.ClassName]));
      OutDent;
    finally
      OutDent;
    end;
  end;
end;

procedure LogTypeDetails(AType: TRttiType; AParentType: TRttiType; AParentTypes: TList<TRttiType>);
var
  LFields: TArray<TRttiField>;
  LField: TRttiField;
  LElementType: TRttiType;
  LParentTypes: TList<TRttiType>;
begin
  LogLine(Format('RttiType: %s', [AType.ClassName]));
  LogAttributes(AType.GetAttributes);
  if AParentTypes.IndexOf(AParentType) < 0 then
    AParentTypes.Add(AParentType);
  if AParentTypes.IndexOf(AType) >= 0 then
  begin
    LogLine('RECURSIVE');
    Exit;
  end;
  LElementType := nil;
  if AType is  TRttiDynamicArrayType then
    LElementType := TRttiDynamicArrayType(AType).ElementType
  else if AType is TRttiArrayType then
    LElementType := TRttiArrayType(AType).ElementType;
  if LElementType <> nil then
  begin
    LogLine(Format('ElementType: %s', [LElementType.QualifiedName]));
    Indent;
    try
      LParentTypes := TList<TRttiType>.Create(AParentTypes);
      try
        LogTypeDetails(LElementType, AType, LParentTypes);
      finally
        LParentTypes.Free;
      end;
    finally
      OutDent;
    end;
  end;
  LFields := AType.GetFields;
  for LField in LFields do
  begin
    LParentTypes := TList<TRttiType>.Create(AParentTypes);
    try
      LogField(LField, AType, LParentTypes);
    finally
      LParentTypes.Free;
    end;
    Indent;
    try
      LogAttributes(LField.GetAttributes);
    finally
      OutDent;
    end;
  end;
end;


procedure LogTypeDetails(const AQualifiedName: string);
var
  LRttiContext: TRttiContext;
  LType: TRttiType;
  LQualifiedName: string;
  LParentTypes: TList<TRttiType>;
begin
  LQualifiedName := AQualifiedName;
  LType := LRttiContext.FindType(LQualifiedName);
  if LType = nil then
    raise Exception.CreateFmt('Type not found: %s', [LQualifiedName]);
  try
    // QualifiedName not always available
    LogLine(Format('Type: %s', [LType.QualifiedName]));
  except
    LogLine(Format('Type: %s', [LType.Name]));
  end;
  Indent;
  try
    LParentTypes := TList<TRttiType>.Create;
    try
      LogTypeDetails(LType, nil, LParentTypes);
    finally
      LParentTypes.Free;
    end;
  finally
    OutDent;
  end;
end;


{ TForm8 }

procedure TForm56.ButtonUnmarshalJsonClick(Sender: TObject);
var
  LTypeFactory: TTypeFactory;
  LObject: TObject;
  LJSONUnMarshal: TJSONUnMarshal;
  LJSONValue: TJSONValue;
begin
  LTypeFactory := GetSelectedType;
  Assert(LTypeFactory <> nil);
  LJSONValue := TJSONObject.ParseJSONValue(MemoJSONValue.Text);
  try
    LJSONUnMarshal := TJSONConverters.GetJSONUnMarshaler;
    try
      LObject := LJSONUnmarshal.Unmarshal(LJSONValue);
      try
        LTypeFactory.ValidateClass(LObject);
        Memo1.Lines.Add(LObject.ClassName + ' OK')
      finally
        LObject.Free;
      end;
    finally
      LJSONUnMarshal.Free;
    end;
  finally
    LJSONValue.Free;
  end;
end;

procedure TForm56.ButtonMarshalClick(Sender: TObject);
var
  LTypeFactory: TTypeFactory;
  LObject: TObject;
  LJSONMarshal: TJSONMarshal;
  LJSONValue: TJSONValue;
begin
  LTypeFactory := GetSelectedType;
  Assert(LTypeFactory <> nil);
  LObject := LTypeFactory.CreateClass;
  try
    LJSONMarshal := TJSONConverters.GetJSONMarshaler;
    try
      LJSONValue := LJSONMarshal.Marshal(LObject);
      try
        MemoJSONValue.Text := LJSONValue.ToString;
      finally
        LJSONValue.Free;
      end;
    finally
      LJSONMarshal.Free;
    end;
  finally
    LObject.Free;
  end;
end;


procedure TForm56.ButtonTypeDetailsClick(Sender: TObject);
var
  LQualifiedName: string;
  LType: TTypeFactory;
begin
  LType := GetSelectedType;
  LQualifiedName := LType.QualifiedName;
  LogTypeDetails(LQualifiedName);
end;

procedure TForm56.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
var
  LType: TTypeFactory;
begin
  LType := GetSelectedType;
  if LType <> nil then
  begin
    ButtonMarshal.Caption := 'Marshal ' + LType.TypeDescription;
    ButtonUnmarshalJson.Caption := 'Unmarshal ' + LType.TypeDescription;
    ButtonTypeDetails.Caption := 'Log ' + LType.TypeName;
  end
  else
  begin
    ButtonMarshal.Caption := 'Marshal';
    ButtonUnmarshalJson.Caption := 'Unmarshal';
    ButtonTypeDetails.Caption := 'Type Details';
  end;
  ButtonMarshal.Enabled := LType <> nil;
  ButtonUnmarshalJson.Enabled := LType <> nil;
  ButtonTypeDetails.Enabled := LType <> nil;
end;

procedure TForm56.ButtonAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ListBox1.Items.Count do
  begin
    ListBox1.ItemIndex := I;
    ButtonMarshalClick(Self);
    ButtonUnmarshalJsonClick(Self);
  end;
end;

procedure TForm56.ButtonClearJSONClick(Sender: TObject);
begin
  MemoJSONValue.Clear;
end;

procedure TForm56.ButtonClearLogClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm56.ButtonListTypesClick(Sender: TObject);
begin
  EnumerateTypes(
    procedure(AType: TRttiType)
    begin
      LogLine(Format('Type Name: %s', [AType.QualifiedName]));
    end);
end;

procedure TForm56.ButtonLogTypeClick(Sender: TObject);
var
  LQualifiedName: string;
begin
  LQualifiedName := ComboBoxTypeNames.Text;
  LogTypeDetails(LQualifiedName);
end;


procedure TForm56.CheckBoxWordWrapClick(Sender: TObject);
begin
  MemoJSONValue.WordWrap := CheckBoxWordWrap.Checked;
  if MemoJSONValue.WordWrap then
    MemoJSONValue.ScrollBars := TScrollStyle.ssVertical
  else
    MemoJSONValue.ScrollBars := TScrollStyle.ssBoth;
end;

destructor TForm56.Destroy;
begin

  inherited;
end;


procedure TForm56.FormCreate(Sender: TObject);
var
  LTypes: TArray<TTypeFactory>;
  LType: TTypeFactory;
begin
  // Uncomment to test alternate separators
  // DecimalSeparator := ',';
  // ThousandSeparator := '.';
  LTypes := GetTypeFactories;
  for LType in LTypes do
  begin
    ListBox1.Items.AddObject(LType.TypeDescription,
      LType);
  end;

  ComboBoxTypeNames.Clear;
  EnumerateTypes(
    procedure(AType: TRttiType)
    begin
      ComboBoxTypeNames.Items.Add(AType.QualifiedName);
    end);
end;


function TForm56.GetSelectedType: TTypeFactory;
begin
  if ListBox1.ItemIndex >= 0 then
    Result := TTypeFactory(ListBox1.Items.Objects[ListBox1.ItemIndex])
  else
    Result := nil;
end;

initialization
  TestTypeFactory.GLogLineProc :=
    procedure(ALine: string) begin LogLine(ALine); end;
end.
