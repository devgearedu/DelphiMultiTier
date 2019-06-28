unit Unit23;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Data.DBXInterBase, IWDBStdCtrls, Vcl.Controls, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWGrids, IWDBGrids, Data.DB,
  Datasnap.DBClient, SimpleDS, Data.SqlExpr, IWCompButton;

type
  TIWForm23 = class(TIWAppForm)
    SQLConnection1: TSQLConnection;
    SimpleDataSet1: TSimpleDataSet;
    DataSource1: TDataSource;
    IWDBGrid1: TIWDBGrid;
    IWDBNavigator1: TIWDBNavigator;
    IWButton1: TIWButton;
    procedure IWButton1Click(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

uses Unit1;


procedure TIWForm23.IWButton1Click(Sender: TObject);
begin
  TIWForm1.Create(webapplication).Show;
end;

initialization
  TIWForm23.SetAsMainForm;

end.
