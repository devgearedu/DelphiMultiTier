
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FormServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ServerContainerUnit1;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ed_port: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if ServerContainer1.DSServer1.Started then
  begin
     ServerContainer1.DSServer1.Stop;
     Caption := 'Server stopped';
  end
  else
  begin
     ServerContainer1.DSTCPServerTransport1.Port := StrToInt(ed_port.Text);
     Caption := 'Server running... - Port ' + ed_port.Text;
     ServerContainer1.DSServer1.Start;
  end;
end;

end.




