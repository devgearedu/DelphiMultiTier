object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 239
  Width = 414
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=Sample')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 32
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 168
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 288
    Top = 32
  end
  object Dept: TFDTable
    IndexFieldNames = 'CODE'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DEPT'
    TableName = 'DEPT'
    Left = 64
    Top = 104
  end
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveDataSetReader1
    Writer = FDBatchMoveJSONWriter1
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 288
    Top = 104
  end
  object FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader
    DataSet = Dept
    Left = 168
    Top = 112
  end
  object FDBatchMoveJSONWriter1: TFDBatchMoveJSONWriter
    FileName = 'D:\201906_'#44592#48376#44284#51221'\'#48516#49328#52376#47532#44284#51221'\RESTDATASNAP\Dept.json'
    DataDef.Fields = <>
    Left = 304
    Top = 176
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 64
    Top = 168
  end
end
