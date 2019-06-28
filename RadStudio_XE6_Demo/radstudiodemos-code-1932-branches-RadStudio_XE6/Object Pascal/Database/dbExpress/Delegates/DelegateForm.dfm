object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 396
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    506
    396)
  PixelsPerInch = 96
  TextHeight = 12
  object Label8: TLabel
    Left = 18
    Top = 66
    Width = 28
    Height = 12
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Label8'
  end
  object Pagecontrol: TPageControl
    Left = 0
    Top = 0
    Width = 507
    Height = 397
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ActivePage = ConnectionSheet
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object ConnectionSheet: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Connect'
      DesignSize = (
        499
        370)
      object Button1: TButton
        Left = 210
        Top = 234
        Width = 56
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Connect'
        TabOrder = 0
        OnClick = Button1Click
      end
      object ConnectSheet: TPanel
        Left = 2
        Top = 14
        Width = 498
        Height = 155
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Caption = 'ConnectSheet'
        Color = clInactiveBorder
        ParentBackground = False
        TabOrder = 1
        DesignSize = (
          498
          155)
        object Label4: TLabel
          Left = 12
          Top = 8
          Width = 87
          Height = 12
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Connection Source'
        end
        object ListBox1: TListBox
          Left = 12
          Top = 24
          Width = 133
          Height = 127
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ItemHeight = 12
          Sorted = True
          TabOrder = 0
          OnClick = ListBox1Click
        end
        object RadioGroup2: TRadioGroup
          Left = 162
          Top = 12
          Width = 332
          Height = 139
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Connect To:'
          Color = clInactiveBorder
          Items.Strings = (
            'Connection'
            'Connection->DBXTrace'
            'Connection->DBXPool'
            'Connection->DBXPool->DBXTrace')
          ParentBackground = False
          ParentColor = False
          TabOrder = 1
        end
      end
      object Button5: TButton
        Left = 210
        Top = 264
        Width = 56
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Disconnect'
        TabOrder = 2
        OnClick = Button5Click
      end
    end
    object QuerySheet: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Query'
      ImageIndex = 1
      DesignSize = (
        499
        370)
      object Label3: TLabel
        Left = 2
        Top = 2
        Width = 79
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Command Types'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 215
        Top = 2
        Width = 50
        Height = 12
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Commands'
      end
      object DBGrid1: TDBGrid
        Left = 2
        Top = 162
        Width = 521
        Height = 157
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -10
        TitleFont.Name = 'MS Shell Dlg 2'
        TitleFont.Style = []
      end
      object Memo1: TMemo
        Left = 2
        Top = 26
        Width = 523
        Height = 84
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        OnKeyUp = Memo1KeyUp
      end
      object DBNavigator1: TDBNavigator
        Left = 0
        Top = 139
        Width = 200
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        DataSource = DataSource1
        TabOrder = 2
      end
      object ComboBox1: TComboBox
        Left = 268
        Top = 3
        Width = 135
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 3
        OnEnter = ComboBox1Enter
      end
      object Button2: TButton
        Left = 407
        Top = 2
        Width = 40
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Paste'
        TabOrder = 4
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 452
        Top = 2
        Width = 42
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Execute'
        TabOrder = 5
        OnClick = Button3Click
      end
      object ComboBox2: TComboBox
        Left = 79
        Top = 3
        Width = 126
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 6
        OnEnter = ComboBox2Enter
      end
      object Button4: TButton
        Left = 185
        Top = 139
        Width = 78
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Save Changes'
        TabOrder = 7
        OnClick = Button4Click
      end
      object EditResult: TEdit
        Left = 2
        Top = 114
        Width = 495
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akRight]
        TabOrder = 8
      end
    end
    object PoolSheet: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Pool'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label2: TLabel
        Left = 48
        Top = 198
        Width = 109
        Height = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Pool Connections'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 48
        Top = 237
        Width = 158
        Height = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Pool+Trace Connections'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 24
        Top = 67
        Width = 131
        Height = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Non-Pooled Connect'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 24
        Top = 101
        Width = 100
        Height = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Pooled Connect'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object NonPooledBenchLabel: TLabel
        Left = 378
        Top = 66
        Width = 118
        Height = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Press Test Button'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object PooledBenchLabel: TLabel
        Left = 378
        Top = 102
        Width = 118
        Height = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Press Test Button'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 15
        Top = 30
        Width = 216
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Connection Pool Performance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 15
        Top = 164
        Width = 195
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Populate Connection Pools'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
      end
      object PoolConnectEdit: TEdit
        Left = 222
        Top = 196
        Width = 71
        Height = 32
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '10'
      end
      object PoolTraceConnectEdit: TEdit
        Left = 222
        Top = 235
        Width = 71
        Height = 32
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '10'
      end
      object PoolConnectButton: TButton
        Left = 298
        Top = 199
        Width = 56
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Open'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = PoolConnectButtonClick
      end
      object PoolTraceConnectButton: TButton
        Left = 298
        Top = 235
        Width = 56
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Open'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = PoolTraceConnectButtonClick
      end
      object NonPooledBenchEdit: TEdit
        Left = 222
        Top = 67
        Width = 67
        Height = 32
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = '200'
      end
      object PooledBenchEdit: TEdit
        Left = 222
        Top = 101
        Width = 67
        Height = 32
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = '200'
      end
      object NonPooledBenchButton: TButton
        Left = 300
        Top = 66
        Width = 56
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Test'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = NonPooledBenchButtonClick
      end
      object PooledBenchButton: TButton
        Left = 300
        Top = 101
        Width = 56
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Test'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = PooledBenchButtonClick
      end
    end
    object FilesSheet: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Files'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object TraceFileLabel: TLabel
        Left = 90
        Top = 46
        Width = 36
        Height = 12
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'LogFile:'
      end
      object DbxConnectionsLabel: TLabel
        Left = 90
        Top = 78
        Width = 78
        Height = 12
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'DbxConnections:'
      end
      object DbxDriverLabel: TLabel
        Left = 90
        Top = 114
        Width = 54
        Height = 12
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'DbxDrivers:'
      end
      object TraceFileButton: TButton
        Left = 15
        Top = 44
        Width = 56
        Height = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'View'
        TabOrder = 0
        OnClick = TraceFileButtonClick
      end
      object DbxConnectionsButton: TButton
        Left = 15
        Top = 76
        Width = 56
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'View'
        TabOrder = 1
        OnClick = DbxConnectionsButtonClick
      end
      object DbxDriversButton: TButton
        Left = 15
        Top = 112
        Width = 56
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'View'
        TabOrder = 2
        OnClick = DbxDriversButtonClick
      end
    end
  end
  object SQLConnection1: TSQLConnection
    LoadParamsOnConnect = True
    LoginPrompt = False
    Left = 200
    Top = 480
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 104
    Top = 480
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SQLDataSet1
    Left = 136
    Top = 480
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 64
    Top = 480
  end
  object SQLDataSet1: TSQLDataSet
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection1
    Left = 168
    Top = 480
  end
end
