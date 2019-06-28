object fLeakTestForm: TfLeakTestForm
  Left = 750
  Top = 118
  BorderStyle = bsSingle
  Caption = 'Leak Test'
  ClientHeight = 154
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 132
    Width = 325
    Height = 13
    AutoSize = False
    Caption = '(Close the application to see the leak checking in action.)'
    WordWrap = True
  end
  object bLeak: TButton
    Left = 12
    Top = 8
    Width = 325
    Height = 25
    Caption = 'Leak a TObject'
    TabOrder = 0
    OnClick = bLeakClick
  end
  object bLeakAndRegister: TButton
    Left = 12
    Top = 40
    Width = 325
    Height = 25
    Caption = 'Leak a TObject, but register it as an expected leak'
    TabOrder = 1
    OnClick = bLeakAndRegisterClick
  end
  object cbLeakReportingEnabled: TComboBox
    Left = 12
    Top = 104
    Width = 325
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 2
    Text = 'Unexpected memory leaks will be reported on shutdown.'
    OnChange = cbLeakReportingEnabledChange
    Items.Strings = (
      'Memory leak reporting is disabled.'
      'Unexpected memory leaks will be reported on shutdown.')
  end
  object bTestUnregister: TButton
    Left = 12
    Top = 72
    Width = 325
    Height = 25
    Caption = 'TObject.Create, register leak, TObject.Free, Unregister leak'
    TabOrder = 3
    OnClick = bTestUnregisterClick
  end
end
