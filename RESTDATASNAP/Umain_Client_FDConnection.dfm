object Form18: TForm18
  Left = 0
  Top = 0
  Caption = 'Form18'
  ClientHeight = 297
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 25
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 0
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 72
    Width = 501
    Height = 120
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    TabOrder = 1
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Adapter = FDTableAdapter1
    Left = 456
    Top = 32
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 216
    Top = 24
  end
  object FDTableAdapter1: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    DatSTableName = 'Dept'
    Left = 336
    Top = 24
  end
  object FDStoredProc1: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'TServerMethods1.GetDept3'
    Left = 48
    Top = 232
    ParamData = <
      item
        Name = 'ReturnValue'
        DataType = ftBlob
        ParamType = ptResult
        Value = 
          'ADBS'#15#0'?'#30#0#0#0#63735#0#1#0#1#63735#2'?'#3'?'#4#63735#5#57531'?'#0'M'#0'a'#0'n'#0'a'#0'g'#0'e'#0'r'#0#30#0'U'#0'p'#0'd'#0'a'#0't'#0'e'#0's'#0'R'#0'e'#0'g'#0'i' +
          #0's'#0't'#0'r'#0'y'#0#18#0'T'#0'a'#0'b'#0'l'#0'e'#0'L'#0'i'#0's'#0't'#0#24#0'R'#0'e'#0'l'#0'a'#0't'#0'i'#0'o'#0'n'#0'L'#0'i'#0's'#0't'#0#28#0'U'#0'p'#0'd'#0'a' +
          #0't'#0'e'#0's'#0'J'#0'o'#0'u'#0'r'#0'n'#0'a'#0'l'#0#14#0'C'#0'h'#0'a'#0'n'#0'g'#0'e'#0's'#0
      end>
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 144
    Top = 232
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = FDMemTable1
    ScopeMappings = <>
    Left = 256
    Top = 240
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 348
    Top = 237
    object LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      GridControl = StringGrid1
      Columns = <>
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Protocol=http'
      'Port=8080'
      'Server=192.168.219.127'
      'DriverID=DS')
    Connected = True
    LoginPrompt = False
    Left = 128
    Top = 24
  end
end
