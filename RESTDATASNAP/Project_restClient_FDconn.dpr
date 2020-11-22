program Project_restClient_FDconn;

uses
  Vcl.Forms,
  Umain_Client_FDConnection in 'Umain_Client_FDConnection.pas' {Form18};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm18, Form18);
  Application.Run;
end.
