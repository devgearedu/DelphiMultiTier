
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit frmQueryResultsU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ThreadQueryU, dmThreadU, Data.Bind.Components,
  Data.Bind.DBScope, Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Grid;

type
  TfrmQueryResults = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    thdQuery : ThreadQuery;
    { Public declarations }
  end;

var
  frmQueryResults: TfrmQueryResults;

implementation

uses frmMain;

{$R *.dfm}

procedure TfrmQueryResults.FormCreate(Sender: TObject);
begin
  thdQuery := ThreadQuery.Create(Main.mmoSQL.Lines.Text, DataSource1, Main.edtDatabase.Text,
        Main.edtUsername.Text, Main.edtPassword.Text);
end;

procedure TfrmQueryResults.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  thdQuery.Free;
  Action := caFree;
end;

end.
