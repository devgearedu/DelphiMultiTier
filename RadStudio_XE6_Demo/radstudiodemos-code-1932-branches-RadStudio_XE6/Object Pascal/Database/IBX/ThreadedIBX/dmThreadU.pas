
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit dmThreadU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBDatabase;

type
  TdmThread = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
  private
    { Private declarations }
  public
    constructor Create(DB_Name : String; Username : String; Password : String); reintroduce; overload;
    { Public declarations }
  end;

var
  dmThread: TdmThread;

implementation

{$R *.dfm}

{ TdmThread }

constructor TdmThread.Create(DB_Name: String; Username : String; Password : String);
begin
  inherited Create(nil);
  IBDatabase1.DatabaseName := DB_Name;
  IBDatabase1.Params.Add(Format('user_name=%s', [Username]));
  IBDatabase1.Params.Add(Format('password=%s', [Password]));
  IBDatabase1.Connected := true;
end;

end.
