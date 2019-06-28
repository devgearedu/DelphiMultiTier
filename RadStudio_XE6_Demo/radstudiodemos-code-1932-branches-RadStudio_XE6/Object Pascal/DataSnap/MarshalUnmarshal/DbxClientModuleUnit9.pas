
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit DBXClientModuleUnit9;

interface

uses
  SysUtils, Classes, DBXClientClassesUnit8, DbxDataSnap, DBXCommon, DSHTTPLayer,
  DB, SqlExpr, IPPeerClient, IndyPeerImpl;

type
  TClientModule9 = class(TDataModule)
    SQLConnection1: TSQLConnection;
  private
    FInstanceOwner: Boolean;
    FServerMethods2Client: TServerMethods2Client;
    function GetServerMethods2Client: TServerMethods2Client;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods2Client: TServerMethods2Client read GetServerMethods2Client write FServerMethods2Client;

end;

var
  ClientModule9: TClientModule9;

implementation

{$R *.dfm}

constructor TClientModule9.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule9.Destroy;
begin
  FServerMethods2Client.Free;
  inherited;
end;

function TClientModule9.GetServerMethods2Client: TServerMethods2Client;
begin
  if FServerMethods2Client = nil then
  begin
    SQLConnection1.Open;
    FServerMethods2Client:= TServerMethods2Client.Create(SQLConnection1.DBXConnection, FInstanceOwner);
  end;
  Result := FServerMethods2Client;
end;

end.
