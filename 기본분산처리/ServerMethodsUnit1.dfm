object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 346
  Width = 417
  object totQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select  count(id) as total from insa'
      'where dept_code like :code')
    Left = 272
    Top = 128
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=Sample')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 152
    Top = 40
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 272
    Top = 40
  end
  object DeptProvider: TDataSetProvider
    DataSet = Dept
    Left = 144
    Top = 136
  end
  object Dept: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DEPT'
    TableName = 'DEPT'
    Left = 56
    Top = 136
  end
  object InsaQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from insa'
      'where dept_code =:code')
    Left = 56
    Top = 232
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
  object InsaQueryProviderer: TDataSetProvider
    DataSet = InsaQuery
    Left = 144
    Top = 232
  end
end
