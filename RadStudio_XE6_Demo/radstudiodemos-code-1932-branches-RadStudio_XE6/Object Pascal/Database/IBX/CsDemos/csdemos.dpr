
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program Csdemos;

uses
  Forms,
  Frmtrigg in 'FRMTRIGG.PAS' {FrmTriggerDemo},
  Frmviews in 'FRMVIEWS.PAS' {FrmViewDemo},
  Frmmain in 'FRMMAIN.PAS' {FrmLauncher},
  Frmqrysp in 'FRMQRYSP.PAS' {FrmQueryProc},
  Frmexesp in 'FRMEXESP.PAS' {FrmExecProc},
  Frmtrans in 'FRMTRANS.PAS' {FrmTransDemo},
  DmCSDemo in 'DmCSDemo.pas' {DmEmployee: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLauncher, FrmLauncher);
  Application.CreateForm(TDmEmployee, DmEmployee);
  Application.CreateForm(TFrmTriggerDemo, FrmTriggerDemo);
  Application.CreateForm(TFrmViewDemo, FrmViewDemo);
  Application.CreateForm(TFrmQueryProc, FrmQueryProc);
  Application.CreateForm(TFrmExecProc, FrmExecProc);
  Application.CreateForm(TFrmTransDemo, FrmTransDemo);
  Application.Run;
end.
