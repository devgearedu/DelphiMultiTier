
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FrmData;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, Db, DBTables, Grids, DBGrids, FrmFancy, DBClient;

type
  TDataFrame = class(TFrame)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    FancyFrame1: TFancyFrame;
    Splitter1: TSplitter;
    ClientDataSet1: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
  