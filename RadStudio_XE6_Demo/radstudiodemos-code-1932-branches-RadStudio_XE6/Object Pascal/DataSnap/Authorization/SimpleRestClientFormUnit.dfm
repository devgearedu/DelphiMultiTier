object Form58: TForm58
  Left = 0
  Top = 0
  Caption = 'Delphi DataSnap REST Client'
  ClientHeight = 513
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    565
    513)
  PixelsPerInch = 96
  TextHeight = 13
  object Label9: TLabel
    Left = 7
    Top = 98
    Width = 41
    Height = 13
    Caption = 'URLPath'
  end
  object Label8: TLabel
    Left = 9
    Top = 71
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label6: TLabel
    Left = 9
    Top = 17
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object Label1: TLabel
    Left = 8
    Top = 182
    Width = 55
    Height = 13
    Caption = 'Class Name'
  end
  object Label2: TLabel
    Left = 8
    Top = 206
    Width = 66
    Height = 13
    Caption = 'Method Name'
  end
  object Label3: TLabel
    Left = 22
    Top = 125
    Width = 26
    Height = 13
    Caption = 'User:'
  end
  object Label4: TLabel
    Left = 17
    Top = 151
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label11: TLabel
    Left = 392
    Top = 289
    Width = 26
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Time:'
    ExplicitLeft = 406
  end
  object LabelTime: TLabel
    Left = 477
    Top = 289
    Width = 6
    Height = 13
    Anchors = [akTop, akRight]
    Caption = '0'
    ExplicitLeft = 490
  end
  object Label5: TLabel
    Left = 392
    Top = 265
    Width = 71
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Repeat Count:'
    ExplicitLeft = 406
  end
  object EditURLPath: TEdit
    Left = 77
    Top = 95
    Width = 481
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    OnChange = EditURLPathChange
    ExplicitWidth = 280
  end
  object EditPort: TEdit
    Left = 77
    Top = 68
    Width = 73
    Height = 21
    TabOrder = 2
    Text = '8081'
    OnChange = EditPortChange
  end
  object EditHost: TEdit
    Left = 77
    Top = 14
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'localhost'
    OnChange = EditHostChange
  end
  object ButtonEchoString: TButton
    Left = 474
    Top = 230
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'EchoString'
    TabOrder = 10
    OnClick = ButtonEchoStringClick
    ExplicitLeft = 273
  end
  object EditValue: TEdit
    Left = 8
    Top = 230
    Width = 460
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 9
    Text = 'Echo this  text'
    ExplicitWidth = 259
  end
  object EditServerClass: TEdit
    Left = 77
    Top = 179
    Width = 391
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
    Text = 'TServerMethods1'
    ExplicitWidth = 190
  end
  object ButtonClearSession: TButton
    Left = 16
    Top = 270
    Width = 105
    Height = 25
    Caption = 'Clear Session ID'
    TabOrder = 12
    OnClick = ButtonClearSessionClick
  end
  object EditMethodName: TEdit
    Left = 77
    Top = 203
    Width = 391
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 8
    Text = 'ReverseString'
    ExplicitWidth = 190
  end
  object EditUser: TEdit
    Left = 77
    Top = 122
    Width = 156
    Height = 21
    TabOrder = 5
  end
  object EditPassword: TEdit
    Left = 77
    Top = 149
    Width = 156
    Height = 21
    TabOrder = 6
  end
  object Memo1: TMemo
    Left = 8
    Top = 328
    Width = 541
    Height = 139
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 13
    WordWrap = False
    ExplicitWidth = 340
    ExplicitHeight = 92
  end
  object ButtonClear: TButton
    Left = 474
    Top = 480
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Clear'
    TabOrder = 14
    OnClick = ButtonClearClick
    ExplicitLeft = 273
    ExplicitTop = 433
  end
  object ButtonTestConnection: TButton
    Left = 192
    Top = 64
    Width = 108
    Height = 25
    Caption = 'Test Connection'
    TabOrder = 3
    OnClick = ButtonTestConnectionClick
  end
  object CheckBoxUseProxy: TCheckBox
    Left = 8
    Top = 41
    Width = 178
    Height = 17
    Caption = 'Use HTTP Proxy (e.g.; Fiddler)'
    TabOrder = 1
  end
  object EditRepeatCount: TEdit
    Left = 473
    Top = 262
    Width = 76
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 11
    Text = '1'
    ExplicitLeft = 487
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 144
    Top = 270
  end
  object DSRestConnection1: TDSRestConnection
    Port = 0
    Left = 264
    Top = 16
  end
end
