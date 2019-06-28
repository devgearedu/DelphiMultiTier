
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FileInfoFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolsAPI, StdCtrls;

type
  TFileInfoFrame = class(TFrame, IOTAModuleNotifier)
    ModuleFileSelector: TComboBox;
    CreationTimeLabel: TLabel;
    ModifiedTimeLabel: TLabel;
    CreationTimeEdit: TEdit;
    ModifiedTimeEdit: TEdit;
    FileSizeLabel: TLabel;
    FileSizeEdit: TEdit;
    procedure ModuleFileSelectorClick(Sender: TObject);
  private
    FModule: IOTAModule;
    FNotifierIndex: Integer;
    procedure SetModule(const Value: IOTAModule);
    procedure RefreshView;
  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    { IOTAModuleNotifier }
    function CheckOverwrite: Boolean;
    procedure ModuleRenamed(const NewName: string);
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    property Module: IOTAModule read FModule write SetModule;
  end;

implementation

{$R *.dfm}

{ TFileInfoFrame }

constructor TFileInfoFrame.Create(AOwner: TComponent);
begin
  inherited;
  FNotifierIndex := -1;
end;

Destructor TFileInfoFrame.Destroy;
begin
  SetModule(nil);
  inherited;
end;

procedure TFileInfoFrame.AfterSave;
begin
  RefreshView;
end;

procedure TFileInfoFrame.BeforeSave;
begin
  //no implementation
end;

function TFileInfoFrame.CheckOverwrite: Boolean;
begin
  //no implementation
  Result := True;
end;

procedure TFileInfoFrame.Destroyed;
begin
  SetModule(nil);
end;

procedure TFileInfoFrame.Modified;
begin
  //no implementation
end;

procedure TFileInfoFrame.ModuleFileSelectorClick(Sender: TObject);
var
  FileName: string;
  FileData: TWin32FileAttributeData;
  FileSize: Int64;

  function FileTimeToDateTime(const FileTime: TFileTime): TDateTime;
  var
    LSystemTime: TSystemTime;
    LocalFileTime: TFileTime;
  begin
      FileTimeToLocalFileTime(FileTime, LocalFileTime);
      FileTimeToSystemTime(LocalFileTime, LSystemTime);
      with LSystemTime do
        Result := EncodeDate(wYear, wMonth, wDay) +
          EncodeTime(wHour, wMinute, wSecond, wMilliSeconds);
  end;

begin
  CreationTimeEdit.Text := '';
  ModifiedTimeEdit.Text := '';
  FileSizeEdit.Text := '';
  FileName := FModule.ModuleFileEditors[ModuleFileSelector.ItemIndex].FileName;
  if FileName = '' then
    FileName := ModuleFileSelector.Items[ModuleFileSelector.ItemIndex];
  if GetFileAttributesEx(PChar(FileName), GetFileExInfoStandard, @FileData) then
  begin
    if (FileData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      CreationTimeEdit.Text := DateTimeToStr(FileTimeToDateTime(FileData.ftCreationTime));
      ModifiedTimeEdit.Text := DateTimeToStr(FileTimeToDateTime(FileData.ftLastWriteTime));
      FileSize := (FileData.nFileSizeHigh shl 32) + FileData.nFileSizeLow;
      FileSizeEdit.Text := IntToStr(FileSize);
    end;
  end;
end;

procedure TFileInfoFrame.ModuleRenamed(const NewName: string);
begin
  //no implementation
end;

procedure TFileInfoFrame.RefreshView;
var
  I: Integer;
begin
  ModuleFileSelector.Items.Clear;
  if FModule <> nil then
  begin
    for I := 0 to FModule.ModuleFileCount - 1 do
      ModuleFileSelector.Items.Add(ExtractFileName(FModule.ModuleFileEditors[I].FileName));
    ModuleFileSelector.Visible := ModuleFileSelector.Items.Count > 1;
    if ModuleFileSelector.Items.Count > 0 then
    begin
      ModuleFileSelector.ItemIndex := 0;
      ModuleFileSelectorClick(ModuleFileSelector);
    end;
  end;
end;

procedure TFileInfoFrame.SetModule(const Value: IOTAModule);
begin
  if FModule <> Value then
  begin
    if (FModule <> nil) and (FNotifierIndex > -1) then
    begin
      FModule.RemoveNotifier(FNotifierIndex);
      FNotifierIndex := -1;
    end;
    FModule := Value;
    if FModule <> nil then
      FNotifierIndex := FModule.AddNotifier(Self);
    RefreshView;
  end;
end;

end.
