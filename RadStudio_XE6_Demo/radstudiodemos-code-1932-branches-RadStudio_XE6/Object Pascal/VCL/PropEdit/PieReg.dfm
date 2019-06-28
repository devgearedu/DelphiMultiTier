object AngleEditorDlg: TAngleEditorDlg
  Left = 252
  Top = 197
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Pie Angles Editor'
  ClientHeight = 138
  ClientWidth = 185
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object EAngleLabel: TLabel
    Left = 12
    Top = 54
    Width = 157
    Height = 13
    AutoSize = False
    Caption = 'EndAngle = 0'
  end
  object SAngleLabel: TLabel
    Left = 12
    Top = 6
    Width = 157
    Height = 13
    AutoSize = False
    Caption = 'StartAngle = 0'
  end
  object OKButton: TButton
    Left = 7
    Top = 104
    Width = 77
    Height = 27
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelButton: TButton
    Left = 99
    Top = 104
    Width = 77
    Height = 27
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    OnClick = CancelClick
  end
  object STrackBar: TTrackBar
    Left = 5
    Top = 24
    Width = 176
    Height = 25
    Ctl3D = True
    Max = 360
    Orientation = trHorizontal
    ParentCtl3D = False
    PageSize = 10
    Frequency = 1
    Position = 0
    SelEnd = 0
    SelStart = 0
    TabOrder = 0
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = STrackBarChange
  end
  object ETrackBar: TTrackBar
    Left = 5
    Top = 69
    Width = 176
    Height = 25
    Max = 360
    Orientation = trHorizontal
    PageSize = 10
    Frequency = 1
    Position = 0
    SelEnd = 0
    SelStart = 0
    TabOrder = 1
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = ETrackBarChange
  end
end
