object DataModuleFDClient: TDataModuleFDClient
  OldCreateOrder = False
  Height = 304
  Width = 375
  object dsinsa: TDataSource
    DataSet = mtinsa
    Left = 176
    Top = 200
  end
  object mtDept: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Adapter = taDept
    Left = 40
    Top = 88
  end
  object taDept: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter
    DatSTableName = 'qDept'
    Left = 40
    Top = 136
  end
  object dsDept: TDataSource
    DataSet = mtDept
    Left = 40
    Top = 192
  end
  object mtinsa: TFDMemTable
    CachedUpdates = True
    IndexFieldNames = 'dept_code'
    MasterSource = dsDept
    MasterFields = 'code'
    FetchOptions.AssignedValues = [evMode, evDetailCascade]
    FetchOptions.Mode = fmAll
    FetchOptions.DetailCascade = True
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Adapter = tainsa
    Left = 184
    Top = 88
  end
  object FDSchemaAdapter: TFDSchemaAdapter
    Left = 48
    Top = 24
  end
  object tainsa: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter
    DatSTableName = 'qInsa'
    Left = 178
    Top = 144
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 184
    Top = 32
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 288
    Top = 128
  end
end
