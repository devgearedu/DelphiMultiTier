object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'CompanyTweet Server'
  ClientHeight = 217
  ClientWidth = 434
  Color = clBtnFace
  Constraints.MinHeight = 225
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnClose = FormClose
  DesignSize = (
    434
    217)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 32
    Width = 418
    Height = 3
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
    ExplicitWidth = 348
  end
  object PortLabel: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = 'PORT:'
  end
  object MessageArea: TEdit
    Left = 8
    Top = 182
    Width = 320
    Height = 27
    Anchors = [akLeft, akRight, akBottom]
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TextHint = 'Write your admin messages here'
    OnKeyPress = MessageAreaKeyPress
  end
  object ButtSend: TButton
    Left = 334
    Top = 180
    Width = 93
    Height = 29
    Action = actSend
    Anchors = [akRight, akBottom]
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object ButtRing: TButton
    Left = 322
    Top = 41
    Width = 105
    Height = 25
    Action = actRing
    Anchors = [akTop, akRight]
    Caption = 'Ring Users'
    Enabled = False
    TabOrder = 2
  end
  object ButtVibrate: TButton
    Left = 211
    Top = 41
    Width = 105
    Height = 25
    Action = actVibrate
    Anchors = [akTop, akRight]
    Caption = 'Vibrate Users'
    Enabled = False
    TabOrder = 3
  end
  object PortField: TEdit
    Left = 45
    Top = 5
    Width = 60
    Height = 21
    NumbersOnly = True
    TabOrder = 4
    Text = '8086'
  end
  object StartButton: TButton
    Left = 111
    Top = 5
    Width = 75
    Height = 21
    Caption = 'START'
    TabOrder = 5
    OnClick = StartButtonClick
  end
  object ConnectionPages: TPageControl
    Left = 8
    Top = 72
    Width = 418
    Height = 102
    ActivePage = UsersPage
    Anchors = [akLeft, akTop, akRight, akBottom]
    MultiLine = True
    TabOrder = 6
    object UsersPage: TTabSheet
      Caption = 'Users'
      object LogArea: TListBox
        Left = 0
        Top = 0
        Width = 410
        Height = 74
        Align = alClient
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PopupMenu = BootUserMenu
        TabOrder = 0
      end
    end
    object SessionsPage: TTabSheet
      Caption = 'Sessions'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SessionsList: TListBox
        Left = 0
        Top = 0
        Width = 410
        Height = 74
        Align = alClient
        Enabled = False
        ItemHeight = 13
        PopupMenu = CloseSessionMenu
        TabOrder = 0
      end
    end
  end
  object StopButton: TButton
    Left = 192
    Top = 5
    Width = 75
    Height = 21
    Caption = 'STOP'
    Enabled = False
    TabOrder = 7
    OnClick = StopButtonClick
  end
  object AutoStartCheck: TCheckBox
    Left = 273
    Top = 9
    Width = 160
    Height = 17
    Caption = 'Auto start after 1 minute'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object ActionList1: TActionList
    Left = 248
    Top = 104
    object actSend: TAction
      Caption = 'Send'
      OnExecute = actSendExecute
    end
    object actRing: TAction
      Caption = 'Ring them all'
      OnExecute = actRingExecute
    end
    object actVibrate: TAction
      Caption = 'Vibrate them all'
      OnExecute = actVibrateExecute
    end
  end
  object BootUserMenu: TPopupMenu
    Left = 56
    Top = 104
    object BootUserItem: TMenuItem
      Caption = 'Disconnect selected user'
      OnClick = BootUserItemClick
    end
  end
  object CloseSessionMenu: TPopupMenu
    Left = 152
    Top = 104
    object Closeselectedsession1: TMenuItem
      Caption = 'Close selected session'
      OnClick = Closeselectedsession1Click
    end
  end
  object AutoStartTimer: TTimer
    Interval = 60000
    OnTimer = AutoStartTimerTimer
    Left = 336
    Top = 112
  end
end
