object Form37: TForm37
  Left = 0
  Top = 0
  Caption = 'Form37'
  ClientHeight = 324
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    426
    324)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 273
    Top = 280
    Width = 30
    Height = 13
    Caption = 'Mode:'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 410
    Height = 148
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    Left = 8
    Top = 160
    Width = 410
    Height = 118
    Anchors = [akLeft, akTop, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 291
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Exec'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 89
    Top = 291
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Open'
    TabOrder = 3
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 273
    Top = 294
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 4
    Text = 'amBlocking'
    OnClick = ComboBox1Click
    Items.Strings = (
      'amBlocking'
      'amNonBlocking'
      'amCancelDialog'
      'amAsync')
  end
  object Button3: TButton
    Left = 170
    Top = 291
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Upd ADefs'
    TabOrder = 5
    OnClick = Button3Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_Demo')
    Connected = True
    Left = 20
    Top = 15
  end
  object FDStoredProc1: TFDStoredProc
    BeforeOpen = FDStoredProc1BeforeOpen
    AfterOpen = FDStoredProc1AfterOpen
    BeforeExecute = FDStoredProc1BeforeExecute
    AfterExecute = FDStoredProc1AfterExecute
    BeforeGetRecords = FDStoredProc1BeforeGetRecords
    AfterGetRecords = FDStoredProc1AfterGetRecords
    Connection = FDConnection1
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.CmdExecMode = amNonBlocking
    StoredProcName = 'Northwind.dbo.FDQA_LongRun'
    Left = 103
    Top = 15
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftLargeint
        ParamType = ptResult
        Value = 0
      end>
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    ScreenCursor = gcrHourGlass
    Left = 120
    Top = 125
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 155
    Top = 125
  end
  object FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog
    Left = 190
    Top = 125
  end
  object DataSource1: TDataSource
    DataSet = FDStoredProc1
    Left = 189
    Top = 15
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Left = 208
    Top = 208
  end
end
