unit Utrans;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TTransForm = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    DBGrid2: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TransForm: TTransForm;

implementation

{$R *.dfm}

uses Udm;

procedure TTransForm.Button1Click(Sender: TObject);
begin

 case demo_client.delete_dept(dm.dept.fields[0].asstring) of
 1:  showmessage('사원 삭제 오류');
 2:  showmessage('부서 삭제 오류');
 end;
 DM.Dept.Refresh;
 DM.Insa.Refresh;
end;

procedure TTransForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 
  Action := caFree;
end;

end.
