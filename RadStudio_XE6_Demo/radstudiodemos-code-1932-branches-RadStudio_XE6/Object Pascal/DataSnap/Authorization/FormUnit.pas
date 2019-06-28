
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit FormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, StdCtrls, ComCtrls, DBXCommon, UsersAndRoles, ExtCtrls, DSAuth;

type
  TForm36 = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    ApplicationEvents1: TApplicationEvents;
    MemoServerMethods: TMemo;
    lblTCPPort: TLabel;
    label2: TLabel;
    label3: TLabel;
    lblIpAddress: TLabel;
    lblHostName: TLabel;
    label1: TLabel;
    Label5: TLabel;
    MemoLog: TMemo;
    ButtonClearLog: TButton;
    Label6: TLabel;
    ButtonDisplayServerMethods: TButton;
    ListViewRolesCollection: TListView;
    ButtonAddRoleItem: TButton;
    ButtonEditRoleItem: TButton;
    ButtonDeleteRoleItem: TButton;
    ListViewUserRoles: TListView;
    ButtonAddUserRole: TButton;
    ButtonEditUserRole: TButton;
    ButtonDeleteUserRole: TButton;
    Label7: TLabel;
    ButtonStartHTTP: TButton;
    ButtonStopHTTP: TButton;
    ButtonStartTCP: TButton;
    ButtonStopTCP: TButton;
    lblHTTPPort: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    RadioButtonAuthenticateNone: TRadioButton;
    RadioButtonAuthenticateAll: TRadioButton;
    RadioButtonAutenticateKnownUsers: TRadioButton;
    GroupBox2: TGroupBox;
    RadioButtonDenyAllUsers: TRadioButton;
    RadioButtonAllowAll: TRadioButton;
    RadioButtonUseRoles: TRadioButton;
    GroupBox3: TGroupBox;
    RadioButtonDefaultAuthorization: TRadioButton;
    RadioButtonCheckRolesOnAuthorize: TRadioButton;
    RadioButtonCheckRolesOnPrepare: TRadioButton;
    GroupBoxFilters: TGroupBox;
    CheckBoxRSA: TCheckBox;
    CheckBoxPC1: TCheckBox;
    CheckBoxZLib: TCheckBox;
    ButtonApplyFilters: TButton;
    EditRSAKeyLength: TEdit;
    LabelRSAKeyLength: TLabel;
    CheckBoxRSAGlobalKey: TCheckBox;
    EditRSAKeyExponent: TEdit;
    LabelRSAKeyExponent: TLabel;
    LabelPC1Key: TLabel;
    EditPC1Key: TEdit;
    CheckBoxPC1Random: TCheckBox;
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonRegisterClassClick(Sender: TObject);
    procedure ButtonClearLogClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonDisplayServerMethodsClick(Sender: TObject);
    procedure ButtonDisplayMethodRolesClick(Sender: TObject);
    procedure ButtonAddRoleItemClick(Sender: TObject);
    procedure ButtonEditRoleItemClick(Sender: TObject);
    procedure ButtonDeleteRoleItemClick(Sender: TObject);
    procedure ButtonDisplayUserRolesClick(Sender: TObject);
    procedure ButtonAddUserRoleClick(Sender: TObject);
    procedure ButtonEditUserRoleClick(Sender: TObject);
    procedure ButtonDeleteUserRoleClick(Sender: TObject);
    procedure OnAuthorizationCheckingRadioButton(Sender: TObject);
    procedure ButtonStartHTTPClick(Sender: TObject);
    procedure ButtonStopHTTPClick(Sender: TObject);
    procedure ButtonStartTCPClick(Sender: TObject);
    procedure ButtonStopTCPClick(Sender: TObject);
    procedure OnAuthorizationRequirementsRadioButton(Sender: TObject);
    procedure OnAuthenticationRadioButton(Sender: TObject);
    procedure FilterChanged(Sender: TObject);
    procedure ButtonApplyFiltersClick(Sender: TObject);
  private
    FStarted: Boolean;
    FTCPStarted: Boolean;
    FShowRolesWarning: Boolean;
    FFiltersChanged: Boolean;
    procedure UpdateServerProperties;
    procedure ShowServerMethods;
    procedure ShowServerMethodRoles;
    procedure AddRoleItem;
    function EditRoleItem(ARoleItem: TDSRoleItem): Boolean;
    function DeleteRoleItem(ARoleItem: TDSRoleItem): Boolean;
    function FormatRoleItem(ARole: TDSCustomRoleItem): string;
    procedure AddUserRoleItem;
    procedure DeleteUserRoleItem(ARoleItem: TUserRoleItem);
    procedure EditUserRoleItem(ARoleItem: TUserRoleItem);
    function FormatUserRoleItem(ARole: TUserRoleItem): string;
    procedure ShowUserRoles;
    procedure ShowRolesWarning;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form36: TForm36;

