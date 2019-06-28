object CacheData: TCacheData
  OldCreateOrder = True
  Height = 479
  Width = 741
  object CacheDS: TDataSource
    DataSet = IBCacheQuery
    Left = 47
    Top = 122
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 
      'localhost:C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samp' +
      'les\Data\EMPLOYEE.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    SQLDialect = 1
    Left = 124
    Top = 20
  end
  object IBCacheQuery: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    OnCalcFields = CacheQueryCalcFields
    OnUpdateError = IBCacheQueryUpdateError
    BufferChunks = 1000
    CachedUpdates = True
    ParamCheck = True
    SQL.Strings = (
      'SELECT PROJ_ID , PROJ_NAME'
      'FROM PROJECT '
      'ORDER BY'
      ' PROJ_ID')
    UpdateObject = IBUpdateSQL
    Left = 48
    Top = 20
    object IBCacheQueryPROJ_ID: TIBStringField
      FieldName = 'PROJ_ID'
      Origin = 'PROJECT.PROJ_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 5
    end
    object IBCacheQueryPROJ_NAME: TIBStringField
      FieldName = 'PROJ_NAME'
      Origin = 'PROJECT.PROJ_NAME'
      Required = True
    end
    object IBCacheQueryUpdateStatus: TStringField
      DisplayWidth = 24
      FieldKind = fkCalculated
      FieldName = 'UpdateStatus'
      Calculated = True
    end
  end
  object IBUpdateSQL: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  PROJ_ID,'
      '  PROJ_NAME,'
      '  PROJ_DESC,'
      '  TEAM_LEADER,'
      '  PRODUCT'
      'from PROJECT '
      'where'
      '  PROJ_ID = :PROJ_ID')
    ModifySQL.Strings = (
      'update PROJECT'
      'set'
      '  PROJ_ID = :PROJ_ID,'
      '  PROJ_NAME = :PROJ_NAME'
      'where'
      '  PROJ_ID = :OLD_PROJ_ID')
    InsertSQL.Strings = (
      'insert into PROJECT'
      '  (PROJ_ID, PROJ_NAME)'
      'values'
      '  (:PROJ_ID, :PROJ_NAME)')
    DeleteSQL.Strings = (
      'delete from PROJECT'
      'where'
      '  PROJ_ID = :OLD_PROJ_ID')
    Left = 48
    Top = 72
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 124
    Top = 72
  end
  object IBCachedDataSet: TIBDataSet
    Tag = 1
    Database = IBDatabase1
    Transaction = IBTransaction1
    OnCalcFields = IBCachedDataSetCalcFields
    OnUpdateError = IBCacheQueryUpdateError
    BufferChunks = 1000
    CachedUpdates = True
    DeleteSQL.Strings = (
      'delete from PROJECT'
      'where'
      '  PROJ_ID = :OLD_PROJ_ID')
    InsertSQL.Strings = (
      'insert into PROJECT'
      '  (PROJ_ID, PROJ_NAME)'
      'values'
      '  (:PROJ_ID, :PROJ_NAME)')
    RefreshSQL.Strings = (
      'Select '
      '  PROJ_ID,'
      '  PROJ_NAME,'
      '  PROJ_DESC,'
      '  TEAM_LEADER,'
      '  PRODUCT'
      'from PROJECT '
      'where'
      '  PROJ_ID = :PROJ_ID')
    SelectSQL.Strings = (
      'SELECT PROJ_ID , PROJ_NAME'
      'FROM PROJECT '
      'ORDER BY'
      '  PROJ_ID')
    ModifySQL.Strings = (
      'update PROJECT'
      'set'
      '  PROJ_ID = :PROJ_ID,'
      '  PROJ_NAME = :PROJ_NAME'
      'where'
      '  PROJ_ID = :OLD_PROJ_ID')
    ParamCheck = True
    UniDirectional = False
    Left = 48
    Top = 192
    object IBCachedDataSetPROJ_ID: TIBStringField
      FieldName = 'PROJ_ID'
      Origin = 'PROJECT.PROJ_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 5
    end
    object IBCachedDataSetPROJ_NAME: TIBStringField
      FieldName = 'PROJ_NAME'
      Origin = 'PROJECT.PROJ_NAME'
      Required = True
    end
    object IBCachedDataSetUpdateStatus: TStringField
      DisplayWidth = 24
      FieldKind = fkCalculated
      FieldName = 'UpdateStatus'
      Calculated = True
    end
  end
  object IBCachedTable: TIBTable
    Tag = 2
    Database = IBDatabase1
    Transaction = IBTransaction1
    OnCalcFields = IBCachedTableCalcFields
    OnUpdateError = IBCacheQueryUpdateError
    BufferChunks = 1000
    CachedUpdates = True
    FieldDefs = <
      item
        Name = 'PROJ_ID'
        Attributes = [faRequired, faFixed]
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'PROJ_NAME'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'PROJ_DESC'
        DataType = ftMemo
        Size = 8
      end
      item
        Name = 'TEAM_LEADER'
        DataType = ftSmallint
      end
      item
        Name = 'PRODUCT'
        DataType = ftWideString
        Size = 12
      end>
    IndexDefs = <
      item
        Name = 'RDB$11'
        Fields = 'PROJ_NAME'
        Options = [ixUnique]
      end
      item
        Name = 'RDB$PRIMARY12'
        Fields = 'PROJ_ID'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'RDB$FOREIGN13'
        Fields = 'TEAM_LEADER'
      end
      item
        Name = 'PRODTYPEX'
        Fields = 'PRODUCT;PROJ_NAME'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'PROJECT'
    UniDirectional = False
    Left = 48
    Top = 244
    object IBCachedTablePROJ_ID: TIBStringField
      FieldName = 'PROJ_ID'
      Origin = 'PROJECT.PROJ_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 5
    end
    object IBCachedTablePROJ_NAME: TIBStringField
      FieldName = 'PROJ_NAME'
      Origin = 'PROJECT.PROJ_NAME'
      Required = True
    end
    object IBCachedTableUpdateStatus: TStringField
      DisplayWidth = 24
      FieldKind = fkCalculated
      FieldName = 'UpdateStatus'
      Calculated = True
    end
  end
end
