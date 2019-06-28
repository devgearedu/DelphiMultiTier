object EditorTab: TEditorTab
  Left = 0
  Top = 0
  Width = 761
  Height = 580
  PopupMenu = FramePopupMenu
  TabOrder = 0
  object Ball: TShape
    Left = 72
    Top = 72
    Width = 121
    Height = 129
    Brush.Color = clBlue
    Shape = stCircle
  end
  object MoveTimer: TTimer
    Interval = 10
    OnTimer = MoveTimerTimer
    Left = 368
    Top = 280
  end
  object FramePopupMenu: TPopupMenu
    Left = 431
    Top = 281
    object StopStartItem: TMenuItem
      Caption = 'Stop/Start'
      OnClick = StopStartItemClick
    end
    object SetShapetoHereItem: TMenuItem
      Caption = 'Set Shape to Here'
      OnClick = SetShapetoHereItemClick
    end
    object PropertiesItem: TMenuItem
      Caption = 'Properties'
      OnClick = PropertiesItemClick
    end
  end
end