implementation

{$R *.dfm}

uses ServerContainerUnit1, ServerUtils, ServerMethodsUnit2, RoleItemFormUnit,
  UserRoleItemFormUnit, FilterUtils;

procedure TForm36.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not ServerContainer1.DSServer1.Started;
  ButtonStop.Enabled := ServerContainer1.DSServer1.Started;
  if FStarted <> ServerContainer1.DSServer1.Started then
  begin
    FStarted :=  ServerContainer1.DSServer1.Started;
    FTCPStarted := FStarted;
    UpdateServerProperties;
    //ShowServerMethods;
  end;
  ButtonEditRoleItem.Enabled := ListViewRolesCollection.Selected <> nil;
  ButtonDeleteRoleItem.Enabled := ListViewRolesCollection.Selected <> nil;
  ButtonDeleteUserRole.Enabled := ListViewUserRoles.Selected <> nil;
  ButtonEditUserRole.Enabled := ListViewUserRoles.Selected <> nil;
  ButtonStartHTTP.Enabled := not Servercontainer1.DSHTTPService1.Active;
  ButtonStopHTTP.Enabled := Servercontainer1.DSHTTPService1.Active;
  ButtonStartTCP.Enabled := not FTCPStarted;
  ButtonStopTCP.Enabled := FTCPStarted;
  if ServerContainer1.AuthorizationMode = authDefaultAuth then
  begin
    RadioButtonDenyAllUsers.Enabled := False;
    RadioButtonAllowAll.Enabled := False;
    RadioButtonUseRoles.Enabled := True;
  end
  else
  begin
    RadioButtonDenyAllUsers.Enabled := True;
    RadioButtonAllowAll.Enabled := True;
  end;
  ButtonApplyFilters.Enabled := FFiltersChanged;
  LabelRSAKeyLength.Enabled := CheckBoxRSA.Checked;
  EditRSAKeyLength.Enabled := CheckBoxRSA.Checked;
  EditRSAKeyExponent.Enabled := CheckBoxRSA.Checked;
  LabelRSAKeyExponent.Enabled := CheckBoxRSA.Checked;
  CheckBoxRSAGlobalKey.Enabled := CheckBoxRSA.Checked;
  LabelPC1Key.Enabled := CheckBoxPC1.Checked;
  EditPC1Key.Enabled := CheckBoxPC1.Checked and (not CheckBoxPC1Random.Checked);
  CheckBoxPC1Random.Enabled := CheckBoxPC1.Checked;
end;

procedure TForm36.ButtonDeleteRoleItemClick(Sender: TObject);
var
  LRoleItem: TDSRoleItem;
begin
  if ListViewRolesCollection.Selected <> nil then
  begin
    LRoleItem := ListViewRolesCollection.Selected.Data;
    DeleteRoleItem(LRoleItem);
    ShowRolesWarning;
    ShowServerMethodRoles;
  end;
end;

procedure TForm36.ButtonDeleteUserRoleClick(Sender: TObject);
var
  LRoleItem: TUserRoleItem;
begin
  if ListViewUserRoles.Selected <> nil then
  begin
    LRoleItem := ListViewUserRoles.Selected.Data;
    DeleteUserRoleItem(LRoleItem);
    ShowUserRoles;
  end;
end;

procedure TForm36.ButtonDisplayMethodRolesClick(Sender: TObject);
begin
  ShowServerMethodRoles;
end;

procedure TForm36.ShowRolesWarning;
begin
  if FShowRolesWarning then
    MessageDlg('Changes to method roles take affect when the DSServer is restarted',
      TMsgDlgType.mtWarning, [mbOK], 0);
  FShowRolesWarning := False;
end;

procedure TForm36.ButtonAddRoleItemClick(Sender: TObject);
begin
  AddRoleItem;
  ShowServerMethodRoles;
  ShowRolesWarning;
end;

procedure TForm36.ButtonAddUserRoleClick(Sender: TObject);
begin
  AddUserRoleItem;
  ShowUserRoles;
end;

