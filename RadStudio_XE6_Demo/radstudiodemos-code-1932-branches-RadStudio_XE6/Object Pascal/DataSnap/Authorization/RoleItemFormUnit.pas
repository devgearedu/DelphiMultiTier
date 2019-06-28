
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit RoleItemFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TRoleItemForm = class(TForm)
    Label1: TLabel;
    EditApplyTo: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditAuthorizedRoles: TEdit;
    EditDeniedRoles: TEdit;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    procedure ButtonOKClick(Sender: TObject);
  private
    procedure CheckDelimiters(AEdit: TEdit);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RoleItemForm: TRoleItemForm;

implementation

{$R *.dfm}

procedure TRoleItemForm.CheckDelimiters(AEdit: TEdit);
begin
  AEdit.Text := Trim(AEdit.Text);
  if FindDelimiter(';',AEdit.Text) > 0 then
    raise Exception.Create('Invalid delimiter.  Use '',''.');
end;

procedure TRoleItemForm.ButtonOKClick(Sender: TObject);
begin
  try
    CheckDelimiters(EditApplyTo);
    CheckDelimiters(EditAuthorizedRoles);
    CheckDelimiters(EditDeniedRoles);
  except
    on E: Exception do
    begin
      Self.ModalResult := mrNone;
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;

end;

end.
