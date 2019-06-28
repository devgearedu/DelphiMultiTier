program CompanyTweet;

uses
  FMX_Forms,
  ProxyRegister in 'ProxyRegister.pas',
  FollowingUsersForm in 'FollowingUsersForm.pas' {frmFollowingUsers},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  FollowingTweetsForm in 'FollowingTweetsForm.pas' {frmFollowingTweets},
  MenuForm in 'MenuForm.pas' {frmMenu},
  SettingsForm in 'SettingsForm.pas' {frmSettings},
  CTCallback in 'CTCallback.pas',
  DSProxy in 'DSProxy.pas',
  FPCProxyRegister in 'FPCProxyRegister.pas',
  MainForm in 'MainForm.pas' {frmMain},
  LockedStringListU in 'LockedStringListU.pas',
  FPCSound in 'FPCSound.pas';

{$R *.res}


begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
