
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2010 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DBXPumpUtils;

interface
uses
  Classes, DB, DBXUtils, ComCtrls, CheckLst;

function ProgressCaption(const AType, AName: string;
  const AItemIndex, AItemCount: int64): string;
function ProcCaption(const AProcName: string;
  const AProcIndex, AProcCount: integer): string;
function TableCaption(const ATableName: string;
  const ATableIndex, ATableCount: integer): string;
function TicksToTime(const ATicks: Int64): string;
function SetComboValue(const ACombo:TCustomComboBoxEx; const AValue: string):
  boolean;
function ArrayToList(AValues: TStringArray): string;
function ListToArray(AList: string): TStringArray;
procedure ToggleCheckList(const ACheckList: TCheckListBox;
  const AToggle: boolean);
function CheckedArray(const ACheckList: TCheckListBox;
  const AToggle: boolean): TStringArray;
procedure CheckThisList(const ACheckList: TCheckListBox;
  const AList: TStringArray; const AToggle: boolean = True);
function AllChecked(const ACheckList: TCheckListBox): boolean;
procedure ExcludeList(const ACheckList: TCheckListBox;
  const AList: TStringArray);
procedure IncludeList(const ACheckList: TCheckListBox;
  const AList: TStringArray);
function ToggleDataSet(const ADataSet: TDataSet;
  const AKeyField, AToggleField: string; const AKeys: TStringArray = nil;
  const AToggle: boolean = True;
  const AOptions : TLocateOptions = [loCaseInsensitive]): int64;
function DataSetToArray(const ADataSet: TDataSet; const AField: string;
  const AFilter: string = ''): TStringArray;
procedure CheckDataSetRequest(const ADataSet: TDataSet;
  const Operation: string; Values: string = '');
function LooksLikeFunction(AValue: string): boolean;
function FixQuotes(AValue: string): string;
function RecordToText(ADataSet: TDataSet) : string;
function SizeInK( iVal : int64 ) : string;
function AppDataFolder: string;
function SpecialFolder(Folder: Integer; CanCreate: Boolean): string;

implementation

uses SysUtils, StrUtils, DBXMigrator, TypInfo, ShlObj;

function SpecialFolder(Folder: Integer; CanCreate: Boolean): string;
var
  FilePath: array [0..255] of char;
begin
  SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
  Result := FilePath;
end;

function AppDataFolder: string;
begin
  Result := SpecialFolder(CSIDL_APPDATA, False);
  if Length(Result) > 0 then
    Result := Result + '\';
end;

function SizeInK( iVal : int64 ) : string;
type
   TMagnitudes = record
      Boundary : longint;
      Desc     : string;
   end; { TMagnitudes }
const
   Mags : array [ 1..4 ] of TMagnitudes = (
      ( Boundary: 1073741824; Desc:'GB' ),
      ( Boundary: 1048576; Desc:'MB' ),
      ( Boundary: 1024; Desc: 'K' ),
      ( Boundary: 0; Desc: 'b' )
      );
var
   iBound,
   i : integer;
   number: extended;
begin
   iBound := High( Mags );
   for i := Low( Mags ) to high( Mags ) do
      if iVal >= Mags[ i ].Boundary then
      begin
         iBound := i;
         break;
      end; { Found boundary }
   if Mags[ iBound ].Boundary > 0 then
      number := iVal / Mags[ iBound ].Boundary
   else
      number := iVal + 0.0;
   Result := Trim(Format('%14.0n%s', [number, Mags[ iBound ].Desc]));
end; { SizeInK() }

function FixQuotes(AValue: string): string;
const
  SEager = #39+#39+#39;
begin
  if Pos(SEager, AValue) = 1 then
    Result := Copy(AValue, Length(SEager), Length(AValue) - Length(SEager));
end;

function RecordToText(ADataSet: TDataSet) : string;
var
  f : TField;
  ft : PTypeInfo;
begin
  Result := '';
  ft := TypeInfo(TFieldType);
  for f in ADataSet.Fields do
  begin
    Result := Result + Format('%s(%s)=%s'#13#10,
      [f.FieldName, GetEnumName(ft, Ord(f.DataType)), f.AsString]);
  end;
end;


function LooksLikeFunction(AValue: string): boolean;
const
  SOthers = '"''/,;.)';
var
  open: integer;
  i, j: integer;
begin
  open := Pos('(', AValue);
  if open > 0 then
  begin
    AValue := Copy(AValue, 1, open);
    j := Length(SOthers);
    for i := 1 to j do
      if Pos(SOthers[i],AValue) > 0 then
      begin
        Result := False;
        Exit;
      end;
    Result := True;
  end
  else
    Result := False;
end;

procedure CheckDataSetRequest(const ADataSet: TDataSet;
  const Operation: string; Values: string = '');
begin
  if Not Assigned(ADataSet) then
  begin
    if Length(Values) > 0 then
      Values := Operation + ':' + Values
    else
      Values := Operation;
    Raise EDBXMigrator.CreateFmt('"%s" request ignored. No DataSet is assigned',
      [Values]);
  end;
end;

function DataSetToArray(const ADataSet: TDataSet; const AField: string;
  const AFilter: string = ''): TStringArray;
var
  Filt: string;
  Mark: TBookMark;
  Fld: TField;
  i: int64;
