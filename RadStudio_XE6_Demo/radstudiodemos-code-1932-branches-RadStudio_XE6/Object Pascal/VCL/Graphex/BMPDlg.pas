
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit BMPDlg;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TNewBMPForm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    WidthEdit: TEdit;
    Label2: TLabel;
    HeightEdit: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewBMPForm: TNewBMPForm;

implementation

{$R *.dfm}

end.
