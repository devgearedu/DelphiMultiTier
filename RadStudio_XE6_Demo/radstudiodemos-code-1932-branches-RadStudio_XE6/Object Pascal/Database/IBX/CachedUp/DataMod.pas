
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DataMod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IBX.IBDatabase, IBX.IBCustomDataSet, IBX.IBUpdateSQL, IBX.IBQuery, Db,
  IBX.IBTable;

type
  TCacheData = class(TDataModule)
    CacheDS: TDataSource;
    IBDatabase1: TIBDatabase;
    IBCacheQuery: TIBQuery;
    IBUpdateSQL: TIBUpdateSQL;
    IBTransaction1: TIBTransaction;
    IBCacheQueryUpdateStatus: TStringField;
    IBCachedDataSet: TIBDataSet;
    IBCachedTable: TIBTable;
    IBCachedTableUpdateStatus: TStringField;
    IBCachedDataSetPROJ_ID: TIBStringField;
    IBCachedDataSetPROJ_NAME: TIBStringField;
    IBCachedDataSetUpdateStatus: TStringField;
    IBCachedTablePROJ_ID: TIBStringField;
    IBCachedTablePROJ_NAME: TIBStringField;
    IBCacheQueryPROJ_ID: TIBStringField;
    IBCacheQueryPROJ_NAME: TIBStringField;
    procedure CacheQueryCalcFields(DataSet: TDataSet);
    procedure IBCacheQueryUpdateError(DataSet: TDataSet;
      E: EDatabaseError; UpdateKind: TUpdateKind;
      var UpdateAction: TIBUpdateAction);
    procedure IBCachedDataSetCalcFields(DataSet: TDataSet);
    procedure IBCachedTableCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CacheData: TCacheData;

implementation

uses CachedUp, ErrForm;

{$R *.dfm}

{ This event displays the current update status in a calculated field }
const
  UpdateStatusStr: array[TUpdateStatus] of string = ('Unmodified', 'Modified',
   'Inserted', 'Deleted');

procedure TCacheData.CacheQueryCalcFields(DataSet: TDataSet);
begin
  IBCacheQueryUpdateStatus.AsString := UpdateStatusStr[IBCacheQuery.UpdateStatus];
end;

{ This event is triggered when an error occurs during the update process
  (such as a key violation).  Here we use another form to show the user
  the error and allow them to decide what to do about it.  See ErrForm.pas
  for more information }

procedure TCacheData.IBCacheQueryUpdateError(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TIBUpdateAction);
begin
  UpdateAction := UpdateErrorForm.HandleError(DataSet, E, UpdateKind);
end;

procedure TCacheData.IBCachedDataSetCalcFields(DataSet: TDataSet);
begin
  IBCachedDataSetUpdateStatus.AsString := UpdateStatusStr[IBCachedDataset.UpdateStatus];
end;

procedure TCacheData.IBCachedTableCalcFields(DataSet: TDataSet);
begin
  IBCachedTableUpdateStatus.AsString := UpdateStatusStr[IBCachedTable.UpdateStatus];
end;

end.


