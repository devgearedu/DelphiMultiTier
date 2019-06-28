inherited frmSchemaAdapter: TfrmSchemaAdapter
  Left = 361
  Top = 207
  Width = 587
  Height = 500
  Caption = 'Schema Adapter'
  Font.Name = 'MS Sans Serif'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTitle: TPanel
    Width = 579
    inherited imgAnyDAC: TImage [0]
      Left = 521
    end
    inherited bvlTitle: TBevel [1]
      Width = 521
    end
    inherited lblTitle: TLabel
      Width = 171
      Caption = 'Schema Adapter'
    end
  end
  inherited pnlMain: TPanel
    Width = 579
    Height = 357
    inherited pnlConnection: TPanel
      Width = 579
      Height = 48
      inherited lblUseConnectionDef: TLabel
        Width = 126
      end
      object Button1: TButton
        Left = 162
        Top = 16
        Width = 97
        Height = 25
        Caption = 'Apply updates'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
    object DBGrid1: TDBGrid
      Left = 6
      Top = 48
      Width = 566
      Height = 145
      Anchors = [akLeft, akTop, akRight]
      DataSource = DataSource1
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object DBGrid2: TDBGrid
      Left = 6
      Top = 199
      Width = 566
      Height = 150
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DataSource2
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  inherited pnlButtons: TPanel
    Top = 410
    Width = 579
    inherited bvlButtons: TBevel
      Width = 579
    end
    inherited btnClose: TButton
      Left = 582
    end
  end
  inherited StatusBar1: TStatusBar
    Top = 447
    Width = 579
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 64
    Top = 120
  end
  object FDTableAdapter1: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    SelectCommand = FDCommand1
    Left = 40
    Top = 224
  end
  object FDTableAdapter2: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    SelectCommand = FDCommand2
    Left = 88
    Top = 224
  end
  object FDCommand1: TFDCommand
    Connection = dmlMainComp.dbMain
    CommandKind = skSelect
    CommandText.Strings = (
      'select * from {id FDQA_master_autoinc}')
    Left = 40
    Top = 256
  end
  object FDCommand2: TFDCommand
    Connection = dmlMainComp.dbMain
    CommandKind = skSelect
    CommandText.Strings = (
      'select * from {id FDQA_details_autoinc}')
    Left = 88
    Top = 256
  end
  object FDMemTable1: TFDMemTable
    CachedUpdates = True
    ConstraintsEnabled = True
    Adapter = FDTableAdapter1
    Left = 40
    Top = 192
  end
  object FDMemTable2: TFDMemTable
    CachedUpdates = True
    IndexFieldNames = 'fk_id1'
    ConstraintsEnabled = True
    MasterSource = DataSource1
    MasterFields = 'id1'
    Adapter = FDTableAdapter2
    Left = 88
    Top = 192
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 40
    Top = 160
  end
  object DataSource2: TDataSource
    DataSet = FDMemTable2
    Left = 88
    Top = 160
  end
end
