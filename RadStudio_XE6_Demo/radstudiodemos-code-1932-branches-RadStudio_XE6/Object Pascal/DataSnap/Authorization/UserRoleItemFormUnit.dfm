object UserRoleItemForm: TUserRoleItemForm
  Left = 0
  Top = 0
  Caption = 'User / Role'
  ClientHeight = 118
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    448
    118)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 30
    Height = 13
    Caption = 'Roles:'
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 61
    Height = 13
    Caption = 'User Names:'
  end
  object ButtonCancel: TButton
    Left = 365
    Top = 85
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
    ExplicitLeft = 396
    ExplicitTop = 304
  end
  object ButtonOK: TButton
    Left = 284
    Top = 85
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    ExplicitLeft = 315
    ExplicitTop = 304
  end
  object EditRoles: TEdit
    Left = 83
    Top = 45
    Width = 357
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = 'EditRoles'
  end
  object EditUserNames: TEdit
    Left = 83
    Top = 13
    Width = 358
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Text = 'EditUserNames'
    ExplicitWidth = 363
  end
end
