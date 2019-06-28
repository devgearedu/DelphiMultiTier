object AboutForm: TAboutForm
  Left = 192
  Top = 110
  Width = 237
  Height = 416
  Caption = 'About Football...'
  Color = clBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 29
    Top = 6
    Width = 171
    Height = 16
    Caption = 'FOOTBALL INSTRUCTIONS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 18
    Top = 27
    Width = 192
    Height = 321
    BorderStyle = bsNone
    Color = clBlue
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Default'
    Font.Style = []
    Lines.Strings = (
      'The Computer'#39's on Defense.'
      'You Control the Running Back.'
      ''
      'Slide OFF switch to PRO 1'
      '(PRO 2 for advanced players).'
      ''
      'Press ST button for downs, field'
      'position and yards to go.'
      ''
      'Press ARROW buttons (or I,K,J,L'
      'keys) to maneuver running back '
      '(bright blip) through tacklers '
      '(dimmer blips).  Tackled?'
      'Game stops.'
      ''
      'Press ST button to check status and'
      'reset field.  Try another play.'
      ''
      'On fourth down, try a run, or push'
      'K button to punt or kick field goal.'
      ''
      'If the game malfunctions it may'
      'mean battery wear.  Use a fresh one.'
      '(Just kidding.)')
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 77
    Top = 355
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
end
