object FileInfoFrame: TFileInfoFrame
  Left = 0
  Top = 0
  Width = 585
  Height = 185
  TabOrder = 0
  DesignSize = (
    585
    185)
  object CreationTimeLabel: TLabel
    Left = 15
    Top = 50
    Width = 70
    Height = 13
    Caption = '&Creation Time:'
    FocusControl = CreationTimeEdit
  end
  object ModifiedTimeLabel: TLabel
    Left = 15
    Top = 77
    Width = 69
    Height = 13
    Caption = '&Modified Time:'
    FocusControl = ModifiedTimeEdit
  end
  object FileSizeLabel: TLabel
    Left = 15
    Top = 104
    Width = 42
    Height = 13
    Caption = '&File Size:'
    FocusControl = FileSizeEdit
  end
  object ModuleFileSelector: TComboBox
    Left = 3
    Top = 3
    Width = 579
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'ModuleFileSelector'
    OnClick = ModuleFileSelectorClick
  end
  object CreationTimeEdit: TEdit
    Left = 111
    Top = 47
    Width = 458
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 1
  end
  object ModifiedTimeEdit: TEdit
    Left = 111
    Top = 74
    Width = 458
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 2
  end
  object FileSizeEdit: TEdit
    Left = 111
    Top = 101
    Width = 458
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 3
  end
end
