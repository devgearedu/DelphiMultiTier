
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
library CloudUpload;

uses
  ComServ,
  CloudUpload_TLB in 'CloudUpload_TLB.pas',
  CloudUploadImpl in 'CloudUploadImpl.pas' {CloudUploadImpl: CoClass},
  CloudDM in 'CloudDM.pas' {Cloud: TDataModule},
  CloudContainerList in 'CloudContainerList.pas' {FrmContainerList};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.TLB}

{$R *.RES}

begin
end.
