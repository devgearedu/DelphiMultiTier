program BookClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  ClientForm in 'ClientForm.pas' {Form1},
  DataAccessModule in 'DataAccessModule.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
