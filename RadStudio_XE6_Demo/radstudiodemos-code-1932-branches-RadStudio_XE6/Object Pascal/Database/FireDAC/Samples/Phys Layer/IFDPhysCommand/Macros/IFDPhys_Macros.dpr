program IFDPhys_Macros;

uses
  Forms,
  fMacros in 'fMacros.pas' {frmMacros},
  dmMainBase in '..\..\..\dmMainBase.pas' {dmlMainBase: TDataModule},
  fMainBase in '..\..\..\fMainBase.pas' {frmMainBase},
  fMainConnectionDefBase in '..\..\..\fMainConnectionDefBase.pas' {frmMainConnectionDefBase},
  fMainLayers in '..\..\..\fMainLayers.pas' {frmMainLayers},
  uDatSUtils in '..\..\..\uDatSUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmlMainBase, dmlMainBase);
  Application.CreateForm(TfrmMacros, frmMacros);
  Application.Run;
end.
