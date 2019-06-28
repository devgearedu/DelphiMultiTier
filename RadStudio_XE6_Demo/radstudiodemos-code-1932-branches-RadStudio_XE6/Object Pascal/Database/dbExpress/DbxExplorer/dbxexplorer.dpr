
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program dbxexplorer;

uses
  SysUtils,
  Forms,
  dbxexplore in 'dbxexplore.pas' {Form1};

{$R *.res}

begin
  {$IFDEF WIN32}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
  {$ELSE}
  raise Exception.Create('This demo is supported and to be run under Win32 only!');
  {$ENDIF}
end.
