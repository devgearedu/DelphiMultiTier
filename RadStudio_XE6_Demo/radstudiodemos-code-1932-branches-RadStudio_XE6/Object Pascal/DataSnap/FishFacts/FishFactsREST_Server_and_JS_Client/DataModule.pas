
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DataModule;

interface

uses
  SysUtils, Classes, DB, DBClient;

type
  TFactsDataModule = class(TDataModule)
    Table1: TClientDataSet;
    Table1Category: TStringField;
    Table1SpeciesName: TStringField;
    Table1Lengthcm: TFloatField;
    Table1Length_In: TFloatField;
    Table1Common_Name: TStringField;
    Table1Notes: TMemoField;
    Table1Graphic: TBlobField;
    Table1SpeciesNo: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FactsDataModule: TFactsDataModule;

implementation

{$R *.dfm}

end.
