object Form1: TForm1
  Left = 13
  Top = 32
  Width = 804
  Height = 672
  HorzScrollBar.Range = 745
  VertScrollBar.Range = 633
  Caption = 'DbExpress Explorer'
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 704
    Top = 576
    Width = 41
    Height = 57
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F0000000120B0000120B00001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333300003333333333333333333300003333333083333333333300003333
      33380833333333330000333333330083333333330000333333330B0833333333
      00003333330000B08333333300003333330BBFBB08333333000033333330FB00
      00333333000033333330BFB0833333330000333300000BFB0833333300003333
      0FBFBFBFB08333330000333330FBFB00003333330000333330BFBFB083333333
      00003333330BFBFB0833333300003333330FFFBFF0833333000033333330FBFF
      BF08333300003333333000000000333300003333333333333333333300003333
      33333333333333330000}
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 728
    Top = 16
    Width = 3
    Height = 12
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 13
    Font.Name = 'Helvetica'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TreeView1: TTreeView
    Left = 8
    Top = 8
    Width = 369
    Height = 625
    Indent = 19
    ReadOnly = True
    TabOrder = 4
    OnClick = TreeView1Click
    OnDblClick = TreeView1DblClick
    OnExpanded = TreeView1Expanded
    Items.NodeData = {
      03010000002C00000000000000000000000000000000000000FFFFFFFF000000
      000000000001074400720069007600650072007300}
  end
  object DBGrid1: TDBGrid
    Left = 384
    Top = 40
    Width = 329
    Height = 120
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object DBNavigator1: TDBNavigator
    Left = 384
    Top = 8
    Width = 240
    Height = 27
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 624
    Top = 8
    Width = 90
    Height = 27
    Caption = '&Apply Updates'
    TabOrder = 2
    Visible = False
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 384
    Top = 576
    Width = 321
    Height = 57
    TabOrder = 3
    OnKeyDown = Memo1KeyDown
  end
  object DBImage1: TDBImage
    Left = 384
    Top = 376
    Width = 409
    Height = 193
    Color = clBackground
    DataSource = DataSource1
    TabOrder = 6
    Visible = False
    OnExit = DBImage1Exit
  end
  object DBMemo1: TDBMemo
    Left = 384
    Top = 440
    Width = 569
    Height = 129
    DataSource = DataSource1
    TabOrder = 5
    Visible = False
    OnExit = DBMemo1Exit
  end
  object SQLConnection1: TSQLConnection
    Left = 144
    Top = 16
  end
  object SQLDataSet1: TSQLDataSet
    Params = <>
    Left = 176
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 208
    Top = 32
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SQLDataSet1
    Left = 224
    Top = 16
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    OnReconcileError = ClientDataSet1ReconcileError
    Left = 208
    Top = 48
  end
  object SQLDataSet2: TSQLDataSet
    Params = <>
    Left = 248
    Top = 48
  end
end
