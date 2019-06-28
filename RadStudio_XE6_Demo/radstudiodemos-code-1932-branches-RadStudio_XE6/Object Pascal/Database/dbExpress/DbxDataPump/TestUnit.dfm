object Form24: TForm24
  Left = 0
  Top = 0
  Caption = 'Form24'
  ClientHeight = 446
  ClientWidth = 841
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    841
    446)
  PixelsPerInch = 120
  TextHeight = 17
  object Button1: TButton
    Left = 10
    Top = 10
    Width = 232
    Height = 33
    Caption = 'Get All Tables and Their Columns'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 10
    Top = 51
    Width = 820
    Height = 384
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button2: TButton
    Left = 250
    Top = 10
    Width = 212
    Height = 33
    Caption = 'Test Drop And Create Table'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 471
    Top = 10
    Width = 98
    Height = 33
    Caption = 'Button3'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 577
    Top = 10
    Width = 98
    Height = 33
    Caption = 'Migrate'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 683
    Top = 10
    Width = 98
    Height = 33
    Caption = 'Params Test'
    TabOrder = 5
    OnClick = Button5Click
  end
end
