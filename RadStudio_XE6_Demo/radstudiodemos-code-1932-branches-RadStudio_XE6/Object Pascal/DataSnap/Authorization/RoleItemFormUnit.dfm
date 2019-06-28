object RoleItemForm: TRoleItemForm
  Left = 0
  Top = 0
  Caption = 'Role Item'
  ClientHeight = 145
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    431
    145)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 49
    Height = 13
    Caption = 'Apply To: '
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 85
    Height = 13
    Caption = 'Authorized Roles:'
  end
  object Label3: TLabel
    Left = 16
    Top = 80
    Width = 66
    Height = 13
    Caption = 'Denied Roles:'
  end
  object EditApplyTo: TEdit
    Left = 71
    Top = 13
    Width = 345
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'EditApplyTo'
  end
  object EditAuthorizedRoles: TEdit
    Left = 107
    Top = 45
    Width = 309
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = 'EditAuthorizedRoles'
    ExplicitWidth = 305
  end
  object EditDeniedRoles: TEdit
    Left = 107
    Top = 77
    Width = 309
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = 'EditDeniedRoles'
    ExplicitWidth = 305
  end
  object ButtonOK: TButton
    Left = 260
    Top = 109
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
    OnClick = ButtonOKClick
    ExplicitLeft = 256
    ExplicitTop = 112
  end
  object ButtonCancel: TButton
    Left = 341
    Top = 109
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    ExplicitLeft = 337
    ExplicitTop = 112
  end
end
