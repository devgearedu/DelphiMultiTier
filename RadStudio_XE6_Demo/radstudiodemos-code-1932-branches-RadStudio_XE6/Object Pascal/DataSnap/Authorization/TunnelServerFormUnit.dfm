object Form52: TForm52
  Left = 0
  Top = 0
  Caption = 'DataSnap HTTP to TCP tunnel server'
  ClientHeight = 609
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    527
    609)
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 26
    Top = 307
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object Label7: TLabel
    Left = 23
    Top = 288
    Width = 74
    Height = 13
    Caption = 'Authentication:'
  end
  object ButtonStopHTTP: TButton
    Left = 104
    Top = 8
    Width = 34
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopHTTPClick
  end
  object ButtonStartHTTP: TButton
    Left = 23
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start HTTP'
    TabOrder = 0
    OnClick = ButtonStartHTTPClick
  end
  object MemoLog: TMemo
    Left = 26
    Top = 326
    Width = 493
    Height = 235
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 6
    WordWrap = False
  end
  object ButtonClearLog: TButton
    Left = 26
    Top = 576
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Clear Log'
    TabOrder = 7
    OnClick = ButtonClearLogClick
  end
  object GroupBox1: TGroupBox
    Left = 23
    Top = 47
    Width = 335
    Height = 225
    Caption = 'HTTP Service Properties'
    TabOrder = 2
    object Label3: TLabel
      Left = 19
      Top = 134
      Width = 85
      Height = 13
      Caption = 'Server Password:'
    end
    object Label4: TLabel
      Left = 19
      Top = 107
      Width = 91
      Height = 13
      Caption = 'Server User Name:'
    end
    object Label1: TLabel
      Left = 19
      Top = 80
      Width = 95
      Height = 13
      Caption = 'Server TCP/IP Port:'
    end
    object Label5: TLabel
      Left = 19
      Top = 53
      Width = 91
      Height = 13
      Caption = 'Server Host Name:'
    end
    object Label2: TLabel
      Left = 19
      Top = 26
      Width = 89
      Height = 13
      Caption = 'HTTP Listener Port'
    end
    object CheckBoxCredentialPassthrough: TCheckBox
      Left = 132
      Top = 158
      Width = 201
      Height = 17
      Caption = 'Credential Passthrough'
      TabOrder = 5
      OnClick = OnEditChange
    end
    object ButtonChangeProperties: TButton
      Left = 19
      Top = 181
      Width = 121
      Height = 25
      Caption = 'Apply Changes'
      TabOrder = 6
      OnClick = ButtonChangePropertiesClick
    end
    object EditAuthPassword: TEdit
      Left = 132
      Top = 131
      Width = 173
      Height = 21
      TabOrder = 4
      OnChange = OnEditChange
    end
    object EditAuthUserName: TEdit
      Left = 132
      Top = 104
      Width = 170
      Height = 21
      TabOrder = 3
      OnChange = OnEditChange
    end
    object EditTunnelTCPPort: TEdit
      Left = 132
      Top = 77
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '211'
      OnChange = OnEditChange
    end
    object EditRemoteHostName: TEdit
      Left = 132
      Top = 50
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'localhost'
      OnChange = OnEditChange
    end
    object EditHTTPPort: TEdit
      Left = 132
      Top = 23
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'EditHTTPPort'
      OnChange = OnEditChange
    end
  end
  object RadioButtonAuthenticateUsersWithName: TRadioButton
    Left = 342
    Top = 287
    Width = 155
    Height = 17
    Caption = 'Allow users with Names'
    TabOrder = 5
    OnClick = RadioButtonAuthenticateAllClick
  end
  object RadioButtonAuthenticateNone: TRadioButton
    Left = 223
    Top = 287
    Width = 113
    Height = 17
    Caption = 'Deny All Users'
    TabOrder = 4
    OnClick = RadioButtonAuthenticateAllClick
  end
  object RadioButtonAuthenticateAll: TRadioButton
    Left = 121
    Top = 287
    Width = 96
    Height = 17
    Caption = 'Allow All Users'
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = RadioButtonAuthenticateAllClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 424
    Top = 32
  end
end
