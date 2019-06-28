object Form10: TForm10
  Left = 0
  Top = 0
  Caption = 'Connection Monitoring Demo Client'
  ClientHeight = 142
  ClientWidth = 549
  Color = clBtnFace
  Constraints.MaxHeight = 180
  Constraints.MaxWidth = 565
  Constraints.MinHeight = 180
  Constraints.MinWidth = 565
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  DesignSize = (
    549
    142)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 32
    Height = 13
    Caption = 'HTTP:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 279
    Top = 8
    Width = 42
    Height = 13
    Caption = 'TCP/IP:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 272
    Top = 8
    Width = 1
    Height = 126
    Anchors = [akLeft, akTop, akBottom]
    Shape = bsLeftLine
    ExplicitHeight = 274
  end
  object ButtonHTTPCallback: TButton
    Left = 8
    Top = 27
    Width = 258
    Height = 25
    Caption = 'START HTTP Callback'
    TabOrder = 0
    OnClick = ButtonHTTPCallbackClick
  end
  object ButtonTCPCallback: TButton
    Left = 279
    Top = 27
    Width = 262
    Height = 25
    Caption = 'START TCP/IP Callback'
    TabOrder = 1
    OnClick = ButtonTCPCallbackClick
  end
  object MemoHTTP: TMemo
    Left = 8
    Top = 58
    Width = 258
    Height = 47
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object MemoTCP: TMemo
    Left = 279
    Top = 58
    Width = 262
    Height = 47
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object FieldHTTPReverse: TEdit
    Left = 72
    Top = 111
    Width = 114
    Height = 21
    Enabled = False
    TabOrder = 4
    Text = 'Hello, World!'
  end
  object ButtonHTTPReverse: TButton
    Left = 192
    Top = 109
    Width = 75
    Height = 25
    Caption = 'REVERSE'
    Enabled = False
    TabOrder = 5
    OnClick = ButtonHTTPReverseClick
  end
  object FieldTCPReverse: TEdit
    Left = 343
    Top = 111
    Width = 117
    Height = 21
    Enabled = False
    TabOrder = 6
    Text = 'Hello, World!'
  end
  object ButtonTCPReverse: TButton
    Left = 466
    Top = 109
    Width = 75
    Height = 25
    Caption = 'REVERSE'
    Enabled = False
    TabOrder = 7
    OnClick = ButtonTCPReverseClick
  end
  object CheckHTTPConnect: TCheckBox
    Left = 8
    Top = 115
    Width = 58
    Height = 13
    Caption = 'Connect'
    TabOrder = 8
    OnClick = CheckHTTPConnectClick
  end
  object CheckTCPConnect: TCheckBox
    Left = 279
    Top = 115
    Width = 58
    Height = 17
    Caption = 'Connect'
    TabOrder = 9
    OnClick = CheckTCPConnectClick
  end
  object HTTPChannelManager: TDSClientCallbackChannelManager
    DSHostname = 'localhost'
    DSPort = '8088'
    CommunicationProtocol = 'http'
    ChannelName = 'HTTPMemoChannel'
    ManagerId = '822559.387915.528923'
    OnChannelStateChange = HTTPChannelManagerChannelStateChange
    Left = 80
    Top = 56
  end
  object TCPChannelManager: TDSClientCallbackChannelManager
    DSHostname = 'localhost'
    DSPort = '211'
    CommunicationProtocol = 'tcp/ip'
    ChannelName = 'TCPMemoChannel'
    ManagerId = '982842.382624.346131'
    OnChannelStateChange = TCPChannelManagerChannelStateChange
    Left = 360
    Top = 56
  end
  object HTTPConnection: TSQLConnection
    DriverName = 'Datasnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DbxDataSnap'
      'HostName=localhost'
      'Port=8088'
      'CommunicationProtocol=http'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=17.0.0.0,Culture=neutral,PublicKey' +
        'Token=a91a7c5705831a4f'
      'Filters={}')
    Left = 184
    Top = 56
    UniqueId = '{9AD9FB44-8C7B-4B93-9537-01B4C6C13B22}'
  end
  object TCPConnection: TSQLConnection
    DriverName = 'Datasnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DbxDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=17.0.0.0,Culture=neutral,PublicKey' +
        'Token=a91a7c5705831a4f'
      'Filters={}')
    Left = 464
    Top = 56
    UniqueId = '{A1232440-4029-48A7-AB6B-A051D3C8CFBF}'
  end
end
