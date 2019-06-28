object Form1: TForm1
  Left = 271
  Top = 114
  Caption = 'Session Test Server'
  ClientHeight = 235
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    399
    235)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 184
    Top = 13
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 103
    Width = 383
    Height = 10
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 8
    Top = 111
    Width = 45
    Height = 13
    Caption = 'Sessions:'
  end
  object Label3: TLabel
    Left = 8
    Top = 39
    Width = 231
    Height = 13
    Caption = 'STEP 1: Click the "Open Browser" button above.'
  end
  object Label4: TLabel
    Left = 8
    Top = 58
    Width = 329
    Height = 13
    Caption = 
      'STEP 2: In the browser, enter a user name and password, and log ' +
      'in'
  end
  object Label5: TLabel
    Left = 8
    Top = 77
    Width = 304
    Height = 13
    Caption = 'STEP 3: Come back here and click the "Update Sessions" button'
  end
  object ButtonStart: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 210
    Top = 10
    Width = 55
    Height = 21
    TabOrder = 3
    Text = '8089'
  end
  object ButtonOpenBrowser: TButton
    Left = 271
    Top = 8
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 0
    OnClick = ButtonOpenBrowserClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 130
    Width = 383
    Height = 71
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object Button1: TButton
    Left = 292
    Top = 207
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Update Sessions'
    TabOrder = 5
    OnClick = Button1Click
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 344
    Top = 56
  end
end
