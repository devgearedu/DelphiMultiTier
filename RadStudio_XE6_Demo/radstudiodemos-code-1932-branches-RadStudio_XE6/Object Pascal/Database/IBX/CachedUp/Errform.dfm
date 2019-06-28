object UpdateErrorForm: TUpdateErrorForm
  Left = 306
  Top = 160
  Caption = 'Update Error'
  ClientHeight = 297
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 41
    Top = 21
    Width = 65
    Height = 13
    Caption = 'Update Type:'
  end
  object UpdateType: TLabel
    Left = 111
    Top = 22
    Width = 49
    Height = 13
    Caption = 'Modified'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 33
    Top = 41
    Width = 71
    Height = 13
    Caption = 'Error Message:'
  end
  object ErrorText: TLabel
    Left = 49
    Top = 59
    Width = 322
    Height = 59
    AutoSize = False
    Caption = 'ErrorText'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object UpdateData: TStringGrid
    Left = 31
    Top = 124
    Width = 362
    Height = 124
    ColCount = 2
    FixedCols = 0
    RowCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    OnSetEditText = UpdateDataSetEditText
    ColWidths = (
      166
      169)
  end
  object RetryButton: TButton
    Left = 65
    Top = 267
    Width = 75
    Height = 25
    Caption = '&Retry'
    ModalResult = 4
    TabOrder = 1
  end
  object SkipButton: TButton
    Left = 177
    Top = 267
    Width = 75
    Height = 25
    Caption = '&Skip'
    ModalResult = 5
    TabOrder = 2
  end
  object AbortButton: TButton
    Left = 284
    Top = 267
    Width = 75
    Height = 25
    Caption = '&Abort'
    ModalResult = 3
    TabOrder = 3
  end
end
