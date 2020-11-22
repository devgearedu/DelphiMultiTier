object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 252
  Width = 380
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=sample')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 152
    Top = 32
  end
  object Dept: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DEPT'
    TableName = 'DEPT'
    Left = 48
    Top = 112
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 264
    Top = 32
  end
  object deptProvider: TDataSetProvider
    DataSet = Dept
    Left = 152
    Top = 112
  end
  object InsaQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from insa'
      'where dept_code =:code')
    Left = 48
    Top = 184
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
  object InsaQueryProvider: TDataSetProvider
    DataSet = InsaQuery
    Left = 152
    Top = 184
  end
  object tot_query: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select  count(id) as total from insa'
      'where dept_code like :code')
    Left = 280
    Top = 112
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
end
