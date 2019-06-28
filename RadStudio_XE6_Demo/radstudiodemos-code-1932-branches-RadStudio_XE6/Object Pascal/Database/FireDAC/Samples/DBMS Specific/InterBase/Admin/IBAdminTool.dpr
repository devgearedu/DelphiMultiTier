program IBAdminTool;

uses
  FMX.Forms,
  AdminUtility in 'AdminUtility.pas' {Form14},
  dmAdmin in 'dmAdmin.pas' {AdminDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAdminDM, AdminDM);
  Application.CreateForm(TForm14, Form14);
  Application.Run;
end.