procedure TForm36.ButtonApplyFiltersClick(Sender: TObject);
begin
  ClearServerFilters(ServerContainer1.DSTCPServerTransport1.Filters);
  ClearServerFilters(ServerContainer1.DSHTTPService1.Filters);
  if CheckBoxRSA.Checked then
  begin
    AddRSAServerFilter(ServerContainer1.DSTCPServerTransport1.Filters,
    CheckBoxRSAGlobalKey.Checked, StrToInt(EditRSAKeyLength.Text),
      StrToInt(EditRSAKeyExponent.Text));
    AddRSAServerFilter(ServerContainer1.DSHTTPService1.Filters,
    CheckBoxRSAGlobalKey.Checked, StrToInt(EditRSAKeyLength.Text),
      StrToInt(EditRSAKeyExponent.Text));
  end;
  if CheckBoxPC1.Checked then
  begin
    if CheckBoxPC1Random.Checked then
    begin
      AddPC1ServerFilter(ServerContainer1.DSTCPServerTransport1.Filters, '', 'PC1DynamicKey');
      AddPC1ServerFilter(ServerContainer1.DSHTTPService1.Filters, '', 'PC1DynamicKey');
    end
    else
    begin
      AddPC1ServerFilter(ServerContainer1.DSTCPServerTransport1.Filters, EditPC1Key.Text, 'PC1');
      AddPC1ServerFilter(ServerContainer1.DSHTTPService1.Filters, EditPC1Key.Text, 'PC1');
    end;
  end;
  if CheckBoxZLib.Checked then
  begin
    AddZLibServerFilter(ServerContainer1.DSTCPServerTransport1.Filters);
    AddZLibServerFilter(ServerContainer1.DSHTTPService1.Filters);
  end;


  FFiltersChanged := False;
end;

procedure TForm36.AddRoleItem;
var
  LRoleItem: TDSRoleItem;
begin
  with TRoleItemForm.Create(Self) do
  try
    EditApplyTo.Text := '';
    EditAuthorizedRoles.Text := '';
    EditDeniedRoles.Text := '';
    if ShowModal = mrOK then
    begin
      LRoleItem := TDSRoleItem(ServerContainer1.DSAuthenticationManager1.Roles.Add);
      LRoleItem.ApplyTo.DelimitedText := EditApplyTo.Text;
      LRoleItem.AuthorizedRoles.DelimitedText := EditAuthorizedRoles.Text;
      LRoleItem.DeniedRoles.DelimitedText := EditDeniedRoles.Text;
      ServerContainer1.DSAuthenticationManager1.Roles.MarkUpdated; // Cause internal role collections to be updated
      end;
  finally
    Free;
  end;
end;

