object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 469
  Height = 349
  TabOrder = 0
  object DBChart1: TDBChart
    Left = 16
    Top = 3
    Width = 441
    Height = 262
    BackWall.Pen.Width = 6
    BottomWall.Color = 4194304
    BottomWall.Pen.Width = 7
    Gradient.EndColor = clGray
    Gradient.MidColor = clWhite
    Gradient.StartColor = clSilver
    Title.Font.Height = -24
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'TDBChart')
    Chart3DPercent = 16
    Frame.Width = 6
    Legend.Color = clAqua
    Legend.DividingLines.Visible = True
    Legend.Font.Style = [fsItalic]
    Legend.Font.Shadow.Color = clBlue
    Legend.Font.Shadow.HorizSize = -1
    Legend.Font.Shadow.VertSize = -1
    Legend.Frame.Width = 3
    Legend.TextStyle = ltsRightValue
    Legend.Transparency = 4
    Pages.MaxPointsPerPage = 3
    View3DOptions.Zoom = 106
    BevelInner = bvLowered
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      20
      15
      20)
    ColorPaletteIndex = 13
    object Series1: TBarSeries
      BarBrush.Color = 33554432
      BarBrush.Gradient.EndColor = clRed
      BarPen.Width = 2
      Marks.Arrow.Color = 4194304
      Marks.Arrow.Width = 2
      Marks.Callout.Arrow.Color = 4194304
      Marks.Callout.Arrow.Width = 2
      Marks.Callout.ArrowHead = ahLine
      Marks.Callout.Length = 23
      Marks.Symbol.Frame.Width = 10
      Marks.Symbol.Pen.Width = 10
      SeriesColor = clRed
      BarWidthPercent = 75
      Emboss.HorizSize = 3
      Emboss.VertSize = 3
      Emboss.Visible = True
      Gradient.EndColor = clRed
      Shadow.Color = 7566195
      Shadow.HorizSize = 1
      Shadow.VertSize = 1
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
  object Button1: TButton
    Left = 16
    Top = 272
    Width = 75
    Height = 25
    Caption = #52376#51020
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 97
    Top = 271
    Width = 75
    Height = 25
    Caption = #51060#51204
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 16
    Top = 303
    Width = 75
    Height = 25
    Caption = #45796#51020
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 97
    Top = 302
    Width = 75
    Height = 25
    Caption = #47592#45149
    TabOrder = 4
    OnClick = Button4Click
  end
  object ColorGrid1: TColorGrid
    Left = 192
    Top = 271
    Width = 88
    Height = 56
    TabOrder = 5
    OnChange = ColorGrid1Change
  end
  object CheckBox1: TCheckBox
    Left = 304
    Top = 271
    Width = 137
    Height = 17
    Caption = '3D'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = CheckBox1Click
  end
  object ComboBox1: TComboBox
    Left = 304
    Top = 304
    Width = 145
    Height = 21
    ItemIndex = 1
    TabOrder = 7
    Text = '100'
    OnChange = ComboBox1Change
    Items.Strings = (
      '75'
      '100'
      '125'
      '150')
  end
end
