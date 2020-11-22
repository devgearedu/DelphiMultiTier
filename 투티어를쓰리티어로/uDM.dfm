object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 468
  Width = 445
  object InsaQuerySource: TDataSource
    DataSet = insaquery
    Left = 280
    Top = 120
  end
  object DeptSource: TDataSource
    DataSet = Dept
    OnDataChange = DeptSourceDataChange
    Left = 112
    Top = 120
  end
  object InsaSource: TDataSource
    DataSet = insa
    Left = 96
    Top = 184
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    Connected = True
    SQLConnection = fdConnection1
    Left = 160
    Top = 48
  end
  object Dept: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'deptProvider'
    RemoteServer = DSProviderConnection1
    Left = 40
    Top = 120
  end
  object insa: TClientDataSet
    Active = True
    Aggregates = <>
    Constraints = <
      item
        CustomConstraint = 'age >= 20 and  age <= 60'
        ErrorMessage = #45208#48120#48276#50948#44032' '#53952#47549#45768#45796'.'
        FromDictionary = False
      end>
    FieldDefs = <
      item
        Name = 'ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'AGE'
        DataType = ftSmallint
      end
      item
        Name = 'DEPT_CODE'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Section'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IPSA_DATE'
        DataType = ftDate
      end
      item
        Name = 'During'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'CLASS'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'SALARY'
        DataType = ftInteger
      end
      item
        Name = 'Tax'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'PHOTO'
        DataType = ftBlob
      end
      item
        Name = 'GRADE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <
      item
        Name = 'i_id'
        Fields = 'id'
      end
      item
        Name = 'i_name'
        Fields = 'name'
      end
      item
        Name = 'i_dept'
        Fields = 'dept_code'
      end>
    Params = <>
    ProviderName = 'InsaProvider'
    RemoteServer = DSProviderConnection1
    StoreDefs = True
    BeforeInsert = insaBeforeInsert
    OnCalcFields = insaCalcFields
    OnNewRecord = insaNewRecord
    OnReconcileError = insaReconcileError
    Left = 40
    Top = 184
    object insaID: TIntegerField
      Alignment = taCenter
      AutoGenerateValue = arAutoInc
      DisplayLabel = #49324#48264
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object insaNAME: TStringField
      DisplayLabel = #51060#47492
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 10
    end
    object insaAGE: TSmallintField
      Alignment = taCenter
      DisplayLabel = #45208#51060
      FieldName = 'AGE'
      Origin = 'AGE'
    end
    object insaDEPT_CODE: TStringField
      DisplayLabel = #48512#49436#53076#46300
      FieldName = 'DEPT_CODE'
      Origin = 'DEPT_CODE'
      Size = 4
    end
    object insasection: TStringField
      AutoGenerateValue = arAutoInc
      FieldKind = fkLookup
      FieldName = 'section'
      LookupDataSet = Dept
      LookupKeyFields = 'CODE'
      LookupResultField = 'SECTION'
      KeyFields = 'DEPT_CODE'
      Lookup = True
    end
    object insaIPSA_DATE: TDateField
      DisplayLabel = #51077#49324#51068#51088
      FieldName = 'IPSA_DATE'
      Origin = 'IPSA_DATE'
      DisplayFormat = 'yyyy'#45380'mm'#50900'dd'#51068
      EditMask = '!9999/99/00;1;_'
    end
    object insaduring: TIntegerField
      DisplayLabel = #44540#49549#45380#49688
      FieldKind = fkCalculated
      FieldName = 'during'
      DisplayFormat = '0'#45380
      Calculated = True
    end
    object insaCLASS: TStringField
      DisplayLabel = #51649#44553
      FieldName = 'CLASS'
      Origin = 'CLASS'
      Size = 4
    end
    object insaSALARY: TIntegerField
      DisplayLabel = #51077#49324#51068#51088
      FieldName = 'SALARY'
      Origin = 'SALARY'
      DisplayFormat = '#,##'#50896
    end
    object insatax: TFloatField
      DisplayLabel = #49464#44552
      FieldKind = fkCalculated
      FieldName = 'tax'
      DisplayFormat = '#,##0'#50896
      Calculated = True
    end
    object insaPHOTO: TBlobField
      DisplayLabel = #49324#51652
      FieldName = 'PHOTO'
      Origin = 'PHOTO'
      Visible = False
    end
    object insaGRADE: TStringField
      DisplayLabel = #46321#44553
      FieldName = 'GRADE'
      Origin = 'GRADE'
      Size = 1
    end
  end
  object insaquery: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'CODE'
        ParamType = ptInput
        Size = 4
      end>
    ProviderName = 'InsaQueryProvider'
    RemoteServer = DSProviderConnection1
    Left = 232
    Top = 120
  end
  object fdConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DbxDatasnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/')
    Connected = True
    Left = 48
    Top = 48
    UniqueId = '{83CDEC98-ECFC-4766-BE19-0F6E1139C498}'
  end
end
