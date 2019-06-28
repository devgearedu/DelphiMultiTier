
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit SimpleClientFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, System.WideStrings, Data.DB, Data.SqlExpr, Data.DBXCommon, Vcl.AppEvnts,
  Generics.Collections, Data.DBXJson, IPPeerClient, IndyPeerImpl, DbxDataSnap;

type
  TForm58 = class(TForm)
    EditURLPath: TEdit;
    Label9: TLabel;
    EditPort: TEdit;
    Label8: TLabel;
    ComboBoxProtocol: TComboBox;
    Label7: TLabel;
    EditHost: TEdit;
    Label6: TLabel;
    ButtonEchoString: TButton;
    EditValue: TEdit;
    SQLConnection1: TSQLConnection;
    Label1: TLabel;
    EditServerClass: TEdit;
    ButtonCloseConnection: TButton;
    ApplicationEvents1: TApplicationEvents;
    EditMethodName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditUser: TEdit;
    Label4: TLabel;
    EditPassword: TEdit;
    Memo1: TMemo;
    ButtonClear: TButton;
    CheckBoxBasicHTTPAuth: TCheckBox;
    CheckBoxUseHTTPProxy: TCheckBox;
    GroupBoxFilters: TGroupBox;
    LabelRSAKeyLength: TLabel;
    LabelRSAKeyExponent: TLabel;
    LabelPC1Key: TLabel;
    CheckBoxRSA: TCheckBox;
    CheckBoxPC1: TCheckBox;
    CheckBoxZLib: TCheckBox;
    EditRSAKeyLength: TEdit;
    CheckBoxRSAGlobalKey: TCheckBox;
    EditRSAKeyExponent: TEdit;
    EditPC1Key: TEdit;
    EditRepeatCount: TEdit;
    Label5: TLabel;
    LabelTime: TLabel;
    Label11: TLabel;
    procedure ButtonEchoStringClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonCloseConnectionClick(Sender: TObject);
    procedure ComboBoxProtocolChange(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure OnCheckBoxClick(Sender: TObject);
    procedure CheckBoxEncryptionFiltersClick(Sender: TObject);
    procedure FilterChange(Sender: TObject);
    procedure SQLConnection1BeforeConnect(Sender: TObject);
  private
    FDefaultPorts: TDictionary<string, Integer>;
    function EchoString(ADBXConnection: TDBXConnection; const AServerClassName,
      AMethodName, AValue: string): string;
    procedure OpenConnection(const AHost: string; APort: Integer;
      const AProtocol, AURLPath: string; const AUser, APassword: string;
      ABasicAuth: Boolean;
      AUseHTTPProxy: Boolean;
      AUseRSA, AUsePC1, AUseZLib: Boolean;
      ARSAUseGlobalKey: Boolean; ARSAKeyLength: Integer; ARSAKeyExponent: Integer;
      const APC1Key: string);
    procedure SavePort;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Form58: TForm58;

implementation

{$R *.dfm}

uses System.JSON, Datasnap.DSHTTPLayer, System.StrUtils, HTTPProxyProtocol, FilterUtils;

procedure TForm58.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
var
  LHttp: Boolean;
begin
  ButtonCloseConnection.Enabled := SQLConnection1.Connected;
  ButtonEchoString.Caption := EditMethodName.Text;
  LHttp := StartsText('http', ComboBoxProtocol.Text);
  CheckBoxBasicHTTPAuth.Enabled := LHttp;
  CheckBoxUseHTTPProxy.Enabled := LHttp;
  LabelRSAKeyLength.Enabled := CheckBoxRSA.Checked;
  EditRSAKeyLength.Enabled := CheckBoxRSA.Checked;
  EditRSAKeyExponent.Enabled := CheckBoxRSA.Checked;
  LabelRSAKeyExponent.Enabled := CheckBoxRSA.Checked;
  CheckBoxRSAGlobalKey.Enabled := CheckBoxRSA.Checked;
  LabelPC1Key.Enabled := CheckBoxPC1.Checked;
  EditPC1Key.Enabled := CheckBoxPC1.Checked;
end;

procedure TForm58.ButtonClearClick(Sender: TObject);
begin
Memo1.Lines.Clear;
end;

procedure TForm58.ButtonCloseConnectionClick(Sender: TObject);
begin
  SQLConnection1.Close;
end;

procedure TForm58.SavePort;
var
  LPort: Integer;
  LProtocol: string;
begin
  LPort := StrToInt(EditPort.Text);
  LProtocol := ComboBoxProtocol.Items[ComboBoxProtocol.ItemIndex];
  if FDefaultPorts.ContainsKey(LProtocol) then
    FDefaultPorts[LProtocol] := LPort
  else
    FDefaultPorts.Add(LProtocol, LPort);
end;

procedure TForm58.SQLConnection1BeforeConnect(Sender: TObject);
begin
  // Generate new PC1 key

end;

procedure TForm58.ButtonEchoStringClick(Sender: TObject);
var
  LResult: string;
  LCount: Integer;
  LStart: Cardinal;
  I: Integer;
begin
  LabelTime.Caption := '0';
  LCount := StrToInt(EditRepeatCount.Text);
  try
    if not SQLConnection1.Connected then
    begin
      OpenConnection(EditHost.Text,
        StrToInt(EditPort.Text),
        ComboBoxProtocol.Items[ComboBoxProtocol.ItemIndex],
        EditURLPath.Text,
        EditUser.Text, EditPassword.Text,
        CheckBoxBasicHTTPAuth.Checked,
        CheckBoxUseHTTPProxy.Checked,
        CheckBoxRSA.Checked, CheckBoxPC1.Checked, CheckBoxZLib.Checked,
        CheckBoxRSAGlobalKey.Checked, StrToInt(EditRSAKeyLength.Text), StrToInt(EditRSAKeyExponent.Text),
        EditPC1Key.Text);
      SavePort;
    end;
    LStart := GetTickCount;
    for I := 0 to LCount - 1 do
    begin
      LResult := EchoString(SQLConnection1.DBXConnection,
        EditServerClass.Text, EditMethodName.Text, EditValue.Text);
    end;
    LabelTime.Caption := IntToStr(GetTickCount - LStart);
    Memo1.Lines.Insert(0, LResult);
  except
    on E: Exception do
      Memo1.Lines.Insert(0, Format('Exception: %s, %s', [E.ClassName, E.Message]));
  end;
end;

procedure TForm58.CheckBoxEncryptionFiltersClick(Sender: TObject);
begin
  SQLConnection1.Close;
end;

procedure TForm58.FilterChange(Sender: TObject);
begin
  SQLConnection1.Close;
end;

procedure TForm58.ComboBoxProtocolChange(Sender: TObject);
var
  LPort: Integer;
begin
  if FDefaultPorts.TryGetValue(ComboBoxProtocol.Text, LPort) then
    EditPort.Text := IntToStr(LPort)
  else
    EditPort.Text := '';
  SQLConnection1.Close;
end;

constructor TForm58.Create(AOwner: TComponent);
begin
  inherited;
  FDefaultPorts := TDictionary<string, Integer>.Create;
  FDefaultports.Add('http', 8081);
  FDefaultports.Add('tcp/ip', 211);
end;

destructor TForm58.Destroy;
begin
  FDefaultPorts.Free;
  inherited;
end;

function TForm58.EchoString(ADBXConnection: TDBXConnection;
  const AServerClassName, AMethodName: string; const AValue: string): string;
var
  LEchoStringCommand: TDBXCommand;
begin
  LEchoStringCommand := ADBXConnection.CreateCommand;
  try
    LEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    LEchoStringCommand.Text := AServerClassName + '.' + AMethodName;
    LEchoStringCommand.Prepare;
    LEchoStringCommand.Parameters[0].Value.SetWideString(AValue);
    LEchoStringCommand.ExecuteUpdate;
    Result := LEchoStringCommand.Parameters[1].Value.GetWideString;
  finally
    LEchoStringCommand.Free;
  end;
end;

procedure TForm58.EditChange(Sender: TObject);
begin
  SQLConnection1.Close;
end;

procedure TForm58.OnCheckBoxClick(Sender: TObject);
begin
  SQLConnection1.Close;
end;

procedure TForm58.OpenConnection(
  const AHost: string;
  APort: Integer;
  const AProtocol: string;
  const AURLPath: string;
  const AUser, APassword: string;
  ABasicAuth: Boolean;
  AUseHTTPProxy: Boolean;
  AUseRSA, AUsePC1, AUseZLib: Boolean;
  ARSAUseGlobalKey: Boolean; ARSAKeyLength: Integer; ARSAKeyExponent: Integer;
  const APC1Key: string);
var
  LClientFilters: TJSONObject;
  LFilterString: string;
begin
  try
    SQLConnection1.Close;
  except
  end;
  if AUseRSA or AUsePC1 or AUseZLib then
  begin
    LClientFilters := TJSONObject.Create;
    try
      if AUseRSA then
        LClientFilters.AddPair(
          CreateClientRSAFilterParams(ARSAUseGlobalKey, ARSAKeyLength, ARSAKeyExponent));
      if AUsePC1 then
        LClientFilters.AddPair(
          CreateClientPC1FilterParams(APC1Key));
      if AUseZLib then
        LClientFilters.AddPair(
          CreateClientZLibFilterParams);
      LFilterString := LClientFilters.ToString;
    finally
      FreeAndNil(LClientFilters);
    end;
    SQLConnection1.Params.Values[TDBXPropertyNames.Filters] := LFilterString;
  end
  else
      SQLConnection1.Params.Values[TDBXPropertyNames.Filters] := '';
  SQLConnection1.Params.Values[TDBXPropertyNames.Port] := IntToStr(APort);
  SQLConnection1.Params.Values[TDBXPropertyNames.HostName] := AHost;
  if AUseHTTPProxy then
    SQLConnection1.Params.Values[TDBXPropertyNames.CommunicationProtocol] := sHTTPProxyProtocolLayer
  else
    SQLConnection1.Params.Values[TDBXPropertyNames.CommunicationProtocol] := AProtocol;
  SQLConnection1.Params.Values[TDBXPropertyNames.URLPath] := AURLPath;
  SQLConnection1.Params.Values[TDBXPropertyNames.DSAuthenticationUser] := AUser;
  SQLConnection1.Params.Values[TDBXPropertyNames.DSAuthenticationPassword] := APassword;
  if ABasicAuth then
    SQLConnection1.Params.Values[TDBXPropertyNames.DSAuthenticationScheme] := 'basic'
  else
    SQLConnection1.Params.Values[TDBXPropertyNames.DSAuthenticationScheme] := '';

  SQLConnection1.Open;
end;


end.
