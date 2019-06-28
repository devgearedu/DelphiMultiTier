
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit SampleProxyGeneratorUnit;

interface

uses
  DBXCommon, DSProxy, Classes, DSProxyWriter, DSClientMetaData, Generics.Collections, SysUtils,
  DSCommonProxy;

type

  TSampleProxyGenerator = class
  private
      class procedure SetProperties(AProxyGenerator: TDSProxyGenerator;
        AUnitName, AExcludeClasses, AExcludeMethods, AIncludeClasses, AIncludeMethods: string);
  protected
  public
      class function GenerateString(AMetaDataLoader: IDSProxyMetaDataLoader;
        const ADirectory, AUnitName, AExcludeClasses, AExcludeMethods, AIncludeClasses, AIncludeMethods: string;
        const AWriter: string): string;
      class procedure GenerateFile(AMetaDataLoader: IDSProxyMetaDataLoader;
        ADirectory: String; const AUnitName, AExcludeClasses, AExcludeMethods, AIncludeClasses, AIncludeMethods: string; const AWriter: string;
        ACreatingFiles: TFunc<TStrings, Boolean>; ACreatedFiles: TProc<TStrings>);
  end;
  
implementation

uses DBXPlatform, Registry;


class function TSampleProxyGenerator.GenerateString(AMetaDataLoader: IDSProxyMetaDataLoader;
  const ADirectory, AUnitName, AExcludeClasses, AExcludeMethods, AIncludeClasses, AIncludeMethods: string;
  const AWriter: string): string;
var
  LProxyGenerator: TDSProxyGenerator;
  LFileDescriptions: TDSProxyFileDescriptions;
  I: Integer;
  LStreams: TObjectDictionary<string, TStream>;
  LPair: TPair<string, TStream>;
  LReader: TStreamReader;
begin
  LProxyGenerator := TDSProxyGenerator.Create(nil);
  try
    LProxyGenerator.Writer := AWriter;
    SetProperties(LProxyGenerator,
      AUnitName, AExcludeClasses, AExcludeMethods, AIncludeClasses, AIncludeMethods);
    LProxyGenerator.TargetDirectory := ADirectory;
    LStreams := TObjectDictionary<string, TStream>.Create([doOwnsValues]);
    try
      LFileDescriptions := LProxyGenerator.FileDescriptions;
      for I := 0 to Length(LFileDescriptions) - 1 do
        LStreams.Add(LFileDescriptions[I].ID,
          TStringStream.Create());
      LProxyGenerator.WriteToStreams(AMetaDataLoader, LStreams);
      for LPair in LStreams do
      begin
        LPair.Value.Seek(0, soFromBeginning);
        LReader := TStreamReader.Create(LPair.Value);
        try
          if Result <> '' then
            Result := Result + #13#10'============================'#13#10;
          Result := Result + LReader.ReadToEnd;  // TStringStream(LPair.Value).DataString;
        finally
          LReader.Free;
        end;
      end;
    finally
      LStreams.Free;
    end;
  finally
    LProxyGenerator.Free;
  end;
end;

type
  TProxyGeneratorEvents = class
  private
    FCreatingFiles: TFunc<TStrings, Boolean>;
    FCreatedFiles: TProc<TStrings>;
    constructor Create(  ACreatingFiles: TFunc<TStrings, Boolean>; ACreatedFiles: TProc<TStrings>);
    procedure CreatedFiles(Sender: TObject; Files: TStrings);
    procedure CreatingFiles(Sender: TObject; Files: TStrings; var Cancel: Boolean);
  end;

constructor TProxyGeneratorEvents.Create(ACreatingFiles: TFunc<TStrings, Boolean>; ACreatedFiles: TProc<TStrings>);
begin
  FCreatingFiles := ACreatingFiles;
  FCreatedFiles := ACreatedFiles;
end;

procedure TProxyGeneratorEvents.CreatedFiles(Sender: TObject; Files: TStrings);
begin
  if Assigned(FCreatedFiles) then
    FCreatedFiles(Files);
end;

procedure TProxyGeneratorEvents.CreatingFiles(Sender: TObject; Files: TStrings; var Cancel: Boolean);
begin
  if Assigned(FCreatingFiles) then
    Cancel := not FCreatingFiles(Files);
end;

class procedure TSampleProxyGenerator.GenerateFile(AMetaDataLoader: IDSProxyMetaDataLoader;
  ADirectory: String;
  const AUnitName, AExcludeClasses, AExcludeMethods, AIncludeClasses, AIncludeMethods: string;const  AWriter: string;
  ACreatingFiles: TFunc<TStrings, Boolean>; ACreatedFiles: TProc<TStrings>);
var
  LProxyGenerator: TDSProxyGenerator;
  LEvents: TProxyGeneratorEvents;
begin
  LProxyGenerator := TDSProxyGenerator.Create(nil);
  try
    LProxyGenerator.Writer := AWriter;
    SetProperties(LProxyGenerator,
      AUnitName, AExcludeClasses, AExcludeMethods, AIncludeClasses, AIncludeMethods);
    LProxyGenerator.TargetDirectory := ADirectory;
    LEvents := TProxyGeneratorEvents.Create(ACreatingFiles, ACreatedFiles);
    try
      LProxyGenerator.OnCreatingFiles := LEvents.CreatingFiles;
      LProxyGenerator.OnCreatedFiles := LEvents.CreatedFiles;
      LProxyGenerator.Write(AMetaDataLoader);
    finally
      LEvents.Free;
    end;
  finally
    LProxyGenerator.Free;
  end;
end;

class procedure TSampleProxyGenerator.SetProperties(AProxyGenerator: TDSProxyGenerator;
  AUnitName, AExcludeClasses, AExcludeMethods, AIncludeClasses, AIncludeMethods: string);
begin
  AProxyGenerator.TargetUnitName := AUnitName;
  AProxyGenerator.IncludeMethods := AIncludeMethods;
  AProxyGenerator.IncludeClasses := AIncludeClasses;
  AProxyGenerator.ExcludeMethods := AExcludeMethods;
  AProxyGenerator.ExcludeClasses := AExcludeClasses;
end;




end.
