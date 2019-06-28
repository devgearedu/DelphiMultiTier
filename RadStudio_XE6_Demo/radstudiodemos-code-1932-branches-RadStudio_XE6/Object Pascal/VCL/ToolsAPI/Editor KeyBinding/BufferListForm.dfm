object BufferListFrm: TBufferListFrm
  Left = 311
  Top = 285
  BorderStyle = bsDialog
  Caption = 'Buffer List'
  ClientHeight = 226
  ClientWidth = 409
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BufferListBox: TListBox
    Left = 8
    Top = 8
    Width = 313
    Height = 209
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = BufferListBoxDblClick
  end
  object OKButton: TButton
    Left = 328
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 328
    Top = 40
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
