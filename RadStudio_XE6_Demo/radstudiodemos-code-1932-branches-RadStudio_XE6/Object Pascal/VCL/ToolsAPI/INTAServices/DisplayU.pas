
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DisplayU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtDlgs, ExtCtrls, Buttons;

type
  TDisplayForm = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure ComboBox1Change(Sender: TObject);
    procedure DisplayFormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DisplayForm: TDisplayForm;

implementation

{$R *.dfm}

procedure TDisplayForm.ComboBox1Change(Sender: TObject);
begin
  ComboBox1.Text := ComboBox1.SelText;
end;

procedure TDisplayForm.DisplayFormShow(Sender: TObject);
begin
  ComboBox1.Text := ComboBox1.items[1];
end;

procedure TDisplayForm.Button1Click(Sender: TObject);
begin
//Make sure you load a "correct" toolbutton, you fail later when
//you try to add it to the IDE's image list.

//The Open dialog is set to the shared borland images directory.
  if OpenPictureDialog1.Execute then
    Image1.Picture.LoadFromFile(OpenPictureDialog1.filename);
end;

end.
