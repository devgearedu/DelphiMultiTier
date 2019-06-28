object fDemo: TfDemo
  Left = 508
  Top = 305
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Usage Tracker Demo'
  ClientHeight = 141
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bShowTracker: TButton
    Left = 8
    Top = 96
    Width = 217
    Height = 37
    Caption = 'Show Usage Tracker'
    TabOrder = 0
    OnClick = bShowTrackerClick
  end
  object gbMinimumBlockAlignment: TGroupBox
    Left = 8
    Top = 4
    Width = 217
    Height = 85
    Caption = 'Minimum Block Alignment'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 48
      Width = 201
      Height = 25
      AutoSize = False
      Caption = 
        '(Affects new allocations only. Current live pointers are unaffec' +
        'ted.)'
      WordWrap = True
    end
    object cbMinimumBlockAlignment: TComboBox
      Left = 12
      Top = 16
      Width = 193
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'At least 8 byte aligned'
      OnChange = cbMinimumBlockAlignmentChange
      Items.Strings = (
        'At least 8 byte aligned'
        'At least 16 byte aligned')
    end
  end
end
