unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,FMX.Layouts, FMX.ListBox,
  FMX.StdCtrls
  {$IFDEF IOS}
  ,iOSContactsManager
{$ENDIF};



type
  TForm3 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    lbDetails: TLabel;
    StyleBook1: TStyleBook;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Change(Sender: TObject);
  private
    fiOSContactManager : TiOSContactsManager;
  public
    { Déclarations publiques }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.FormCreate(Sender: TObject);
var
  i : integer;
begin
  try
    fiOSContactManager := TiOSContactsManager.Create;
    fiOSContactManager.ExtractContacts;
    ListBox1.BeginUpdate;
    try
      Label1.Text := Format('Contacts List (%d)',[fiOSContactManager.ContactsCount]);
      for i := 0 to fiOSContactManager.ContactsCount -1 do
        ListBox1.Items.Add(Format('%s %s',[fiOSContactManager.Contacts[i].FirstName,fiOSContactManager.Contacts[i].LastName]));
    finally
      ListBox1.EndUpdate;
    end;
  except
    On E:Exception do
      Raise Exception.create('[TForm3.FormCreate] : '+E.message);
  end;
end;


procedure TForm3.ListBox1Change(Sender: TObject);
Const
  _CRLF = #13#10;
var
  wContact : PiOSContact;
begin

  if ListBox1.ItemIndex <> -1 then
  begin
    wContact := fiOSContactManager.Contacts[ListBox1.ItemIndex];
    lbDetails.Text := 'First Name : ' + wContact.FirstName + _CRLF +
                      'Last Name  : ' + wContact.LastName  + _CRLF +
                      'Email      : ' + wContact.Email     + _CRLF +
                      'Phone      : ' + wContact.PhoneNumber;
  end;
end;

end.
