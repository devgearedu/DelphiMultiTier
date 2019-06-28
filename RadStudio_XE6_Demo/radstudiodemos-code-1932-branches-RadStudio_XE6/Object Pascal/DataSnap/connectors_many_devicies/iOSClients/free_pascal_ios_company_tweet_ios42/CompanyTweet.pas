program CompanyTweet;

uses
  cwstring, cthreads, FMX_Forms,
  DSRESTTypes in 'DSRESTTypes.pas',
  DSRESTConnection in 'DSRESTConnection.pas',
  MainForm in 'MainForm.pas' {frmMain},
  FollowingUsersForm in 'FollowingUsersForm.pas' {frmFollowingUsers},
  FollowingTweetsForm in 'FollowingTweetsForm.pas' {frmFollowingTweetsForm};

{.$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
