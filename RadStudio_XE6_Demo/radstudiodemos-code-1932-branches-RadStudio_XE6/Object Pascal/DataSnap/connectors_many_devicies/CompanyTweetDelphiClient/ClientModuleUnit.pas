
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit ClientModuleUnit;

interface

uses
  System.SysUtils,
  System.Classes,
  ClientClassesUnit,
  Datasnap.DSClientRest,
  Data.DBXDataSnap,
  Data.DBXCommon,
  Data.DB,
  Data.SqlExpr,
  IndyPeerImpl;

type
  TClientModule1 = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FCompanyTweetClient: TCompanyTweetClient;
    function GetCompanyTweetClient: TCompanyTweetClient;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property CompanyTweetClient: TCompanyTweetClient read GetCompanyTweetClient write FCompanyTweetClient;

end;

var
  ClientModule1: TClientModule1;

implementation

{$R *.dfm}

constructor TClientModule1.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule1.Destroy;
begin
  FCompanyTweetClient.Free;
  inherited;
end;

function TClientModule1.GetCompanyTweetClient: TCompanyTweetClient;
begin
  if FCompanyTweetClient = nil then
    FCompanyTweetClient:= TCompanyTweetClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FCompanyTweetClient;
end;

end.
