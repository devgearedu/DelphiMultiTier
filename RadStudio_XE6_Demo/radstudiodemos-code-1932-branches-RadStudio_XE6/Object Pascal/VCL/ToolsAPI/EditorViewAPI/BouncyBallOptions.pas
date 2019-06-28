
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit BouncyBallOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TBouncyBallOptionsFrame = class(TFrame)
    lbColor: TLabel;
    BallColorBox: TColorBox;
    CycleColorsCB: TCheckBox;
    lbHStep: TLabel;
    lbVStep: TLabel;
    HStepEdit: TEdit;
    VStepEdit: TEdit;
    HStepUpDown: TUpDown;
    VStepUpDown: TUpDown;
    UseExistingCB: TCheckBox;
    procedure BallColorBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TBouncyBallOptionsFrame.BallColorBoxChange(Sender: TObject);
begin
  CycleColorsCB.Checked := False;
end;

end.
