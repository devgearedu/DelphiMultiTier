
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutDialog = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    OKButton: TButton;
    AboutMemo: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutDialog: TAboutDialog;

procedure ShowAboutDialog;

implementation

{$R *.dfm}

procedure ShowAboutDialog;
begin
  with TAboutDialog.Create(Application) do
  try
    AboutMemo.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'ABOUT.TXT');
    ShowModal;
  finally
    Free;
  end;
end;

end.
 
