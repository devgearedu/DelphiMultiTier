object MonitorForm: TMonitorForm
  Left = 0
  Top = 0
  Caption = 'Connection Monitor Demo Server'
  ClientHeight = 227
  ClientWidth = 536
  Color = clBtnFace
  Constraints.MaxWidth = 552
  Constraints.MinHeight = 265
  Constraints.MinWidth = 552
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  DesignSize = (
    536
    227)
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 8
    Top = 211
    Width = 181
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'HTTP PORT: 8088, TCP/IP PORT: 211'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object MyTabSheet: TPageControl
    Left = 8
    Top = 7
    Width = 521
    Height = 202
    ActivePage = ConnectionsTab
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object ConnectionsTab: TTabSheet
      Caption = 'Connections'
      DesignSize = (
        513
        174)
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 72
        Height = 13
        Caption = 'Connections:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 175
        Top = 8
        Width = 52
        Height = 13
        Caption = 'Sessions:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 335
        Top = 8
        Width = 104
        Height = 13
        Caption = 'Callback Channels:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 335
        Top = 145
        Width = 46
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Message:'
        ExplicitTop = 155
      end
      object ConnectionsList: TListBox
        Left = 8
        Top = 27
        Width = 161
        Height = 136
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        PopupMenu = KillConnMenu
        TabOrder = 0
        OnClick = ConnectionsListClick
      end
      object SessionsList: TListBox
        Left = 175
        Top = 27
        Width = 154
        Height = 136
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        PopupMenu = KillSessionMenu
        TabOrder = 1
        OnClick = SessionsListClick
      end
      object ChannelsList: TListBox
        Left = 335
        Top = 27
        Width = 170
        Height = 109
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        PopupMenu = ChannelMenu
        TabOrder = 2
      end
      object BroadcastField: TEdit
        Left = 384
        Top = 142
        Width = 121
        Height = 21
        Anchors = [akLeft, akBottom]
        TabOrder = 3
        Text = 'Hello, World!'
      end
    end
    object HTTPLogTab: TTabSheet
      Caption = 'HTTP Traffic'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        513
        174)
      object Label5: TLabel
        Left = 3
        Top = 3
        Width = 94
        Height = 13
        Caption = 'HTTP Traffic Log:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object HTTPTrafficMemo: TMemo
        Left = 3
        Top = 22
        Width = 502
        Height = 121
        Anchors = [akLeft, akTop, akRight, akBottom]
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object ClearHTTPLogButton: TButton
        Left = 440
        Top = 146
        Width = 59
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'clear'
        TabOrder = 1
        OnClick = ClearHTTPLogButtonClick
      end
      object LogHTTPTrafficCheck: TCheckBox
        Left = 3
        Top = 149
        Width = 118
        Height = 17
        Anchors = [akLeft, akBottom]
        Caption = 'Log HTTP Traffic'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object OpenInBrowserButton: TButton
        Left = 280
        Top = 146
        Width = 121
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Open Browser Client'
        TabOrder = 3
        OnClick = OpenInBrowserButtonClick
      end
      object LogFileDispatch: TCheckBox
        Left = 112
        Top = 149
        Width = 145
        Height = 17
        Anchors = [akLeft, akBottom]
        Caption = 'Log File Dispatching'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
    end
  end
  object KillSessionMenu: TPopupMenu
    Left = 256
    Top = 88
    object CloseSelectedSession1: TMenuItem
      Caption = 'Close Selected Session'
      OnClick = CloseSelectedSession1Click
    end
  end
  object ChannelMenu: TPopupMenu
    Left = 440
    Top = 88
    object BroadcastMessage1: TMenuItem
      Caption = 'Broadcast Message'
      OnClick = BroadcastMessage1Click
    end
  end
  object KillConnMenu: TPopupMenu
    Left = 80
    Top = 104
    object closeConnItem: TMenuItem
      Caption = 'Close Connection'
      OnClick = closeConnItemClick
    end
  end
end
