program Qry_SchemaAdapter;

uses
  Forms,
  dmMainBase in '..\..\..\..\dmMainBase.pas' {dmlMainBase: TDataModule},
  dmMainComp in '..\..\..\dmMainComp.pas' {dmlMainComp: TdmlMainComp},
  fMainBase in '..\..\..\..\fMainBase.pas' {frmMainBase},
  fMainConnectionDefBase in '..\..\..\..\fMainConnectionDefBase.pas' {frmMainConnectionDefBase},
  fMainCompBase in '..\..\..\fMainCompBase.pas' {frmMainCompBase},
  fMainQueryBase in '..\..\fMainQueryBase.pas' {frmMainQueryBase},
  fSchemaAdapter in 'fSchemaAdapter.pas' {frmSchemaAdapter};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmlMainComp, dmlMainComp);
  Application.CreateForm(TfrmSchemaAdapter, frmSchemaAdapter);
  Application.Run;
end.
