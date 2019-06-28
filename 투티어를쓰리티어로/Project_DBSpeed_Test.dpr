program Project_DBSpeed_Test;

uses
  Vcl.Forms,
  uDBSpeed_Test in 'uDBSpeed_Test.pas' {TestForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestForm, TestForm);
  Application.Run;
end.
