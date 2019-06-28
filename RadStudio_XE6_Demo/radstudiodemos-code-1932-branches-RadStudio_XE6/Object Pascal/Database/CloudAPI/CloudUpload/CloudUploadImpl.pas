
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit CloudUploadImpl;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  System.Win.ComObj, Winapi.ActiveX, CloudUpload_TLB, System.Win.StdVCL,
  Winapi.ShlObj, Winapi.Windows, Winapi.ShellAPI;

type

  TCloudUploadContextMenu = class(TAutoObject, ICloudUploadContextMenu,
    IShellExtInit, IContextMenu)
  private
    FFileName: string;
    FMenuItemIndex: UINT;
    procedure Upload(Handle: HWND; Cloud: Integer; FileName: String);
  protected
    { IShellExtInit Methods }
    { Initialize the context menu if a files was selected}
    function IShellExtInit.Initialize = ShellExtInitialize;
    function ShellExtInitialize(pidlFolder: PItemIDList; lpdobj: IDataObject;
      hKeyProgID: HKEY): HResult; stdcall;

    { IContextMenu Methods }
    { Initializes the context menu and it decides which items appear in it,
      based on the flags you pass }
    function QueryContextMenu(Menu: HMENU; indexMenu, idCmdFirst, idCmdLast,
      uFlags: UINT): HResult; stdcall;

    { Execute the command, which will be the upload to Amazon or Azure}
    function InvokeCommand(var lpici: TCMInvokeCommandInfo): HResult; stdcall;
    { Set help string on the Explorer status bar when the menu item is selected }
    function GetCommandString(idCmd: UINT_PTR; uFlags: UINT; pwReserved: PUINT;
      pszName: LPSTR; cchMax: UINT): HResult; stdcall;

  end;

  { the new class factory }
  TCloudUploadObjectFactory = class(TAutoObjectFactory)
  protected
    procedure ApproveShellExtension(&Register: Boolean; const ClsID: string);
    function GetProgID: string; override;
  public
    procedure UpdateRegistry(Register: Boolean); override;
  end;

implementation

uses CloudDM, System.Win.ComServ, System.SysUtils, System.Win.Registry,
  Data.Cloud.CloudAPI;

{ TCloudUploadImpl }

// Upload the files in to the Cloud
procedure TCloudUploadContextMenu.Upload(Handle: HWND; Cloud: Integer;
  FileName: String);
var
  Container: TCloud;
  ResponseInfo: TCloudResponseInfo;
begin
  try
    Container := TCloud.Create(nil, Handle);
    if Container.LoadConfiguration then
      ResponseInfo := Container.Upload(FileName, Cloud)
    else
      MessageBox(Handle,
        PWideChar('Please, provide the parameters on the ini file'),
        'Cloud Upload', MB_ICONWARNING);

  finally
    Container.Free;
  end;
end;

function TCloudUploadContextMenu.GetCommandString(idCmd: UINT_PTR; uFlags: UINT;
  pwReserved: PUINT; pszName: LPSTR; cchMax: UINT): HResult;
begin
  Result := E_INVALIDARG;

  { Set help string on the Explorer status bar when the menu item is selected }
  if (idCmd in [AmazonIndex, AzureIndex]) and (uFlags = GCS_HELPTEXT) then
  begin
    StrLCopy(PWideChar(pszName), PWideChar('Copy the selected file to ' +
      TClouds[idCmd]), cchMax);
    Result := NOERROR;
  end;

end;

function TCloudUploadContextMenu.InvokeCommand
  (var lpici: TCMInvokeCommandInfo): HResult;
var
  Item: Word;
begin
  Result := E_FAIL;

  if HiWord(Integer(lpici.lpVerb)) <> 0 then
    Exit;

  { if the index matches the index for the menu, show the cloud options }
  Item := LoWord(Integer(lpici.lpVerb));

  if Item in [AmazonIndex, AzureIndex] then
  begin
    try
      Upload(lpici.HWND, Item, FFileName);
    except
      on E: Exception do
        MessageBox(lpici.hwnd, PWideChar(E.Message), 'Cloud Upload', MB_ICONERROR);

    end;
    Result := NOERROR;
  end;

end;

function TCloudUploadContextMenu.QueryContextMenu(Menu: HMENU;
  indexMenu, idCmdFirst, idCmdLast, uFlags: UINT): HResult;
var
  CloudMenuItem: TMenuItemInfo;
  MenuCaption: String;
  SubMenu: HMENU;
  uId: UINT;
