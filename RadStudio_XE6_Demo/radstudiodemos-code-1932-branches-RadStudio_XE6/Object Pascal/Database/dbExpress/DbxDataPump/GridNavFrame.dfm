object GridFrame: TGridFrame
  Left = 0
  Top = 0
  Width = 528
  Height = 238
  TabOrder = 0
  DesignSize = (
    528
    238)
  object Label1: TLabel
    Left = 249
    Top = 12
    Width = 56
    Height = 13
    Caption = 'Grid Label'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Navigator: TDBNavigator
    Left = 3
    Top = 3
    Width = 240
    Height = 25
    DataSource = DataSource
    TabOrder = 0
  end
  object Grid: TDBGrid
    Left = 3
    Top = 36
    Width = 522
    Height = 199
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = GridCellClick
    OnColEnter = GridColEnter
    OnColExit = GridColExit
    OnDrawColumnCell = GridDrawColumnCell
    OnKeyPress = GridKeyPress
  end
  object DataSource: TDataSource
    Left = 344
    Top = 40
  end
  object PopupMenu1: TPopupMenu
    Left = 376
    Top = 40
    object SelectAll1: TMenuItem
      Action = ActSelectAll
    end
    object Clearall1: TMenuItem
      Action = ActClearAll
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CountRows1: TMenuItem
      Action = ActCountRows
    end
    object Estimate1: TMenuItem
      Action = ActEstimate
    end
    object Opentable1: TMenuItem
      Action = ActOpenTable
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 408
    Top = 40
    object ActSelectAll: TAction
      Category = 'Grid'
      Caption = 'Select &All'
      Hint = 'Select all rows in grid'
      ShortCut = 16449
      OnExecute = ActSelectAllExecute
      OnUpdate = ActSelectAllUpdate
    end
    object ActClearAll: TAction
      Category = 'Grid'
      Caption = '&Clear all'
      ShortCut = 24641
      OnExecute = ActClearAllExecute
      OnUpdate = ActClearAllUpdate
    end
    object ActCountRows: TAction
      Category = 'Grid'
      Caption = 'Count &Rows'
      ShortCut = 41042
      OnExecute = ActCountRowsExecute
      OnUpdate = ActCountRowsUpdate
    end
    object ActOpenTable: TAction
      Category = 'Grid'
      Caption = '&Open table'
      ShortCut = 16463
      OnExecute = ActOpenTableExecute
      OnUpdate = ActOpenTableUpdate
    end
    object ActEstimate: TAction
      Category = 'Grid'
      Caption = '&Estimate'
      Hint = 'Estimate the number of rows and size of data being migrated'
      ShortCut = 16453
      OnExecute = ActEstimateExecute
      OnUpdate = ActEstimateUpdate
    end
  end
  object ImageList1: TImageList
    Left = 440
    Top = 40
  end
end
