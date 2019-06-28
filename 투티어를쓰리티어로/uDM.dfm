object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 468
  Width = 445
  object InsaQuerySource: TDataSource
    DataSet = InsaQuery
    Left = 232
    Top = 120
  end
  object DeptSource: TDataSource
    DataSet = Dept
    OnDataChange = DeptSourceDataChange
    Left = 96
    Top = 120
  end
  object InsaSource: TDataSource
    DataSet = Insa
    Left = 96
    Top = 184
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b')
    Connected = True
    Left = 48
    Top = 40
    UniqueId = '{229AA74F-A227-4BFC-A5E4-B6486C7E315F}'
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    Connected = True
    SQLConnection = SQLConnection1
    Left = 160
    Top = 40
  end
  object Dept: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DeptProvider'
    RemoteServer = DSProviderConnection1
    Left = 40
    Top = 120
  end
  object Insa: TClientDataSet
    Active = True
    Aggregates = <>
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
    BeforeInsert = InsaBeforeInsert
    OnCalcFields = InsaCalcFields
    OnNewRecord = InsaNewRecord
    OnReconcileError = InsaReconcileError
    AfterApplyUpdates = InsaAfterApplyUpdates
    Left = 40
    Top = 184
    object InsaID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = ' '#49324#48264
      DisplayWidth = 10
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
      DisplayWidth = 13
      FieldName = 'Section'
      ReadOnly = True
    end
    object InsaIPSA_DATE: TDateField
      DisplayLabel = #51077#49324#51068#51088
      DisplayWidth = 21
      FieldName = 'IPSA_DATE'
      Origin = 'IPSA_DATE'
      DisplayFormat = 'yyyy'#45380'mm'#50900'dd'#51068
      EditMask = '!9999/99/00;1;_'
    end
    object InsaDuring: TIntegerField
      DisplayLabel = #44592#44036
      DisplayWidth = 10
      FieldName = 'During'
      ReadOnly = True
    end
    object InsaCLASS: TStringField
      DisplayLabel = #51649#44553
      DisplayWidth = 4
      FieldName = 'CLASS'
      Origin = 'CLASS'
      Size = 4
    end
    object InsaTax: TFloatField
      DisplayLabel = #49464#44552
      DisplayWidth = 10
      FieldName = 'Tax'
      ReadOnly = True
      DisplayFormat = '#,##0'#50896
    end
    object InsaSALARY: TIntegerField
      DisplayLabel = #44553#50668
      DisplayWidth = 15
      FieldName = 'SALARY'
      Origin = 'SALARY'
      DisplayFormat = '#,##0'#50896
    end
    object InsaPHOTO: TBlobField
      DisplayLabel = #49324#51652
      DisplayWidth = 10
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
  object InsaQuery: TClientDataSet
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
    Left = 184
    Top = 120
  end
end
