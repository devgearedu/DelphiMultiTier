unit fGetFieldNames;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, DB, StdCtrls, ExtCtrls, ComCtrls, 
  fMainCompBase;

type
  TfrmGetFieldNames = class(TfrmMainCompBase)
    lbxTables: TListBox;
    lbxFields: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    lbxKeyFields: TListBox;
    Label3: TLabel;
    procedure lbxTablesClick(Sender: TObject);
    procedure cbDBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGetFieldNames: TfrmGetFieldNames;

implementation

uses
  dmMainComp;

{$R *.dfm}

procedure TfrmGetFieldNames.cbDBClick(Sender: TObject);
begin
  inherited cbDBClick(Sender);
  dmlMainComp.dbMain.GetTableNames('', '', '', lbxTables.Items);
  lbxTables.ItemIndex := 0;
  lbxTablesClick(Sender);
end;

procedure TfrmGetFieldNames.lbxTablesClick(Sender: TObject);
begin
  with lbxTables do begin
    dmlMainComp.dbMain.GetFieldNames('', '', Items[ItemIndex], '', lbxFields.Items);
    dmlMainComp.dbMain.GetKeyFieldNames('', '', Items[ItemIndex], '', lbxKeyFields.Items);
  end
end;

end.
