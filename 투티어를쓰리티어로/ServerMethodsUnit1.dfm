object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 363
  Width = 454
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 176
    Top = 40
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=sample')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 40
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 96
    Top = 40
  end
  object Insa: TFDTable
    Filtered = True
    IndexFieldNames = 'ID'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'INSA'
    TableName = 'INSA'
    Left = 40
    Top = 192
    object InsaID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object InsaNAME: TStringField
      DisplayLabel = #51060#47492
      DisplayWidth = 10
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 10
    end
    object InsaAGE: TSmallintField
      DisplayLabel = #45208#51060
      DisplayWidth = 10
      FieldName = 'AGE'
      Origin = 'AGE'
      MaxValue = 60
      MinValue = 20
    end
    object InsaDEPT_CODE: TStringField
      DisplayLabel = #48512#49436#53076#46300
      DisplayWidth = 8
      FieldName = 'DEPT_CODE'
      Origin = 'DEPT_CODE'
      Size = 4
    end
    object InsaSection: TStringField
      DisplayLabel = #54016#47749
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Section'
      LookupDataSet = Dept
      LookupKeyFields = 'CODE'
      LookupResultField = 'SECTION'
      KeyFields = 'DEPT_CODE'
      Lookup = True
    end
    object InsaIPSA_DATE: TDateField
      DisplayLabel = #51077#49324#51068#51088
      DisplayWidth = 14
      FieldName = 'IPSA_DATE'
      Origin = 'IPSA_DATE'
      DisplayFormat = 'YYYY'#45380'MM'#50900'DD'#51068
    end
    object InsaDuring: TIntegerField
      DisplayLabel = #44540#49549#45380#49688
      FieldKind = fkCalculated
      FieldName = 'During'
      DisplayFormat = '00'#45380
      Calculated = True
    end
    object InsaCLASS: TStringField
      DisplayLabel = #51649#44553
      DisplayWidth = 4
      FieldName = 'CLASS'
      Origin = 'CLASS'
      Size = 4
    end
    object InsaSALARY: TIntegerField
      DisplayLabel = #44553#50668
      DisplayWidth = 14
      FieldName = 'SALARY'
      Origin = 'SALARY'
      DisplayFormat = '#,##0'#50896
    end
    object InsaTax: TFloatField
      DisplayLabel = #49464#44552
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Tax'
      DisplayFormat = '#,##0'#50896
      Calculated = True
    end
    object InsaPHOTO: TBlobField
      DisplayLabel = #49324#51652
      FieldName = 'PHOTO'
      Origin = 'PHOTO'
      Visible = False
    end
    object InsaGRADE: TStringField
      DisplayLabel = #46321#44553
      DisplayWidth = 4
      FieldName = 'GRADE'
      Origin = 'GRADE'
      Size = 1
    end
  end
  object Dept: TFDTable
    Filtered = True
    IndexFieldNames = 'CODE'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DEPT'
    TableName = 'DEPT'
    Left = 40
    Top = 120
  end
  object InsaQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from insa'
      'where dept_code = :code')
    Left = 232
    Top = 120
    ParamData = <
      item
        Name = 'CODE'
        DataType = ftString
        ParamType = ptInput
        Size = 4
      end>
  end
  object DeptProvider: TDataSetProvider
    DataSet = Dept
    Left = 120
    Top = 120
  end
  object InsaProvider: TDataSetProvider
    DataSet = Insa
    Left = 120
    Top = 192
  end
  object InsaQueryProvider: TDataSetProvider
    DataSet = InsaQuery
    Left = 296
    Top = 120
  end
  object Tot_Query: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select count(id) as total'
      'from insa'
      'where dept_code like :code')
    Left = 124
    Top = 312
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
  object FDStoredProc1: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'INSERT_DEPT'
    Left = 48
    Top = 312
    ParamData = <
      item
        Position = 1
        Name = 'PCODE'
        DataType = ftString
        ParamType = ptInput
        Size = 4
      end
      item
        Position = 2
        Name = 'PDEPT'
        DataType = ftString
        ParamType = ptInput
        Size = 6
      end
      item
        Position = 3
        Name = 'PSECTION'
        DataType = ftString
        ParamType = ptInput
        Size = 8
      end>
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 184
    Top = 312
  end
  object DeptQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from dept'
      'order by dept,section')
    Left = 232
    Top = 200
  end
  object DeptQueryProvider: TDataSetProvider
    DataSet = DeptQuery
    Left = 304
    Top = 200
  end
end
