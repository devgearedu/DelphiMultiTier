object DBXClientForm56: TDBXClientForm56
  Left = 0
  Top = 0
  Caption = 'DBX Callback Channel  Client'
  ClientHeight = 520
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  DesignSize = (
    747
    520)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 104
    Top = 8
    Width = 73
    Height = 13
    Caption = 'Channel Name:'
  end
  object Label3: TLabel
    Left = 216
    Top = 8
    Width = 45
    Height = 13
    Caption = 'Client ID:'
  end
  object Label4: TLabel
    Left = 8
    Top = 60
    Width = 74
    Height = 13
    Caption = 'Client Channels'
  end
  object Label5: TLabel
    Left = 8
    Top = 162
    Width = 74
    Height = 13
    Caption = 'Client Callbacks'
  end
  object Label9: TLabel
    Left = 8
    Top = 383
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object Label10: TLabel
    Left = 8
    Top = 8
    Width = 43
    Height = 13
    Caption = 'Protocol:'
  end
  object ComboBoxChannelName: TComboBox
    Left = 104
    Top = 27
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = 'ChannelOne'
    Items.Strings = (
      'ChannelOne'
      'ChannelTwo'
      'ChannelThree')
  end
  object ComboBoxCallbackName: TComboBox
    Left = 647
    Top = 81
    Width = 92
    Height = 21
    Anchors = [akTop, akRight]
    ItemIndex = 0
    TabOrder = 1
    Text = 'CallbackAAA'
    Items.Strings = (
      'CallbackAAA'
      'CallbackBBB'
      'CallbackCCC')
  end
  object ComboBoxClientName: TComboBox
    Left = 216
    Top = 27
    Width = 145
    Height = 21
    ItemIndex = 0
    TabOrder = 2
    Text = 'ClientFirst'
    Items.Strings = (
      'ClientFirst'
      'ClientSecond'
      'ClientThird')
  end
  object ListBoxChannels: TListBox
    Left = 8
    Top = 79
    Width = 483
    Height = 74
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 3
  end
  object ButtonCreateClientChannel: TButton
    Left = 383
    Top = 25
    Width = 153
    Height = 25
    Caption = 'Create Client Channel'
    TabOrder = 4
    OnClick = ButtonCreateClientChannelClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 402
    Width = 731
    Height = 79
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object ButtonCreateCallback: TButton
    Left = 497
    Top = 79
    Width = 145
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Create Callback'
    TabOrder = 6
    OnClick = ButtonCreateCallbackClick
  end
  object ListBoxCallbacks: TListBox
    Left = 8
    Top = 181
    Width = 483
    Height = 95
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 7
  end
  object ButtonTerminateClientChannel: TButton
    Left = 497
    Top = 108
    Width = 145
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Terminate Client Channel'
    TabOrder = 8
    OnClick = ButtonTerminateClientChannelClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 282
    Width = 649
    Height = 95
    Caption = 'Broadcast/Notify'
    TabOrder = 9
    object Label6: TLabel
      Left = 96
      Top = 16
      Width = 73
      Height = 13
      Caption = 'Channel Name:'
    end
    object Label2: TLabel
      Left = 11
      Top = 65
      Width = 46
      Height = 13
      Caption = 'Message:'
    end
    object Label7: TLabel
      Left = 317
      Top = 16
      Width = 61
      Height = 13
      Caption = 'Client Name:'
    end
    object Label8: TLabel
      Left = 210
      Top = 16
      Width = 73
      Height = 13
      Caption = 'Callback Name:'
    end
    object Label11: TLabel
      Left = 8
      Top = 16
      Width = 43
      Height = 13
      Caption = 'Protocol:'
    end
    object ComboBoxBroadcastToChannel: TComboBox
      Left = 96
      Top = 35
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'ChannelOne'
      Items.Strings = (
        'ChannelOne'
        'ChannelTwo'
        'ChannelThree')
    end
    object ButtonBroadcastToChannel: TButton
      Left = 488
      Top = 21
      Width = 146
      Height = 25
      Caption = 'Broadcast to Channel'
      TabOrder = 5
      OnClick = ButtonBroadcastToChannelClick
    end
    object EditChannelBroadcastMessage: TEdit
      Left = 63
      Top = 62
      Width = 314
      Height = 21
      TabOrder = 4
      Text = 'Message'
    end
    object ComboBoxClientBroadcast: TComboBox
      Left = 317
      Top = 35
      Width = 145
      Height = 21
      ItemIndex = 0
      TabOrder = 2
      Text = 'ClientFirst'
      Items.Strings = (
        'ClientFirst'
        'ClientSecond'
        'ClientThird')
    end
    object ComboBoxCallbackBroadcast: TComboBox
      Left = 210
      Top = 35
      Width = 92
      Height = 21
      ItemIndex = 0
      TabOrder = 3
      Text = 'CallbackAAA'
      Items.Strings = (
        'CallbackAAA'
        'CallbackBBB'
        'CallbackCCC')
    end
    object ButtonNotifyClient: TButton
      Left = 488
      Top = 52
      Width = 146
      Height = 25
      Caption = 'Notify Client'
      TabOrder = 6
      OnClick = ButtonNotifyClientClick
    end
    object ComboBoxProtocolBroadcast: TComboBox
      Left = 8
      Top = 35
      Width = 75
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'tcp/ip'
      Items.Strings = (
        'tcp/ip'
        'http'
        '')
    end
  end
  object ButtonTerminateAllClientChannels: TButton
    Left = 497
    Top = 139
    Width = 145
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Terminate All Client Channels'
    TabOrder = 10
    OnClick = ButtonTerminateAllClientChannelsClick
  end
  object ButtonTerminateCallback: TButton
    Left = 497
    Top = 181
    Width = 145
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Terminate Callback'
    TabOrder = 11
    OnClick = ButtonTerminateCallbackClick
  end
  object ButtonClearLog: TButton
    Left = 8
    Top = 487
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Clear'
    TabOrder = 12
    OnClick = ButtonClearLogClick
  end
  object ComboBoxProtocol: TComboBox
    Left = 8
    Top = 27
    Width = 75
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 13
    Text = 'tcp/ip'
    Items.Strings = (
      'tcp/ip'
      'http'
      '')
  end
  object CheckBoxTerminateWhenClose: TCheckBox
    Left = 190
    Top = 495
    Width = 244
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Terminate All Client Channels when close'
    Checked = True
    State = cbChecked
    TabOrder = 14
  end
  object EventMessagesCheck: TCheckBox
    Left = 488
    Top = 496
    Width = 137
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Show Event Messages'
    TabOrder = 15
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 656
    Top = 300
  end
  object DSHTTPClientCallbackChannelManager1: TDSClientCallbackChannelManager
    DSPort = '8087'
    CommunicationProtocol = 'http'
    ManagerId = '392057.591003.108474'
    OnChannelStateChange = DSHTTPClientCallbackChannelManager1ChannelStateChange
    Left = 632
    Top = 240
  end
  object DSTCPIPClientCallbackChannelManager1: TDSClientCallbackChannelManager
    DSHostname = 'localhost'
    DSPort = '211'
    CommunicationProtocol = 'tcp/ip'
    ManagerId = '567928.209308.650856'
    OnChannelStateChange = DSHTTPClientCallbackChannelManager1ChannelStateChange
    Left = 656
    Top = 184
  end
  object SQLConnectionHTTP: TSQLConnection
    DriverName = 'Datasnap'
    Params.Strings = (
      'DriverUnit=DbxDataSnap'
      'HostName=localhost'
      'Port=8087'
      'CommunicationProtocol=http'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=15.0.0.0,Culture=neutral,PublicKey' +
        'Token=a91a7c5705831a4f'
      'Filters={}')
    Left = 392
    Top = 384
  end
  object SQLConnectionTCPIP: TSQLConnection
    DriverName = 'Datasnap'
    Params.Strings = (
      'DriverUnit=DbxDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=15.0.0.0,Culture=neutral,PublicKey' +
        'Token=a91a7c5705831a4f'
      'Filters={}')
    Left = 264
    Top = 384
  end
end
