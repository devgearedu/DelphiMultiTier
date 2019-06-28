object FrmContainerList: TFrmContainerList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'List of Containers'
  ClientHeight = 328
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    329
    328)
  PixelsPerInch = 96
  TextHeight = 18
  object lbContainers: TListBox
    Left = 8
    Top = 8
    Width = 317
    Height = 264
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 18
    Items.Strings = (
      '1'
      '2'
      '3'
      '4')
    TabOrder = 0
    OnDblClick = bbUploadClick
  end
  object bbNew: TButton
    Left = 24
    Top = 278
    Width = 113
    Height = 42
    Caption = '&New Container'
    TabOrder = 1
    WordWrap = True
    OnClick = bbNewClick
  end
  object bbUpload: TBitBtn
    Left = 184
    Top = 278
    Width = 113
    Height = 42
    Caption = '&Upload'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = bbUploadClick
  end
end
