object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'DataSnap Heavyweight Callback Monitoring Server'
  ClientHeight = 162
  ClientWidth = 421
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  DesignSize = (
    421
    162)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 21
    Width = 88
    Height = 13
    Caption = 'Monitor event log:'
  end
  object LogMemo: TMemo
    Left = 8
    Top = 40
    Width = 405
    Height = 85
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object BroadcastField: TEdit
    Left = 8
    Top = 133
    Width = 314
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
  end
  object BroadcastButton: TButton
    Left = 328
    Top = 131
    Width = 85
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'BROADCAST'
    TabOrder = 2
    OnClick = BroadcastButtonClick
  end
  object ButtonBrowser: TButton
    Left = 304
    Top = 8
    Width = 109
    Height = 25
    Caption = 'Open In Browser'
    TabOrder = 3
    OnClick = ButtonBrowserClick
  end
end
