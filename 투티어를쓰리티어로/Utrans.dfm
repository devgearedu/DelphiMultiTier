object TransForm: TTransForm
  Left = 0
  Top = 0
  Caption = 'TransForm'
  ClientHeight = 370
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  DesignSize = (
    472
    370)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 15
    Top = 40
    Width = 449
    Height = 154
    Anchors = [akLeft, akTop, akRight]
    DataSource = DM.DeptSource
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 14
    Top = 9
    Width = 290
    Height = 25
    DataSource = DM.DeptSource
    TabOrder = 1
  end
  object Button1: TButton
    Left = 328
    Top = 9
    Width = 121
    Height = 25
    Caption = #49325#51228
    TabOrder = 2
    OnClick = Button1Click
  end
  object DBGrid2: TDBGrid
    Left = 16
    Top = 208
    Width = 448
    Height = 154
    Margins.Top = 16
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DM.InsaSource
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
