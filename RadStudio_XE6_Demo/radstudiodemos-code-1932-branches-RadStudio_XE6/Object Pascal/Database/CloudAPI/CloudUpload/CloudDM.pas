
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit CloudDM;

interface

uses
  System.SysUtils, System.Classes, Data.Cloud.AzureAPI, Data.Cloud.CloudAPI,
  Data.Cloud.AmazonAPI, Winapi.Windows, IniFiles, IOUtils,
  System.Generics.Collections;

type
  TCloud = class(TDataModule)
    AzureConnection: TAzureConnectionInfo;
    AmazonConnection: TAmazonConnectionInfo;
  private
    { Private declarations }
    FHandle: HWND;
    function GetComputerandUserName: String;
    function UploadtoAmazon(FileName: String): TCloudResponseInfo;
    function UploadtoAzure(FileName: String): TCloudResponseInfo;
    function ContentOf(const FileName: String;
      RequiredSizeMod: Integer = 0): TBytes;
    procedure ShowResponseInfo(Title: String; Response: TCloudResponseInfo);
  public
    { Public declarations }

    function LoadConfiguration: Boolean;
    function Upload(FileName: String; Cloud: Integer): TCloudResponseInfo;

    class procedure SaveLog(s: String);
    constructor Create(AOWner: TComponent; Handle: HWND); reintroduce; overload;
  end;

var
  Cloud: TCloud;

Const
  AmazonIndex = 0;
  AzureIndex = 1;
  TClouds: Array [0 .. 1] of PWideChar = ('Amazon S3', 'Microsoft Azure');

implementation

uses CloudContainerList;

Const
  SMyAzureKey = 'MyAzureKey'; // do not translate
  SMyAmazonKey = 'MyAmazonKey'; // do not translate
  SInternetConfig = 'Internet Access Configuration'; // do not translate

  SAccountName = 'AccountName'; // do not translate
  SAccountKey = 'AccountKey'; // do not translate
  SProxyHost = 'ProxyHost'; // do not translate
  SProxyPort = 'ProxyPort'; // do not translate

  SStorageEndpoint = 'StorageBlobEndpoint'; // do not translate

  SMDPath = 'originalfilepath';
  SMDFrom = 'uploadfrom';
  SMDCreateby = 'createdby';

{$R *.dfm}
  { TCloudContainer }

function TCloud.ContentOf(const FileName: String;
  RequiredSizeMod: Integer): TBytes;
var
  fs: TFileStream;
begin
  if FileName <> EmptyStr then
  begin
    fs := TFileStream.Create(FileName, fmOpenRead);
    try
      if RequiredSizeMod < 1 then
        SetLength(Result, fs.Size)
      else
        SetLength(Result, ((fs.Size div RequiredSizeMod) + 1) *
          RequiredSizeMod);
      fs.ReadBuffer(Result[0], fs.Size);
    finally
      fs.Free;
    end;
  end
  else
    SetLength(Result, 0);

end;

constructor TCloud.Create(AOWner: TComponent; Handle: HWND);
begin
  inherited Create(AOWner);
  FHandle := Handle

end;

function TCloud.GetComputerandUserName: String;
var
  cName, uName: array [0 .. 255] of char;
  c: DWORD;
begin
  c := SizeOf(cName);

  GetComputerName(cName, c);
  GetUserName(uName, c);

  Result := StrPas(cName) + '\' + StrPas(uName);
end;

function TCloud.LoadConfiguration: Boolean;
var
  IniFile: string;
  Ini: TIniFile;
  Port: Integer;
  SUrl: String;
