program procject_Client_RestConnection;

uses
  Vcl.Forms,
  umain_client_restconnection in 'umain_client_restconnection.pas' {Form18},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  UDM in 'UDM.pas' {Dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm18, Form18);
  Application.CreateForm(TDm, Dm);
  Application.Run;
end.
