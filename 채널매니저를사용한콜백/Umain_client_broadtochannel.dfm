object Form15: TForm15
  Left = 0
  Top = 0
  Caption = #53364#46972#51060#50616#53944#54868#47732
  ClientHeight = 364
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 264
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
    Top = 312
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
  object Label3: TLabel
    Left = 184
    Top = 264
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
  object Label4: TLabel
    Left = 184
    Top = 312
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
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 534
    Height = 193
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 207
    Width = 153
    Height = 39
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 184
    Top = 207
    Width = 137
    Height = 39
    Caption = 'Sotp'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit_LocalClientID: TEdit
    Left = 8
    Top = 286
    Width = 153
    Height = 21
    TabOrder = 3
  end
  object Edit_localCallBackID: TEdit
    Left = 8
    Top = 334
    Width = 153
    Height = 21
    TabOrder = 4
  end
  object Edit_RemoteClientID: TEdit
    Left = 184
    Top = 285
    Width = 137
    Height = 21
    TabOrder = 5
  end
  object Edit_RemoteCallBackID: TEdit
    Left = 184
    Top = 334
    Width = 137
    Height = 21
    TabOrder = 6
  end
  object Button3: TButton
    Left = 352
    Top = 255
    Width = 175
    Height = 38
    Caption = 'broadCast To Channel'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 352
    Top = 207
    Width = 175
    Height = 21
    TabOrder = 8
    Text = 'Edit1'
  end
  object Button4: TButton
    Left = 352
    Top = 310
    Width = 175
    Height = 46
    Caption = 'Notify'
    TabOrder = 9
    OnClick = Button4Click
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
        '.Data.DbxClientDriver,Version=17.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b')
    Left = 360
    Top = 16
    UniqueId = '{06ADC8FD-2193-44B7-B064-8234F4DC37DD}'
  end
  object ChannelManager: TDSClientCallbackChannelManager
    DSHostname = 'Localhost'
    DSPort = '211'
    CommunicationProtocol = 'tcp/ip'
    ChannelName = 'MemoChannel'
    ManagerId = '821917.148606.19315'
    Left = 480
    Top = 16
  end
end
