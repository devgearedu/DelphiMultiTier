
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ClientModuleUnit_FishFactsIndy;

interface

uses
  SysUtils, Classes, ClientClassesUnit_FishFactsIndy, DBXDataSnap, DBXCommon, DSHTTPLayer,
  DB, SqlExpr, IPPeerClient, IndyPeerImpl;

type
  TClientModule_FishFactsIndy = class(TDataModule)
    SQLConnection1: TSQLConnection;
  private
    FInstanceOwner: Boolean;
    FFishFactsServerMethodsClient: TFishFactsServerMethodsClient;
    function GetFishFactsServerMethodsClient: TFishFactsServerMethodsClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property FishFactsServerMethodsClient: TFishFactsServerMethodsClient read GetFishFactsServerMethodsClient write FFishFactsServerMethodsClient;

end;

var
  ClientModule_FishFactsIndy: TClientModule_FishFactsIndy;

implementation

{$R *.dfm}

constructor TClientModule_FishFactsIndy.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule_FishFactsIndy.Destroy;
begin
  FFishFactsServerMethodsClient.Free;
end;

function TClientModule_FishFactsIndy.GetFishFactsServerMethodsClient: TFishFactsServerMethodsClient;
begin
  if FFishFactsServerMethodsClient = nil then
  begin
    SQLConnection1.Open;
    FFishFactsServerMethodsClient:= TFishFactsServerMethodsClient.Create(SQLConnection1.DBXConnection, FInstanceOwner);
  end;
  Result := FFishFactsServerMethodsClient;
end;

end.
