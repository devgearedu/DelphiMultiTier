program Project30;

uses
  Forms,
  Unit30 in 'Unit30.pas' {Form30};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm30, Form30);
  Application.Run;
end.
