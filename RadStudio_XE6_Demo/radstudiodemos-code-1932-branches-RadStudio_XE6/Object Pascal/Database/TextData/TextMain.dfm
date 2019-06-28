object TextDataDemoForm: TTextDataDemoForm
  Left = 200
  Top = 108
  Width = 443
  Height = 309
  Caption = 'TTextDataSet Demo'
  ParentFont = True
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 12
    Top = 38
    Width = 411
    Height = 229
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 18
    Top = 6
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object DataSource1: TDataSource
    DataSet = TextDataSet1
    Left = 308
    Top = 4
  end
  object TextDataSet1: TTextDataSet
    FileName = 'textfile.txt'
    Active = True
    Left = 272
    Top = 4
  end
end
