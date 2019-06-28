
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit BindListUtilsSampleFormUnit;

// This sample populate TListBox, TComboBox and TListView using utility functions in
// BindListUtils.
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  Datasnap.DBClient, Data.Bind.Components, Data.Bind.DBScope, Vcl.CheckLst,
  Vcl.ComCtrls;

type
  TForm38 = class(TForm)
    ListBox1: TListBox;
    BindSourceDB1: TBindSourceDB;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    ButtonFromCDS1: TButton;
    ButtonFromDBScope1: TButton;
    ButtonFromStringList: TButton;
    ComboBox1: TComboBox;
    ButtonFromDBScope2: TButton;
    ListView1: TListView;
    ButtonFromDBScope3: TButton;
    ButtonFromDBScope4: TButton;
    ButtonFromSampleObject1: TButton;
    ButtonFromSampleObject2: TButton;
    ButtonClear: TButton;
    ButtonFormCDS2: TButton;
    ButtonFromCDS3: TButton;
    ButtonFromCDS4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    procedure ButtonFromCDS1Click(Sender: TObject);
    procedure ButtonFromDBScope1Click(Sender: TObject);
    procedure ButtonFromStringListClick(Sender: TObject);
    procedure ButtonFromDBScope2Click(Sender: TObject);
    procedure ButtonFromDBScope3Click(Sender: TObject);
    procedure ButtonFromDBScope4Click(Sender: TObject);
    procedure ButtonFromSampleObject1Click(Sender: TObject);
    procedure ButtonFromSampleObject2Click(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonFormCDS2Click(Sender: TObject);
    procedure ButtonFromCDS3Click(Sender: TObject);
    procedure ButtonFromCDS4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form38: TForm38;

implementation

{$R *.dfm}

uses BindListUtils, VCL.Bind.Editors, Generics.Collections;

// Fill from a TDataSet enumerator.  Scope is TField.
procedure TForm38.ButtonFormCDS2Click(Sender: TObject);
begin
  FillList(ListBox1, 'Text', ClientDataSet1,
    'Current.AsString', 'Category');

  FillList(ComboBox1, 'Text', ClientDataSet1,
    'Current.AsString', 'Category');

end;

// Fill from a TDataSet enumerator using multiple binding expressions.  Scope is TDataSet.
procedure TForm38.ButtonFromCDS3Click(Sender: TObject);
begin
  FillList(
    ListView1,
    TArray<string>.Create(
      'Caption',
      'SubItems.Strings[0]'),
    ClientDataSet1,
    TArray<string>.Create(
      'Current.Category.AsString',
      'Current.FieldByName("Species Name").AsString'));

end;

// Fill from a TDataSet enumerator.  Scope is TField.
procedure TForm38.ButtonFromCDS4Click(Sender: TObject);
begin
  FillList(ListView1, 'Caption', ClientDataSet1, 'Current.AsString', 'Category');

end;

// Fill from a TDataSet enumerator.  Scope is TDataSet.
procedure TForm38.ButtonFromCDS1Click(Sender: TObject);
begin
  FillList(ListBox1, 'Text', ClientDataSet1,
    'Current.Category.AsString + " - " +  Current.Common_Name.AsString');

  FillList(ComboBox1, 'Text', ClientDataSet1,
    'Current.Category.AsString + " - " +  Current.Common_Name.AsString');
end;

// Fill from a TBindSourceDB.  Scope is TDataSet.
procedure TForm38.ButtonFromDBScope1Click(Sender: TObject);
begin
  FillList(ListBox1, 'Text', BindSourceDB1, 'Category.AsString + " - " +  Common_Name.AsString');

  FillList(ComboBox1, 'Text', BindSourceDB1, 'Category.AsString + " - " +  Common_Name.AsString');
end;

// Fill from enumerable type TStrings.  Scope is TStrings.
procedure TForm38.ButtonFromStringListClick(Sender: TObject);
var
  LStrings: TStrings;
begin
  LStrings := TStringList.Create;
  try
    LStrings.DelimitedText := 'one,two,three,four,five,six';

    FillList(ListBox1, 'Text', LStrings, 'Current');

    FillList(ComboBox1, 'Text', LStrings, 'Current');
  finally
    LStrings.Free;
  end;
end;

// Fill from TBindSourceDB.  Scope is TField.
procedure TForm38.ButtonFromDBScope2Click(Sender: TObject);
begin
  FillList(ListBox1, 'Text', BindSourceDB1, 'AsString', 'Category');

  FillList(ComboBox1, 'Text', BindSourceDB1, 'AsString', 'Category');
end;

// Fill from TBindSourceDB using multiple binding expressions.  Scope is TDataSet.
procedure TForm38.ButtonFromDBScope3Click(Sender: TObject);
begin
  FillList(
    ListView1,
    TArray<string>.Create(
      'Caption',
      'SubItems.Strings[0]'),
    BindSourceDB1,
    TArray<string>.Create(
      'Category.AsString',
      'FieldByName("Species Name").AsString'));
end;

// Fill from TBindSourceDB .  Scope is TField.
procedure TForm38.ButtonFromDBScope4Click(Sender: TObject);
begin
  FillList(ListView1, 'Caption', BindSourceDB1, 'AsString', 'Category');
end;

type
  TSampleObject = class
  private
    FStringProp: string;
    FIntegerProp: Integer;
  public
    constructor Create(AIntegerProp: Integer);
    property StringProp: string read FStringProp;
    property IntegerProp: Integer read FIntegerProp;
  end;

// Fill from  enumerable type TList<TSampleObject>.  Scope is TSampleObject.
procedure TForm38.ButtonFromSampleObject1Click(Sender: TObject);
var
  LList: TList<TSampleObject>;
  I: Integer;
begin
  LList := TObjectList<TSampleObject>.Create; // Owns objects
  try
    for I := 1 to 10 do
      LList.Add(TSampleObject.Create(I));

    FillList(ListBox1, 'Text', LList, 'ToStr(Current.IntegerProp) + ": " + Current.StringProp');

    FillList(ComboBox1, 'Text', LList, 'ToStr(Current.IntegerProp) + ": " + Current.StringProp');
  finally
    LList.Free;
  end;
end;

// Fill from  enumerable type TList<TSampleObject> using multiple binding expressions.  Scope is TSampleObject.
procedure TForm38.ButtonFromSampleObject2Click(Sender: TObject);
var
  LList: TList<TSampleObject>;
  I: Integer;
begin
  LList := TObjectList<TSampleObject>.Create; // Owns objects
  try
    for I := 1 to 10 do
      LList.Add(TSampleObject.Create(I));

    FillList(
      ListView1,
      TArray<string>.Create(
        'Caption',
        'SubItems.Strings[0]'),
      LList,
      TArray<string>.Create(
        'Current.IntegerProp',
        'Current.StringProp'));
  finally
    LList.Free;
  end;
end;

procedure TForm38.ButtonClearClick(Sender: TObject);
begin
  ClearList(ListBox1);
  ClearList(ComboBox1);
  ClearList(ListView1);
end;

{ TSampleObject }

constructor TSampleObject.Create(AIntegerProp: Integer);
begin
  FIntegerProp := AIntegerProp;
  FStringProp := 'Item' + IntToStr(AIntegerProp);
end;


end.
