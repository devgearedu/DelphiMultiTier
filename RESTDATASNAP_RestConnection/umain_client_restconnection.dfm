object Form18: TForm18
  Left = 0
  Top = 0
  Caption = 'Form18'
  ClientHeight = 380
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 41
    Caption = 'Get Depts'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 248
    Top = 8
    Width = 113
    Height = 33
    Caption = 'ApplyUpdates'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 384
    Top = 8
    Width = 105
    Height = 33
    Caption = 'refresh'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 512
    Top = 8
    Width = 97
    Height = 33
    Caption = 'session'
    TabOrder = 3
    OnClick = Button4Click
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 181
    Width = 601
    Height = 180
    DataSource = InsaSource
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 55
    Width = 601
    Height = 120
    DataSource = DeptSorce
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Dept: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 104
  end
  object Insa: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 184
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 56
    Top = 264
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = Dept
    ScopeMappings = <>
    Left = 496
    Top = 288
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
  end
  object BindSourceDB2: TBindSourceDB
    DataSet = Insa
    ScopeMappings = <>
    Left = 496
    Top = 232
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 128
    Top = 264
  end
  object DeptSorce: TDataSource
    DataSet = Dept
    OnDataChange = DeptSorceDataChange
    Left = 128
    Top = 104
  end
  object InsaSource: TDataSource
    DataSet = Insa
    Left = 128
    Top = 184
  end
end
