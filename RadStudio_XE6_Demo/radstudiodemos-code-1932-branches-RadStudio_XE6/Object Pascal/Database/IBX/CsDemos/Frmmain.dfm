object FrmLauncher: TFrmLauncher
  Left = 195
  Top = 112
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Client/Server Concepts'
  ClientHeight = 248
  ClientWidth = 240
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object BtnTrigg: TButton
    Left = 8
    Top = 48
    Width = 225
    Height = 34
    Hint = 'Shows a trigger in action'
    Caption = 'Salary Change &Trigger Demo'
    TabOrder = 1
    OnClick = BtnTriggClick
  end
  object BtnViews: TButton
    Left = 8
    Top = 8
    Width = 225
    Height = 34
    Hint = 'Demonstrates that views are treated like tables'
    Caption = 'Show a &View in action'
    TabOrder = 0
    OnClick = BtnViewsClick
  end
  object BtnQrySP: TButton
    Left = 8
    Top = 88
    Width = 225
    Height = 34
    Hint = 'Shows a query procedure in action'
    Caption = '&Query Stored Procedure Demo'
    TabOrder = 2
    OnClick = BtnQrySPClick
  end
  object BtnExecSP: TButton
    Left = 8
    Top = 128
    Width = 225
    Height = 34
    Hint = 'Shows an executable procedure in action'
    Caption = '&Executable Stored Procedure Demo'
    TabOrder = 3
    OnClick = BtnExecSPClick
  end
  object BtnClose: TButton
    Left = 8
    Top = 208
    Width = 225
    Height = 34
    Hint = 'Exits this sample'
    Caption = '&Exit'
    TabOrder = 5
    OnClick = BtnCloseClick
  end
  object BtnTrans: TButton
    Left = 8
    Top = 168
    Width = 225
    Height = 34
    Hint = 'Shows simple transaction handling'
    Caption = 'T&ransaction Editing Demo'
    TabOrder = 4
    OnClick = BtnTransClick
  end
end
