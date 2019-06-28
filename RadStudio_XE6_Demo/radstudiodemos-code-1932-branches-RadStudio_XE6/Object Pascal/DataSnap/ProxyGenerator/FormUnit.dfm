object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Sample Proxy Generator'
  ClientHeight = 617
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    541
    617)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 154
    Caption = 'Connection'
    TabOrder = 0
    DesignSize = (
      257
      154)
    object Label6: TLabel
      Left = 9
      Top = 17
      Width = 22
      Height = 13
      Caption = 'Host'
    end
    object Label7: TLabel
      Left = 9
      Top = 44
      Width = 39
      Height = 13
      Caption = 'Protocol'
    end
    object Label8: TLabel
      Left = 9
      Top = 71
      Width = 20
      Height = 13
      Caption = 'Port'
    end
    object Label9: TLabel
      Left = 7
      Top = 98
      Width = 41
      Height = 13
      Caption = 'URLPath'
    end
    object EditHost: TEdit
      Left = 68
      Top = 14
      Width = 121
      Height = 25
      TabOrder = 0
      Text = 'localhost'
    end
    object ComboBoxProtocol: TComboBox
      Left = 68
      Top = 41
      Width = 73
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      Items.Strings = (
        'tcp/ip'
        'http')
    end
    object EditPort: TEdit
      Left = 68
      Top = 68
      Width = 73
      Height = 25
      TabOrder = 2
      Text = '211'
    end
    object EditURLPath: TEdit
      Left = 68
      Top = 95
      Width = 182
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 271
    Top = 8
    Width = 262
    Height = 154
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Code'
    TabOrder = 1
    DesignSize = (
      262
      154)
    object Label1: TLabel
      Left = 16
      Top = 17
      Width = 76
      Height = 13
      Caption = 'Exclude Classes'
    end
    object Label2: TLabel
      Left = 16
      Top = 44
      Width = 81
      Height = 13
      Caption = 'Exclude Methods'
    end
    object Label3: TLabel
      Left = 16
      Top = 126
      Width = 49
      Height = 13
      Caption = 'Unit Name'
    end
    object Label4: TLabel
      Left = 16
      Top = 98
      Width = 79
      Height = 13
      Caption = 'Include Methods'
    end
    object Label5: TLabel
      Left = 16
      Top = 71
      Width = 74
      Height = 13
      Caption = 'Include Classes'
    end
    object EditExcludeClasses: TEdit
      Left = 109
      Top = 14
      Width = 142
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object EditExcludeMethods: TEdit
      Left = 110
      Top = 41
      Width = 141
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object EditUnitName: TEdit
      Left = 110
      Top = 123
      Width = 141
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Text = 'Unit1'
    end
    object EditIncludeMethods: TEdit
      Left = 110
      Top = 95
      Width = 141
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object EditIncludeClasses: TEdit
      Left = 109
      Top = 68
      Width = 142
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 195
    Width = 524
    Height = 112
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Output'
    TabOrder = 2
    DesignSize = (
      524
      112)
    object Directory: TLabel
      Left = 32
      Top = 48
      Width = 44
      Height = 13
      Caption = 'Directory'
    end
    object CheckBoxWriteToFile: TCheckBox
      Left = 16
      Top = 24
      Width = 81
      Height = 17
      Caption = 'Write to File'
      TabOrder = 0
    end
    object EditOutputDirectory: TEdit
      Left = 87
      Top = 47
      Width = 411
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object CheckBoxWriteToMemo: TCheckBox
      Left = 16
      Top = 81
      Width = 97
      Height = 17
      Caption = 'Write to Memo'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object ButtonGenerateProxy: TButton
    Left = 7
    Top = 313
    Width = 76
    Height = 25
    Caption = 'Generate'
    TabOrder = 3
    OnClick = ButtonGenerateProxyClick
  end
  object MemoCode: TMemo
    Left = 8
    Top = 344
    Width = 526
    Height = 256
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 4
    WordWrap = False
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 154
    Width = 525
    Height = 39
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Language'
    TabOrder = 5
    object ComboBoxLanguages: TComboBox
      Left = 68
      Top = 15
      Width = 182
      Height = 25
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'Datasnap'
    Params.Strings = (
      'DriverUnit=DbxDataSnap'
      'Filters={}')
    Left = 336
    Top = 184
  end
end
