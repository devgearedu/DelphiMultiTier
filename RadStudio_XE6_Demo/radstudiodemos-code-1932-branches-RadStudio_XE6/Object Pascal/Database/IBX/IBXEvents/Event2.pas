
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Event2;

interface

uses Windows, Messages, SysUtils, Classes, Forms,
  DB, IBX.IBEvents, IBX.IBCustomDataSet, IBX.IBStoredProc,
  IBX.IBDatabase;

type
  TdmEvents = class(TDataModule)
    Database1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    StoredProc1: TIBStoredProc;
    IBEventAlerter1: TIBEvents;
    procedure IBEventAlerter1EventAlert(Sender: TObject; EventName: string;
      EventCount: Longint; var CancelAlerts: Boolean);
    procedure DataModuleCreate(Sender: TObject);
  end;

var
  dmEvents: TdmEvents;

implementation

uses Event1;

{$R *.dfm}

procedure TdmEvents.DataModuleCreate(Sender: TObject);
begin
  IBTransaction1.Active := False;
end;

procedure TdmEvents.IBEventAlerter1EventAlert(Sender: TObject;
  EventName: string; EventCount: Longint; var CancelAlerts: Boolean);
begin
  frmEvents.lbReceived.Items.Add(EventName);
end;

end.
