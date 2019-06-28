program Project_Server;

uses
  Vcl.Forms,
  UMain_Server in 'UMain_Server.pas' {Form17},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas',
  ServerContainerUnit2 in 'ServerContainerUnit2.pas' {ServerContainer2: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TForm17, Form17);
  Application.CreateForm(TServerContainer2, ServerContainer2);
  Application.Run;
end.

