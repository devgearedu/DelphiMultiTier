
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FishFactsServerMethods;

interface

uses
  SysUtils, Classes, DSServer, DB, DBTables, DBXCommon, DBXDBReaders, System.JSON,
  DBClient, DataModule;

type
{$METHODINFO ON}
  TFishFactsServerMethods = class(TComponent)
  private
    FDataModule: TFactsDataModule;
    procedure GetKeys(const Container: TJSONArray); overload;
    function DataModule: TFactsDataModule;
  public
    function ReverseString(Value: string): string;
    function GetKeys: TJSONArray; overload;
    function GetImage(Key: String): TStream;
    function GetFacts(const AKey: string;
      out ASpeciesName: string;
      out ACategory: string;
      out ACommonName: string;
      out ALengthIn: Double;
      out ALengthCm: Double): Boolean;
    function GetNotes(const AKey: string;
      out ANotes: string): Boolean;
  end;
{$METHODINFO OFF}

implementation

uses StrUtils, HTTPApp, Types, Graphics, Jpeg;

function TFishFactsServerMethods.DataModule: TFactsDataModule;
begin
  if FDataModule = nil then
    FDataModule := TFactsDataModule.Create(Self);
  Result := FDataModule;
end;

function TFishFactsServerMethods.GetFacts(const AKey: string;
  out ASpeciesName: string;
  out ACategory: string;
  out ACommonName: string;
  out ALengthIn: Double;
  out ALengthCm: Double): Boolean;

var
  LLocated: Boolean;
begin
  ASpeciesName := '';
  ACategory := '';
  ACommonName := '';
  ALengthIn := 0;
  ALengthCm := 0;
  DataModule.Table1.Active := True;
  try
    try
      LLocated :=  DataModule.Table1.Locate(DataModule.Table1SpeciesNo.FieldName, AKey, [loCaseInsensitive]);
    except
      LLocated := False;
    end;
    if LLocated then
    begin
      ASpeciesName := DataModule.Table1SpeciesName.AsString;
      ACategory := DataModule.Table1Category.AsString;
      ACommonName := DataModule.Table1Common_Name.AsString;
      ALengthIn := DataModule.Table1Length_In.AsFloat;
      ALengthCm := DataModule.Table1Lengthcm.AsFloat;
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  finally
     DataModule.Table1.Active := False;
  end;
end;

function TFishFactsServerMethods.GetImage(Key: String): TStream;
var
  LStream: TStream;
  LPicture: TPicture;
  LJPG: TJPEGImage;
begin
  Result := nil;
  DataModule.Table1.Active := True;
  try
    if DataModule.Table1.Locate(DataModule.Table1SpeciesNo.FieldName, Key,
      [loCaseInsensitive]) then
    begin
      LStream := TMemoryStream.Create;
      try
        LPicture := TPicture.Create;
        try
          LPicture.Assign(DataModule.Table1Graphic);
          LJPG := TJPEGImage.Create;
          try
            LJPG.Assign(LPicture.Graphic);
            LJPG.SaveToStream(LStream);
          finally
            LJPG.Free;
          end;
        finally
          LPicture.Free;
        end;
        LStream.Position := 0;
        Result := LStream;
        Exit;
      except
        FreeAndNil(LStream);
        raise;
      end;
    end;
  finally
    DataModule.Table1.Active := False;
  end;
end;

function TFishFactsServerMethods.GetKeys: TJSONArray;
var
  Container: TJSONArray;
begin
  Container := TJSONArray.Create;
  GetKeys(Container);
  Result := Container;
end;

function TFishFactsServerMethods.GetNotes(const AKey: string;
  out ANotes: string): Boolean;
var
  LLocated: Boolean;
begin
  ANotes := '';
  DataModule.Table1.Active := True;
  try
    try
      LLocated :=  DataModule.Table1.Locate(DataModule.Table1SpeciesNo.FieldName, AKey, [loCaseInsensitive]);
    except
      LLocated := False;
    end;
    if LLocated then
    begin
      ANotes := DataModule.Table1Notes.AsString;
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  finally
     DataModule.Table1.Active := False;
  end;
end;

procedure TFishFactsServerMethods.GetKeys(const Container: TJSONArray);
begin
  DataModule.Table1.Active := True;
  try
    DataModule.Table1.First;
    while not DataModule.Table1.Eof do
    begin
      Container.AddElement(TJSONString.Create(DataModule.Table1SpeciesNo.AsString));
      DataModule.Table1.Next;
    end;
  finally
    DataModule.Table1.Active := False;
  end;
end;

function TFishFactsServerMethods.ReverseString(Value: string): string;
begin
  Result := StrUtils.ReverseString(Value);
end;
end.

