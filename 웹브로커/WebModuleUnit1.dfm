object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      Producer = HomeProducer
    end
    item
      Name = 'DeptActionItem'
      PathInfo = '/Dept'
      Producer = DeptProducer
    end
    item
      Name = 'InsaActionItem'
      PathInfo = '/Insa'
      OnAction = WebModule1InsaActionItemAction
    end
    item
      Name = 'WebActionItem1'
      PathInfo = '/etc'
      Producer = DataSetPageProducer1
    end
    item
      Name = 'WebActionItem2'
      PathInfo = '/Inform'
      OnAction = WebModule1WebActionItem2Action
    end>
  Height = 284
  Width = 485
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=sample')
    Connected = True
    LoginPrompt = False
    Left = 56
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
    Active = True
    IndexFieldNames = 'CODE'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DEPT'
    TableName = 'DEPT'
    Left = 56
    Top = 120
  end
  object DeptProducer: TDataSetTableProducer
    Columns = <
      item
        FieldName = 'CODE'
      end
      item
        FieldName = 'DEPT'
      end
      item
        FieldName = 'SECTION'
      end>
    Header.Strings = (
      '============ Dept List ===================================')
    MaxRows = 5
    DataSet = Dept
    TableAttributes.BgColor = 'Silver'
    TableAttributes.Border = 1
    OnFormatCell = DeptProducerFormatCell
    Left = 168
    Top = 120
  end
  object HomeProducer: TPageProducer
    HTMLFile = 'E:\'#50728#46972#51064#44368#50977'\202010'#50900'_'#50952#46020#50864#44284#51221'\'#48516#49328#52376#47532'\'#50937#48652#47196#52964'\home.htm'
    Left = 280
    Top = 120
  end
  object InsaQuery: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from insa'
      'where dept_code =:code')
    Left = 56
    Top = 184
    ParamData = <
      item
        Name = 'CODE'
        DataType = ftString
        ParamType = ptInput
        Value = 'C001'
      end>
    object InsaQueryID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object InsaQueryNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
    end
    object InsaQueryAGE: TSmallintField
      FieldName = 'AGE'
      Origin = 'AGE'
    end
    object InsaQueryDEPT_CODE: TStringField
      FieldName = 'DEPT_CODE'
      Origin = 'DEPT_CODE'
      Required = True
      Size = 4
    end
    object InsaQueryCLASS: TStringField
      FieldName = 'CLASS'
      Origin = 'CLASS'
      Size = 4
    end
    object InsaQueryIPSA_DATE: TDateField
      DisplayWidth = 20
      FieldName = 'IPSA_DATE'
      Origin = 'IPSA_DATE'
      DisplayFormat = 'yyyy'#45380'mm'#50900'dd'#51068
    end
    object InsaQuerySALARY: TIntegerField
      DisplayLabel = #44553#50668
      FieldName = 'SALARY'
      Origin = 'SALARY'
      DisplayFormat = '#,##0'#50896
    end
    object InsaQueryPHOTO: TBlobField
      FieldName = 'PHOTO'
      Origin = 'PHOTO'
    end
    object InsaQueryGRADE: TStringField
      FieldName = 'GRADE'
      Origin = 'GRADE'
      Size = 1
    end
  end
  object InsaQueryProducer: TDataSetTableProducer
    Columns = <
      item
        FieldName = 'NAME'
      end
      item
        FieldName = 'AGE'
      end
      item
        FieldName = 'DEPT_CODE'
      end
      item
        FieldName = 'CLASS'
      end
      item
        FieldName = 'IPSA_DATE'
      end
      item
        Align = haRight
        FieldName = 'SALARY'
      end>
    DataSet = InsaQuery
    TableAttributes.Border = 1
    OnFormatCell = InsaQueryProducerFormatCell
    Left = 168
    Top = 184
  end
  object DataSetPageProducer1: TDataSetPageProducer
    HTMLDoc.Strings = (
      '<html>'
      '<head>'
      '<title> Dept Information </title>'
      '</head>'
      '<body>'
      '<p><h2>Code: <#code></h2><p>'
      '<table border =0>'
      '<tr>'
      '<td><b>Dept: <b></td>'
      '<td><#dept></td>'
      '</tr>'
      '<tr>'
      '<td><b>Section: <b></td>'
      '<td><#section></td>'
      '</tr>'
      '</table>'
      '</body>'
      '</html>')
    DataSet = Dept
    Left = 288
    Top = 192
  end
  object InsaInformProducer: TDataSetPageProducer
    HTMLDoc.Strings = (
      '<html>'
      '<head>'
      '<title> Insa Information </title>'
      '</head>'
      '<body>'
      '<p><h2>Name: <#name></h2><p>'
      '<table border =0>'
      '<tr>'
      '<td><b>Age: <b></td>'
      '<td><#Age></td>'
      '</tr>'
      '<tr>'
      '<td><b>Dept_Code: <b></td>'
      '<td><#Dept_Code></td>'
      '</tr>'
      '<tr>'
      '<td><b>class: <b></td>'
      '<td><#class></td>'
      '</tr>'
      '<tr>'
      '<td><b>ipsa_date: <b></td>'
      '<td><#ipsa_date></td>'
      '</tr>'
      '<tr>'
      '<td><b>salary: <b></td>'
      '<td><#salary></td>'
      '</tr>'
      '</table>'
      '</body>'
      '</html>')
    DataSet = InsaQuery
    Left = 408
    Top = 192
  end
end
