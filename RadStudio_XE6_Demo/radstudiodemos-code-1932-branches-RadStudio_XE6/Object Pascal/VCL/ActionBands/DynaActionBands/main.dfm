object Form1: TForm1
  Left = 253
  Top = 146
  Caption = 'ActionManager Helper Demo'
  ClientHeight = 311
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 556
    Height = 25
    UseSystemFont = False
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Spacing = 3
  end
  object Memo1: TMemo
    Left = 0
    Top = 61
    Width = 556
    Height = 231
    Align = alClient
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 25
    Width = 556
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Button4: TButton
      Left = 260
      Top = 6
      Width = 102
      Height = 25
      Action = DeleteItemsAction
      TabOrder = 3
    end
    object Button1: TButton
      Left = 171
      Top = 6
      Width = 82
      Height = 25
      Action = AddSeparatorAction
      TabOrder = 2
    end
    object Button3: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Action = AddCategoryAction
      TabOrder = 0
    end
    object Button2: TButton
      Left = 89
      Top = 6
      Width = 75
      Height = 25
      Action = AddActionAction
      TabOrder = 1
    end
    object DisableBtn: TButton
      Left = 372
      Top = 6
      Width = 112
      Height = 25
      Caption = 'Disable Menu Button'
      TabOrder = 4
      OnClick = DisableBtnClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 292
    Width = 556
    Height = 19
    AutoHint = True
    Panels = <>
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = Action1
                Caption = '&Action1'
              end
              item
                Action = Action2
                Caption = 'A&ction2'
              end>
            Caption = '&test'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    LinkedActionLists = <
      item
        ActionList = ActionList1
        Caption = 'ActionList1'
      end>
    Left = 69
    Top = 97
    StyleName = 'Platform Default'
    object Action1: TAction
      Category = 'test'
      Caption = 'Action1'
      Enabled = False
    end
    object Action2: TAction
      Category = 'Test'
      Caption = 'Action2'
      Enabled = False
    end
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Enabled = False
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Enabled = False
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Enabled = False
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Enabled = False
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object EditUndo1: TEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Enabled = False
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 3
      ShortCut = 16474
    end
    object AddCategoryAction: TAction
      Category = 'Buttons'
      Caption = 'Add Category'
      Hint = 
        'Adds the '#39'Edit'#39' Category to the menu after the item with the cap' +
        'tion '#39'&Test'#39
      OnExecute = AddCategoryActionExecute
    end
    object AddActionAction: TAction
      Category = 'Buttons'
      Caption = 'Add Action'
      Hint = 
        'Adds the EditCut action after the item with the caption '#39'&Action' +
        '1'#39
      OnExecute = AddActionActionExecute
    end
    object AddSeparatorAction: TAction
      Category = 'Buttons'
      Caption = 'Add Separator'
      Hint = 'Adds a separator after the item that is connected to Action1'
      OnExecute = AddSeparatorActionExecute
    end
    object DeleteItemsAction: TAction
      Category = 'Buttons'
      Caption = 'Delete Action Items'
      Hint = 'Deletes all items attached to Action1'
      OnExecute = DeleteItemsActionExecute
    end
  end
  object ActionList1: TActionList
    Left = 202
    Top = 90
    object EditDelete2: TEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 5
      ShortCut = 46
    end
  end
end
