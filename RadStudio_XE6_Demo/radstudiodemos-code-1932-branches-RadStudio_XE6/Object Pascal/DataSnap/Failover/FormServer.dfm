object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Server'
  ClientHeight = 120
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 25
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Button1: TButton
    Left = 127
    Top = 32
    Width = 98
    Height = 45
    Caption = 'Start/Stop'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ed_port: TEdit
    Left = 72
    Top = 44
    Width = 49
    Height = 21
    TabOrder = 1
    Text = '211'
  end
end
