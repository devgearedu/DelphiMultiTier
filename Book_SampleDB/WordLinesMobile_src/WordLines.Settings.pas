unit WordLines.Settings;

interface

type
  TSettings = class
  private
    FName: string;
    FEmail: string;
    FPassword: string;
    FScore: Integer;

    FWebTopName: string;
    FWebTopScore: Integer;
  public
    procedure Save;
    procedure Load;

    property Name: string read FName write FName;
    property Email: string read FEmail write FEmail;
    property Password: string read FPassword write FPassword;
    property Score: Integer read FScore write FScore;
    property WebTopName: string read FWebTopName write FWebTopName;
    property WebTopScore: Integer read FWebTopScore write FWebTopScore;
  end;

var
  Settings: TSettings;

implementation

uses
  System.IniFiles, CCR.PrefsIniFile;

{ TSettings }

procedure TSettings.Load;
var
  IniFile: TCustomIniFile;
begin
  IniFile := CreateUserPreferencesIniFile;
  try
    FName := IniFile.ReadString('user', 'name', '');
    FEmail := IniFile.ReadString('user', 'email', '');
    FPassword := IniFile.ReadString('user', 'password', '');
    FScore := IniFile.ReadInteger('user', 'score', 0);
    FWebTopName := IniFile.ReadString('top', 'name', '???');
    FWebTopScore := IniFile.ReadInteger('top', 'score', 0);
  finally
    IniFile.Free;
  end;
end;

procedure TSettings.Save;
var
  IniFile: TCustomIniFile;
begin
  IniFile := CreateUserPreferencesIniFile;
  try
    IniFile.WriteString('user', 'name', FName);
    IniFile.WriteString('user', 'email', FEmail);
    IniFile.WriteString('user', 'password', FPassword);
    IniFile.WriteInteger('user', 'score', FScore);
    IniFile.WriteString('top', 'name', FWebTopName);
    IniFile.WriteInteger('top', 'score', FWebTopScore);
  finally
    IniFile.Free;
  end;
end;

initialization
  Settings := TSettings.Create;

finalization
  Settings.Free;

end.
