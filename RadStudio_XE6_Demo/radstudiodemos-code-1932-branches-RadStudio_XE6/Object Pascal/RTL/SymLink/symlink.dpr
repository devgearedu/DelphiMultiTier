
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program symlink;

{$APPTYPE CONSOLE}

uses
  SysUtils, IOUtils;

var
  LinkName, TargetName: string;
  Success: Boolean;
begin
{$IFDEF MSWINDOWS}
  if not CheckWin32Version(6, 0) then
  begin
    WriteLn('must be run on Windows Vista or later');
    Exit;
  end;
{$ENDIF MSWINDOWS}

  try
    Success := False;

    if ParamCount = 2 then
    begin
      LinkName := ParamStr(0);
      TargetName := ParamStr(1);
      Success := True;
    end;

    if Success then
    begin
      if TFile.Exists(LinkName) then
      begin
        WriteLn(Format('symlink: %s: File exists', [LinkName]));
        Exit;
      end;

      if not TFile.CreateSymLink(LinkName, TargetName) then
        Success := False;
    end;

    if not Success then
      WriteLn('usage: symlink [link file] [target file]');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
