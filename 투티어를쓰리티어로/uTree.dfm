object TreeForm: TTreeForm
  Left = 0
  Top = 0
  Anchors = []
  Caption = #51312#51649#46020
  ClientHeight = 281
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    377
    281)
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView1: TTreeView
    Left = 0
    Top = 8
    Width = 177
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    Indent = 19
    TabOrder = 0
    OnClick = TreeView1Click
  end
  object ListView1: TListView
    Left = 183
    Top = 8
    Width = 186
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = #51060#47492
      end
      item
        Caption = #51649#44553
      end>
    TabOrder = 1
    ViewStyle = vsReport
  end
  object fdquery1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DeptqueryProvider'
    RemoteServer = DM.DSProviderConnection1
    Left = 48
    Top = 40
  end
end
