
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit XPAppExpt;

interface

procedure Register;

implementation

uses
  Classes, SysUtils, Windows, ToolsApi;

{$R XPAPPRES.res}

type
  TSourceIndex = (siXPAppProject, siXPAppModule);

  TXPAppProjectCreator = class(TInterfacedObject, IOTACreator, IOTAProjectCreator, IOTAProjectCreator50)
  public
    { IOTACreator }
    function  GetCreatorType: String; virtual;
    function  GetExisting: Boolean; virtual;
    function  GetFileSystem: String; virtual;
    function  GetOwner: IOTAModule; virtual;
    function  GetUnnamed: Boolean; virtual;
    { IOTAProjectCreator }
    function  GetFileName: String; virtual;
    function  GetOptionFileName: String; virtual;
    function  GetShowSource: Boolean; virtual;
    procedure NewDefaultModule; virtual;
    function  NewOptionSource(const ProjectName: String): IOTAFile; virtual;
    procedure NewProjectResource(const Project: IOTAProject); virtual;
    function  NewProjectSource(const ProjectName: String): IOTAFile; virtual;
    { IOTAProjectCreator50 }
    procedure NewDefaultProjectModule(const Project: IOTAProject); virtual;
  end;

  TXPAppModuleCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  public
    function GetAncestorName: string;
    function GetFormName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent: string;
      const AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent: string; const FormIdent: string;
      const AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent: string; const FormIdent: string;
      const AncestorIdent: string): IOTAFile;
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  end;


  TXPAppProjectWizard = class(TNotifierObject, IOTAWizard, IOTARepositoryWizard,
    IOTARepositoryWizard60, IOTARepositoryWizard80, IOTAProjectWizard)
  public
    function GetDesigner: string;
    function GetPersonality: string;
    function GetGalleryCategory: IOTAGalleryCategory;
    { IOTAWizard declarations }
    function  GetIDString: String;
    function  GetName: String;
    function  GetState: TWizardState;
    procedure Execute;
    { IOTARepositoryWizard declarations }
    function  GetAuthor: String;
    function  GetComment: String;
    function  GetPage: String;
    function  GetGlyph: Cardinal;
  end;

  TXPProjectSource = class(TInterfacedObject, IOTAFile)
  private
    FProjectName: string;
  public
    constructor Create(const ProjectName: string);
    function GetAge: TDateTime;
    function GetSource: string;
  end;

  TXPModuleSource = class(TInterfacedObject, IOTAFile)
  private
    FModuleIdent: string;
    FFormIdent: string;
    FAncestorIdent: string;
  public
    constructor Create(const ModuleIdent, FormIdent, AncestorIdent: string);
    function GetAge: TDateTime;
    function GetSource: string;
  end;

var
  ModuleSources: array[TSourceIndex] of PAnsiChar;
  ModuleText: PAnsiChar;

procedure InitModuleSources;
var
  ResInstance: THandle;
  ResName: PChar;
  P: PAnsiChar;
  SourceIndex: TSourceIndex;
begin
  ResInstance := FindResourceHInstance(HInstance);
  ResName := 'XPAPPCODE';
  ModuleText := StrNew(PAnsiChar(LockResource(LoadResource(ResInstance,
    FindResource(ResInstance, ResName, RT_RCDATA)))));
  P := ModuleText;
  for SourceIndex := Low(TSourceIndex) to High(TSourceIndex) do
  begin
    ModuleSources[SourceIndex] := P;
    while P^ <> '|' do
    begin
      if P^ in LeadBytes then Inc(P);
      Inc(P);
    end;
    P^ := #0;
    Inc(P);
  end;
end;

procedure DoneModuleSources;
begin
  StrDispose(ModuleText);
end;

{ TXPAppProjectCreator }

function TXPAppProjectCreator.GetCreatorType: string;
begin
  Result := sApplication;
end;

function TXPAppProjectCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TXPAppProjectCreator.GetFileName: string;
begin
  Result := '';
end;

function TXPAppProjectCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TXPAppProjectCreator.GetOptionFileName: string;
begin
  Result := '';
end;

function TXPAppProjectCreator.GetOwner: IOTAModule;
begin
  Result := nil;
end;

function TXPAppProjectCreator.GetShowSource: Boolean;
begin
  Result := False;
end;

function TXPAppProjectCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

procedure TXPAppProjectCreator.NewDefaultModule;
begin
end;

