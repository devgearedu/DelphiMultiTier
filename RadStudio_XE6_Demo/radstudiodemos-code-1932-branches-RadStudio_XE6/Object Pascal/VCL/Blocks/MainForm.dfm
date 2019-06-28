object BlockForm: TBlockForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Delphi Blocks'
  ClientHeight = 535
  ClientWidth = 460
  Color = clSkyBlue
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = GamePopupMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 460
    Height = 535
    Align = alClient
    OnPaint = PaintBox1Paint
    ExplicitLeft = -8
    ExplicitTop = 8
    ExplicitWidth = 458
    ExplicitHeight = 525
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 32
    Top = 16
  end
  object GamePopupMenu: TPopupMenu
    Left = 96
    Top = 16
    object StartnewgameF1: TMenuItem
      Caption = 'Start new game'
      ShortCut = 113
      OnClick = StartnewgameF1Click
    end
    object Pause1: TMenuItem
      Caption = 'Pause'
      ShortCut = 114
      OnClick = Pause1Click
    end
    object Help1: TMenuItem
      Caption = '-'
    end
    object Help2: TMenuItem
      Caption = 'Help'
      ShortCut = 112
      OnClick = Help2Click
    end
  end
end
