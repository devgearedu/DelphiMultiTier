
//---------------------------------------------------------------------------

// This software is Copyright (c) 2013 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FrmData, FrmMD;

type
  TForm1 = class(TForm)
    MDFrame: TMasterDetailFrame;
    SimpleFrame: TDataFrame;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses ShlObj;

const
  // Change this value depending on where the *.cds demo files are located
  // on your system.
  CDSDirectory = '\CodeGear Shared\Data\';

function GetCommonPath : string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0..MAX_PATH] of char;
begin
  Result := '';
  if SHGetFolderPath( 0, CSIDL_PROGRAM_FILES_COMMON, 0, SHGFP_TYPE_CURRENT, @path[0]) = S_OK then
    Result := path;
end;


procedure TForm1.FormCreate(Sender: TObject);
var DemosDir: string;
begin
  DemosDir := 'C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samples\Data\';
  with SimpleFrame do
  begin
    ClientDataset1.FileName := DemosDir + 'biolife.cds';
    with FancyFrame1 do
    begin
      DBMemo1.DataSource := DataSource1;
      DBMemo1.DataField := 'Notes';
      DBImage1.DataSource := DataSource1;
      DBImage1.DataField := 'Graphic';
    end;
    ClientDataset1.Open;
  end;
  with MDFrame do
  begin
    with MasterFrame do
    begin
      FancyFrame1.Free;
      ClientDataset1.FileName := DemosDir + 'customer.cds';
      ClientDataset1.Open;
    end;
    with DetailFrame do
    begin
      FancyFrame1.Free;
      ClientDataset1.MasterSource := MasterFrame.DataSource1;
      ClientDataset1.MasterFields := 'CustNo';
      ClientDataset1.IndexFieldNames := 'CustNo';
      ClientDataset1.FileName := DemosDir + 'orders.cds';
      ClientDataset1.Open;
    end;
  end;
end;

end.
