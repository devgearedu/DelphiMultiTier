object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'DataSnap Heavyweight Callback REST Monitoring Client'
  ClientHeight = 227
  ClientWidth = 424
  Color = clBtnFace
  Constraints.MinHeight = 265
  Constraints.MinWidth = 440
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  DesignSize = (
    424
    227)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 67
    Height = 13
    Caption = 'First Callback:'
  end
  object Label2: TLabel
    Left = 8
    Top = 118
    Width = 81
    Height = 13
    Caption = 'Second Callback:'
  end
  object MemoFirstCB: TMemo
    Left = 8
    Top = 27
    Width = 408
    Height = 54
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitWidth = 426
  end
  object ButtonFirstStop: TButton
    Left = 342
    Top = 87
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'STOP'
    Enabled = False
    TabOrder = 1
    OnClick = ButtonFirstStopClick
  end
  object ButtonFirstStart: TButton
    Left = 8
    Top = 87
    Width = 75
    Height = 25
    Caption = 'START'
    TabOrder = 2
    OnClick = ButtonFirstStartClick
  end
  object MemoSecondCB: TMemo
    Left = 8
    Top = 137
    Width = 408
    Height = 54
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
    ExplicitWidth = 426
    ExplicitHeight = 59
  end
  object ButtonAllStop: TButton
    Left = 152
    Top = 197
    Width = 120
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'STOP ALL CALLBACKS'
    Enabled = False
    TabOrder = 4
    OnClick = ButtonAllStopClick
    ExplicitTop = 202
    ExplicitWidth = 138
  end
  object ButtonSecondStart: TButton
    Left = 8
    Top = 197
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'START'
    TabOrder = 5
    OnClick = ButtonSecondStartClick
    ExplicitTop = 207
  end
  object ButtonSecondStop: TButton
    Left = 341
    Top = 197
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'STOP'
    Enabled = False
    TabOrder = 6
    OnClick = ButtonSecondStopClick
    ExplicitLeft = 359
    ExplicitTop = 207
  end
  object DSRestConnection1: TDSRestConnection
    Protocol = 'http'
    Host = 'localhost'
    Port = 8080
    Left = 200
    Top = 88
  end
end
