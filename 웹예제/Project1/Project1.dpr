program Project1;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  Unit23 in 'Unit23.pas' {IWForm23: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  Unit1 in 'Unit1.pas' {IWForm1: TIWAppForm};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
