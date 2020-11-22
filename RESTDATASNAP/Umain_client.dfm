object Form212: TForm212
  Left = 0
  Top = 0
  Caption = 'Form212'
  ClientHeight = 375
  ClientWidth = 532
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 219
    Top = 8
    Width = 305
    Height = 50
    Caption = 'GetDept'
    TabOrder = 0
    OnClick = Button2Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 72
    Width = 516
    Height = 153
    DataSource = DataSource1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 231
    Width = 516
    Height = 129
    DataSource = DataSource2
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/datasnap/rest/TServerMethods1'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 32
    Top = 96
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'GetDept'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 104
    Top = 96
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    RootElement = ' result[0].depts.dept'
    Left = 192
    Top = 96
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = FDMemTable1
    FieldDefs = <>
    Response = RESTResponse1
    NestedElements = True
    Left = 296
    Top = 96
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'code'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'dept'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'section'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 408
    Top = 96
  end
  object RESTRequest2: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'item'
        Options = [poAutoCreated]
      end>
    Resource = 'GetInsa/{item}/'
    Response = RESTResponse2
    Left = 48
    Top = 296
  end
  object RESTResponse2: TRESTResponse
    ContentType = 'application/json'
    RootElement = 'result[0].Insas.Insa'
    Left = 144
    Top = 288
  end
  object RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter
    Active = True
    Dataset = InsaQuery
    FieldDefs = <>
    Response = RESTResponse2
    Left = 248
    Top = 288
  end
  object InsaQuery: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Dept_Code'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Class'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 432
    Top = 296
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    OnDataChange = DataSource1DataChange
    Left = 464
    Top = 96
  end
  object DataSource2: TDataSource
    DataSet = InsaQuery
    Left = 376
    Top = 296
  end
end
