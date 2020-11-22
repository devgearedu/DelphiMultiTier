unit Umain_Client_FDConnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.DS,
  FireDAC.Phys.DSDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FireDAC.Stan.StorageBin, Vcl.Grids,
  Vcl.StdCtrls, FireDAC.Comp.DataSet;

type
  TForm18 = class(TForm)
    FDMemTable1: TFDMemTable;
    Button1: TButton;
    StringGrid1: TStringGrid;
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDTableAdapter1: TFDTableAdapter;
    FDStoredProc1: TFDStoredProc;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    FDConnection1: TFDConnection;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form18: TForm18;

implementation

{$R *.dfm}

procedure TForm18.Button1Click(Sender: TObject);
var
  LStringStream: TStringStream;
begin
  FDStoredProc1.ExecProc;
  LStringStream := TStringStream.Create(FDStoredProc1.Params[0].asBlob);
  try
    if LStringStream <> nil then
    begin
      LStringStream.Position := 0;
      FDSchemaAdapter1.LoadFromStream(LStringStream, TFDStorageFormat.sfBinary);
    end;
  finally
    LStringStream.Free;
  end;
end;

end.
