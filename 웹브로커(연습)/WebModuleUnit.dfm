object WebModule8: TWebModule8
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      Producer = HomeProducer
    end
    item
      Name = 'WebActionItem1'
      PathInfo = '/Dept'
      Producer = DeptProducer
      OnAction = WebModule8WebActionItem1Action
    end
    item
      Name = 'WebActionItem2'
      PathInfo = '/Insa'
      OnAction = WebModule8WebActionItem2Action
    end
    item
      Name = 'WebActionItem3'
      PathInfo = '/etc'
      Producer = DataSetPageProducer1
    end>
  Height = 254
  Width = 415
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=sample')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 176
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 304
    Top = 32
  end
  object Dept: TFDTable
    Active = True
    IndexFieldNames = 'CODE'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DEPT'
    TableName = 'DEPT'
    Left = 48
    Top = 104
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
      '===========Dept List====================================')
    DataSet = Dept
    TableAttributes.BgColor = 'Gray'
    TableAttributes.Border = 1
    OnFormatCell = DeptProducerFormatCell
    Left = 136
    Top = 104
  end
  object HomeProducer: TPageProducer
    HTMLFile = 'D:\'#45944#54028#51060#44368#50977#49548#49828'\'#48516#49328#52376#47532'\'#50937#48652#47196#52964'('#50672#49845')\home.htm'
    Left = 304
    Top = 104
  end
  object InsaQuery: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from insa'
      'where dept_code =:code')
    Left = 48
    Top = 176
    ParamData = <
      item
        Name = 'CODE'
        DataType = ftString
        ParamType = ptInput
        Value = 'E001'
      end>
  end
  object InsaProducer: TDataSetTableProducer
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
        FieldName = 'SALARY'
      end>
    DataSet = InsaQuery
    TableAttributes.Border = 1
    Left = 136
    Top = 176
  end
  object DataSetPageProducer1: TDataSetPageProducer
    HTMLDoc.Strings = (
      '<html>'
      '<head>'
      '<title>dept information</title>'
      '</head>'
      '<body>'
      '<p><h2>Team Name:<#section></h2></p>'
      '</body>'
      '</html>')
    DataSet = Dept
    Left = 304
    Top = 184
  end
end
