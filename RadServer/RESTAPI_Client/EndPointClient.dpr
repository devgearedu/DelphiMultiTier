program EndPointClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainForm in 'MainForm.pas' {Form1},
  DataAccessModule in 'DataAccessModule.pas' {dmDataAccess: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmDataAccess, dmDataAccess);
  Application.Run;
end.
