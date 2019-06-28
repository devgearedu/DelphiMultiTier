program ChatRoomServerProject_XE2;

{$R *.dres}

uses
  Forms,
  ChatRoomServerContainer in 'ChatRoomServerContainer.pas' {ServerContainerForm: TDataModule},
  ChatRoomServerMethodsUnit in 'ChatRoomServerMethodsUnit.pas' {ChatRoomServerMethods: TDSServerModule},
  ChatRoomServerUnit in 'ChatRoomServerUnit.pas' {ChatRoomForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainerForm, ServerContainerForm);
  Application.CreateForm(TChatRoomForm, ChatRoomForm);
  Application.Run;
end.

