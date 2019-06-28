unit fMainCompBase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    Grids, DBGrids, DB, StdCtrls, ComCtrls, ExtCtrls, Buttons, 
  fMainBase, fMainConnectionDefBase,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Comp.Client;

type
  TfrmMainCompBase = class(TfrmMainConnectionDefBase)
    StatusBar1: TStatusBar;
  public
    procedure GetConnectionDefs(AList: TStrings); override;
    procedure SetConnDefName(AConnDefName: String); override;
    procedure ConnectionActive(AValue: Boolean); override;
    function GetFormatOptions: TFDFormatOptions; override;
    function GetRDBMSKind: TFDRDBMSKind; override;
  end;

var
  frmMainCompBase: TfrmMainCompBase;

implementation

uses
  dmMainComp;

{$R *.dfm}

procedure TfrmMainCompBase.GetConnectionDefs(AList: TStrings);
begin
  FDManager.GetConnectionDefNames(AList);
end;

procedure TfrmMainCompBase.ConnectionActive(AValue: Boolean);
begin
  if AValue then
    dmlMainComp.dbMain.Open
  else
    dmlMainComp.dbMain.Close;
end;

procedure TfrmMainCompBase.SetConnDefName(AConnDefName: String);
begin
  dmlMainComp.dbMain.ConnectionDefName := AConnDefName;
end;

function TfrmMainCompBase.GetFormatOptions: TFDFormatOptions;
begin
  Result := dmlMainComp.dbMain.FormatOptions;
end;

function TfrmMainCompBase.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := dmlMainComp.dbMain.RDBMSKind;
end;

end.
