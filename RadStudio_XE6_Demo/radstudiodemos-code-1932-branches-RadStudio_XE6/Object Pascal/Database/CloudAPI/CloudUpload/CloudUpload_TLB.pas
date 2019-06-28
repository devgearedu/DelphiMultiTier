
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit CloudUpload_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 41028 $
// File generated on 7/22/2011 11:49:56 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\Andreano\Documents\RAD Studio\Projects\ShellExtension\CloudUpload2\CloudUpload (1)
// LIBID: {B17975E9-F04B-41BD-9D69-646E5B6942F8}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  CloudUploadMajorVersion = 1;
  CloudUploadMinorVersion = 0;

  LIBID_CloudUpload: TGUID = '{B17975E9-F04B-41BD-9D69-646E5B6942F8}';

  IID_ICloudUploadContextMenu: TGUID = '{2FF528EA-2C38-4B7A-884E-C1A3F91D6EC5}';
  CLASS_CloudUploadContextMenu: TGUID = '{BBAB3AF5-43D9-4C12-BC92-32CF83868822}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ICloudUploadContextMenu = interface;
  ICloudUploadContextMenuDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  CloudUploadContextMenu = ICloudUploadContextMenu;


// *********************************************************************//
// Interface: ICloudUploadContextMenu
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2FF528EA-2C38-4B7A-884E-C1A3F91D6EC5}
// *********************************************************************//
  ICloudUploadContextMenu = interface(IDispatch)
    ['{2FF528EA-2C38-4B7A-884E-C1A3F91D6EC5}']
  end;

// *********************************************************************//
// DispIntf:  ICloudUploadContextMenuDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2FF528EA-2C38-4B7A-884E-C1A3F91D6EC5}
// *********************************************************************//
  ICloudUploadContextMenuDisp = dispinterface
    ['{2FF528EA-2C38-4B7A-884E-C1A3F91D6EC5}']
  end;

// *********************************************************************//
// The Class CoCloudUploadContextMenu provides a Create and CreateRemote method to
// create instances of the default interface ICloudUploadContextMenu exposed by
// the CoClass CloudUploadContextMenu. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCloudUploadContextMenu = class
    class function Create: ICloudUploadContextMenu;
    class function CreateRemote(const MachineName: string): ICloudUploadContextMenu;
  end;

implementation

uses ComObj;

class function CoCloudUploadContextMenu.Create: ICloudUploadContextMenu;
begin
  Result := CreateComObject(CLASS_CloudUploadContextMenu) as ICloudUploadContextMenu;
end;

class function CoCloudUploadContextMenu.CreateRemote(const MachineName: string): ICloudUploadContextMenu;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CloudUploadContextMenu) as ICloudUploadContextMenu;
end;

end.

