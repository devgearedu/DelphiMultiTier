program Oracle_NestedCursors;

uses
  Forms,
  fNestedCursors in 'fNestedCursors.pas' {frmNestedCursors};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmNestedCursors, frmNestedCursors);
  Application.Run;
end.
