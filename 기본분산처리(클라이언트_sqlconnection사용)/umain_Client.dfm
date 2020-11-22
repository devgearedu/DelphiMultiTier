object Form19: TForm19
  Left = 0
  Top = 0
  Caption = 'Form19'
  ClientHeight = 477
  ClientWidth = 665
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
    Top = 72
    Width = 627
    Height = 113
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
    Left = 296
    Top = 24
    Width = 300
    Height = 33
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 200
    Width = 75
    Height = 25
    Caption = 'applyupdates'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 200
    Width = 75
    Height = 25
    Caption = 'revertrecord'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 199
    Top = 200
    Width = 75
    Height = 25
    Caption = 'cancelupdates'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 296
    Top = 200
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 393
    Top = 200
    Width = 75
    Height = 25
    Caption = 'load'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 487
    Top = 200
    Width = 75
    Height = 25
    Caption = 'reverse'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 568
    Top = 200
    Width = 75
    Height = 25
    Caption = 'get_count'
    TabOrder = 8
    OnClick = Button7Click
  end
  object DBGrid2: TDBGrid
    Left = 24
    Top = 300
    Width = 633
    Height = 137
    DataSource = DataSource2
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button8: TButton
    Left = 487
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Echo'
    TabOrder = 10
    OnClick = Button8Click
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DbxDatasnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/')
    Left = 32
    Top = 24
    UniqueId = '{8E4D8203-195C-4F70-9265-E5BB6250484E}'
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    SQLConnection = SQLConnection1
    Left = 96
    Top = 24
  end
  object Dept: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'deptProvider'
    RemoteServer = DSProviderConnection1
    OnReconcileError = DeptReconcileError
    Left = 184
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = Dept
    OnDataChange = DataSource1DataChange
    Left = 232
    Top = 24
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
    Left = 488
    Top = 104
  end
  object insaquery: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'CODE'
        ParamType = ptInput
      end>
    ProviderName = 'InsaQueryProvider'
    RemoteServer = DSProviderConnection1
    Left = 40
    Top = 248
  end
  object DataSource2: TDataSource
    DataSet = insaquery
    Left = 128
    Top = 248
  end
end
