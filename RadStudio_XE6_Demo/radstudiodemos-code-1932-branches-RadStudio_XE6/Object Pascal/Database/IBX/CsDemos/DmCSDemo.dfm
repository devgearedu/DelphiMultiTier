object DmEmployee: TDmEmployee
  OldCreateOrder = True
  OnCreate = DmEmployeeCreate
  Height = 345
  Width = 456
  object SalesSource: TDataSource
    DataSet = SalesTable
    Left = 32
    Top = 112
  end
  object CustomerSource: TDataSource
    DataSet = CustomerTable
    Left = 128
    Top = 112
  end
  object EmployeeSource: TDataSource
    DataSet = EmployeeTable
    Left = 224
    Top = 112
  end
  object SalaryHistorySource: TDataSource
    DataSet = SalaryHistoryTable
    Left = 328
    Top = 112
  end
  object EmployeeDatabase: TIBDatabase
    Connected = True
    DatabaseName = 
      'localhost:C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samp' +
      'les\Data\EMPLOYEE.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    Left = 40
    Top = 8
  end
  object IBTransaction1: TIBTransaction
    Active = True
    Left = 32
    Top = 168
  end
  object ShipOrderProc: TIBStoredProc
    Database = EmployeeDatabase
    Transaction = IBTransaction1
    StoredProcName = 'SHIP_ORDER'
    Left = 128
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'PO_NUM'
        ParamType = ptInput
      end>
  end
  object DeleteEmployeeProc: TIBStoredProc
    Database = EmployeeDatabase
    Transaction = IBTransaction1
    StoredProcName = 'DELETE_EMPLOYEE'
    Left = 224
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'EMP_NUM'
        ParamType = ptInput
      end>
  end
  object EmployeeLookUp: TIBDataSet
    Database = EmployeeDatabase
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from EMPLOYEE'
      'where'
      '  EMP_NO = :OLD_EMP_NO')
    InsertSQL.Strings = (
      'insert into EMPLOYEE'
      
        '  (DEPT_NO, EMP_NO, FIRST_NAME, HIRE_DATE, JOB_CODE, JOB_COUNTRY' +
        ', JOB_GRADE, '
      '   LAST_NAME, PHONE_EXT, SALARY)'
      'values'
      
        '  (:DEPT_NO, :EMP_NO, :FIRST_NAME, :HIRE_DATE, :JOB_CODE, :JOB_C' +
        'OUNTRY, '
      '   :JOB_GRADE, :LAST_NAME, :PHONE_EXT, :SALARY)')
    RefreshSQL.Strings = (
      'Select '
      '  EMP_NO,'
      '  FIRST_NAME,'
      '  LAST_NAME,'
      '  PHONE_EXT,'
      '  HIRE_DATE,'
      '  DEPT_NO,'
      '  JOB_CODE,'
      '  JOB_GRADE,'
      '  JOB_COUNTRY,'
      '  SALARY,'
      '  FULL_NAME'
      'from EMPLOYEE '
      'where'
      '  EMP_NO = :EMP_NO')
    SelectSQL.Strings = (
      'select * from EMPLOYEE')
    ModifySQL.Strings = (
      'update EMPLOYEE'
      'set'
      '  DEPT_NO = :DEPT_NO,'
      '  EMP_NO = :EMP_NO,'
      '  FIRST_NAME = :FIRST_NAME,'
      '  HIRE_DATE = :HIRE_DATE,'
      '  JOB_CODE = :JOB_CODE,'
      '  JOB_COUNTRY = :JOB_COUNTRY,'
      '  JOB_GRADE = :JOB_GRADE,'
      '  LAST_NAME = :LAST_NAME,'
      '  PHONE_EXT = :PHONE_EXT,'
      '  SALARY = :SALARY'
      'where'
      '  EMP_NO = :OLD_EMP_NO')
    ParamCheck = True
    UniDirectional = False
    Left = 328
    Top = 8
    object EmployeeLookUpEMP_NO: TSmallintField
      FieldName = 'EMP_NO'
      Origin = '"EMPLOYEE"."EMP_NO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object EmployeeLookUpFIRST_NAME: TIBStringField
      FieldName = 'FIRST_NAME'
      Origin = '"EMPLOYEE"."FIRST_NAME"'
      Required = True
      Size = 15
    end
    object EmployeeLookUpLAST_NAME: TIBStringField
      FieldName = 'LAST_NAME'
      Origin = '"EMPLOYEE"."LAST_NAME"'
      Required = True
    end
    object EmployeeLookUpPHONE_EXT: TIBStringField
      FieldName = 'PHONE_EXT'
      Origin = '"EMPLOYEE"."PHONE_EXT"'
      Size = 4
    end
    object EmployeeLookUpHIRE_DATE: TDateTimeField
      FieldName = 'HIRE_DATE'
      Origin = '"EMPLOYEE"."HIRE_DATE"'
    end
    object EmployeeLookUpDEPT_NO: TIBStringField
      FieldName = 'DEPT_NO'
      Origin = '"EMPLOYEE"."DEPT_NO"'
      Required = True
      FixedChar = True
      Size = 3
    end
    object EmployeeLookUpJOB_CODE: TIBStringField
      FieldName = 'JOB_CODE'
      Origin = '"EMPLOYEE"."JOB_CODE"'
      Required = True
      Size = 5
    end
    object EmployeeLookUpJOB_GRADE: TSmallintField
      FieldName = 'JOB_GRADE'
      Origin = '"EMPLOYEE"."JOB_GRADE"'
      Required = True
    end
    object EmployeeLookUpJOB_COUNTRY: TIBStringField
      FieldName = 'JOB_COUNTRY'
      Origin = '"EMPLOYEE"."JOB_COUNTRY"'
      Required = True
      Size = 15
    end
    object EmployeeLookUpSALARY: TIBBCDField
      FieldName = 'SALARY'
      Origin = '"EMPLOYEE"."SALARY"'
      Precision = 10
      Size = 2
    end
    object EmployeeLookUpFULL_NAME: TIBStringField
      FieldKind = fkInternalCalc
      FieldName = 'FULL_NAME'
      Origin = '"EMPLOYEE"."FULL_NAME"'
      ProviderFlags = []
      ReadOnly = True
      Size = 37
    end
  end
  object SalesTable: TIBDataSet
    Database = EmployeeDatabase
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from SALES'
      'where'
      '  PO_NUMBER = :OLD_PO_NUMBER')
    InsertSQL.Strings = (
      'insert into SALES'
      
        '  (CUST_NO, DATE_NEEDED, DISCOUNT, ITEM_TYPE, ORDER_DATE, ORDER_' +
        'STATUS, '
      
        '   PAID, PO_NUMBER, QTY_ORDERED, SALES_REP, SHIP_DATE, TOTAL_VAL' +
        'UE)'
      'values'
      
        '  (:CUST_NO, :DATE_NEEDED, :DISCOUNT, :ITEM_TYPE, :ORDER_DATE, :' +
        'ORDER_STATUS, '
      
        '   :PAID, :PO_NUMBER, :QTY_ORDERED, :SALES_REP, :SHIP_DATE, :TOT' +
        'AL_VALUE)')
    RefreshSQL.Strings = (
      'Select '
      '  PO_NUMBER,'
      '  CUST_NO,'
      '  SALES_REP,'
      '  ORDER_STATUS,'
      '  ORDER_DATE,'
      '  SHIP_DATE,'
      '  DATE_NEEDED,'
      '  PAID,'
      '  QTY_ORDERED,'
      '  TOTAL_VALUE,'
      '  DISCOUNT,'
      '  ITEM_TYPE,'
      '  AGED'
      'from SALES '
      'where'
      '  PO_NUMBER = :PO_NUMBER')
    SelectSQL.Strings = (
      'select *  from SALES')
    ModifySQL.Strings = (
      'update SALES'
      'set'
      '  CUST_NO = :CUST_NO,'
      '  DATE_NEEDED = :DATE_NEEDED,'
      '  DISCOUNT = :DISCOUNT,'
      '  ITEM_TYPE = :ITEM_TYPE,'
      '  ORDER_DATE = :ORDER_DATE,'
      '  ORDER_STATUS = :ORDER_STATUS,'
      '  PAID = :PAID,'
      '  PO_NUMBER = :PO_NUMBER,'
      '  QTY_ORDERED = :QTY_ORDERED,'
      '  SALES_REP = :SALES_REP,'
      '  SHIP_DATE = :SHIP_DATE,'
      '  TOTAL_VALUE = :TOTAL_VALUE'
      'where'
      '  PO_NUMBER = :OLD_PO_NUMBER')
    ParamCheck = True
    UniDirectional = False
    Left = 32
    Top = 64
  end
  object EmployeeTable: TIBDataSet
    Database = EmployeeDatabase
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from EMPLOYEE'
      'where'
      '  EMP_NO = :OLD_EMP_NO')
    InsertSQL.Strings = (
      'insert into EMPLOYEE'
      
        '  (DEPT_NO, EMP_NO, FIRST_NAME, HIRE_DATE, JOB_CODE, JOB_COUNTRY' +
        ', JOB_GRADE, '
      '   LAST_NAME, PHONE_EXT, SALARY)'
      'values'
      
        '  (:DEPT_NO, :EMP_NO, :FIRST_NAME, :HIRE_DATE, :JOB_CODE, :JOB_C' +
        'OUNTRY, '
      '   :JOB_GRADE, :LAST_NAME, :PHONE_EXT, :SALARY)')
    RefreshSQL.Strings = (
      'Select '
      '  EMP_NO,'
      '  FIRST_NAME,'
      '  LAST_NAME,'
      '  PHONE_EXT,'
      '  HIRE_DATE,'
      '  DEPT_NO,'
      '  JOB_CODE,'
      '  JOB_GRADE,'
      '  JOB_COUNTRY,'
      '  SALARY,'
      '  FULL_NAME'
      'from EMPLOYEE '
      'where'
      '  EMP_NO = :EMP_NO')
    SelectSQL.Strings = (
      'select * from EMPLOYEE')
    ModifySQL.Strings = (
      'update EMPLOYEE'
      'set'
      '  DEPT_NO = :DEPT_NO,'
      '  EMP_NO = :EMP_NO,'
      '  FIRST_NAME = :FIRST_NAME,'
      '  HIRE_DATE = :HIRE_DATE,'
      '  JOB_CODE = :JOB_CODE,'
      '  JOB_COUNTRY = :JOB_COUNTRY,'
      '  JOB_GRADE = :JOB_GRADE,'
      '  LAST_NAME = :LAST_NAME,'
      '  PHONE_EXT = :PHONE_EXT,'
      '  SALARY = :SALARY'
      'where'
      '  EMP_NO = :OLD_EMP_NO')
    ParamCheck = True
    UniDirectional = False
    Left = 128
    Top = 64
  end
  object CustomerTable: TIBDataSet
    Database = EmployeeDatabase
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from CUSTOMER'
      'where'
      '  CUST_NO = :OLD_CUST_NO')
    InsertSQL.Strings = (
      'insert into CUSTOMER'
      
        '  (ADDRESS_LINE1, ADDRESS_LINE2, CITY, CONTACT_FIRST, CONTACT_LA' +
        'ST, COUNTRY, '
      
        '   CUST_NO, CUSTOMER, ON_HOLD, PHONE_NO, POSTAL_CODE, STATE_PROV' +
        'INCE)'
      'values'
      
        '  (:ADDRESS_LINE1, :ADDRESS_LINE2, :CITY, :CONTACT_FIRST, :CONTA' +
        'CT_LAST, '
      
        '   :COUNTRY, :CUST_NO, :CUSTOMER, :ON_HOLD, :PHONE_NO, :POSTAL_C' +
        'ODE, :STATE_PROVINCE)')
    RefreshSQL.Strings = (
      'Select '
      '  CUST_NO,'
      '  CUSTOMER,'
      '  CONTACT_FIRST,'
      '  CONTACT_LAST,'
      '  PHONE_NO,'
      '  ADDRESS_LINE1,'
      '  ADDRESS_LINE2,'
      '  CITY,'
      '  STATE_PROVINCE,'
      '  COUNTRY,'
      '  POSTAL_CODE,'
      '  ON_HOLD'
      'from CUSTOMER '
      'where'
      '  CUST_NO = :CUST_NO')
    SelectSQL.Strings = (
      'select * from CUSTOMER'
      'WHERE CUST_NO = :CUST_NO')
    ModifySQL.Strings = (
      'update CUSTOMER'
      'set'
      '  ADDRESS_LINE1 = :ADDRESS_LINE1,'
      '  ADDRESS_LINE2 = :ADDRESS_LINE2,'
      '  CITY = :CITY,'
      '  CONTACT_FIRST = :CONTACT_FIRST,'
      '  CONTACT_LAST = :CONTACT_LAST,'
      '  COUNTRY = :COUNTRY,'
      '  CUST_NO = :CUST_NO,'
      '  CUSTOMER = :CUSTOMER,'
      '  ON_HOLD = :ON_HOLD,'
      '  PHONE_NO = :PHONE_NO,'
      '  POSTAL_CODE = :POSTAL_CODE,'
      '  STATE_PROVINCE = :STATE_PROVINCE'
      'where'
      '  CUST_NO = :OLD_CUST_NO')
    ParamCheck = True
    UniDirectional = False
    DataSource = SalesSource
    Left = 224
    Top = 64
  end
  object SalaryHistoryTable: TIBDataSet
    Database = EmployeeDatabase
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from SALARY_HISTORY'
      'where'
      '  EMP_NO = :OLD_EMP_NO')
    InsertSQL.Strings = (
      'insert into SALARY_HISTORY'
      '  (CHANGE_DATE, EMP_NO, OLD_SALARY, PERCENT_CHANGE, UPDATER_ID)'
      'values'
      
        '  (:CHANGE_DATE, :EMP_NO, :OLD_SALARY, :PERCENT_CHANGE, :UPDATER' +
        '_ID)')
    RefreshSQL.Strings = (
      'Select '
      '  EMP_NO,'
      '  CHANGE_DATE,'
      '  UPDATER_ID,'
      '  OLD_SALARY,'
      '  PERCENT_CHANGE,'
      '  NEW_SALARY'
      'from SALARY_HISTORY '
      'where'
      '  EMP_NO = :EMP_NO')
    SelectSQL.Strings = (
      'select * from SALARY_HISTORY'
      'WHERE EMP_NO=:EMP_NO')
    ModifySQL.Strings = (
      'update SALARY_HISTORY'
      'set'
      '  CHANGE_DATE = :CHANGE_DATE,'
      '  EMP_NO = :EMP_NO,'
      '  OLD_SALARY = :OLD_SALARY,'
      '  PERCENT_CHANGE = :PERCENT_CHANGE,'
      '  UPDATER_ID = :UPDATER_ID'
      'where'
      '  EMP_NO = :OLD_EMP_NO')
    ParamCheck = True
    UniDirectional = False
    DataSource = EmployeeSource
    Left = 328
    Top = 64
  end
end
