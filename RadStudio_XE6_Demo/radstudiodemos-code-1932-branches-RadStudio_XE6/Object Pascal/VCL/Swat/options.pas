
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit options;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TOptionsDlg = class(TForm)
    Bevel1: TBevel;
    Slow: TLabel;
    Fast: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Speed: TLabel;
    Population: TLabel;
    Time: TLabel;
    OKBtn: TButton;
    CancelBtn: TButton;
    SpeedSet: TTrackBar;
    PopulationSet: TTrackBar;
    GameTimeSet: TEdit;
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptionsDlg: TOptionsDlg;

implementation

uses Main;

{$R *.dfm}

procedure TOptionsDlg.OKBtnClick(Sender: TObject);
begin
  SwatForm.LiveTime := SpeedSet.Max + 1 - SpeedSet.Position;
  SwatForm.Frequence := PopulationSet.Position;
  SwatForm.GameTime := StrToInt(GameTimeSet.Text);

  // limit the value of GameTime to a reasonable length
  if (SwatForm.GameTime < 1) then
    SwatForm.GameTime := 150;
  if (SwatForm.GameTime > 9999) then
    SwatForm.GameTime := 9999;
end;

procedure TOptionsDlg.FormShow(Sender: TObject);
begin
  SpeedSet.Position := SpeedSet.Max + 1 - SwatForm.LiveTime;
  PopulationSet.Position := SwatForm.Frequence;
  GameTimeSet.Text := inttoStr(SwatForm.GameTime);
end;

end.
