object Form61: TForm61
  Left = 0
  Top = 0
  Caption = 'DBX User Types Client'
  ClientHeight = 393
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    514
    393)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 183
    Top = 8
    Width = 315
    Height = 329
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 9
    WordWrap = False
  end
  object ButtonAll: TButton
    Left = 17
    Top = 236
    Width = 75
    Height = 25
    Caption = 'All Tests'
    TabOrder = 5
    OnClick = ButtonAllClick
  end
  object ButtonGenericListFields: TButton
    Left = 17
    Top = 152
    Width = 145
    Height = 25
    Caption = 'GenericList Field Tests'
    TabOrder = 3
    OnClick = ButtonGenericListFieldsClick
  end
  object CheckBoxInstanceOwner: TCheckBox
    Left = 17
    Top = 272
    Width = 97
    Height = 17
    Caption = 'InstanceOwner'
    TabOrder = 6
    OnClick = CheckBoxInstanceOwnerClick
  end
  object Button1: TButton
    Left = 423
    Top = 352
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 10
    OnClick = Button1Click
  end
  object ButtonUnsupportedFields: TButton
    Left = 17
    Top = 112
    Width = 145
    Height = 25
    Caption = 'Unsupported Fields Tests'
    TabOrder = 2
    OnClick = ButtonUnsupportedFieldsClick
  end
  object ButtonStringFieldsTests: TButton
    Left = 17
    Top = 72
    Width = 129
    Height = 25
    Caption = 'StringsField Tests'
    TabOrder = 1
    OnClick = ButtonStringFieldsTestsClick
  end
  object ButtonPersonTests: TButton
    Left = 17
    Top = 32
    Width = 88
    Height = 25
    Caption = 'Person Tests'
    TabOrder = 0
    OnClick = ButtonPersonTestsClick
  end
  object CheckBoxRegistered: TCheckBox
    Left = 8
    Top = 343
    Width = 289
    Height = 17
    Caption = 'Test Types with registered converters/reverters'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object CheckBoxAttributes: TCheckBox
    Left = 8
    Top = 368
    Width = 329
    Height = 17
    Caption = 'Test types with Interceptors declared with attributes'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object ButtonGenericDictionaryTests: TButton
    Left = 17
    Top = 194
    Width = 160
    Height = 25
    Caption = 'GenericDictionary Field Tests'
    TabOrder = 4
    OnClick = ButtonGenericDictionaryTestsClick
  end
end
