object DisplayForm: TDisplayForm
  Left = 469
  Top = 351
  Width = 292
  Height = 270
  Caption = 'Display Form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = DisplayFormShow
  PixelsPerInch = 120
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 0
    Top = 80
    Width = 284
    Height = 98
    Align = alTop
    Caption = 'Select Image'
    TabOrder = 0
    object Image1: TImage
      Left = 118
      Top = 20
      Width = 51
      Height = 50
    end
    object Button1: TButton
      Left = 10
      Top = 30
      Width = 92
      Height = 30
      Caption = 'Load'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 284
    Height = 80
    Align = alTop
    Caption = 'Select Action'
    TabOrder = 1
    object ComboBox1: TComboBox
      Left = 20
      Top = 30
      Width = 178
      Height = 24
      ItemHeight = 16
      TabOrder = 0
      OnChange = ComboBox1Change
    end
  end
  object BitBtn1: TBitBtn
    Left = 10
    Top = 197
    Width = 92
    Height = 31
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 138
    Top = 197
    Width = 92
    Height = 31
    TabOrder = 3
    Kind = bkCancel
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    InitialDir = 'c:\Program files\Common Files\Borland Shared\Images\Buttons'
    Left = 152
    Top = 248
  end
end
