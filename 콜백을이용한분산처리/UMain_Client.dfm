object MainForm_Client: TMainForm_Client
  Left = 0
  Top = 0
  Caption = 'MainForm_Client'
  ClientHeight = 237
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 398
    Height = 137
    TabOrder = 0
  end
  object button1: TButton
    Left = 24
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 184
    Width = 75
    Height = 25
    Caption = 'stop'
    TabOrder = 2
    OnClick = Button2Click
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=23.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b')
    Left = 352
    Top = 176
  end
  object ChannelManager: TDSClientCallbackChannelManager
    DSHostname = 'localhost'
    DSPort = '211'
    CommunicationProtocol = 'tcp/ip'
    ChannelName = 'MemoChannel'
    ManagerId = '148182.356276.207931'
    Left = 288
    Top = 176
  end
end
