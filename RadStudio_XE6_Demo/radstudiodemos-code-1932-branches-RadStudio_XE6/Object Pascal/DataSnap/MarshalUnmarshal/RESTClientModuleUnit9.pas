
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit RESTClientModuleUnit9;

interface

uses
  SysUtils, Classes, RESTClientClassesUnit7, DSClientRest, IPPeerClient, IndyPeerImpl;

type
  TClientModule9 = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
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
  inherited;
  FServerMethods2Client.Free;
end;

function TClientModule9.GetServerMethods2Client: TServerMethods2Client;
begin
  if FServerMethods2Client = nil then
    FServerMethods2Client:= TServerMethods2Client.Create(DSRestConnection1, FInstanceOwner);
  Result := FServerMethods2Client;
end;

end.
