unit WordLines.SelectLanguage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Effects, FMX.Objects;

type
  TSelectLanguageFrm = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Label1: TLabel;
    lblEnglish: TLabel;
    GlowEffect2: TGlowEffect;
    lblFrench: TLabel;
    GlowEffect1: TGlowEffect;
    lblRussian: TLabel;
    GlowEffect3: TGlowEffect;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    lblStartingNewGame: TLabel;
    procedure LanguageLblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FLang: string;
  public
    { Public declarations }
    property Lang: string read FLang;
  end;

var
  SelectLanguageFrm: TSelectLanguageFrm;

implementation

{$R *.fmx}

procedure TSelectLanguageFrm.FormCreate(Sender: TObject);
begin
  FLang := 'EN';
end;

procedure TSelectLanguageFrm.LanguageLblClick(Sender: TObject);
const
  Langs: array [0..2] of string = ('EN', 'FR', 'RU');
begin
  lblStartingNewGame.Visible := True;
  Application.ProcessMessages;

  FLang := Langs[(Sender as TComponent).Tag];
  ModalResult := mrOk;
  Close;
end;

end.
