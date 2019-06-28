object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Session Store Object'
  ClientHeight = 106
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    415
    106)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 64
    Height = 13
    Caption = 'Go here first:'
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 68
    Height = 13
    Caption = 'Then go here:'
  end
  object Edit1: TEdit
    Left = 8
    Top = 27
    Width = 401
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 
      'http://localhost:8080/datasnap/rest/TServerMethods1/StoreObject/' +
      'abc/a/b/c'
  end
  object Edit2: TEdit
    Left = 8
    Top = 73
    Width = 399
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
end
