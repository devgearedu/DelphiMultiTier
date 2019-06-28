object TabDockHost: TTabDockHost
  Left = 412
  Top = 306
  Caption = 'TabDockHost'
  ClientHeight = 275
  ClientWidth = 492
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 492
    Height = 275
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DockSite = True
    TabOrder = 0
    OnDockOver = PageControl1DockOver
    OnGetSiteInfo = PageControl1GetSiteInfo
    OnUnDock = PageControl1UnDock
  end
end
