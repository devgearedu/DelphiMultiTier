object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 282
  Width = 441
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=Sample')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 32
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 160
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 264
    Top = 32
  end
  object Dept: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DEPT'
    TableName = 'DEPT'
    Left = 56
    Top = 128
  end
  object DeptProvider: TDataSetProvider
    DataSet = Dept
    Left = 136
    Top = 128
  end
  object InsaQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from insa'
      'where dept_code =:code')
    Left = 56
    Top = 216
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
  object InsaQueryProvider: TDataSetProvider
    DataSet = InsaQuery
    Left = 144
    Top = 216
  end
  object tot_query: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select count(id) as total'
      'from insa'
      'where dept_code like :code')
    Left = 264
    Top = 128
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
end
