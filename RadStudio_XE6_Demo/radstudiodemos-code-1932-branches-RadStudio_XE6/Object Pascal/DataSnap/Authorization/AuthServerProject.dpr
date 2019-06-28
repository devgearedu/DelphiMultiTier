program AuthServerProject;

// Copyright (c) 2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

uses
  Forms,
  FormUnit in 'FormUnit.pas' {Form36},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas',
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule},
  UsersAndRoles in 'UsersAndRoles.pas',
  SimpleServerClass in 'SimpleServerClass.pas',
  UserRoleItemFormUnit in 'UserRoleItemFormUnit.pas' {UserRoleItemForm},
  RoleItemFormUnit in 'RoleItemFormUnit.pas' {RoleItemForm},
  ServerUtils in 'ServerUtils.pas',
  FilterUtils in 'FilterUtils.pas',
  PC1DynamicKey in 'PC1DynamicKey.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.CreateForm(TForm36, Form36);
  Application.CreateForm(TRoleItemForm, RoleItemForm);
  Application.CreateForm(TUserRoleItemForm, UserRoleItemForm);
  Application.Run;
end.

