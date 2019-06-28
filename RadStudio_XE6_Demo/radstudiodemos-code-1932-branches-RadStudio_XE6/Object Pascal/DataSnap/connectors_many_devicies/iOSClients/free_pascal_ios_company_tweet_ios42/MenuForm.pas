unit MenuForm;

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls, FMX_Forms,
  FMX_Dialogs,
  {$IFDEF FPC}
  FPCProxyRegister;
  {$ELSE}
  ProxyRegister;
  {$ENDIF}

type
  TfrmMenu = class(TForm)
    btnActiveUsers: TButton;
    btnLogout: TButton;
    procedure btnLogoutClick(Sender: TObject);
    procedure btnActiveUsersClick(Sender: TObject);
  private
    FResultCode: Integer;
    procedure SetResultCode(const Value: Integer);
    { Private declarations }
  public
    property ResultCode: Integer read FResultCode write SetResultCode;
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.lfm}

procedure TfrmMenu.btnActiveUsersClick(Sender: TObject);
begin
  SetResultCode(1);
end;

procedure TfrmMenu.btnLogoutClick(Sender: TObject);
begin
  SetResultCode(2);
end;

procedure TfrmMenu.SetResultCode(const Value: Integer);
begin
  FResultCode := Value;
end;

end.
