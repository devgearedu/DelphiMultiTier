object MainForm: TMainForm
  Left = 0
  Top = 0
  Width = 596
  Height = 419
  Caption = 'Get DBMS info'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object mmInfo: TMemo
    Left = 10
    Top = 10
    Width = 537
    Height = 305
    Lines.Strings = (
      'mmInfo')
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Button1: TButton
    Left = 10
    Top = 331
    Width = 99
    Height = 33
    Caption = 'Get report'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 116
    Top = 331
    Width = 98
    Height = 33
    Caption = 'Get versions'
    TabOrder = 2
    OnClick = Button2Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=MySQL_Demo')
    Left = 120
    Top = 224
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Left = 160
    Top = 224
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 200
    Top = 224
  end
end
