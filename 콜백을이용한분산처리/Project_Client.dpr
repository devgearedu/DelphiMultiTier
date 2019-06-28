program Project_Client;

uses
  Vcl.Forms,
  Umain_client in 'UMain_Client.pas' {MainForm_Client};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm_Client, MainForm_Client);
  Application.Run;
end.