begin
  { only adding one menu CloudMenuItem, so generate the result code accordingly }
  Result := MakeResult(SEVERITY_SUCCESS, 0, 3);

  { store the menu CloudMenuItem index }
  FMenuItemIndex := indexMenu;

  { specify what the menu says, depending on where it was spawned }
  if (uFlags = CMF_NORMAL) then // from the desktop
    MenuCaption := 'Send file from Desktop to the Cloud'
  else if (uFlags and CMF_VERBSONLY) = CMF_VERBSONLY then // from a shortcut
    MenuCaption := 'Send file from Shourtcut to the Cloud'
  else if (uFlags and CMF_EXPLORE) = CMF_EXPLORE then // from explorer
    MenuCaption := 'Send file from Explorer to the Cloud'
  else
    { fail for any other value }
    Result := E_FAIL;

  if Result <> E_FAIL then
  begin

    SubMenu := CreatePopupMenu;

    uId := idCmdFirst;
    InsertMenu(SubMenu, AmazonIndex, MF_BYPOSITION, uId, TClouds[AmazonIndex]);

    Inc(uId);
    InsertMenu(SubMenu, AzureIndex, MF_BYPOSITION, uId, TClouds[AzureIndex]);

    FillChar(CloudMenuItem, SizeOf(TMenuItemInfo), #0);
    CloudMenuItem.cbSize := SizeOf(TMenuItemInfo);
    CloudMenuItem.fMask := MIIM_SUBMENU or MIIM_STRING or MIIM_ID;
    CloudMenuItem.fType := MFT_STRING;
    CloudMenuItem.wID := FMenuItemIndex;
    CloudMenuItem.hSubMenu := SubMenu;
    CloudMenuItem.dwTypeData := PWideChar(MenuCaption);
    CloudMenuItem.cch := Length(MenuCaption);

    InsertMenuItem(Menu, indexMenu, True, CloudMenuItem);
  end;
end;

function TCloudUploadContextMenu.ShellExtInitialize(pidlFolder: PItemIDList;
  lpdobj: IDataObject; hKeyProgID: HKEY): HResult;
var
  DataFormat: TFormatEtc;
  StrgMedium: TStgMedium;
  Buffer: array [0 .. MAX_PATH] of Char;
begin
  Result := E_FAIL;

  { Check if an object was defined }
  if lpdobj = nil then
    Exit;

  { Prepare to get information about the object }
  DataFormat.cfFormat := CF_HDROP;
  DataFormat.ptd := nil;
  DataFormat.dwAspect := DVASPECT_CONTENT;
  DataFormat.lindex := -1;
  DataFormat.tymed := TYMED_HGLOBAL;

  if lpdobj.GetData(DataFormat, StrgMedium) <> S_OK then
    Exit;

  { The implementation now support only one file }
  if DragQueryFile(StrgMedium.hGlobal, $FFFFFFFF, nil, 0) = 1 then
  begin
    SetLength(FFileName, MAX_PATH);
    DragQueryFile(StrgMedium.hGlobal, 0, @Buffer, SizeOf(Buffer));
    FFileName := Buffer;
    Result := NOERROR;
  end
  else
  begin
    // Don't show the Menu if more then one file was selected
    FFileName := EmptyStr;
    Result := E_FAIL;
  end;

  { http://msdn.microsoft.com/en-us/library/ms693491(v=vs.85).aspx }
  ReleaseStgMedium(StrgMedium);

end;

{ TCloudUploadObjectFactory }

{ Required to registration for Windows NT/2000 }
procedure TCloudUploadObjectFactory.ApproveShellExtension(&Register: Boolean;
  const ClsID: string);
Const
  WinNTRegKey =
    'SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved';
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;

  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    if not Reg.OpenKey(WinNTRegKey, True) then
      Exit;

    { register the extension appropriately }
    if &Register then
      Reg.WriteString(ClsID, Description)
    else
      Reg.DeleteValue(ClsID);
  finally
    Reg.Free;
  end;

end;

function TCloudUploadObjectFactory.GetProgID: string;
begin
  { ProgID not required for shell extensions }
  Result := '';
end;

procedure TCloudUploadObjectFactory.UpdateRegistry(Register: Boolean);
Const
  ContextKey = '*\shellex\ContextMenuHandlers\%s';
begin
  { perform normal registration }
  inherited UpdateRegistry(Register);

  { Registration required for Windows NT/2000 }
  ApproveShellExtension(Register, GUIDToString(ClassID));

  { if this server is being registered, register the required key/values
    to expose it to Explorer }
  if Register then
    CreateRegKey(Format(ContextKey, [ClassName]), '', GUIDToString(ClassID),
      HKEY_CLASSES_ROOT)
  else
    DeleteRegKey(Format(ContextKey, [ClassName]));

end;

initialization

TCloudUploadObjectFactory.Create(ComServer, TCloudUploadContextMenu,
  CLASS_CloudUploadContextMenu, ciMultiInstance, tmApartment);

end.
