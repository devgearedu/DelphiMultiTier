object Form61: TForm61
  Left = 37
  Top = 0
  Caption = 'Marshal Person Cpp Example'
  ClientHeight = 358
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object GroupBox1: TGroupBox
    Left = 21
    Top = 10
    Width = 430
    Height = 106
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Person'
    TabOrder = 0
    DesignSize = (
      430
      106)
    object Label1: TLabel
      Left = 21
      Top = 31
      Width = 69
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'FirstName: '
    end
    object Label2: TLabel
      Left = 21
      Top = 67
      Width = 65
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'LastName:'
    end
    object EditFirstName: TEdit
      Left = 95
      Top = 27
      Width = 323
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object EditLastName: TEdit
      Left = 95
      Top = 63
      Width = 323
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
  object ButtonClear: TButton
    Left = 127
    Top = 292
    Width = 98
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Clear'
    TabOrder = 1
    OnClick = ButtonClearClick
  end
  object GroupBox2: TGroupBox
    Left = 21
    Top = 124
    Width = 430
    Height = 160
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Person Collection'
    TabOrder = 2
    object ListBox1: TListBox
      Left = 21
      Top = 21
      Width = 388
      Height = 116
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ItemHeight = 17
      TabOrder = 0
    end
  end
  object ButtonGet: TButton
    Left = 21
    Top = 292
    Width = 98
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Get (REST)'
    TabOrder = 3
    OnClick = ButtonGetClick
  end
end
