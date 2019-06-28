object frmEvents: TfrmEvents
  Left = 241
  Top = 153
  BorderStyle = bsDialog
  Caption = 'Event Alerter Demo'
  ClientHeight = 318
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clNavy
  Font.Height = -11
  Font.Name = 'System'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 16
    Top = 12
    Width = 193
    Height = 105
    Caption = 'Database Connection'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object btnOpenDatabase: TButton
      Left = 34
      Top = 24
      Width = 125
      Height = 25
      Caption = '&Open Database'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnOpenDatabaseClick
    end
    object btnCloseDatabase: TButton
      Left = 34
      Top = 60
      Width = 125
      Height = 25
      Caption = '&Close Database'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCloseDatabaseClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 120
    Width = 193
    Height = 185
    Caption = 'Event Registration'
    Enabled = False
    TabOrder = 1
    object btnRegisterEvents: TButton
      Left = 34
      Top = 140
      Width = 125
      Height = 25
      Caption = '&Register Events'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnRegisterEventsClick
    end
    object moRegister: TMemo
      Left = 20
      Top = 32
      Width = 153
      Height = 97
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 220
    Top = 120
    Width = 193
    Height = 185
    Caption = 'Events Received'
    Enabled = False
    TabOrder = 2
    object btnClearEvents: TButton
      Left = 34
      Top = 140
      Width = 125
      Height = 25
      Caption = 'Clear &Event Log'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnClearEventsClick
    end
    object lbReceived: TListBox
      Left = 20
      Top = 32
      Width = 153
      Height = 97
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
    end
  end
  object GroupBox4: TGroupBox
    Left = 220
    Top = 12
    Width = 193
    Height = 105
    Caption = 'Generate Events'
    Enabled = False
    TabOrder = 3
    object Label1: TLabel
      Left = 20
      Top = 32
      Width = 28
      Height = 13
      Caption = 'Event'
      Enabled = False
      FocusControl = ebEvent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnGenerateEvent: TButton
      Left = 34
      Top = 60
      Width = 125
      Height = 25
      Caption = '&Generate Event'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnGenerateEventClick
    end
    object ebEvent: TEdit
      Left = 52
      Top = 28
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
end
