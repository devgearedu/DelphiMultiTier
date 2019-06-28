program BlobStreams;

uses
  Vcl.Forms,
  fBlobStr in 'fBlobStr.pas' {frmBlobStr};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmBlobStr, frmBlobStr);
  Application.Run;
end.
