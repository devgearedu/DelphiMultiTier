object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 282
  Width = 512
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
    Left = 296
    Top = 32
  end
  object Dept: TFDTable
    IndexFieldNames = 'CODE'
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    UpdateOptions.UpdateTableName = 'DEPT'
    TableName = 'DEPT'
    Left = 64
    Top = 96
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 416
    Top = 96
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 416
    Top = 32
  end
  object InsaQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from insa'
      'where dept_code =:code')
    Left = 64
    Top = 176
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 168
    Top = 96
  end
end
