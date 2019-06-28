program Project1;

uses
  Forms,
  dmMainBase in '..\..\..\..\dmMainBase.pas' {dmlMainBase: TDataModule},
  dmMainComp in '..\..\..\dmMainComp.pas' {dmlMainComp: TDataModule},
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
