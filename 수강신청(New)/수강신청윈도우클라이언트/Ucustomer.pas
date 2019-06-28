unit Ucustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Data.DB;

type
  TForm_Customer = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    Button5: TButton;
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Customer: TForm_Customer;

implementation

uses Udm;

{$R *.dfm}

procedure TForm_Customer.Button1Click(Sender: TObject);
begin
  Dm.Customer.SaveToFile('Customer.cds');
end;

procedure TForm_Customer.Button2Click(Sender: TObject);
begin
  Dm.Customer.LoadFromFile('Customer.cds');
end;

procedure TForm_Customer.Button3Click(Sender: TObject);
begin
  Dm.Customer.CancelUpdates;
end;

procedure TForm_Customer.Button4Click(Sender: TObject);
begin
 Dm.Customer.ApplyUpdates(-1);
end;

procedure TForm_Customer.Button5Click(Sender: TObject);
begin
   dm.Customer.RevertRecord;
end;

procedure TForm_Customer.CheckBox1Click(Sender: TObject);
begin
  dm.Customer.CachedUpdates := CheckBox1.Checked;
end;

procedure TForm_Customer.Edit1Change(Sender: TObject);
begin
  Dm.Customer.IndexName := 'NAMEIDX';
  dm.Customer.FindNearest([edit1.text]);
end;

procedure TForm_Customer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

end.
