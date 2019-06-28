unit fMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, ComCtrls, StdCtrls, DB, Buttons, Grids, DBGrids, ExtCtrls,
  fMainCompBase,
  FireDAC.Stan.Intf, FireDAC.DatS, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.DataMove;

type
  TfrmMain = class(TfrmMainCompBase)
    dtmMain: TFDDataMove;
    btnTabToASCMove: TButton;
    btnASCToTabMove: TButton;
    btnTabToTabMove: TButton;
    qryMoved: TFDQuery;
    qryLoaded: TFDQuery;
    dsMoved: TDataSource;
    dsLoaded: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    grdLoaded: TDBGrid;
    Panel3: TPanel;
    Splitter1: TSplitter;
    grdMoved: TDBGrid;
    procedure btnTabToASCMoveClick(Sender: TObject);
    procedure btnASCToTabMoveClick(Sender: TObject);
    procedure btnTabToTabMoveClick(Sender: TObject);
    procedure cbDBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
    procedure CloseQueries;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  dmMainComp,
  FireDAC.Stan.Util;

{$R *.dfm}

{ ---------------------------------------------------------------------------- }
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited FormCreate(Sender);
  // These properties is used for optimised TFDDataMove work.
  // You may set up the ones in design time.
  with dtmMain do begin
    Mode := dmAlwaysInsert;
    Options := Options + [poClearDest] - [poOptimiseDest];
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmMain.btnASCToTabMoveClick(Sender: TObject);
begin
  CloseQueries;
  // Text file to Table in RDBMS
  with dtmMain do begin
    // Set up kind of source
    SourceKind := skText;
    // Set up Text file name
    // FDExpandStr utility expands the variables like '$(FDHOME)' to the string
    TextFileName := FDExpandStr('$(FDHOME)\Samples\Comp Layer\TFDDataMove\Main\Data.txt');
    // Set delimiter char
    TextDataDef.Separator := ';';
    // If Text file contains the field names TextDataDef.WithFieldNames must be True
    TextDataDef.WithFieldNames := True;
    // Use TFDQuery as Destination
    Destination := qryLoaded;
  end;
  dtmMain.Execute;

  // show data in dbgrid
  qryLoaded.Open;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmMain.btnTabToASCMoveClick(Sender: TObject);
begin
  CloseQueries;
  // Table in RDBMS to Text file
  with dtmMain do begin
    // Set up Text file name
    TextFileName := FDExpandStr('$(FDHOME)\Samples\Comp Layer\TFDDataMove\Main\DataOut.txt');
    // Use TFDQuery as Source
    Source := qryLoaded;
    // Set up kind of destination
    DestinationKind := skText;
  end;
  dtmMain.Execute;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmMain.btnTabToTabMoveClick(Sender: TObject);
begin
  CloseQueries;
  // Table to Table in RDBMS
  with dtmMain do begin
    // Use TFDTable as Source
    Source := qryLoaded;
    // Use TFDTable as Destination
    Destination := qryMoved;
    // Setting other properties
    Mode := dmAlwaysInsert;
    Options := Options + [poClearDest];
  end;
  dtmMain.Execute;

  // show data in dbgrid
  qryLoaded.Open;
  qryMoved.Open;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmMain.cbDBClick(Sender: TObject);
begin
  inherited cbDBClick(Sender);
  btnTabToASCMove.Enabled := True;
  btnASCToTabMove.Enabled := True;
  btnTabToTabMove.Enabled := True;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmMain.CloseQueries;
begin
  qryMoved.Close;
  qryLoaded.Close;
end;

end.
