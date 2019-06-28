object frmMain: TfrmMain
  Left = 253
  Top = 121
  Caption = 'SQL Monitoring Example'
  ClientHeight = 335
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 210
    Width = 574
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 218
  end
  object Splitter2: TSplitter
    Left = 265
    Top = 22
    Height = 188
    ExplicitTop = 24
    ExplicitHeight = 194
  end
  object Memo1: TMemo
    Left = 0
    Top = 22
    Width = 265
    Height = 188
    Align = alLeft
    Lines.Strings = (
      'select * from employee')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 268
    Top = 22
    Width = 306
    Height = 188
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 213
    Width = 574
    Height = 122
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 574
    Height = 22
    AutoSize = True
    Caption = 'ToolBar1'
    Images = ImageList1
    TabOrder = 3
    object btnRun: TToolButton
      Left = 0
      Top = 0
      Hint = 'Run SQL'
      Caption = 'btnRun'
      Enabled = False
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = RunClick
    end
    object btnLaunch: TToolButton
      Left = 23
      Top = 0
      Hint = 'New Monitor Window'
      Caption = 'btnLaunch'
      ImageIndex = 1
      OnClick = LaunchClick
    end
    object Label2: TLabel
      Left = 46
      Top = 0
      Width = 251
      Height = 22
      AutoSize = False
    end
    object Label1: TLabel
      Left = 297
      Top = 0
      Width = 3
      Height = 22
    end
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 
      'localhost:C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samp' +
      'les\Data\EMPLOYEE.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    TraceFlags = [tfQPrepare, tfQExecute, tfQFetch, tfError, tfStmt, tfConnect, tfTransact, tfBlob, tfService, tfMisc]
    Left = 120
    Top = 40
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    DefaultAction = TACommitRetaining
    Left = 148
    Top = 40
  end
  object IBDataSet1: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 32
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from EMPLOYEE')
    ParamCheck = True
    UniDirectional = False
    Active = True
    Left = 184
    Top = 40
  end
  object DataSource1: TDataSource
    DataSet = IBDataSet1
    Left = 212
    Top = 40
  end
  object IBSQLMonitor1: TIBSQLMonitor
    OnSQL = IBSQLMonitor1SQL
    TraceFlags = [tfQPrepare, tfQExecute, tfQFetch, tfError, tfStmt, tfConnect, tfTransact, tfBlob, tfService, tfMisc]
    Left = 32
    Top = 36
  end
  object MainMenu1: TMainMenu
    Left = 424
    Top = 28
    object Trace1: TMenuItem
      Caption = 'Tracing'
      Checked = True
      object Connect3: TMenuItem
        Caption = 'DB Connect'
        OnClick = Connect3Click
      end
      object Trace2: TMenuItem
        Caption = 'Monitor Hook'
        Checked = True
        OnClick = Trace2Click
      end
      object SQLMonitor1: TMenuItem
        Caption = 'SQL Monitor'
        Checked = True
        OnClick = SQLMonitor1Click
      end
    end
    object Flags1: TMenuItem
      Caption = 'Flags'
      object Database1: TMenuItem
        Caption = 'Database'
        OnClick = Database1Click
      end
      object MonitorHook1: TMenuItem
        Caption = 'MonitorHook'
        OnClick = MonitorHook1Click
      end
      object SQLMonitor2: TMenuItem
        Caption = 'SQL Monitor'
        OnClick = SQLMonitor2Click
      end
    end
    object Clear1: TMenuItem
      Caption = 'Clear Trace'
      OnClick = Clear1Click
    end
    object MonitorCount1: TMenuItem
      Caption = 'MonitorCount'
      OnClick = MonitorCount1Click
    end
  end
  object ImageList1: TImageList
    Left = 280
    Top = 18
    Bitmap = {
      494C010102000400280010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100C6C6C6009494
      9400000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B00000031313100C6C6
      C60094949400000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000039000000BD0000003131
      3100C6C6C6009494940000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006363630094949400949494007B000000BD00
      000031313100C6C6C60094949400000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003131310094949400C6C6C600C6C6C60094949400636363007B000000FF00
      0000BD00000031313100C6C6C600949494000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000313131009494
      9400C6C6C600949494006363630000000000000000007B000000BD000000FF00
      0000FF000000BD00000031313100313131000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100C6C6C6009494
      9400313131000000000039000000BD000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF3900005A39000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000031313100C6C6C600313131000000
      000039000000BD000000FF000000FF000000FF000000FF390000FF7B0000FF39
      0000FF000000FF390000DEBD0000210000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BD00
      0000FF000000FF000000FF000000FF000000FFBD0000BD7B00009C390000FF7B
      0000FF390000DEBD000021000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B390000BD7B0000FF7B
      0000FF7B0000FF000000FF000000FFBD00007B3900000000000042000000FFBD
      0000DEBD00002100000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004200000042000000420000004200
      0000BD7B0000FF000000FFBD00007B39000000000000000000007B390000DEBD
      0000210000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BD7B0000FFBD00007B390000000000000000000021000000BD7B00002100
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BD7B00007B39000000000000000000000000000021000000210000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000630000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FF9FFF7E00000000FF0F900100000000
      FF07C00300000000FF83E00300000000FE01E00300000000F000E00300000000
      C000E00300000000800000010000000000008000000000008001E00700000000
      0043E00F0000000000C7E00F00000000F18FE02700000000F39FC07300000000
      F7FF9E7900000000FFFF7EFE0000000000000000000000000000000000000000
      000000000000}
  end
end
