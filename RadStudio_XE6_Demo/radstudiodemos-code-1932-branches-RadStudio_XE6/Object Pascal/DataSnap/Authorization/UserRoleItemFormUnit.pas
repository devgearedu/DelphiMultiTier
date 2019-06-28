
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit UserRoleItemFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TUserRoleItemForm = class(TForm)
    ButtonCancel: TButton;
    ButtonOK: TButton;
    EditRoles: TEdit;
    Label2: TLabel;
    EditUserNames: TEdit;
    Label1: TLabel;
    procedure ButtonOKClick(Sender: TObject);
  private
    procedure CheckDelimiters(AEdit: TEdit);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserRoleItemForm: TUserRoleItemForm;

implementation

{$R *.dfm}

procedure TUserRoleItemForm.CheckDelimiters(AEdit: TEdit);
begin
  AEdit.Text := Trim(AEdit.Text);
  if FindDelimiter(';',AEdit.Text) > 0 then
    raise Exception.Create('Invalid delimiter.  Use '',''.');
end;

procedure TUserRoleItemForm.ButtonOKClick(Sender: TObject);
begin
  try
    CheckDelimiters(EditUserNames);
    CheckDelimiters(EditRoles);
  except
    on E: Exception do
    begin
      Self.ModalResult := mrNone;
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;

end;

end.
