unit Unit1;

interface

uses
  SysUtils, Classes, HTTPApp, DBXInterBase, DB, SqlExpr;

type
  TWebModule1 = class(TWebModule)
    SQLConnection1: TSQLConnection;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '<html><heading/><body>Web Server Application</body></html>';
end;

end.
