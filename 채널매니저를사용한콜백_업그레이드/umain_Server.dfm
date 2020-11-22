object Form18: TForm18
  Left = 0
  Top = 0
  Caption = 'Form18'
  ClientHeight = 307
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  DesignSize = (
    583
    307)
  PixelsPerInch = 96
  TextHeight = 13
  object Channels: TLabel
    Left = 16
    Top = 21
    Width = 44
    Height = 13
    Caption = 'Channels'
  end
  object Label1: TLabel
    Left = 168
    Top = 21
    Width = 44
    Height = 13
    Caption = 'Callbacks'
  end
  object Label2: TLabel
    Left = 426
    Top = 21
    Width = 32
    Height = 13
    Caption = 'Clients'
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 8
    Top = 157
    Width = 337
    Height = 121
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      '')
    TabOrder = 0
    OnChange = Memo1Change
  end
  object ListBoxChannels: TListBox
    Left = 8
    Top = 40
    Width = 138
    Height = 71
    ItemHeight = 13
    TabOrder = 1
  end
  object ListBoxCallbacks: TListBox
    Left = 152
    Top = 40
    Width = 168
    Height = 71
    ItemHeight = 13
    TabOrder = 2
  end
  object ListBoxClients: TListBox
    Left = 326
    Top = 40
    Width = 249
    Height = 71
    ItemHeight = 13
    TabOrder = 3
  end
  object ButtonBroadcastChannel: TButton
    Left = 361
    Top = 191
    Width = 177
    Height = 25
    Caption = 'Broadcast Message'
    TabOrder = 4
    OnClick = ButtonBroadcastChannelClick
  end
  object ButtonBroadCastCallback: TButton
    Left = 361
    Top = 222
    Width = 177
    Height = 25
    Caption = 'Broadcast callBack'
    TabOrder = 5
    OnClick = ButtonBroadCastCallbackClick
  end
  object ButtonSendMessage: TButton
    Left = 361
    Top = 253
    Width = 176
    Height = 25
    Caption = 'Notify Client'
    TabOrder = 6
    OnClick = ButtonSendMessageClick
  end
  object ButtonListChannels: TButton
    Left = 8
    Top = 117
    Width = 138
    Height = 34
    Caption = 'List Channels'
    Enabled = False
    TabOrder = 7
    OnClick = ButtonListChannelsClick
  end
  object ButtonListCallbacks: TButton
    Left = 152
    Top = 117
    Width = 168
    Height = 34
    Caption = 'List Callbacks'
    Enabled = False
    TabOrder = 8
    OnClick = ButtonListCallbacksClick
  end
  object ButtonListClients: TButton
    Left = 326
    Top = 117
    Width = 171
    Height = 34
    Caption = 'List Clients'
    Enabled = False
    TabOrder = 9
    OnClick = ButtonListClientsClick
  end
  object ButtonListAll: TButton
    Left = 500
    Top = 117
    Width = 75
    Height = 34
    Caption = 'List All'
    Enabled = False
    TabOrder = 10
    OnClick = ButtonListAllClick
  end
  object Button3: TButton
    Left = 361
    Top = 157
    Width = 176
    Height = 28
    Caption = 'Restart DSServer'
    TabOrder = 11
    OnClick = Button3Click
  end
  object AutoUpdateCheck: TCheckBox
    Left = 16
    Top = -2
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
    Left = 368
    Top = 8
  end
end
