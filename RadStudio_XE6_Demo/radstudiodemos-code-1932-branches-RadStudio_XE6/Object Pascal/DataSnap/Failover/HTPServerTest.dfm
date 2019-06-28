object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'DSHTTPTest'
  ClientHeight = 351
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblActiveTunnelSessions: TLabel
    Left = 8
    Top = 286
    Width = 169
    Height = 13
    Caption = 'Current number of tunnel sessions:'
  end
  object lblOpenSessions: TLabel
    Left = 199
    Top = 286
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lstLog: TListBox
    Left = 8
    Top = 8
    Width = 672
    Height = 249
    ItemHeight = 13
    ScrollWidth = 300
    TabOrder = 0
  end
  object btnClearLog: TButton
    Left = 605
    Top = 263
    Width = 75
    Height = 25
    Caption = 'Clear Log'
    TabOrder = 1
    OnClick = btnClearLogClick
  end
  object chkActive: TCheckBox
    Left = 8
    Top = 263
    Width = 97
    Height = 17
    Caption = 'Active'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = chkActiveClick
  end
  object btnClose: TButton
    Left = 605
    Top = 316
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object btnRefresh: TButton
    Left = 223
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Refresh'
    TabOrder = 4
    OnClick = btnRefreshClick
  end
  object btnCloseAll: TButton
    Left = 304
    Top = 281
    Width = 97
    Height = 25
    Caption = 'Close All Sessions'
    TabOrder = 5
    OnClick = btnCloseAllClick
  end
  object Button1: TButton
    Left = 407
    Top = 281
    Width = 75
    Height = 25
    Caption = 'List Sessions'
    TabOrder = 6
    OnClick = Button1Click
  end
  object cbFailover: TCheckBox
    Left = 8
    Top = 320
    Width = 97
    Height = 17
    Caption = 'Enable Failover'
    Checked = True
    State = cbChecked
    TabOrder = 7
    OnClick = cbFailoverClick
  end
  object DSHTTPService1: TDSHTTPService
    Trace = DSHTTPService1Trace
    Filters = <>
    AuthenticationManager = DSAuthenticationManager1
    HttpPort = 8020
    Left = 240
    Top = 80
  end
  object DSAuthenticationManager1: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManager1UserAuthenticate
    Roles = <>
    Left = 232
    Top = 160
  end
end
