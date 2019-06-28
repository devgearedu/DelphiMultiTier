object MainForm: TMainForm
  Left = 530
  Top = 233
  Caption = 'Docking Demo'
  ClientHeight = 440
  ClientWidth = 667
  Color = clWindow
  ParentFont = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object VSplitter: TSplitter
    Left = 164
    Top = 48
    Width = 6
    Height = 304
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Visible = False
    ExplicitLeft = 28
    ExplicitTop = 52
  end
  object HSplitter: TSplitter
    Left = 0
    Top = 415
    Width = 667
    Height = 4
    Cursor = crVSplit
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    Visible = False
    ExplicitLeft = -7
    ExplicitTop = 423
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 667
    Height = 48
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    AutoSize = True
    BandMaximize = bmDblClick
    Bands = <
      item
        Break = False
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 21
        Width = 661
      end
      item
        Control = ToolBar2
        ImageIndex = -1
        MinHeight = 21
        Width = 661
      end>
    DockSite = True
    OnDockOver = CoolBar1DockOver
    object ToolBar1: TToolBar
      Left = 12
      Top = 0
      Width = 280
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 52
      Caption = 'ToolBar1'
      Constraints.MaxWidth = 280
      DragKind = dkDock
      DragMode = dmAutomatic
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object ToolButton13: TToolButton
        Left = 0
        Top = 0
        Action = ExitAction
      end
      object ToolButton16: TToolButton
        Left = 52
        Top = 0
        Width = 14
        Caption = 'ToolButton16'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object btnToolBar1: TToolButton
        Left = 66
        Top = 0
        Action = ViewToolBar1
        Style = tbsCheck
      end
      object btnToolBar2: TToolButton
        Left = 118
        Top = 0
        Action = ViewToolBar2
        Style = tbsCheck
      end
    end
    object ToolBar2: TToolBar
      Left = 12
      Top = 23
      Width = 390
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 37
      Caption = 'ToolBar2'
      Constraints.MaxWidth = 390
      DragKind = dkDock
      DragMode = dmAutomatic
      ShowCaptions = True
      TabOrder = 1
      Transparent = True
      Wrapable = False
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = ViewWhiteWindow
      end
      object ToolButton2: TToolButton
        Left = 37
        Top = 0
        Action = ViewBlueWindow
      end
      object ToolButton3: TToolButton
        Left = 74
        Top = 0
        Action = ViewGreenWindow
      end
      object ToolButton5: TToolButton
        Left = 111
        Top = 0
        Action = ViewLimeWindow
      end
      object ToolButton6: TToolButton
        Left = 148
        Top = 0
        Action = ViewPurpleWindow
      end
      object ToolButton7: TToolButton
        Left = 185
        Top = 0
        Action = ViewRedWindow
      end
      object ToolButton4: TToolButton
        Left = 222
        Top = 0
        Action = ViewTealWindow
      end
    end
  end
  object LeftDockPanel: TPanel
    Left = 23
    Top = 48
    Width = 141
    Height = 304
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    BevelOuter = bvNone
    Color = clWindow
    DockSite = True
    ParentBackground = False
    TabOrder = 1
    OnDockDrop = LeftDockPanelDockDrop
    OnDockOver = LeftDockPanelDockOver
    OnGetSiteInfo = LeftDockPanelGetSiteInfo
    OnUnDock = LeftDockPanelUnDock
    ExplicitLeft = 27
  end
  object BottomDockPanel: TPanel
    Left = 0
    Top = 352
    Width = 667
    Height = 63
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    DockSite = True
    ParentBackground = False
    TabOrder = 2
    OnDockDrop = LeftDockPanelDockDrop
    OnDockOver = BottomDockPanelDockOver
    OnGetSiteInfo = LeftDockPanelGetSiteInfo
    OnUnDock = LeftDockPanelUnDock
  end
  object LeftDockTabSet: TDockTabSet
    Left = 0
    Top = 48
    Width = 23
    Height = 304
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ShrinkToFit = True
    Style = tsModernTabs
    TabPosition = tpRight
    AutoSelect = True
    DestinationDockSite = LeftDockPanel
    OnDockDrop = LeftDockTabSetDockDrop
    OnGetSiteInfo = LeftDockTabSetGetSiteInfo
    OnTabAdded = LeftDockTabSetTabAdded
    OnTabRemoved = LeftDockTabSetTabRemoved
  end
  object BottomDockTabSet: TDockTabSet
    Left = 0
    Top = 419
    Width = 667
    Height = 21
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    SoftTop = True
    Style = tsModernTabs
    DestinationDockSite = BottomDockPanel
    OnDockDrop = LeftDockTabSetDockDrop
    OnGetSiteInfo = LeftDockTabSetGetSiteInfo
    OnTabAdded = LeftDockTabSetTabAdded
    OnTabRemoved = LeftDockTabSetTabRemoved
  end
  object ActionList1: TActionList
    Left = 136
    Top = 80
    object ViewToolBar1: TAction
      Category = 'ViewToolBars'
      Caption = 'ToolBar &1'
      Checked = True
      ImageIndex = 1
      OnExecute = ViewToolBar1Execute
    end
    object ViewToolBar2: TAction
      Category = 'ViewToolBars'
      Caption = 'ToolBar &2'
      Checked = True
      ImageIndex = 2
      OnExecute = ViewToolBar2Execute
    end
    object ViewWhiteWindow: TAction
      Category = 'ViewWindows'
      Caption = '&White'
      Hint = 'View white window'
      OnExecute = ViewWhiteWindowExecute
    end
    object ExitAction: TAction
      Caption = 'E&xit'
      OnExecute = ExitActionExecute
    end
    object ViewBlueWindow: TAction
      Tag = 1
      Category = 'ViewWindows'
      Caption = '&Blue'
      OnExecute = ViewWhiteWindowExecute
    end
    object ViewGreenWindow: TAction
      Tag = 2
      Category = 'ViewWindows'
      Caption = '&Green'
      OnExecute = ViewWhiteWindowExecute
    end
    object ViewRedWindow: TAction
      Tag = 3
      Category = 'ViewWindows'
      Caption = '&Red'
      OnExecute = ViewWhiteWindowExecute
    end
    object ViewTealWindow: TAction
      Tag = 4
      Category = 'ViewWindows'
      Caption = '&Teal'
      OnExecute = ViewWhiteWindowExecute
    end
    object ViewPurpleWindow: TAction
      Tag = 5
      Category = 'ViewWindows'
      Caption = '&Purple'
      OnExecute = ViewWhiteWindowExecute
    end
    object ViewLimeWindow: TAction
      Tag = 6
      Category = 'ViewWindows'
      Caption = '&Lime'
      OnExecute = ViewWhiteWindowExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 176
    Top = 80
    object File2: TMenuItem
      Caption = '&File'
      object Exit2: TMenuItem
        Action = ExitAction
      end
    end
    object View2: TMenuItem
      Caption = '&View'
      object ToolBar11: TMenuItem
        Action = ViewToolBar1
      end
      object ToolBar21: TMenuItem
        Action = ViewToolBar2
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Floatonclosedocked1: TMenuItem
        Caption = 'Float on close docked'
        OnClick = Floatonclosedocked1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object White1: TMenuItem
        Action = ViewWhiteWindow
      end
      object Blue1: TMenuItem
        Action = ViewBlueWindow
      end
      object Green1: TMenuItem
        Action = ViewGreenWindow
      end
      object Lime1: TMenuItem
        Action = ViewLimeWindow
      end
      object Purple1: TMenuItem
        Action = ViewPurpleWindow
      end
      object Red1: TMenuItem
        Action = ViewRedWindow
      end
      object Teal1: TMenuItem
        Action = ViewTealWindow
      end
    end
  end
end
