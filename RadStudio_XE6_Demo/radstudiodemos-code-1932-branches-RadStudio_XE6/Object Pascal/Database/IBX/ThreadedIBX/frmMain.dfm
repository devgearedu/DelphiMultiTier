object Main: TMain
  Left = 210
  Top = 113
  Caption = 'Threaded Queries'
  ClientHeight = 213
  ClientWidth = 549
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 549
    Height = 57
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 10
      Width = 46
      Height = 13
      Caption = 'Database'
    end
    object Label2: TLabel
      Left = 4
      Top = 36
      Width = 53
      Height = 13
      Caption = 'User Name'
    end
    object Password: TLabel
      Left = 212
      Top = 36
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object edtUsername: TEdit
      Left = 60
      Top = 32
      Width = 149
      Height = 21
      TabOrder = 0
      Text = 'sysdba'
    end
    object edtPassword: TEdit
      Left = 264
      Top = 32
      Width = 137
      Height = 21
      TabOrder = 1
      Text = 'masterkey'
    end
    object edtDatabase: TEdit
      Left = 60
      Top = 6
      Width = 445
      Height = 21
      TabOrder = 2
      Text = 
        'localhost:C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samp' +
        'les\Data\employee.gdb'
    end
  end
  object mmoSQL: TMemo
    Left = 0
    Top = 57
    Width = 549
    Height = 117
    Align = alTop
    Lines.Strings = (
      'select * from employee')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 80
    Top = 180
    Width = 129
    Height = 25
    Caption = 'Run Query In DBGrid'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 309
    Top = 180
    Width = 129
    Height = 25
    Caption = 'Run Query In String Grid'
    TabOrder = 3
    OnClick = Button2Click
  end
end
