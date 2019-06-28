
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit frmConnectU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmConnect = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    edtDatabase: TEdit;
    edtUser: TEdit;
    edtPassword: TEdit;
    edtRole: TEdit;
    btnBrowse: TButton;
    dlgOpen: TOpenDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure edtDatabaseChange(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConnect: TfrmConnect;

implementation

{$R *.dfm}

procedure TfrmConnect.edtDatabaseChange(Sender: TObject);
begin
  if (edtDatabase.Text <> '') and (edtUser.Text <> '')
     and (edtPassword.Text <> '') then
    btnOk.Enabled := true
  else
    btnOK.Enabled := false;
end;

procedure TfrmConnect.btnBrowseClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edtDatabase.Text := dlgOpen.FileName;
end;

end.
