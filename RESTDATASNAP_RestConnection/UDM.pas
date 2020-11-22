unit UDM;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit1, Datasnap.DSClientRest;

type
  TDm = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FServerMethods1Client: TServerMethods1Client;
    function GetServerMethods1Client: TServerMethods1Client;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods1Client: TServerMethods1Client read GetServerMethods1Client write FServerMethods1Client;

    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}



{$R *.dfm}

{ TDm }

constructor TDm.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TDm.Destroy;
begin
   FServerMethods1Client.Free;
  inherited;
end;

function TDm.GetServerMethods1Client: TServerMethods1Client;
begin
  if FServerMethods1Client = nil then
    FServerMethods1Client:= TServerMethods1Client.Create(DSRestConnection1, FInstanceOwner);
  Result := FServerMethods1Client;

end;

end.
