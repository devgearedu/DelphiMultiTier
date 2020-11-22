program RestMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  MoBileForm in 'MoBileForm.pas' {Form19},
  DataAcessModule in 'DataAcessModule.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm19, Form19);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
