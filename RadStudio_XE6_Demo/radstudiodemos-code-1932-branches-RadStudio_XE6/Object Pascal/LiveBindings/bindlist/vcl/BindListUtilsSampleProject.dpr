
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program BindListUtilsSampleProject;

uses
  Vcl.Forms,
  BindListUtilsSampleFormUnit in 'BindListUtilsSampleFormUnit.pas' {Form38},
  BindListUtils in '..\BindListUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm38, Form38);
  Application.Run;
end.
