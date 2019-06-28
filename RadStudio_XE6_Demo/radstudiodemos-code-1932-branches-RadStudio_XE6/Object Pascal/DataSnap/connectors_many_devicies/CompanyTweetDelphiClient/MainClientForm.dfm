object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'CompanyTweet Console'
  ClientHeight = 210
  ClientWidth = 552
  Color = clBtnFace
  Constraints.MinHeight = 220
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  DesignSize = (
    552
    210)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelUsers: TLabel
    Left = 361
    Top = 45
    Width = 95
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Connected Users'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = 243
  end
  object LabelTweets: TLabel
    Left = 8
    Top = 45
    Width = 41
    Height = 13
    Caption = 'Tweets'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 32
    Width = 536
    Height = 3
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
    ExplicitWidth = 418
  end
  object PortLabel: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = 'PORT:'
  end
  object ButtRefresh: TButton
    Left = 462
    Top = 44
    Width = 82
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Refresh'
    Enabled = False
    TabOrder = 0
    OnClick = ButtRefreshClick
  end
  object UsersList: TListBox
    Left = 358
    Top = 64
    Width = 187
    Height = 136
    Anchors = [akTop, akRight, akBottom]
    Enabled = False
    ItemHeight = 13
    TabOrder = 1
  end
  object StartButton: TButton
    Left = 111
    Top = 5
    Width = 75
    Height = 21
    Caption = 'START'
    TabOrder = 2
    OnClick = StartButtonClick
  end
  object PortField: TEdit
    Left = 45
    Top = 5
    Width = 60
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    Text = '8086'
  end
  object TweetsMemo: TMemo
    Left = 8
    Top = 64
    Width = 344
    Height = 138
    Anchors = [akLeft, akTop, akRight, akBottom]
    PopupMenu = ClearMenu
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object StopButton: TButton
    Left = 192
    Top = 5
    Width = 75
    Height = 21
    Caption = 'STOP'
    Enabled = False
    TabOrder = 5
    OnClick = StopButtonClick
  end
  object ChannelManager: TDSClientCallbackChannelManager
    CommunicationProtocol = 'http'
    ManagerId = '264263.716544.180092'
    OnServerConnectionError = ChannelManagerServerConnectionError
    OnServerConnectionTerminate = ChannelManagerServerConnectionTerminate
    Left = 135
    Top = 72
  end
  object Timer1: TTimer
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 32
    Top = 72
  end
  object ClearMenu: TPopupMenu
    Left = 136
    Top = 128
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
  end
end
