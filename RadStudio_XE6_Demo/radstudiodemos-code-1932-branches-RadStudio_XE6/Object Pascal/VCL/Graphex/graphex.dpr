
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program GraphEx;

uses
  Forms,
  GraphWin in 'GraphWin.pas' {Form1},
  BMPDlg in 'BMPDlg.pas' {NewBMPForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TNewBMPForm, NewBMPForm);
  Application.Run;
end.
