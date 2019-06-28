object Dm: TDm
  OldCreateOrder = False
  Height = 322
  Width = 471
  object CustTemp_Source: TDataSource
    DataSet = CustTemp
    Left = 224
    Top = 8
  end
  object curritb_Source: TDataSource
    DataSet = curritb
    Left = 224
    Top = 80
  end
  object Curri_Source: TDataSource
    DataSet = Curri
    Left = 224
    Top = 152
  end
  object Customer_Source: TDataSource
    DataSet = Customer
    Left = 232
    Top = 224
  end
  object currilist_Source: TDataSource
    DataSet = query_CurriList
    Left = 368
    Top = 8
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Book_SampleDB\PROJECTDB.IB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 32
    Top = 72
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 32
    Top = 128
  end
  object CustTemp: TFDTable
    Active = True
    IndexFieldNames = 'CTCODE;PNO'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'CUSTTEMP'
    TableName = 'CUSTTEMP'
    Left = 152
    Top = 16
  end
  object curritb: TFDTable
    Active = True
    IndexFieldNames = 'CTCODE'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'CURRITB'
    TableName = 'CURRITB'
    Left = 152
    Top = 80
  end
  object Curri: TFDTable
    Active = True
    OnCalcFields = CurriCalcFields
    IndexFieldNames = 'CODE'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'CURRI'
    TableName = 'CURRI'
    Left = 152
    Top = 160
    object CurriCODE: TStringField
      FieldName = 'CODE'
      Origin = 'CODE'
      Required = True
      FixedChar = True
      Size = 2
    end
    object CurriKIND: TStringField
      FieldName = 'KIND'
      Origin = 'KIND'
    end
    object CurriNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
    end
    object CurriLOGO: TBlobField
      FieldName = 'LOGO'
      Origin = 'LOGO'
    end
    object CurriKind_Name: TStringField
      FieldKind = fkCalculated
      FieldName = 'Kind_Name'
      Calculated = True
    end
  end
  object Customer: TFDTable
    Active = True
    IndexFieldNames = 'CUSTNO'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'CUSTOMER'
    TableName = 'CUSTOMER'
    Left = 152
    Top = 224
    object CustomerCUSTNO: TStringField
      DisplayLabel = #44256#44061#48264#54840
      FieldName = 'CUSTNO'
      Origin = 'CUSTNO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 7
    end
    object CustomerNAME: TStringField
      DisplayLabel = #51060#47492
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 10
    end
    object CustomerPNO: TStringField
      DisplayLabel = #51452#48124#46321#47197#48264#54840
      FieldName = 'PNO'
      Origin = 'PNO'
      FixedChar = True
      Size = 13
    end
    object CustomerTEL: TStringField
      DisplayLabel = #51204#54868#48264#54840
      FieldName = 'TEL'
      Origin = 'TEL'
      Size = 15
    end
    object CustomerADDR: TStringField
      DisplayLabel = #51452#49548
      FieldName = 'ADDR'
      Origin = 'ADDR'
      Size = 50
    end
    object CustomerCOMPANY: TStringField
      DisplayLabel = #54868#49324#47749
      FieldName = 'COMPANY'
      Origin = 'COMPANY'
      Size = 30
    end
    object CustomerCCODE: TStringField
      DisplayLabel = #49324#50629#51088#46321#47197#48264#54840
      FieldName = 'CCODE'
      Origin = 'CCODE'
      Size = 10
    end
    object CustomerCBOSS: TStringField
      DisplayLabel = #54924#49324#45824#54364#51060#47492
      FieldName = 'CBOSS'
      Origin = 'CBOSS'
      Size = 10
    end
    object CustomerCADDR: TStringField
      DisplayLabel = #54924#49324#51452#49548
      FieldName = 'CADDR'
      Origin = 'CADDR'
      Size = 50
    end
    object CustomerCTEL: TStringField
      DisplayLabel = #54924#49324#51204#54868#48264#54840
      FieldName = 'CTEL'
      Origin = 'CTEL'
      Size = 15
    end
    object CustomerCFAX: TStringField
      DisplayLabel = #54924#49324#54057#49828#48264#54840
      FieldName = 'CFAX'
      Origin = 'CFAX'
      Size = 15
    end
    object CustomerEMAIL: TStringField
      DisplayLabel = #51060#47700#51068#51452#49548
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 30
    end
  end
  object query_CurriList: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'Select * From curritb'
      'where (ctcode like :p_code) and'
      '(start >= :p_date1) and (start <= :p_date2)')
    Left = 304
    Top = 8
    ParamData = <
      item
        Name = 'P_CODE'
        DataType = ftString
        ParamType = ptInput
        Size = 5
      end
      item
        Name = 'P_DATE1'
        DataType = ftTimeStamp
        ParamType = ptInput
      end
      item
        Name = 'P_DATE2'
        DataType = ftTimeStamp
        ParamType = ptInput
      end>
  end
  object Orders: TFDTable
    Active = True
    IndexName = 'CTCODE_CUSTNO_IDX'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'ORDERS'
    TableName = 'ORDERS'
    Left = 304
    Top = 72
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 32
    Top = 200
  end
end
