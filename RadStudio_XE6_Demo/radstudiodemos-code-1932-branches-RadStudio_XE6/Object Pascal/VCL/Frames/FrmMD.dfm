object MasterDetailFrame: TMasterDetailFrame
  Left = 0
  Top = 0
  Width = 553
  Height = 367
  TabOrder = 0
  object Splitter2: TSplitter
    Left = 338
    Top = 0
    Width = 3
    Height = 367
    Cursor = crHSplit
  end
  inline MasterFrame: TDataFrame
    Height = 367
    Align = alLeft
    inherited Splitter1: TSplitter
      Top = 263
    end
    inherited DBGrid1: TDBGrid
      Height = 238
    end
    inherited DBNavigator1: TDBNavigator
      Hints.Strings = ()
    end
    inherited FancyFrame1: TFancyFrame
      Top = 266
    end
  end
  inline DetailFrame: TDataFrame
    Left = 341
    Width = 212
    Height = 367
    Align = alClient
    TabOrder = 1
    inherited Splitter1: TSplitter
      Top = 263
      Width = 212
    end
    inherited DBGrid1: TDBGrid
      Width = 212
      Height = 238
    end
    inherited DBNavigator1: TDBNavigator
      Width = 212
      Hints.Strings = ()
    end
    inherited FancyFrame1: TFancyFrame
      Top = 266
      Width = 212
      inherited DBImage1: TDBImage
        Width = 48
      end
    end
  end
end
