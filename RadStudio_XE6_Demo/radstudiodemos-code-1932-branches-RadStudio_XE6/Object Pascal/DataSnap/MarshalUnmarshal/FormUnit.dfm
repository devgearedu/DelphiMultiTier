object Form56: TForm56
  Left = 0
  Top = 0
  Caption = 'Marshal/Unmarshal Tests'
  ClientHeight = 687
  ClientWidth = 973
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    973
    687)
  PixelsPerInch = 120
  TextHeight = 17
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 109
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Type Descriptions'
  end
  object JSONValue: TLabel
    Left = 303
    Top = 10
    Width = 65
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'JSONValue'
  end
  object Label2: TLabel
    Left = 10
    Top = 458
    Width = 23
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Log'
  end
  object Label3: TLabel
    Left = 21
    Top = 433
    Width = 67
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Rtti Types:'
  end
  object ButtonMarshal: TButton
    Left = 10
    Top = 333
    Width = 286
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'ButtonMarshal'
    TabOrder = 2
    OnClick = ButtonMarshalClick
  end
  object Memo1: TMemo
    Left = 10
    Top = 483
    Width = 952
    Height = 163
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 10
    WordWrap = False
  end
  object ButtonClearLog: TButton
    Left = 864
    Top = 653
    Width = 98
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Caption = 'Clear'
    TabOrder = 11
    OnClick = ButtonClearLogClick
  end
  object CheckBoxWordWrap: TCheckBox
    Left = 730
    Top = 339
    Width = 127
    Height = 22
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Word Wrap'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = CheckBoxWordWrapClick
  end
  object ListBox1: TListBox
    Left = 10
    Top = 35
    Width = 286
    Height = 291
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ItemHeight = 17
    TabOrder = 0
  end
  object MemoJSONValue: TMemo
    Left = 303
    Top = 35
    Width = 659
    Height = 291
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ButtonUnmarshalJson: TButton
    Left = 303
    Top = 333
    Width = 357
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'ButtonUnmarshalJson'
    TabOrder = 3
    OnClick = ButtonUnmarshalJsonClick
  end
  object ButtonClearJSON: TButton
    Left = 864
    Top = 333
    Width = 98
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    TabOrder = 7
    OnClick = ButtonClearJSONClick
  end
  object ButtonAll: TButton
    Left = 10
    Top = 374
    Width = 286
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Marshal/Unmarshal All'
    TabOrder = 4
    OnClick = ButtonAllClick
  end
  object ButtonLogType: TButton
    Left = 854
    Top = 426
    Width = 108
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akTop, akRight]
    Caption = 'Log Details'
    TabOrder = 9
    OnClick = ButtonLogTypeClick
  end
  object ComboBoxTypeNames: TComboBox
    Left = 98
    Top = 429
    Width = 748
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    DropDownCount = 40
    Sorted = True
    TabOrder = 8
    Text = 'ComboBoxTypeNames'
  end
  object ButtonTypeDetails: TButton
    Left = 303
    Top = 374
    Width = 357
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'ButtonTypeDetails'
    TabOrder = 5
    OnClick = ButtonTypeDetailsClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 576
    Top = 280
  end
end
