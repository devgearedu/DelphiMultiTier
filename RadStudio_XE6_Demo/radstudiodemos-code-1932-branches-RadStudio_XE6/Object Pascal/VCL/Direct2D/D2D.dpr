
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program D2D;

uses
  Windows,
  Dialogs,
  Forms,
  Sysutils,
  uMain in 'uMain.pas' {Form1};

{$R *.res}

function VerifyOS: boolean;
var
  Data: TOSVERSIONINFOEX;
  SysInfo: TSystemInfo;
begin
  Result := false;
  FillChar(Data, SizeOf(Data), 0); //#1 Adding this might solve the whole problem -JJS 10/12/2005
  Data.dwOSVersionInfoSize := SizeOf(Data);
  GetVersionEx(Data);

    // accept Windows 7 beta or later
  if (Data.dwMajorVersion >= 6) then
    if (Data.dwMinorVersion >= 1) or (Data.dwMajorVersion > 6) then
      Result := true;
end;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  if not VerifyOS then
  begin
    ShowMessage('This example requires Windows 7 or later, Ok to exit');
    Exit;
  end;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
