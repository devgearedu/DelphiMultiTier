program WordLines;



uses
  System.StartUpCopy,
  FMX.Forms,
  WordLines.MainForm in 'WordLines.MainForm.pas' {MainForm},
  WordLines.BoardController in 'WordLines.BoardController.pas',
  WordLines.Dictionary in 'WordLines.Dictionary.pas',
  WordLines.WordFinder in 'WordLines.WordFinder.pas',
  WordLines.Classes in 'WordLines.Classes.pas',
  WordLines.Highscores in 'WordLines.Highscores.pas' {HighscoresForm},
  WordLines.Settings in 'WordLines.Settings.pas',
  WordLines.GameFlow in 'WordLines.GameFlow.pas',
  CCR.PrefsIniFile in 'Libs\PrefsIniFile\CCR.PrefsIniFile.pas',
  CCR.PrefsIniFile.Android in 'Libs\PrefsIniFile\CCR.PrefsIniFile.Android.pas',
  CCR.PrefsIniFile.Apple in 'Libs\PrefsIniFile\CCR.PrefsIniFile.Apple.pas',
  WordLines.SelectLanguage in 'WordLines.SelectLanguage.pas' {SelectLanguageFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.soLandscape, TFormOrientation.soInvertedLandscape];
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