begin
  Fld := ADataSet.FieldByName(AField);
  Mark := ADataSet.BookMark;
  Filt := ADataSet.Filter;
  ADataSet.DisableControls;
  try
    if Length(AFilter) > 0 then
    begin
      ADataSet.Filter := AFilter;
      ADataSet.Filtered := True;
    end;
    i := 0;
    ADataSet.First;
    SetLength(Result, ADataSet.RecordCount); // Should be correct for CDS, others .. who knows?
    while not ADataSet.EOF do
    begin
      Result[i] := Fld.asString;
      Inc(i);
      ADataSet.Next;
    end;
    SetLength(Result, i);
  finally
    ADataSet.Filter := Filt;
    ADataSet.Filtered := Length(Filt) > 0;
    ADataSet.BookMark := Mark;
    ADataSet.EnableControls;
  end;
end;

function ToggleDataSet(const ADataSet: TDataSet;
  const AKeyField, AToggleField: string; const AKeys: TStringArray = nil;
  const AToggle: boolean = True;
  const AOptions : TLocateOptions = [loCaseInsensitive]): int64;
var
  Mark : TBookmark;
  Key: string;
  FldToggle: TField;

  procedure ToggleField;
  begin
    Inc(Result);
    if FldToggle.AsBoolean <> AToggle then
    begin
      ADataSet.Edit;
      FldToggle.AsBoolean := AToggle;
      ADataSet.Post;
    end;
  end;

begin
  Result := 0;
  if not Assigned(ADataSet) then
    Exit;
  Mark := ADataSet.Bookmark;
  ADataSet.DisableControls;
  try
    FldToggle := ADataSet.FieldByName(AToggleField);
    if Assigned(AKeys) then
    begin
      for key in AKeys do
        if ADataSet.Locate(AKeyField, key, AOptions) then
          ToggleField
    end
    else
    begin
      ADataSet.First;
      while not ADataSet.EOF do
      begin
        ToggleField;
        ADataSet.Next;
      end;
    end;
  finally
    ADataSet.BookMark := Mark;
    ADataSet.EnableControls;
  end;
end;

function ProgressCaption(const AType, AName: string;
  const AItemIndex, AItemCount: int64): string;
begin
  Result := Format( '%s %s (%d of %d):',
    [AType, AName, AItemIndex + 1, AItemCount] )
end;

function ProcCaption(const AProcName: string;
  const AProcIndex, AProcCount: integer): string;
begin
  Result := ProgressCaption('Procedure', AProcName, AProcIndex, AProcCount);
end;

function TableCaption(const ATableName: string;
  const ATableIndex, ATableCount: integer): string;
begin
  Result := ProgressCaption('Table', ATableName, ATableIndex, ATableCount);
end;

function TicksToTime(const ATicks: Int64): string;
var
  dt : TDateTime;
  days: integer;
begin
  dt := ATicks / MSecsPerSec / SecsPerDay;
  days := Trunc(dt);
  if days > 0 then
    Result := Format('%d days, %s', [days,
      FormatDateTime('hh:nn:ss.z', Frac(dt))])
  else
    Result := FormatDateTime('hh:nn:ss.z', Frac(dt));
end;

function SetComboValue(const ACombo:TCustomComboBoxEx; const AValue: string):
  boolean;
var
  i: integer;
begin
  i := ACombo.Items.IndexOf(AValue);
  Result := i >= 0;
  if Result then
    ACombo.ItemIndex := i;
end;

function ArrayToList(AValues: TStringArray): string;
var
  v: string;
begin
  Result := '';
  for v in AValues do
    Result := Result + v + ',';
  if Length(Result) > 0 then
    SetLength(Result, Length(Result) - 1);
end;

function ListToArray(AList: string): TStringArray;
var
  s: TStrings;
  I: Integer;
begin
  s := TStringList.Create;
  try
    s.DelimitedText := AList;
    SetLength(Result, s.Count);
    for I := 0 to s.Count - 1 do
      Result[i] := s[i];
  finally
    FreeAndNil(s);
  end;
end;

procedure ToggleCheckList(const ACheckList: TCheckListBox;
  const AToggle: boolean);
var
  I: Integer;
begin
  for I := 0 to ACheckList.Count - 1 do
    ACheckList.Checked[I] := AToggle;
end;

function CheckedArray(const ACheckList: TCheckListBox;
  const AToggle: boolean): TStringArray;
var
  I,
  J,
  L: Integer;
begin
  L := ACheckList.Count;
  J := 0;
  SetLength(Result, L);
  for I := 0 to L - 1 do
    if ACheckList.Checked[I] = AToggle then
    begin
      Result[j] := ACheckList.Items[I];
      Inc(J);
    end;
  SetLength(Result, J);
end;

procedure CheckThisList(const ACheckList: TCheckListBox;
  const AList: TStringArray; const AToggle: boolean = True);
var
  s: string;
  i: integer;
begin
  for s in AList do
  begin
    i := ACheckList.Items.IndexOf(s);
    if i >= 0 then
      ACheckList.Checked[i] := AToggle;
  end;
end;

function AllChecked(const ACheckList: TCheckListBox): boolean;
var
  I: Integer;
begin
  for I := 0 to ACheckList.Count - 1 do
    if not ACheckList.Checked[I] then
    begin
      Result := False;
      Exit;
    end;
  Result := True;
end;

procedure ExcludeList(const ACheckList: TCheckListBox;
  const AList: TStringArray);
begin
  ToggleCheckList(ACheckList, True); // Turn all on first
  CheckThisList(ACheckList, AList, False);
end;

procedure IncludeList(const ACheckList: TCheckListBox;
  const AList: TStringArray);
begin
  ToggleCheckList(ACheckList, False); // Turn all off first
  CheckThisList(ACheckList, AList, True);
end;


end.
