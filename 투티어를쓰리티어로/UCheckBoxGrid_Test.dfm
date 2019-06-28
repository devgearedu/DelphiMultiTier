object Form185: TForm185
  Left = 0
  Top = 0
  Caption = 'Form185'
  ClientHeight = 342
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 112
    Width = 531
    Height = 217
    DataSource = DataSource1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 547
    Height = 106
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 416
      Top = 64
      Width = 3
      Height = 13
    end
    object Button1: TButton
      Left = 416
      Top = 16
      Width = 113
      Height = 33
      Caption = #49440#53469#45936#51060#53552#54633#49328#44396#54616#44592
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 320
      Top = 16
      Width = 90
      Height = 33
      Caption = #49440#53469#52712#49548
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=sample')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 120
    Top = 16
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 224
    Top = 16
  end
  object FDTable1: TFDTable
    Active = True
    IndexFieldNames = 'ID'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'INSA'
    TableName = 'INSA'
    Left = 288
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 352
    Top = 16
  end
end