begin


  IniFile := GetHomePath + '\CloudUpload-Extension.ini';
  Ini := TIniFile.Create(IniFile);

  try
    // The ini file will be created in case it doesn't exist
    if not FileExists(IniFile) then
    begin
      // Azure parameters
      Ini.WriteString(SMyAzureKey, SAccountName, EmptyStr);
      Ini.WriteString(SMyAzureKey, SAccountKey, EmptyStr);
      Ini.WriteString(SMyAzureKey, SStorageEndpoint, EmptyStr);

      // Amazon parameters
      Ini.WriteString(SMyAmazonKey, SAccountName, EmptyStr);
      Ini.WriteString(SMyAmazonKey, SAccountKey, EmptyStr);
      Ini.WriteString(SMyAmazonKey, SStorageEndpoint, EmptyStr);

      // Internet access configuration
      Ini.WriteString(SInternetConfig, SProxyHost, EmptyStr);
      Ini.WriteString(SInternetConfig, SProxyPort, EmptyStr);

      Ini.UpdateFile;
      Result := False;
    end
    else
    begin

      TryStrToInt(Ini.ReadString(SInternetConfig, SProxyPort, '0'), Port);

      with AzureConnection do
      begin
        AccountName := Ini.ReadString(SMyAzureKey, SAccountName, EmptyStr);
        AccountKey := Ini.ReadString(SMyAzureKey, SAccountKey, EmptyStr);

        RequestProxyHost := Ini.ReadString(SInternetConfig, SProxyHost,
          EmptyStr);
        RequestProxyPort := Port;

        SUrl := Ini.ReadString(SMyAzureKey, SStorageEndpoint, EmptyStr);

        UseDefaultEndpoints := SUrl = EmptyStr;
        BlobEndpoint := SUrl;
      end;

      with AmazonConnection do
      begin
        AccountName := Ini.ReadString(SMyAmazonKey, SAccountName, EmptyStr);
        AccountKey := Ini.ReadString(SMyAmazonKey, SAccountKey, EmptyStr);

        RequestProxyHost := Ini.ReadString(SInternetConfig, SProxyHost,
          EmptyStr);
        RequestProxyPort := Port;

        SUrl := Ini.ReadString(SMyAmazonKey, SStorageEndpoint, EmptyStr);

        UseDefaultEndpoints := SUrl = EmptyStr;
        StorageEndpoint := SUrl;
      end;
      Result := True;
    end;

  finally
    Ini.Free;
  end;
end;

class procedure TCloud.SaveLog(s: String);
var
  LogFile: TextFile;
