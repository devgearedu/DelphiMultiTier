object Form221: TForm221
  Left = 0
  Top = 0
  Caption = 'Form221'
  ClientHeight = 400
  ClientWidth = 692
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 47
    Width = 678
    Height = 120
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
    Left = 8
    Top = 16
    Width = 320
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 24
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Cancelupdates'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 112
    Top = 184
    Width = 75
    Height = 25
    Caption = 'revertrecord'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 206
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Applyupdates'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 287
    Top = 184
    Width = 75
    Height = 25
    Caption = 'SAVE'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 368
    Top = 184
    Width = 75
    Height = 25
    Caption = 'load'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 449
    Top = 184
    Width = 75
    Height = 25
    Caption = 'GetCount'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 530
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Echo'
    TabOrder = 8
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 611
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Reverse'
    TabOrder = 9
    OnClick = Button8Click
  end
  object DBGrid2: TDBGrid
    Left = 24
    Top = 231
    Width = 545
    Height = 161
    DataSource = DataSource2
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Edit1: TEdit
    Left = 358
    Top = 20
    Width = 121
    Height = 21
    TabOrder = 11
    Text = 'delphi'
  end
  object Edit2: TEdit
    Left = 485
    Top = 20
    Width = 121
    Height = 21
    TabOrder = 12
    Text = 'delphi'
  end
  object Button9: TButton
    Left = 612
    Top = 16
    Width = 75
    Height = 25
    Caption = #49436#48260#50672#44208
    TabOrder = 13
    OnClick = Button9Click
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DbxDatasnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    BeforeConnect = SQLConnection1BeforeConnect
    Left = 40
    Top = 24
    UniqueId = '{805FE62B-182D-4ADD-8E2B-A91497A35FBF}'
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    SQLConnection = SQLConnection1
    Left = 152
    Top = 24
  end
  object Dept: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DeptProvider'
    RemoteServer = DSProviderConnection1
    OnReconcileError = DeptReconcileError
    Left = 256
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = Dept
    OnDataChange = DataSource1DataChange
    Left = 328
    Top = 24
  end
  object InsaQuery: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'CODE'
        ParamType = ptInput
      end>
    ProviderName = 'InsaQueryProvider'
    RemoteServer = DSProviderConnection1
    Left = 32
    Top = 224
  end
  object DataSource2: TDataSource
    DataSet = InsaQuery
    Left = 104
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
    ServerMethodName = 'TServerMethods1.ReverseString'
    Left = 184
    Top = 232
  end
end