function TForm36.DeleteRoleItem(ARoleItem: TDSRoleItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if MessageDlg('Delete ' + FormatRoleItem(ARoleItem) + '?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk then
    with ServerContainer1.DSAuthenticationManager1 do
    begin
      for I := 0 to Roles.Count do
      begin
        if Roles[I] = ARoleItem then
        begin
          Result := True;
          Roles.Delete(I);
          Roles.MarkUpdated; // Cause internal role collections to be updated
          break;
        end;
      end;
    end;
end;

function TForm36.EditRoleItem(ARoleItem: TDSRoleItem): Boolean;
begin
  Result := False;
  with TRoleItemForm.Create(Self) do
  try
    EditApplyTo.Text := ARoleItem.ApplyTo.DelimitedText;
    EditAuthorizedRoles.Text := ARoleItem.AuthorizedRoles.DelimitedText;
    EditDeniedRoles.Text := ARoleItem.DeniedRoles.DelimitedText;
    if ShowModal = mrOK then
    begin
      Result := True;
      ARoleItem.ApplyTo.DelimitedText := EditApplyTo.Text;
      ARoleItem.AuthorizedRoles.DelimitedText := EditAuthorizedRoles.Text;
      ARoleItem.DeniedRoles.DelimitedText := EditDeniedRoles.Text;
    end;
  finally
    Free;
  end;
end;

procedure TForm36.ButtonClearLogClick(Sender: TObject);
begin
  MemoLog.Clear;
end;

procedure TForm36.ButtonDisplayServerMethodsClick(Sender: TObject);
begin
  ShowServerMethods;
end;

procedure TForm36.ButtonDisplayUserRolesClick(Sender: TObject);
begin
  ShowUserRoles;
end;

procedure TForm36.ButtonEditRoleItemClick(Sender: TObject);
var
  LRoleItem: TDSRoleItem;
begin
  if ListViewRolesCollection.Selected <> nil then
  begin
    LRoleItem := ListViewRolesCollection.Selected.Data;
    if EditRoleItem(LRoleItem) then
    begin
      ServerContainer1.DSAuthenticationManager1.Roles.MarkUpdated;
      ShowServerMethodRoles;
      ShowRolesWarning;
    end;
  end;
end;

procedure TForm36.ButtonEditUserRoleClick(Sender: TObject);
var
  LRoleItem: TUserRoleItem;
begin
  if ListViewUserRoles.Selected <> nil then
  begin
    LRoleItem := ListViewUserRoles.Selected.Data;
    EditUserRoleItem(LRoleItem);
    ShowUserRoles;
  end;
end;

procedure TForm36.ButtonRegisterClassClick(Sender: TObject);
begin
  ServerMethodsUnit2.RegisterServerMethods(ServerContainer1, ServerContainer1.DSServer1);
end;

procedure TForm36.ButtonStartClick(Sender: TObject);
begin
  ServerContainer1.DSServer1.Start;
  FShowRolesWarning := True;
end;

procedure TForm36.ButtonStartHTTPClick(Sender: TObject);
begin
  ServerContainer1.DSHTTPService1.Start;
end;

procedure TForm36.ButtonStartTCPClick(Sender: TObject);
begin
  ServerContainer1.DSTCPServerTransport1.Start;
  FTCPStarted := True;

end;

procedure TForm36.ButtonStopClick(Sender: TObject);
begin
  ServerContainer1.DSServer1.Stop;
end;

procedure TForm36.ButtonStopHTTPClick(Sender: TObject);
begin
  ServerContainer1.DSHTTPService1.Stop;

end;

procedure TForm36.ButtonStopTCPClick(Sender: TObject);
begin
  ServerContainer1.DSTCPServerTransport1.Stop;
  FTCPStarted := False;

end;

procedure TForm36.FormCreate(Sender: TObject);
begin
  FShowRolesWarning := True;
  FStarted := False;
  ShowServerMethodRoles;
  ShowUserRoles;
  ServerContainer1.DSHTTPService1.Start;
  OnAuthorizationRequirementsRadioButton(Self); // Synch servercontainer with controls
  OnAuthorizationCheckingRadioButton(Self); // Synch servercontainer with controls
end;

resourcestring
  sFormatRoleItem = 'ApplyTo(%3:d): ''%0:s'', Authorized(%4:d): ''%1:s'', Denied(%5:d): ''%2:s'',';
  sFormatUserRoleItem = 'Users(%2:d): ''%0:s'', Roles(%3:d): ''%1:s''';

procedure TForm36.UpdateServerProperties;
begin
  lblHostName.Caption:= String(TServerSockUtils.GetHostName);
  lblHTTPPort.Caption:= IntToStr(ServerContainer1.DSHTTPService1.HttpPort);
  lblTCPPort.Caption:= IntToStr(ServerContainer1.DSTCPServerTransport1.Port);
  lblIpAddress.Caption:= TServerSockUtils.GetIPAddress;
end;

procedure TForm36.ShowServerMethods;
var
  LServerMethods: string;
begin
  MemoServerMethods.Clear;
  if ServerContainer1.DSServer1.Started then
  begin
    TServerMetaDataUtils.GetServerMethods('localhost', ServerContainer1.DSTCPServerTransport1.Port, LServerMethods);
    MemoServerMethods.Lines.Add(LServerMethods);
  end
end;

procedure TForm36.FilterChanged(Sender: TObject);
begin
  FFiltersChanged := True;
end;

function TForm36.FormatRoleItem(ARole: TDSCustomRoleItem): string;
begin
  Result := Format(sFormatRoleItem,
    [ARole.ApplyTo.DelimitedText, ARole.AuthorizedRoles.DelimitedText, ARole.DeniedRoles.DelimitedText,
    ARole.ApplyTo.Count, ARole.AuthorizedRoles.Count, ARole.DeniedRoles.Count]);
end;

function TForm36.FormatUserRoleItem(ARole: TUserRoleItem): string;
begin
  Result := Format(sFormatUserRoleItem,
    [ARole.UserNames.DelimitedText, ARole.Roles.DelimitedText,
    ARole.UserNames.Count, ARole.Roles.Count]);
end;

procedure TForm36.ShowServerMethodRoles;
var
  I: Integer;
  LRole: TDSCustomRoleItem;
  LListItem: TListItem;
begin
  ListViewRolesCollection.Clear;
  for I := 0 to ServerContainer1.DSAuthenticationManager1.Roles.Count - 1 do
  begin
    LRole := ServerContainer1.DSAuthenticationManager1.Roles[I];
    LListItem := ListViewRolesCollection.Items.Add;
    LListItem.Data := LRole;
    LListItem.Caption := Format('(%d)%s', [LRole.ApplyTo.Count, LRole.ApplyTo.DelimitedText]);
    LListItem.SubItems.Add(Format('(%d)%s', [LRole.AuthorizedRoles.Count, LRole.AuthorizedRoles.DelimitedText]));
    LListItem.SubItems.Add(Format('(%d)%s', [LRole.DeniedRoles.Count, LRole.DeniedRoles.DelimitedText]));
  end;
end;

procedure TForm36.ShowUserRoles;
var
  I: Integer;
  LRole: TUserRoleItem;
  LListItem: TListItem;
begin
  ListViewUserRoles.Clear;
  for I := 0 to ServerContainer1.UserRoleItems.Count - 1 do
  begin
    LRole := ServerContainer1.UserRoleItems[I];
    LListItem := ListViewUserRoles.Items.Add;
    LListItem.Data := LRole;
    LListItem.Caption := Format('(%d)%s', [LRole.UserNames.Count, LRole.UserNames.DelimitedText]);
    LListItem.SubItems.Add(Format('(%d)%s', [LRole.Roles.Count, LRole.Roles.DelimitedText]));
  end;
end;

procedure TForm36.FormShow(Sender: TObject);
var
  LMemo: TMemo;
begin
  FShowRolesWarning := False; // Don't need this because call Roles.MarkUpdated
  LMemo := MemoLog;
  ServerContainer1.LogMessageProc :=
    procedure(AMessage: string)
    begin
      TThread.Queue(nil, procedure
      begin
        LMemo.Lines.Add(AMessage)
      end);
    end;
end;

procedure TForm36.OnAuthenticationRadioButton(Sender: TObject);
begin
  if RadioButtonAuthenticateAll.Checked then
    ServerContainer1.AuthenticationMode := TAuthenticationMode.authenticateAllUsers
  else if RadioButtonAutenticateKnownUsers.Checked then
    ServerContainer1.AuthenticationMode :=  TAuthenticationMode.authenticateUsersWithRoles
  else if RadioButtonAuthenticateNone.Checked then
    ServerContainer1.AuthenticationMode :=  TAuthenticationMode.authenticateNoUsers
end;


procedure TForm36.OnAuthorizationRequirementsRadioButton(Sender: TObject);
begin
  if RadioButtonDenyAllUsers.Checked then
    ServerContainer1.AllowDenyMode := TAuthorizationRequirments.denyAll
  else if RadioButtonAllowAll.Checked then
    ServerContainer1.AllowDenyMode := TAuthorizationRequirments.allowAll
  else
    ServerContainer1.AllowDenyMode := TAuthorizationRequirments.useRoles
end;

procedure TForm36.OnAuthorizationCheckingRadioButton(Sender: TObject);
begin
  if RadioButtonDefaultAuthorization.Checked then
    ServerContainer1.AuthorizationMode := TAuthorizationChecking.authDefaultAuth
  else if RadioButtonCheckRolesOnAuthorize.Checked then
    ServerContainer1.AuthorizationMode := TAuthorizationChecking.authOnAuthorize
  else
    ServerContainer1.AuthorizationMode := TAuthorizationChecking.authOnPrepare
end;

procedure TForm36.AddUserRoleItem;
var
  LRoleItem: TUserRoleItem;
begin
  with TUserRoleItemForm.Create(Self) do
  try
    EditUserNames.Text := '';
    EditRoles.Text := '';
    if ShowModal = mrOK then
    begin
      LRoleItem := TUserRoleItem(ServerContainer1.UserRoleItems.Add);
      LRoleItem.UserNames.DelimitedText := EditUserNames.Text;
      LRoleItem.Roles.DelimitedText := EditRoles.Text;
      ServerContainer1.UserRoleItemsChanged;
    end;
  finally
    Free;
  end;
end;

procedure TForm36.DeleteUserRoleItem(ARoleItem: TUserRoleItem);
var
  I: Integer;
begin
  if MessageDlg('Delete ' + FormatUserRoleItem(ARoleItem) + '?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk then
    with ServerContainer1 do
    begin
      for I := 0 to UserRoleItems.Count do
      begin
        if UserRoleItems[I] = ARoleItem then
        begin
          UserRoleItems.Delete(I);
          ServerContainer1.UserRoleItemsChanged;
          break;
        end;
      end;
    end;
end;

procedure TForm36.EditUserRoleItem(ARoleItem: TUserRoleItem);
begin
  with TUserRoleItemForm.Create(Self) do
  try
    EditUserNames.Text := ARoleItem.UserNames.DelimitedText;
    EditRoles.Text := ARoleItem.Roles.DelimitedText;
    if ShowModal = mrOK then
    begin
      ARoleItem.UserNames.DelimitedText := EditUserNames.Text;
      ARoleItem.Roles.DelimitedText := EditRoles.Text;
      ServerContainer1.UserRoleItemsChanged;
    end;
  finally
    Free;
  end;
end;

end.

