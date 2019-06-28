object CacheDemoForm: TCacheDemoForm
  Left = 239
  Top = 170
  Caption = 'Cached Updates Example'
  ClientHeight = 349
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 9
    Top = 36
    Width = 332
    Height = 309
    DataSource = CacheData.CacheDS
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PROJ_ID'
        Title.Alignment = taCenter
        Title.Caption = 'ProjID'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PROJ_NAME'
        Title.Alignment = taCenter
        Title.Caption = 'Project Name'
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UpdateStatus'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Update Status'
        Width = 141
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 11
    Top = 4
    Width = 240
    Height = 25
    DataSource = CacheData.CacheDS
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 351
    Top = 236
    Width = 129
    Height = 109
    Caption = 'Show Records'
    TabOrder = 2
    object UnmodifiedCB: TCheckBox
      Left = 12
      Top = 16
      Width = 81
      Height = 17
      Caption = 'Unmodified'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = UpdateRecordsToShow
    end
    object ModifiedCB: TCheckBox
      Left = 12
      Top = 38
      Width = 81
      Height = 17
      Caption = 'Modified'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = UpdateRecordsToShow
    end
    object InsertedCB: TCheckBox
      Left = 12
      Top = 60
      Width = 81
      Height = 17
      Caption = 'Inserted'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = UpdateRecordsToShow
    end
    object DeletedCB: TCheckBox
      Left = 12
      Top = 82
      Width = 81
      Height = 17
      Caption = 'Deleted'
      TabOrder = 3
      OnClick = UpdateRecordsToShow
    end
  end
  object Panel2: TPanel
    Left = 351
    Top = 131
    Width = 129
    Height = 102
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object ApplyUpdatesBtn: TButton
      Left = 9
      Top = 9
      Width = 110
      Height = 25
      Caption = '&Apply Updates'
      TabOrder = 0
      OnClick = ApplyUpdatesBtnClick
    end
    object CancelUpdatesBtn: TButton
      Left = 9
      Top = 41
      Width = 110
      Height = 25
      Caption = '&Cancel Updates'
      TabOrder = 1
      OnClick = CancelUpdatesBtnClick
    end
    object RevertRecordBtn: TButton
      Left = 9
      Top = 72
      Width = 110
      Height = 25
      Caption = '&Revert Record'
      TabOrder = 2
      OnClick = RevertRecordBtnClick
    end
  end
  object ReExecuteButton: TButton
    Left = 352
    Top = 4
    Width = 129
    Height = 25
    Caption = 'Re-execute Query'
    TabOrder = 4
    OnClick = ReExecuteButtonClick
  end
  object RadioGroup1: TRadioGroup
    Left = 351
    Top = 68
    Width = 129
    Height = 65
    ItemIndex = 0
    Items.Strings = (
      'TIBQuery'
      'TIBDataSet'
      'TIBTable')
    TabOrder = 5
    OnClick = RadioGroup1Click
  end
  object btnUpdateStatus: TButton
    Left = 352
    Top = 36
    Width = 129
    Height = 25
    Caption = 'Update Status'
    TabOrder = 6
    OnClick = btnUpdateStatusClick
  end
  object MainMenu1: TMainMenu
    Left = 268
    Top = 263
    object miAbout: TMenuItem
      Caption = 'A&bout'
      OnClick = miAboutClick
    end
  end
end
