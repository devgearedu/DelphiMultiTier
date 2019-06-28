
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit BufferListForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TBufferListFrm = class(TForm)
    BufferListBox: TListBox;
    OKButton: TButton;
    CancelButton: TButton;
    procedure BufferListBoxDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TBufferListFrm.BufferListBoxDblClick(Sender: TObject);
begin
  if BufferListBox.ItemIndex > -1 then ModalResult := mrOK;
end;

end.
