object ServerMethods: TServerMethods
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 305
  Width = 523
  object FDConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=sample')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 24
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 176
    Top = 24
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 304
    Top = 24
  end
  object FDStanStorageJSONLink: TFDStanStorageJSONLink
    Left = 432
    Top = 24
  end
  object FDSchemaAdapter: TFDSchemaAdapter
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 88
  end
  object qDEPT: TFDQuery
    Active = True
    CachedUpdates = True
    OnUpdateError = DataSetUpdateError
    Connection = FDConnection
    SchemaAdapter = FDSchemaAdapter
    SQL.Strings = (
      'select * from dept')
    Left = 56
    Top = 152
  end
  object qinsa: TFDQuery
    Active = True
    CachedUpdates = True
    IndexFieldNames = 'DEPT_CODE'
    MasterSource = dsDept
    MasterFields = 'CODE'
    OnUpdateError = DataSetUpdateError
    Connection = FDConnection
    SchemaAdapter = FDSchemaAdapter
    FetchOptions.AssignedValues = [evDetailCascade]
    FetchOptions.DetailCascade = True
    SQL.Strings = (
      'select * from insa')
    Left = 160
    Top = 152
  end
  object dsDept: TDataSource
    DataSet = qDEPT
    Left = 56
    Top = 208
  end
  object dsInsa: TDataSource
    DataSet = qinsa
    Left = 160
    Top = 208
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 432
    Top = 88
  end
end
