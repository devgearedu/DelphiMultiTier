
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit TextMain;

{ This project demonstrates a custom TDataSet implementation.
  See TextData.Pas for more info.  You will need to compile and
  install TextPKG.DPK before using this sample. }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TextData, ExtCtrls, DBCtrls, Grids, DBGrids, Db;

type
  TTextDataDemoForm = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    TextDataSet1: TTextDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TextDataDemoForm: TTextDataDemoForm;

implementation

{$R *.dfm}

end.
