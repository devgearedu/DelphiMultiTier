
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TMain = class(TForm)
    Panel1: TPanel;
    mmoSQL: TMemo;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edtUsername: TEdit;
    Password: TLabel;
    edtPassword: TEdit;
    Button2: TButton;
    edtDatabase: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses frmQueryResultsU, frmQueryGridResultsU;

{$R *.dfm}

procedure TMain.Button1Click(Sender: TObject);
begin
  TfrmQueryResults.Create(self).Show;
end;

procedure TMain.Button2Click(Sender: TObject);
begin
  TfrmQueryGridResults.Create(self).Show;
end;

end.