begin
  { open the log file }
  AssignFile(LogFile, 'c:\Shell.txt');
  if FileExists('c:\Shell.txt') then
    Append(LogFile)
  else
    Rewrite(LogFile);

  WriteLn(LogFile, s + #13#10);

  { write and close the logfile }
  CloseFile(LogFile);
end;

procedure TCloud.ShowResponseInfo(Title: String; Response: TCloudResponseInfo);
begin
  case Response.StatusCode of
    200, 201:
      MessageBox(FHandle, 'File Uploaded', PWideChar(Title), MB_OK);
  else
    MessageBox(FHandle, PWideChar('Error ' + Response.StatusMessage),
      PWideChar(Title), MB_ICONWARNING);
  end;
end;

function TCloud.Upload(FileName: String; Cloud: Integer): TCloudResponseInfo;
begin
  case Cloud of
    AmazonIndex:
      Result := UploadtoAmazon(FileName);
    AzureIndex:
      Result := UploadtoAzure(FileName);
  else
    Result := TCloudResponseInfo.Create;
  end;
end;

function TCloud.UploadtoAmazon(FileName: String): TCloudResponseInfo;
var
  StorageService: TAmazonStorageService;
  BucketList, Metadata: TStrings;
  Content: TBytes;
  ResponseList: TCloudResponseInfo;
  FrmList: TFrmContainerList;
  Act: TContainerAction;
  BucketName: String;
  I: Integer;
begin
  Result := TCloudResponseInfo.Create;

  if (FileName = EmptyStr) then
    Exit;

  StorageService := TAmazonStorageService.Create(AmazonConnection);

{$REGION 'Define the Bucket'}
  ResponseList := TCloudResponseInfo.Create;
  BucketList := StorageService.ListBuckets(ResponseList);

  if ResponseList.StatusCode = 200 then
  begin

    // Amazon return date/time information for each Bucket
    // this for is required to remove that information
    for I := 0 to BucketList.Count - 1 do
      BucketList[I] := BucketList.Names[I];

    FrmList := TFrmContainerList.Create(nil, BucketList, TClouds[AmazonIndex]);
    try
      FrmList.ShowModal;
      Act := FrmList.Action;

      case Act of
        caCreate:
          begin
            if StorageService.CreateBucket(FrmList.Container, amzbaNotSpecified,
              amzrNotSpecified, Result) then
              BucketName := FrmList.Container;
          end;
        caUpload:
          begin
            BucketName := FrmList.Container;
          end;
      end;
    finally
      FrmList.Free;
    end;

    if Act = TContainerAction.caNone then
      Exit;

  end;
{$ENDREGION}
  try

    Metadata := TStringList.Create;
    Metadata.Values[SMDPath] := ExtractFilePath(FileName);
    Metadata.Values[SMDFrom] := GetComputerandUserName;

    Content := ContentOf(FileName);

    FileName := StringReplace(FileName, ' ', '%20', [rfReplaceAll, rfIgnoreCase]);

    StorageService.UploadObject(BucketName, ExtractFileName(FileName), Content,
      False, Metadata, nil, amzbaPublicRead, Result);
    ShowResponseInfo(TClouds[AmazonIndex], Result);

  except
    on E: Exception do
    begin
      MessageBox(FHandle, PWideChar('Error ' + E.Message),
        TClouds[AmazonIndex], MB_OK);
    end;
  end;

  FreeAndNil(Metadata);
  FreeAndNil(StorageService);
end;

function TCloud.UploadtoAzure(FileName: String): TCloudResponseInfo;
var
  BlobService: TAzureBlobService;
  SList, Metadata: TStrings;
  ContainerList: TList<TAzureContainer>;
  ContainerObj: TAzureContainer;
  Content: TBytes;
  BlobName, ContainerName: String;
  ResponseList: TCloudResponseInfo;
  FrmList: TFrmContainerList;
  Act: TContainerAction;
begin

  Result := TCloudResponseInfo.Create;

  if (FileName = EmptyStr) then
    Exit;

  BlobService := TAzureBlobService.Create(AzureConnection);
  try

{$REGION 'Define the container'}
    ResponseList := TCloudResponseInfo.Create;
    ContainerList := BlobService.ListContainers(nil, ResponseList);
    Metadata := TStringList.Create;

    if ResponseList.StatusCode = 200 then
    begin

      SList := TStringList.Create;
      for ContainerObj in ContainerList do
        SList.Add(ContainerObj.Name);
      ContainerList.Free;

      FrmList := TFrmContainerList.Create(nil, SList, TClouds[AzureIndex]);
      try
        FrmList.ShowModal;
        Act := FrmList.Action;

        case Act of
          caCreate:
            begin
              Metadata.Values[SMDCreateby] := GetComputerandUserName;

              if BlobService.CreateContainer(FrmList.Container, Metadata,
                bpaBlob, Result) then
                ContainerName := FrmList.Container;
            end;
          caUpload:
            begin
              ContainerName := FrmList.Container;
            end;
        end;
      finally
        SList.Free;
        FrmList.Free;
      end;

      if Act = TContainerAction.caNone then
        Exit;

    end;
{$ENDREGION}

    Metadata.Clear;
    Metadata.Values[SMDPath] := ExtractFilePath(FileName);
    Metadata.Values[SMDFrom] := GetComputerandUserName;

    Content := ContentOf(FileName);
    BlobName := ExtractFileName(FileName);

    BlobService.PutBlockBlob(ContainerName, BlobName, Content, '', nil,
      Metadata, Result);
    ShowResponseInfo(TClouds[AzureIndex], Result);

  except
    on E: Exception do
    begin
      MessageBox(FHandle, PWideChar('Error ' + E.Message),
        TClouds[AzureIndex], MB_OK);
    end;
  end;

  FreeAndNil(ResponseList);
  FreeAndNil(Metadata);
  FreeAndNil(BlobService);

end;

end.
