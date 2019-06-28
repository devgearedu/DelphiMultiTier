
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program FramesDemo;

uses
  Forms,
  FrmData in 'FrmData.pas' {DataFrame: TFrame},
  FrmFancy in 'FrmFancy.pas' {FancyFrame: TFrame},
  FrmMD in 'FrmMD.pas' {MasterDetailFrame: TFrame},
  FrmMain in 'FrmMain.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
