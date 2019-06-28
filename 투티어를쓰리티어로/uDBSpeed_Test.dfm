object TestForm: TTestForm
  Left = 0
  Top = 0
  Caption = 'TestForm'
  ClientHeight = 338
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 185
    Height = 313
    TabOrder = 0
  end
  object Button1: TButton
    Left = 272
    Top = 8
    Width = 130
    Height = 41
    Caption = #51068#48152#53244#47532
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 273
    Top = 102
    Width = 130
    Height = 41
    Caption = #53944#47004#51117#49496
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 273
    Top = 55
    Width = 130
    Height = 41
    Caption = 'DML ARRAY SIZE'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button3: TButton
    Left = 272
    Top = 242
    Width = 130
    Height = 41
    Caption = 'ClinetDataset'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button5: TButton
    Left = 272
    Top = 289
    Width = 130
    Height = 41
    Caption = 'memtable'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 272
    Top = 193
    Width = 130
    Height = 43
    Caption = 'delete'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 273
    Top = 149
    Width = 129
    Height = 38
    Caption = #53944#47004#51117#49496',DML'
    TabOrder = 7
    OnClick = Button7Click
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 216
    Top = 16
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 216
    Top = 216
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 160
  end
  object DataSetProvider1: TDataSetProvider
    Left = 216
    Top = 104
  end
  object FDTable1: TFDTable
    Active = True
    IndexFieldNames = 'CODE'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'TEST'
    TableName = 'TEST'
    Left = 216
    Top = 280
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=sample')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 40
    Top = 88
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 40
    Top = 168
  end
end
