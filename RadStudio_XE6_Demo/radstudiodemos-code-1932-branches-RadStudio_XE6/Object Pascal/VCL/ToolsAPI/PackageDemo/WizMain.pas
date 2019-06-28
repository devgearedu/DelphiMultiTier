
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit WizMain;

interface

uses
  Windows, ToolsAPI, Forms, Dialogs, FrmMain, SysUtils, Graphics;

type
  TMenuIOTATest = class(TNotifierObject, IOTAWIzard, IOTAMenuWizard)
  public
    function GetMenuText: string;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
  end;

procedure Register;

var
  PackageTest: IOTAPackageServices;
  PackageForm: TForm2;

implementation

procedure Register;
begin
  RegisterPackageWizard(TMenuIOTATest.create as IOTAWizard);
end;

procedure InitExpert;
begin
  PackageTest := (BorlandIDEServices as IOTAPackageServices);
end;

procedure DoneExpert;
begin
  { stubbed out }
end;

{ TMenuIOTATest }

procedure TMenuIOTATest.Execute;
var
  i: Integer;
  
begin
  if BorlandIDEServices <> nil then
  begin
   PackageForm := TForm2.create(Nil);
   with PackageForm do
     {Package information}
     for i := 0 to PackageTest.GetPackageCount-1 do
       ListBox1.Items.Add(PackageTest.GetPackageName(i));

   PackageForm.ShowModal;
   PackageForm.Free;
  end;
end;

function TMenuIOTATest.GetIDString: string;
begin
  Result := 'PackageInfoMenuId';
end;

function TMenuIOTATest.GetMenuText: string;
begin
  Result := 'Packa&ge Info';
end;

function TMenuIOTATest.GetName: string;
begin
  Result := 'PackageInfoMenu';
end;

function TMenuIOTATest.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

initialization
  InitExpert;

finalization
  DoneExpert;

end.
