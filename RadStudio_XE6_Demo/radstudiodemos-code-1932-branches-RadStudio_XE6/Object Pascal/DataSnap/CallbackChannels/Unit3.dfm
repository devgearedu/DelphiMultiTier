object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Channel Server'
  ClientHeight = 240
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  DesignSize = (
    686
    240)
  PixelsPerInch = 96
  TextHeight = 13
  object Channels: TLabel
    Left = 8
    Top = 77
    Width = 44
    Height = 13
    Caption = 'Channels'
  end
  object Label1: TLabel
    Left = 160
    Top = 77
    Width = 44
    Height = 13
    Caption = 'Callbacks'
  end
  object Label2: TLabel
    Left = 426
    Top = 77
    Width = 32
    Height = 13
    Caption = 'Clients'
  end
  object ButtonBroadcastChannel: TButton
    Left = 8
    Top = 204
    Width = 129
    Height = 25
    Caption = 'Broadcast Message'
    TabOrder = 0
    OnClick = ButtonBroadcastChannelClick
  end
  object Button3: TButton
    Left = 8
    Top = 8
    Width = 113
    Height = 25
    Caption = 'Restart DSServer'
    TabOrder = 1
    OnClick = Button3Click
  end
  object ListBoxChannels: TListBox
    Left = 8
    Top = 96
    Width = 121
    Height = 71
    ItemHeight = 13
    TabOrder = 2
  end
  object ButtonListChannels: TButton
    Left = 8
    Top = 173
    Width = 113
    Height = 25
    Caption = 'List Channels'
    Enabled = False
    TabOrder = 3
    OnClick = ButtonListChannelsClick
  end
  object ListBoxCallbacks: TListBox
    Left = 160
    Top = 96
    Width = 249
    Height = 71
    ItemHeight = 13
    TabOrder = 4
  end
  object ButtonListCallbacks: TButton
    Left = 160
    Top = 173
    Width = 113
    Height = 25
    Caption = 'List Callbacks'
    Enabled = False
    TabOrder = 5
    OnClick = ButtonListCallbacksClick
  end
  object ListBoxClients: TListBox
    Left = 426
    Top = 96
    Width = 249
    Height = 71
    ItemHeight = 13
    TabOrder = 6
  end
  object ButtonListClients: TButton
    Left = 426
    Top = 176
    Width = 97
    Height = 25
    Caption = 'List Clients'
    Enabled = False
    TabOrder = 7
    OnClick = ButtonListClientsClick
  end
  object ButtonBroadCastCallback: TButton
    Left = 160
    Top = 204
    Width = 145
    Height = 25
    Caption = 'Broadcast Message'
    TabOrder = 8
    OnClick = ButtonBroadCastCallbackClick
  end
  object ButtonListAll: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'List All'
    Enabled = False
    TabOrder = 9
    OnClick = ButtonListAllClick
  end
  object ButtonSendMessage: TButton
    Left = 426
    Top = 207
    Width = 97
    Height = 25
    Caption = 'Notify Client'
    TabOrder = 10
    OnClick = ButtonSendMessageClick
  end
  object OpenBrowserButton: TButton
    Left = 564
    Top = 8
    Width = 114
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Open In Browser'
    TabOrder = 11
    OnClick = OpenBrowserButtonClick
  end
  object AutoUpdateCheck: TCheckBox
    Left = 208
    Top = 8
    Width = 225
    Height = 17
    Caption = 'Automatically Update Tunnel Information'
    Checked = True
    State = cbChecked
    TabOrder = 12
    OnClick = AutoUpdateCheckClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 344
    Top = 16
  end
end
