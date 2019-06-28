object DataPumpForm: TDataPumpForm
  Left = 0
  Top = 0
  Caption = 'DBX DataPump'
  ClientHeight = 476
  ClientWidth = 899
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    899
    476)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 11
    Width = 33
    Height = 13
    Caption = '&Source'
    FocusControl = ComboSource
  end
  object Label4: TLabel
    Left = 273
    Top = 11
    Width = 54
    Height = 13
    Caption = '&Destination'
  end
  object ButtonMigrate: TButton
    Left = 741
    Top = 6
    Width = 75
    Height = 25
    Action = actMigrate
    Anchors = [akTop, akRight]
    TabOrder = 0
  end
  object ComboSource: TComboBoxEx
    Left = 56
    Top = 8
    Width = 211
    Height = 22
    AutoCompleteOptions = [acoAutoSuggest, acoAutoAppend]
    ItemsEx = <>
    TabOrder = 1
    OnSelect = ComboSourceSelect
  end
  object ComboDest: TComboBoxEx
    Left = 333
    Top = 8
    Width = 399
    Height = 22
    AutoCompleteOptions = [acoAutoSuggest, acoAutoAppend]
    ItemsEx = <>
    Anchors = [akLeft, akTop, akRight]
    Enabled = False
    TabOrder = 2
    OnSelect = ComboDestSelect
  end
  object PageControl1: TPageControl
    Left = -6
    Top = 37
    Width = 897
    Height = 431
    ActivePage = TabSchema
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    object TabOptions: TTabSheet
      Caption = 'O&ptions'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 22
        Top = 65
        Width = 224
        Height = 13
        Caption = '&Rows to copy before committing a transaction:'
        FocusControl = EditTransRows
      end
      object Label2: TLabel
        Left = 53
        Top = 38
        Width = 193
        Height = 13
        Caption = 'Seconds to wait before &updating status:'
        FocusControl = EditUpdateTime
      end
      object cbTest: TCheckBox
        Left = 13
        Top = 12
        Width = 233
        Height = 17
        Caption = 'Perform a test copy and limit rows copied to:'
        TabOrder = 0
        OnClick = cbTestClick
      end
      object EditTestRows: TEdit
        Left = 252
        Top = 8
        Width = 33
        Height = 21
        TabOrder = 1
        Text = '100'
      end
      object EditTransRows: TEdit
        Left = 252
        Top = 62
        Width = 48
        Height = 21
        TabOrder = 3
        Text = '100000'
      end
      object EditUpdateTime: TEdit
        Left = 252
        Top = 35
        Width = 38
        Height = 21
        TabOrder = 2
        Text = '10'
      end
      object cbVerify: TCheckBox
        Left = 13
        Top = 260
        Width = 494
        Height = 17
        Caption = 
          '&Verify destination data matches source data after table copy co' +
          'mpletes'
        Enabled = False
        TabOrder = 11
        OnClick = cbVerifyClick
      end
      object cbOnlyRead: TCheckBox
        Left = 13
        Top = 121
        Width = 494
        Height = 17
        Caption = '&Only read data from source, don'#39't write data to destination'
        TabOrder = 5
        OnClick = cbOnlyReadClick
      end
      object cbCountRows: TCheckBox
        Left = 13
        Top = 98
        Width = 494
        Height = 17
        Caption = 
          'Count table ro&ws before copying so progress bars and time estim' +
          'ates can be displayed'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = cbCountRowsClick
      end
      object ButtonSaveAs: TButton
        Left = 568
        Top = 3
        Width = 113
        Height = 25
        Action = ActSaveOptions
        TabOrder = 15
      end
      object cbAutoInc: TCheckBox
        Left = 13
        Top = 283
        Width = 494
        Height = 17
        Caption = '&Allow auto-increment columns to be migrated as auto-increment'
        TabOrder = 12
      end
      object cbSkipCreate: TCheckBox
        Left = 13
        Top = 238
        Width = 494
        Height = 17
        Caption = 'S&kip creating destination table metadata if it exists'
        TabOrder = 10
        OnClick = cbSkipCreateClick
      end
      object cbWipeTable: TCheckBox
        Left = 13
        Top = 215
        Width = 494
        Height = 17
        Caption = 'Wipe destination table data before &copying'
        TabOrder = 9
        OnClick = cbWipeTableClick
      end
      object cbIgnoreDefaults: TCheckBox
        Left = 13
        Top = 306
        Width = 494
        Height = 17
        Caption = '&Ignore default values in source connection'
        TabOrder = 13
      end
      object cbMigrateProcedures: TCheckBox
        Left = 13
        Top = 329
        Width = 494
        Height = 17
        Caption = 'Migrate &procedures'
        TabOrder = 14
      end
      object btnViewSwitches: TButton
        Left = 568
        Top = 32
        Width = 113
        Height = 25
        Caption = 'View switches'
        TabOrder = 16
        OnClick = btnViewSwitchesClick
      end
      object cbChunkCopy: TCheckBox
        Left = 13
        Top = 192
        Width = 494
        Height = 17
        Hint = 'Copies records in blocks of <test rows> size'
        Caption = 'Copy data in chun&ks of test row limit size'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = cbChunkCopyClick
      end
      object cbOnlyNew: TCheckBox
        Left = 13
        Top = 168
        Width = 494
        Height = 17
        Hint = 
          'For tables that have an id field, only new records are written t' +
          'o destination'
        Caption = 
          'Only &new records are copied to destination for tables with ID c' +
          'olumns'
        TabOrder = 7
        OnClick = cbOnlyNewClick
      end
      object cbFillById: TCheckBox
        Left = 13
        Top = 145
        Width = 494
        Height = 17
        Caption = 'Fill in missing records &by ID in eligible destination tables'
        TabOrder = 6
        OnClick = cbFillByIdClick
      end
    end
    object TabSchema: TTabSheet
      Caption = 'Sc&hema'
      ImageIndex = 2
      DesignSize = (
        889
        403)
      object LoadingLabel: TLabel
        Left = 6
        Top = 5
        Width = 91
        Height = 13
        Caption = 'Loading schema ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 24
        Width = 886
        Height = 376
        ActivePage = TabSchemaTables
        Anchors = [akLeft, akTop, akRight, akBottom]
        MultiLine = True
        TabOrder = 0
        TabPosition = tpBottom
        object TabSchemaTables: TTabSheet
          Caption = 'T&ables'
          object TableColSplitter: TSplitter
            Left = 0
            Top = 127
            Width = 878
            Height = 3
            Cursor = crVSplit
            Align = alBottom
            Beveled = True
            ExplicitTop = 117
            ExplicitWidth = 673
          end
          object ColIndexSplitter: TSplitter
            Left = 0
            Top = 231
            Width = 878
            Height = 3
            Cursor = crVSplit
            Align = alBottom
            Beveled = True
            ExplicitTop = 233
            ExplicitWidth = 113
          end
          inline FrameTables: TGridFrame
            Left = 0
            Top = 0
            Width = 878
            Height = 127
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 878
            ExplicitHeight = 127
            inherited Label1: TLabel
              Width = 37
              Caption = 'Tables'
              ExplicitWidth = 37
            end
            inherited Navigator: TDBNavigator
              Hints.Strings = ()
            end
            inherited Grid: TDBGrid
              Width = 872
              Height = 85
              OnDrawColumnCell = FrameTablesGridDrawColumnCell
            end
          end
          inline FrameColumns: TGridFrame
            Left = 0
            Top = 130
            Width = 878
            Height = 101
            Align = alBottom
            TabOrder = 1
            ExplicitTop = 130
            ExplicitWidth = 878
            ExplicitHeight = 101
            inherited Label1: TLabel
              Width = 48
              Caption = 'Columns'
              ExplicitWidth = 48
            end
            inherited Navigator: TDBNavigator
              Hints.Strings = ()
            end
            inherited Grid: TDBGrid
              Width = 872
              Height = 62
              OnDrawColumnCell = FrameColumnsGridDrawColumnCell
            end
          end
          inline FrameIndexes: TGridFrame
            Left = 0
            Top = 234
            Width = 878
            Height = 116
            Align = alBottom
            TabOrder = 2
            ExplicitTop = 234
            ExplicitWidth = 878
            ExplicitHeight = 116
            inherited Label1: TLabel
              Width = 46
              Caption = 'Indexes'
              ExplicitWidth = 46
            end
            inherited Navigator: TDBNavigator
              Hints.Strings = ()
            end
            inherited Grid: TDBGrid
              Width = 872
              Height = 77
              OnDrawColumnCell = FrameIndexesGridDrawColumnCell
            end
          end
          object TableFilter: TRadioGroup
            Left = 304
            Top = 0
            Width = 366
            Height = 33
            Caption = ' Display '
            Columns = 4
            ItemIndex = 1
            Items.Strings = (
              'All records'
              'Table'
              'System Table'
              'View')
            TabOrder = 3
            OnClick = TableFilterClick
          end
        end
        object TabSchemaProcedures: TTabSheet
          Caption = '&Procedures'
          ImageIndex = 1
          object Splitter1: TSplitter
            Left = 531
            Top = 0
            Height = 350
            ExplicitLeft = 504
            ExplicitTop = 144
            ExplicitHeight = 100
          end
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 531
            Height = 350
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object Splitter2: TSplitter
              Left = 0
              Top = 201
              Width = 531
              Height = 3
              Cursor = crVSplit
              Align = alBottom
              ExplicitTop = 170
              ExplicitWidth = 30
            end
            inline FrameProcedures: TGridFrame
              Left = 0
              Top = 0
              Width = 531
              Height = 201
              Align = alClient
              TabOrder = 0
              ExplicitWidth = 531
              ExplicitHeight = 201
              inherited Label1: TLabel
                Width = 50
                Caption = 'Routines'
                ExplicitWidth = 50
              end
              inherited Navigator: TDBNavigator
                Hints.Strings = ()
              end
              inherited Grid: TDBGrid
                Top = 39
                Width = 525
                Height = 162
              end
              inherited PopupMenu1: TPopupMenu
                object ViewSource1: TMenuItem [4]
                  Caption = '&View Source'
                  ShortCut = 41046
                end
              end
            end
            inline FrameProcParams: TGridFrame
              Left = 0
              Top = 204
              Width = 531
              Height = 146
              Align = alBottom
              TabOrder = 1
              ExplicitTop = 204
              ExplicitWidth = 531
              ExplicitHeight = 146
              inherited Label1: TLabel
                Width = 67
                Caption = 'Parameters'
                ExplicitWidth = 67
              end
              inherited Navigator: TDBNavigator
                Hints.Strings = ()
              end
              inherited Grid: TDBGrid
                Width = 525
                Height = 107
                OnDrawColumnCell = FrameProcParamsGridDrawColumnCell
              end
            end
            object ProcFilter: TRadioGroup
              Left = 305
              Top = 0
              Width = 223
              Height = 33
              Caption = ' Display '
              Columns = 3
              ItemIndex = 0
              Items.Strings = (
                'All'
                'Procedure'
                'Function')
              TabOrder = 2
              OnClick = ProcFilterClick
            end
          end
          object ScriptPanel: TPanel
            Left = 534
            Top = 0
            Width = 344
            Height = 350
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object Script: TDBRichEdit
              Left = 0
              Top = 21
              Width = 344
              Height = 329
              Align = alClient
              DataField = 'ProcScript'
              DataSource = FrameProcedures.DataSource
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              PopupMenu = PopupMenuEditing
              ScrollBars = ssBoth
              TabOrder = 0
            end
            object ToolBar1: TToolBar
              Left = 0
              Top = 0
              Width = 344
              Height = 21
              Caption = 'ScriptToolbar'
              Images = ImageList1
              TabOrder = 1
              object ToolButton7: TToolButton
                Left = 0
                Top = 0
                Action = ActGenScript
              end
              object ToolButton1: TToolButton
                Left = 23
                Top = 0
                Action = EditCut1
              end
              object ToolButton2: TToolButton
                Left = 46
                Top = 0
                Action = EditCopy1
              end
              object ToolButton3: TToolButton
                Left = 69
                Top = 0
                Action = EditPaste1
              end
              object ToolButton4: TToolButton
                Left = 92
                Top = 0
                Action = EditSelectAll1
              end
              object ToolButton5: TToolButton
                Left = 115
                Top = 0
                Action = EditUndo1
              end
              object ToolButton6: TToolButton
                Left = 138
                Top = 0
                Action = EditDelete1
              end
            end
          end
        end
      end
      object Button1: TButton
        Left = 752
        Top = 0
        Width = 71
        Height = 25
        Action = ActSchemaSave
        Anchors = [akTop, akRight]
        Images = ImageList1
        TabOrder = 1
      end
      object Button2: TButton
        Left = 680
        Top = 0
        Width = 71
        Height = 25
        Action = ActSchemaOpen
        Anchors = [akTop, akRight]
        Images = ImageList1
        TabOrder = 2
      end
      object ButtonLoadSchema: TButton
        Left = 824
        Top = 0
        Width = 62
        Height = 25
        Action = actLoadSchema
        Anchors = [akTop, akRight]
        TabOrder = 3
      end
    end
    object TabStatus: TTabSheet
      Caption = 'Stat&us'
      DesignSize = (
        889
        403)
      object LabelTable: TLabel
        Left = 13
        Top = 0
        Width = 3
        Height = 13
      end
      object LabelRow: TLabel
        Left = 13
        Top = 42
        Width = 3
        Height = 13
      end
      object ProgressTable: TProgressBar
        Left = 13
        Top = 19
        Width = 873
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object ProgressRow: TProgressBar
        Left = 13
        Top = 61
        Width = 873
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object Warnings: TMemo
        Left = 621
        Top = 84
        Width = 265
        Height = 319
        Anchors = [akTop, akRight, akBottom]
        TabOrder = 2
      end
      object Log: TRichEdit
        Left = 8
        Top = 84
        Width = 603
        Height = 317
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PlainText = True
        PopupMenu = PopupMenuEditing
        ScrollBars = ssBoth
        TabOrder = 3
      end
    end
  end
  object ButtonCancel: TButton
    Left = 822
    Top = 6
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Cancel'
    Enabled = False
    TabOrder = 4
    OnClick = ButtonCancelClick
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 448
    Top = 32
    object actMigrate: TAction
      Category = 'Migration'
      Caption = '&Migrate'
      Hint = 'Migrate data from source to destination'
      OnExecute = actMigrateExecute
      OnUpdate = actMigrateUpdate
    end
    object actLoadSchema: TAction
      Category = 'Migration'
      Caption = 'Re&load'
      Hint = 'Load the schema file for the selected source'
      OnExecute = actLoadSchemaExecute
      OnUpdate = actLoadSchemaUpdate
    end
    object ActSaveOptions: TFileSaveAs
      Category = 'File'
      Caption = 'Save o&ptions as...'
      Dialog.DefaultExt = 'pump'
      Dialog.Filter = '*.pump|Data Pump Configuration Files|*.*|All Files'
      Hint = 'Save As|Saves this configuration to a file'
      ImageIndex = 0
      OnAccept = ActSaveOptionsAccept
    end
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 2
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 3
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object EditUndo1: TEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 4
      ShortCut = 16474
    end
    object EditDelete1: TEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 5
      ShortCut = 46
    end
    object ActGenScript: TAction
      Category = 'Edit'
      Caption = '&Generate script'
      ImageIndex = 6
      ShortCut = 32839
      OnExecute = ActGenScriptExecute
      OnUpdate = ActGenScriptUpdate
    end
    object ActSchemaOpen: TFileOpen
      Category = 'Migration'
      Caption = '&Open...'
      Dialog.DefaultExt = 'cds'
      Dialog.Filter = 'Data files|*.cds;*.xml|All Files|*.*'
      Dialog.Title = 'Select a schema file'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
    end
    object ActSchemaSave: TFileSaveAs
      Category = 'Migration'
      Caption = 'Save as...'
      Dialog.DefaultExt = 'cds'
      Dialog.Filter = 'Schema files|*.cds;*.xml|All files|*.*'
      Dialog.Title = 'Please enter a file name to use for saving schema'
      Hint = 'Save Schema As|Saves the active schema to a file'
      ImageIndex = 8
      OnAccept = ActSchemaSaveAccept
      OnUpdate = ActSchemaSaveUpdate
    end
  end
  object ImageList1: TImageList
    Left = 488
    Top = 32
    Bitmap = {
      494C010109000B00180010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000C6C6C6000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000C6C6C6000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000000000000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000000000000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B00000000000000000000000000FFFFFF0000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000633100006331
      0000633100006331000063310000000000000000000000000000000000000000
      0000000000006363000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      84000084840000848400000000000000000000000000000000009C6300006363
      0000636300009C63000000000000000000000000000000000000000000000000
      0000000000006363000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C6300006363
      00009C630000CE9C630000000000000000000000000000000000000000000000
      0000000000006363000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000000000009C6300009C63
      0000CE9C630063630000CE9C6300000000000000000000000000000000000000
      0000CE9C63006363000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000000000009C6300000000
      000000000000CE9C63006363000063630000CE9C63000000000000000000CE9C
      630063630000CE9C630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CE9C63006363000063630000636300006363
      0000CE9C63000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000C6C6C6000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00840000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000C6C6C6000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00840000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000000000000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00000000000000000000000000FFFF
      FF00840000008400000084000000840000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00840000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000FFFFFF0084000000000000000000000000000000000000000000
      0000008484000084840000000000000000000000000000000000000000000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000008400000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFF
      FF00840000008400000084000000840000000000000000848400848484000084
      8400848484000084840084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000FFFFFF0084000000000000000000000084848400008484008484
      8400008484008484840000848400848484000084840084848400008484008484
      8400008484000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000008400000000000000000000000000000000848400848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      00000084840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400848484000084
      84000000000000FFFF00000000000000000000FFFF0000000000848484000084
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FF7E000000000000BFFF000000000000
      F003000000000000E003000000000000E003000000000000E003000000000000
      E0030000000000002003000000000000E002000000000000E003000000000000
      E003000000000000E003000000000000E003000000000000FFFF000000000000
      BF7D0000000000007F7E000000000000FFFFFFFFFF7EFFFFFFFFFFFF9001FFFF
      FFFFEFFDC003001FFFFFC7FFE003000FFFFFC3FBE0030007FFFFE3F7E0030003
      C1FBF1E7E0030001C3FBF8CF00010000C3FBFC1F8000001FC1F3FE3FE007001F
      D863FC1FE00F001FFE07F8CFE00F8FF1FFFFE1E7E027FFF9FFFFC3F3C073FF75
      FFFFC7FD9E79FF8FFFFFFFFF7EFEFFFFFF7EFFFFFFFFFFFFBFFFF9FFFFFFFC00
      F003F6CFFE008000E003F6B7FE000000E003F6B7FE000000E003F8B780000000
      E003FE8F800000012003FE3F80000003E002FF7F80000003E003FE3F80010003
      E003FEBF80030003E003FC9F80070FC3E003FDDF807F0003FFFFFDDF80FF8007
      BF7DFDDF81FFF87F7F7EFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenuTables: TPopupMenu
    Left = 408
    Top = 32
    object SelectAll1: TMenuItem
      Caption = 'Select &All'
      ShortCut = 16449
    end
    object Clearselection1: TMenuItem
      Caption = '&Clear selections'
      ShortCut = 24641
    end
  end
  object dsSchema: TDataSource
    Left = 368
    Top = 32
  end
  object PopupMenuEditing: TPopupMenu
    Images = ImageList1
    Left = 536
    Top = 32
    object Copy1: TMenuItem
      Action = EditCopy1
    end
    object Cut1: TMenuItem
      Action = EditCut1
    end
    object Paste1: TMenuItem
      Action = EditPaste1
    end
    object Delete1: TMenuItem
      Action = EditDelete1
    end
    object SelectAll2: TMenuItem
      Action = EditSelectAll1
    end
    object Undo1: TMenuItem
      Action = EditUndo1
    end
  end
end
