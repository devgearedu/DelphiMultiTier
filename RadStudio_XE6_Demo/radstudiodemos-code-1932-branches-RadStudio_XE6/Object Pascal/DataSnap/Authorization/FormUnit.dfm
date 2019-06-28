object Form36: TForm36
  Left = 0
  Top = 0
  Caption = 'Role Authorization Test Server'
  ClientHeight = 846
  ClientWidth = 986
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    986
    846)
  PixelsPerInch = 120
  TextHeight = 17
  object lblTCPPort: TLabel
    Left = 99
    Top = 63
    Width = 26
    Height = 17
    Caption = 'port'
  end
  object label2: TLabel
    Left = 14
    Top = 39
    Width = 69
    Height = 17
    Caption = 'IP Address:'
  end
  object label3: TLabel
    Left = 16
    Top = 61
    Width = 77
    Height = 17
    Caption = 'TCP/IP Port:'
  end
  object lblIpAddress: TLabel
    Left = 99
    Top = 39
    Width = 61
    Height = 17
    Caption = 'ip address'
  end
  object lblHostName: TLabel
    Left = 99
    Top = 17
    Width = 27
    Height = 17
    Caption = 'host'
  end
  object label1: TLabel
    Left = 14
    Top = 17
    Width = 72
    Height = 17
    Caption = 'Host Name:'
  end
  object Label5: TLabel
    Left = 14
    Top = 349
    Width = 179
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Method/Class Roles Collection'
  end
  object Label6: TLabel
    Left = 16
    Top = 641
    Width = 23
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Log'
  end
  object Label7: TLabel
    Left = 16
    Top = 489
    Width = 125
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'User Roles Collection'
  end
  object lblHTTPPort: TLabel
    Left = 99
    Top = 85
    Width = 68
    Height = 17
    Caption = 'HTTP Port:'
  end
  object Label9: TLabel
    Left = 16
    Top = 84
    Width = 68
    Height = 17
    Caption = 'HTTP Port:'
  end
  object ButtonStart: TButton
    Left = 335
    Top = 10
    Width = 133
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Start DSServer'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 476
    Top = 10
    Width = 44
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object MemoServerMethods: TMemo
    Left = 527
    Top = 9
    Width = 450
    Height = 151
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvRaised
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object MemoLog: TMemo
    Left = 14
    Top = 666
    Width = 962
    Height = 131
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 19
    WordWrap = False
  end
  object ButtonClearLog: TButton
    Left = 9
    Top = 805
    Width = 98
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akBottom]
    Caption = 'Clear Log'
    TabOrder = 20
    OnClick = ButtonClearLogClick
  end
  object ButtonDisplayServerMethods: TButton
    Left = 310
    Top = 124
    Width = 210
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Display Server Methods'
    TabOrder = 6
    OnClick = ButtonDisplayServerMethodsClick
  end
  object ListViewRolesCollection: TListView
    Left = 14
    Top = 374
    Width = 854
    Height = 107
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Columns = <
      item
        Caption = 'ApplyTo'
        Width = 262
      end
      item
        Caption = 'Authorized Roles'
        Width = 262
      end
      item
        Caption = 'Denied Roles'
        Width = 262
      end>
    RowSelect = True
    TabOrder = 11
    ViewStyle = vsReport
  end
  object ButtonAddRoleItem: TButton
    Left = 876
    Top = 373
    Width = 94
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akTop, akRight]
    Caption = 'Add Item'
    TabOrder = 12
    OnClick = ButtonAddRoleItemClick
  end
  object ButtonEditRoleItem: TButton
    Left = 876
    Top = 414
    Width = 94
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akTop, akRight]
    Caption = 'Edit Item'
    TabOrder = 13
    OnClick = ButtonEditRoleItemClick
  end
  object ButtonDeleteRoleItem: TButton
    Left = 876
    Top = 454
    Width = 94
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akTop, akRight]
    Caption = 'Delete Item'
    TabOrder = 14
    OnClick = ButtonDeleteRoleItemClick
  end
  object ListViewUserRoles: TListView
    Left = 14
    Top = 519
    Width = 854
    Height = 114
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Columns = <
      item
        Caption = 'Users'
        Width = 262
      end
      item
        Caption = 'Roles'
        Width = 262
      end>
    RowSelect = True
    TabOrder = 15
    ViewStyle = vsReport
  end
  object ButtonAddUserRole: TButton
    Left = 876
    Top = 519
    Width = 94
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akTop, akRight]
    Caption = 'Add Item'
    TabOrder = 16
    OnClick = ButtonAddUserRoleClick
  end
  object ButtonEditUserRole: TButton
    Left = 876
    Top = 560
    Width = 94
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akTop, akRight]
    Caption = 'Edit Item'
    TabOrder = 17
    OnClick = ButtonEditUserRoleClick
  end
  object ButtonDeleteUserRole: TButton
    Left = 876
    Top = 600
    Width = 94
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akTop, akRight]
    Caption = 'Delete Item'
    TabOrder = 18
    OnClick = ButtonDeleteUserRoleClick
  end
  object ButtonStartHTTP: TButton
    Left = 335
    Top = 48
    Width = 133
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Start HTTP'
    TabOrder = 2
    OnClick = ButtonStartHTTPClick
  end
  object ButtonStopHTTP: TButton
    Left = 476
    Top = 48
    Width = 44
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Stop'
    TabOrder = 3
    OnClick = ButtonStopHTTPClick
  end
  object ButtonStartTCP: TButton
    Left = 335
    Top = 86
    Width = 133
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Start TCP'
    TabOrder = 4
    OnClick = ButtonStartTCPClick
  end
  object ButtonStopTCP: TButton
    Left = 476
    Top = 86
    Width = 44
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Stop'
    TabOrder = 5
    OnClick = ButtonStopTCPClick
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 174
    Width = 187
    Height = 139
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Authentication Rules'
    TabOrder = 8
    object RadioButtonAuthenticateNone: TRadioButton
      Left = 21
      Top = 90
      Width = 148
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Deny All Users'
      TabOrder = 2
      OnClick = OnAuthenticationRadioButton
    end
    object RadioButtonAuthenticateAll: TRadioButton
      Left = 21
      Top = 30
      Width = 148
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Allow All Users'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = OnAuthenticationRadioButton
    end
    object RadioButtonAutenticateKnownUsers: TRadioButton
      Left = 21
      Top = 60
      Width = 148
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'All Users with Roles'
      TabOrder = 1
      OnClick = OnAuthenticationRadioButton
    end
  end
  object GroupBox2: TGroupBox
    Left = 447
    Top = 174
    Width = 153
    Height = 139
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Authorization Rules'
    TabOrder = 10
    object RadioButtonDenyAllUsers: TRadioButton
      Left = 21
      Top = 90
      Width = 148
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Deny All Users'
      TabOrder = 2
      OnClick = OnAuthorizationRequirementsRadioButton
    end
    object RadioButtonAllowAll: TRadioButton
      Left = 21
      Top = 60
      Width = 148
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Allow All Users'
      TabOrder = 1
      OnClick = OnAuthorizationRequirementsRadioButton
    end
    object RadioButtonUseRoles: TRadioButton
      Left = 21
      Top = 30
      Width = 148
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Use Roles'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = OnAuthorizationRequirementsRadioButton
    end
  end
  object GroupBox3: TGroupBox
    Left = 211
    Top = 174
    Width = 228
    Height = 139
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Authorization Checking'
    TabOrder = 9
    object RadioButtonDefaultAuthorization: TRadioButton
      Left = 21
      Top = 30
      Width = 200
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Default Authorization'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = OnAuthorizationCheckingRadioButton
    end
    object RadioButtonCheckRolesOnAuthorize: TRadioButton
      Left = 22
      Top = 60
      Width = 208
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Check roles in OnAuthorize'
      TabOrder = 1
      OnClick = OnAuthorizationCheckingRadioButton
    end
    object RadioButtonCheckRolesOnPrepare: TRadioButton
      Left = 21
      Top = 90
      Width = 200
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Check roles in OnPrepare'
      TabOrder = 2
      OnClick = OnAuthorizationCheckingRadioButton
    end
  end
  object GroupBoxFilters: TGroupBox
    Left = 612
    Top = 174
    Width = 316
    Height = 191
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Filters'
    TabOrder = 21
    object LabelRSAKeyLength: TLabel
      Left = 110
      Top = 48
      Width = 104
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'RSA Key Length:'
    end
    object LabelRSAKeyExponent: TLabel
      Left = 110
      Top = 84
      Width = 121
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'RSA Key Exponent:'
    end
    object LabelPC1Key: TLabel
      Left = 16
      Top = 119
      Width = 57
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'PC1 Key:'
    end
    object CheckBoxRSA: TCheckBox
      Left = 16
      Top = 20
      Width = 59
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'RSA'
      TabOrder = 0
      OnClick = FilterChanged
    end
    object CheckBoxPC1: TCheckBox
      Left = 16
      Top = 50
      Width = 65
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'PC1'
      TabOrder = 1
      OnClick = FilterChanged
    end
    object CheckBoxZLib: TCheckBox
      Left = 16
      Top = 80
      Width = 65
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'ZLib'
      TabOrder = 2
      OnClick = FilterChanged
    end
    object ButtonApplyFilters: TButton
      Left = 216
      Top = 150
      Width = 86
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Apply'
      TabOrder = 7
      OnClick = ButtonApplyFiltersClick
    end
    object EditRSAKeyLength: TEdit
      Left = 241
      Top = 44
      Width = 64
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 4
      Text = '1024'
      OnClick = FilterChanged
    end
    object CheckBoxRSAGlobalKey: TCheckBox
      Left = 110
      Top = 18
      Width = 127
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'RSA Global Key'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = FilterChanged
    end
    object EditRSAKeyExponent: TEdit
      Left = 260
      Top = 80
      Width = 45
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 5
      Text = '3'
      OnClick = FilterChanged
    end
    object EditPC1Key: TEdit
      Left = 110
      Top = 115
      Width = 195
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 6
      Text = '16char serverkey'
      OnClick = FilterChanged
    end
    object CheckBoxPC1Random: TCheckBox
      Left = 10
      Top = 146
      Width = 127
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'PC1 Random Key'
      TabOrder = 8
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 296
    Top = 243
  end
end
