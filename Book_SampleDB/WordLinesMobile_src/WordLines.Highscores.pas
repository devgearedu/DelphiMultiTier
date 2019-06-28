unit WordLines.Highscores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, FMX.StdCtrls,
  FMX.Edit, IPPeerClient;

type
  THighscoresForm = class(TForm)
    Rectangle1: TRectangle;
    TopScoreRequest: TRESTRequest;
    WebTopNameLbl: TLabel;
    TopScoreResponse: TRESTResponse;
    WebTopScoreLbl: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Image2: TImage;
    Label1: TLabel;
    MyTopScoreLbl: TLabel;
    SyncBtn: TButton;
    Label4: TLabel;
    NameEdt: TEdit;
    Label5: TLabel;
    EmailEdt: TEdit;
    Label6: TLabel;
    PasswordEdt: TEdit;
    RESTClient: TRESTClient;
    btnClose: TButton;
    MyScoreRequest: TRESTRequest;
    Label2: TLabel;
    procedure SyncBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    procedure RefreshWebTop;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HighscoresForm: THighscoresForm;

implementation

uses
  Wordlines.Settings;

{$R *.fmx}

procedure THighscoresForm.SyncBtnClick(Sender: TObject);
var
  TopName, TopScore: string;
begin
  MyScoreRequest.Params.ParameterByName('name').Value := NameEdt.Text;
  MyScoreRequest.Params.ParameterByName('password').Value := PasswordEdt.Text;
  MyScoreRequest.Params.ParameterByName('email').Value := EmailEdt.Text;
  MyScoreRequest.Params.ParameterByName('score').Value := IntToStr(Settings.Score);
  MyScoreRequest.Execute;

  TopScoreRequest.Execute;
  TopScoreResponse.GetSimpleValue('name', TopName);
  TopScoreResponse.GetSimpleValue('value', TopScore);

  Settings.Name := NameEdt.Text;
  Settings.Email := EmailEdt.Text;
  Settings.Password := PasswordEdt.Text;
  Settings.WebTopName := TopName;
  Settings.WebTopScore := StrToIntDef(TopScore, 0);
  Settings.Save;

  RefreshWebTop;
end;

procedure THighscoresForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure THighscoresForm.FormCreate(Sender: TObject);
begin
  {$IFDEF IOS}
  CloseBtn.Visible := True;
  {$ENDIF}

  RefreshWebTop;

  MyTopScoreLbl.Text := IntToStr(Settings.Score);

  NameEdt.Text := Settings.Name;
  EmailEdt.Text := Settings.Email;
  PasswordEdt.Text := Settings.Password;
end;

procedure THighscoresForm.RefreshWebTop;
begin
  WebTopNameLbl.Text := Settings.WebTopName;
  WebTopScoreLbl.Text := IntToStr(Settings.WebTopScore);
end;

end.
