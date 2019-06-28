object Form18: TForm18
  Left = 0
  Top = 0
  Caption = 'Form18'
  ClientHeight = 468
  ClientWidth = 517
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 328
    Width = 83
    Height = 16
    Caption = 'LocalClientID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 376
    Width = 99
    Height = 16
    Caption = 'LocalCallBackID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 184
    Top = 376
    Width = 116
    Height = 16
    Caption = 'RemoteCallBackID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 184
    Top = 328
    Width = 100
    Height = 16
    Caption = 'RemoteClientID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 430
    Height = 249
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 89
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit_LocalClientID: TEdit
    Left = 8
    Top = 349
    Width = 153
    Height = 21
    TabOrder = 3
  end
  object Edit_localCallBackID: TEdit
    Left = 8
    Top = 398
    Width = 153
    Height = 21
    TabOrder = 4
  end
  object Edit_RemoteCallBackID: TEdit
    Left = 184
    Top = 398
    Width = 137
    Height = 21
    TabOrder = 5
  end
  object Edit_RemoteClientID: TEdit
    Left = 184
    Top = 349
    Width = 137
    Height = 21
    TabOrder = 6
  end
  object Button3: TButton
    Left = 334
    Top = 341
    Width = 175
    Height = 38
    Caption = 'broadCast To Channel'
    TabOrder = 7
  end
  object Button4: TButton
    Left = 334
    Top = 386
    Width = 175
    Height = 46
    Caption = 'Notify'
    TabOrder = 8
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
        '.Data.DbxClientDriver,Version=19.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b')
    Left = 376
    Top = 264
  end
  object channelmanager: TDSClientCallbackChannelManager
    DSHostname = 'localhost'
    DSPort = '211'
    CommunicationProtocol = 'tcp/ip'
    ChannelName = 'MemoChannel'
    ManagerId = '834208.885524.115894'
    Left = 288
    Top = 264
  end
end
