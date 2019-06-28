object Form213: TForm213
  Left = 0
  Top = 0
  Caption = 'Form213'
  ClientHeight = 402
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 16
    Top = 48
    Width = 533
    Height = 121
    DataSource = DataSource1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 24
    Top = 8
    Width = 320
    Height = 34
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 16
    Top = 184
    Width = 75
    Height = 25
    Caption = 'cancelupdates'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 99
    Top = 182
    Width = 75
    Height = 25
    Caption = 'revertrecord'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 178
    Top = 184
    Width = 75
    Height = 25
    Caption = 'applyupdates'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 259
    Top = 184
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 340
    Top = 184
    Width = 75
    Height = 25
    Caption = 'load'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 421
    Top = 182
    Width = 75
    Height = 25
    Caption = 'Echo'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 504
    Top = 184
    Width = 75
    Height = 25
    Caption = 'GetCount'
    TabOrder = 8
    OnClick = Button7Click
  end
  object DBGrid2: TDBGrid
    Left = 24
    Top = 248
    Width = 525
    Height = 129
    DataSource = InsaQuerySource
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
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
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Connected = True
    Left = 64
    Top = 24
    UniqueId = '{BCFA6ACA-27D3-4DB2-BA29-EE387554A981}'
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    Connected = True
    SQLConnection = SQLConnection1
    Left = 168
    Top = 16
  end
  object Dept: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DeptProvider'
    RemoteServer = DSProviderConnection1
    OnReconcileError = DeptReconcileError
    Left = 192
    Top = 88
  end
  object DataSource1: TDataSource
    DataSet = Dept
    OnDataChange = DataSource1DataChange
    Left = 256
    Top = 88
  end
  object InsaQuery: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'CODE'
        ParamType = ptInput
      end>
    ProviderName = 'InsaQueryProviderer'
    RemoteServer = DSProviderConnection1
    Left = 40
    Top = 224
  end
  object InsaQuerySource: TDataSource
    DataSet = InsaQuery
    Left = 112
    Top = 224
  end
  object SqlServerMethod1: TSqlServerMethod
    Params = <
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'Value'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'ReturnParameter'
        ParamType = ptResult
        Size = 2000
      end>
    SQLConnection = SQLConnection1
    ServerMethodName = 'TServerMethods1.EchoString'
    Left = 336
    Top = 80
  end
end
