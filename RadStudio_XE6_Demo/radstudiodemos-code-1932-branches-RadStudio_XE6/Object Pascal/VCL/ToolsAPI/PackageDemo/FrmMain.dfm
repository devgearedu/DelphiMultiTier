object Form2: TForm2
  Left = 269
  Top = 196
  Width = 345
  Height = 317
  BorderIcons = [biSystemMenu]
  Caption = 'Information'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 337
    Height = 290
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Package information'
      object Label1: TLabel
        Left = 7
        Top = 7
        Width = 75
        Height = 13
        Caption = 'Package name:'
      end
      object Label2: TLabel
        Left = 143
        Top = 7
        Width = 107
        Height = 13
        Caption = 'Package components:'
      end
      object ListBox1: TListBox
        Left = 7
        Top = 20
        Width = 111
        Height = 163
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox1Click
      end
      object ListBox2: TListBox
        Left = 143
        Top = 20
        Width = 111
        Height = 163
        ItemHeight = 13
        TabOrder = 1
      end
      object CheckBox1: TCheckBox
        Left = 7
        Top = 186
        Width = 247
        Height = 14
        Caption = 'Component packages only'
        TabOrder = 2
        OnClick = CheckBox1Click
      end
    end
  end
end
