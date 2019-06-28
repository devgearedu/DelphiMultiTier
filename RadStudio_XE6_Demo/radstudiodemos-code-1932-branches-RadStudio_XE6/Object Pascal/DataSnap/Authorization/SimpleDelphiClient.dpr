program SimpleDelphiClient;

// Copyright (c) 2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

uses
  Vcl.Forms,
  SimpleClientFormUnit in 'SimpleClientFormUnit.pas' {Form58},
  HTTPProxyProtocol in 'HTTPProxyProtocol.pas',
  FilterUtils in 'FilterUtils.pas',
  PC1DynamicKey in 'PC1DynamicKey.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm58, Form58);
  Application.Run;
end.