procedure TXPAppProjectCreator.NewDefaultProjectModule(const Project: IOTAProject);
var
  I, j: Integer;
  ProjectResource: IOTAProjectResource;
  ResourceEntry: IOTAResourceEntry;
  S: TResourceStream;
  TargetFile: string;
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(TXPAppModuleCreator.Create);
  for I := 0 to Project.ModuleFileCount - 1 do
  begin
    if Supports(Project.ModuleFileEditors[I], IOTAProjectResource, ProjectResource) then
        for J := 0 to ProjectResource.GetEntryCount - 1 do
        begin
          ResourceEntry := ProjectResource.GetEntry(J);
          if ResourceEntry.GetResourceType = PChar(24) then
          begin
            ProjectResource.DeleteEntry(ResourceEntry.GetEntryHandle);
            Break;
          end;
        end;
  end;
  S := TResourceStream.Create(HInstance, 'DELPHIXP', RT_RCDATA);
  try
    TargetFile := IncludeTrailingPathDelimiter(ExtractFilePath(Project.FileName)) + 'DelphiXP.res';
    if not FileExists(TargetFile) then
      S.SaveToFile(TargetFile);
    Project.AddFile(TargetFile, False);
  finally
    S.Free;
  end;
end;

function TXPAppProjectCreator.NewOptionSource(const ProjectName: string): IOTAFile;
begin
  Result := nil;
end;

procedure TXPAppProjectCreator.NewProjectResource(const Project: IOTAProject);
begin
end;

function TXPAppProjectCreator.NewProjectSource(const ProjectName: string): IOTAFile;
begin
  Result := TXPProjectSource.Create(ProjectName);
end;

{ TXPAppProjectWizard }

function TXPAppProjectWizard.GetAuthor: String;
begin
  Result := 'CodeGear';
end;

function TXPAppProjectWizard.GetDesigner: string;
begin
  Result := ToolsApi.dVCL;
end;

function TXPAppProjectWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := (BorlandIDEServices as IOTAGalleryCategoryManager).FindCategory(sCategoryDelphiNew);
end;

function TXPAppProjectWizard.GetGlyph: Cardinal;
begin
  Result := LoadIcon(HInstance, 'XPAPP');
end;

function TXPAppProjectWizard.GetPage: String;
begin
  Result := 'New';
end;

function TXPAppProjectWizard.GetPersonality: string;
begin
  Result := ToolsApi.sDelphiPersonality;
end;

function TXPAppProjectWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TXPAppProjectWizard.Execute;
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(TXPAppProjectCreator.Create);
end;

function TXPAppProjectWizard.GetComment: String;
begin
  Result := 'Creates a new XP themed application';
end;

function TXPAppProjectWizard.GetIDString: String;
begin
  Result := 'CodeGear.XPProject';
end;

function TXPAppProjectWizard.GetName: String;
begin
  Result := 'XP Themed Application';
end;

procedure Register;
begin
  RegisterPackageWizard(TXPAppProjectWizard.Create);
end;

{ TXPProjectSource }

constructor TXPProjectSource.Create(const ProjectName: string);
begin
  FProjectName := ProjectName;
end;

function TXPProjectSource.GetAge: TDateTime;
begin
  Result := -1;
end;

function TXPProjectSource.GetSource: string;
begin
  Result := Format(string(AnsiString(ModuleSources[siXPAppProject])),
    [FProjectName]);
end;

{ TXPAppModuleCreator }

procedure TXPAppModuleCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin

end;

function TXPAppModuleCreator.GetAncestorName: string;
begin
  Result := 'Form';
end;

function TXPAppModuleCreator.GetCreatorType: string;
begin
  Result := sForm;
end;

function TXPAppModuleCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TXPAppModuleCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TXPAppModuleCreator.GetFormName: string;
begin
  Result := '';
end;

function TXPAppModuleCreator.GetImplFileName: string;
begin
  Result := '';
end;

function TXPAppModuleCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TXPAppModuleCreator.GetMainForm: Boolean;
begin
  Result := True;
end;

function TXPAppModuleCreator.GetOwner: IOTAModule;
begin
  Result := (BorlandIDEServices as IOTAModuleServices).GetActiveProject;
end;

function TXPAppModuleCreator.GetShowForm: Boolean;
begin
  Result := True;
end;

function TXPAppModuleCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TXPAppModuleCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

function TXPAppModuleCreator.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TXPAppModuleCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := TXPModuleSource.Create(ModuleIdent, FormIdent, AncestorIdent);
end;

function TXPAppModuleCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

{ TXPModuleSource }

constructor TXPModuleSource.Create(const ModuleIdent, FormIdent,
  AncestorIdent: string);
begin
  FModuleIdent := ModuleIdent;
  FFormIdent := FormIdent;
  FAncestorIdent := AncestorIdent;
end;

function TXPModuleSource.GetAge: TDateTime;
begin
  Result := -1
end;

function TXPModuleSource.GetSource: string;
begin
  Result := Format(string(AnsiString(ModuleSources[siXPAppModule])),
    [FModuleIdent, FFormIdent, FAncestorIdent]);
end;

initialization
  InitModuleSources;
finalization
  DoneModuleSources;
end.
