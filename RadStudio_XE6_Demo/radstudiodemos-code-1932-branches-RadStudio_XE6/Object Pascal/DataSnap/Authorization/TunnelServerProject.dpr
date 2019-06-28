program TunnelServerProject;

// Copyright (c) 2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

uses
  Forms,
  TunnelServerFormUnit in 'TunnelServerFormUnit.pas' {Form52},
  TunnelServerContainerUnit in 'TunnelServerContainerUnit.pas' {ServerContainer5: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm52, Form52);
  Application.CreateForm(TServerContainer5, ServerContainer5);
  Application.Run;
end.

