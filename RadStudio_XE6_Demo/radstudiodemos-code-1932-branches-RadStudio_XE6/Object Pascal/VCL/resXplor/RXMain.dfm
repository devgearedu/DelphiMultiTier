object MainForm: TMainForm
  Left = 223
  Top = 151
  Caption = 'Resource Explorer'
  ClientHeight = 403
  ClientWidth = 801
  Color = clBtnFace
  ParentFont = True
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000888
    888888888888888888888888000008F7777777777777777777777778800008F7
    FFFFFFFFFFFFFFFFFFFFF778880008F7888888888888888888888778880008F7
    FFFFFFFFFFFFFFFFFFFFF778880008F7888888888888888888888778880008F7
    777777777777777777777778880008F7222777777777777777777778880008F7
    AAA777777777777777777778880008FFFFFFFF00000000000000000008000087
    7777778777777777777777770800000877777787FFFF8FFFFFFFFFF708000000
    88888887FFFF8FFFFFFFFFF70800000000000087F18F8FFFFFFFFFF700000000
    00000087FFFF8FFFFFFFFFF70000000000000087F18F8F88F88F88F700000000
    00000087FFFF8F88F88F88F70000000000000087F18F8FFFFFFFFFF700000000
    00000087FFFF8F88F88F88F70000000000000087F18F8F88F88F88F700000000
    00000087FFFF8FFFFFFFFFF70000000000000087777777777777777700000000
    0000008766666666600000070000000000000087666666666F0F0F0700000000
    0000008777777777777777770000000000000088888888888888888800000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFC000000F800000078000000380000001800000018000
    00018000000180000001800000018000000180000001C0000001E0000001F000
    0003FFC00007FFC00007FFC00007FFC00007FFC00007FFC00007FFC00007FFC0
    0007FFC00007FFC00007FFC00007FFC00007FFC00007FFFFFFFFFFFFFFFF}
  Menu = MainMenu
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 384
    Width = 801
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 500
      end>
    ExplicitTop = 397
    ExplicitWidth = 884
  end
  object TreeViewPanel: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 384
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 397
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 1
      Caption = ' Resources'
      TabOrder = 0
    end
    object TreeView: TTreeView
      Left = 0
      Top = 21
      Width = 185
      Height = 363
      Align = alClient
      Images = Small
      Indent = 19
      ReadOnly = True
      TabOrder = 1
      OnChange = TreeViewChange
      ExplicitHeight = 376
    end
  end
  object Splitter: TPanel
    Left = 185
    Top = 0
    Width = 2
    Height = 384
    Cursor = crHSplit
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    OnMouseDown = SplitterMouseDown
    OnMouseMove = SplitterMouseMove
    OnMouseUp = SplitterMouseUp
    ExplicitHeight = 397
  end
  object ListViewPanel: TPanel
    Left = 187
    Top = 0
    Width = 614
    Height = 384
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 697
    ExplicitHeight = 397
    object ListViewCaption: TPanel
      Left = 0
      Top = 0
      Width = 614
      Height = 21
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 1
      TabOrder = 0
      ExplicitWidth = 697
    end
    object Notebook: TNotebook
      Left = 0
      Top = 21
      Width = 614
      Height = 363
      Align = alClient
      Color = clBtnFace
      PageIndex = 1
      ParentColor = False
      TabOrder = 1
      OnEnter = NotebookEnter
      ExplicitWidth = 697
      ExplicitHeight = 376
      object TPage
        Left = 0
        Top = 0
        Caption = 'ListViewPage'
        ExplicitWidth = 539
        ExplicitHeight = 0
        object ListView: TListView
          Left = 0
          Top = 0
          Width = 697
          Height = 376
          Align = alClient
          Columns = <
            item
              Caption = 'Name'
              Width = 150
            end
            item
              Caption = 'Offset'
              Width = 80
            end
            item
              Caption = 'Size'
              Width = 80
            end>
          ColumnClick = False
          LargeImages = Large
          ReadOnly = True
          SmallImages = Small
          TabOrder = 0
          ViewStyle = vsReport
          OnEnter = ListViewEnter
          ExplicitWidth = 539
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'ImageViewPage'
        ExplicitWidth = 697
        ExplicitHeight = 376
        object ImageViewer: TImage
          Left = 0
          Top = 0
          Width = 614
          Height = 363
          Align = alClient
          Center = True
          ExplicitWidth = 382
          ExplicitHeight = 174
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'StringViewPage'
        ExplicitWidth = 539
        ExplicitHeight = 0
        object StringViewer: TMemo
          Left = 0
          Top = 0
          Width = 697
          Height = 376
          Align = alClient
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          WantReturns = False
          WordWrap = False
          ExplicitWidth = 539
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'OtherViewPage'
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 678
    Top = 345
    object miFile: TMenuItem
      Caption = '&File'
      object miFileOpen: TMenuItem
        Caption = '&Open...'
        OnClick = FileOpen
      end
      object miFileSave: TMenuItem
        Caption = '&Save Resource...'
        OnClick = SaveResource
      end
      object miN1: TMenuItem
        Caption = '-'
      end
      object miFileExit: TMenuItem
        Caption = 'E&xit'
        OnClick = FileExit
      end
    end
    object miView: TMenuItem
      Caption = '&View'
      OnClick = ViewMenuDropDown
      object miViewStatusBar: TMenuItem
        Caption = 'Status &Bar'
        OnClick = ToggleStatusBar
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object miViewLargeIcons: TMenuItem
        Caption = 'Lar&ge Icons'
        GroupIndex = 1
        RadioItem = True
        OnClick = SelectListViewType
      end
      object miViewSmallIcons: TMenuItem
        Tag = 1
        Caption = 'S&mall Icons'
        GroupIndex = 1
        RadioItem = True
        OnClick = SelectListViewType
      end
      object miViewList: TMenuItem
        Tag = 2
        Caption = '&List'
        GroupIndex = 1
        RadioItem = True
        OnClick = SelectListViewType
      end
      object miViewDetails: TMenuItem
        Tag = 3
        Caption = '&Details'
        GroupIndex = 1
        RadioItem = True
        OnClick = SelectListViewType
      end
    end
    object miHelp: TMenuItem
      Caption = '&Help'
      object miHelpAbout: TMenuItem
        Caption = '&About'
        OnClick = ShowAboutBox
      end
    end
  end
  object FileOpenDialog: TOpenDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist]
    Left = 641
    Top = 345
  end
  object FileSaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist]
    Left = 603
    Top = 345
  end
  object Small: TImageList
    Left = 520
    Top = 345
  end
  object Large: TImageList
    Height = 32
    Width = 32
    Left = 557
    Top = 345
  end
end
