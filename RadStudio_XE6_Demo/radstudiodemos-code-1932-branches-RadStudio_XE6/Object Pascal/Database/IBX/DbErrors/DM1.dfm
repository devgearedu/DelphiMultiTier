object DM: TDM
  OldCreateOrder = True
  Height = 339
  Width = 445
  object CustomerSource: TDataSource
    DataSet = Customer
    Left = 81
    Top = 8
  end
  object OrdersSource: TDataSource
    DataSet = Orders
    Left = 81
    Top = 70
  end
  object ItemsSource: TDataSource
    DataSet = Items
    Left = 81
    Top = 130
  end
  object Database: TIBDatabase
    Connected = True
    DatabaseName = 
      'localhost:C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samp' +
      'les\Data\MASTSQL.GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    Left = 16
    Top = 192
  end
  object IBTransaction1: TIBTransaction
    Active = True
    Left = 80
    Top = 192
  end
  object Customer: TIBDataSet
    Database = Database
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from CUSTOMER'
      'where'
      '  CUSTNO = :OLD_CUSTNO')
    InsertSQL.Strings = (
      'insert into CUSTOMER'
      
        '  (ADDR1, ADDR2, CITY, COMPANY, CONTACT, COUNTRY, CUSTNO, FAX, L' +
        'ASTINVOICEDATE, '
      '   PHONE, STATE, TAXRATE, ZIP)'
      'values'
      
        '  (:ADDR1, :ADDR2, :CITY, :COMPANY, :CONTACT, :COUNTRY, :CUSTNO,' +
        ' :FAX, '
      '   :LASTINVOICEDATE, :PHONE, :STATE, :TAXRATE, :ZIP)')
    RefreshSQL.Strings = (
      'Select '
      '  CUSTNO,'
      '  COMPANY,'
      '  ADDR1,'
      '  ADDR2,'
      '  CITY,'
      '  STATE,'
      '  ZIP,'
      '  COUNTRY,'
      '  PHONE,'
      '  FAX,'
      '  TAXRATE,'
      '  CONTACT,'
      '  LASTINVOICEDATE'
      'from CUSTOMER '
      'where'
      '  CUSTNO = :CUSTNO')
    SelectSQL.Strings = (
      'select * from CUSTOMER')
    ModifySQL.Strings = (
      'update CUSTOMER'
      'set'
      '  ADDR1 = :ADDR1,'
      '  ADDR2 = :ADDR2,'
      '  CITY = :CITY,'
      '  COMPANY = :COMPANY,'
      '  CONTACT = :CONTACT,'
      '  COUNTRY = :COUNTRY,'
      '  CUSTNO = :CUSTNO,'
      '  FAX = :FAX,'
      '  LASTINVOICEDATE = :LASTINVOICEDATE,'
      '  PHONE = :PHONE,'
      '  STATE = :STATE,'
      '  TAXRATE = :TAXRATE,'
      '  ZIP = :ZIP'
      'where'
      '  CUSTNO = :OLD_CUSTNO')
    ParamCheck = True
    UniDirectional = False
    Active = True
    Left = 16
    Top = 8
  end
  object Orders: TIBDataSet
    Database = Database
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from ORDERS'
      'where'
      '  ORDERNO = :OLD_ORDERNO')
    InsertSQL.Strings = (
      'insert into ORDERS'
      
        '  (AMOUNTPAID, CUSTNO, EMPNO, FREIGHT, ITEMSTOTAL, ORDERNO, PAYM' +
        'ENTMETHOD, '
      
        '   PO, SALEDATE, SHIPDATE, SHIPTOADDR1, SHIPTOADDR2, SHIPTOCITY,' +
        ' SHIPTOCONTACT, '
      
        '   SHIPTOCOUNTRY, SHIPTOPHONE, SHIPTOSTATE, SHIPTOZIP, SHIPVIA, ' +
        'TAXRATE, '
      '   TERMS)'
      'values'
      
        '  (:AMOUNTPAID, :CUSTNO, :EMPNO, :FREIGHT, :ITEMSTOTAL, :ORDERNO' +
        ', :PAYMENTMETHOD, '
      
        '   :PO, :SALEDATE, :SHIPDATE, :SHIPTOADDR1, :SHIPTOADDR2, :SHIPT' +
        'OCITY, '
      
        '   :SHIPTOCONTACT, :SHIPTOCOUNTRY, :SHIPTOPHONE, :SHIPTOSTATE, :' +
        'SHIPTOZIP, '
      '   :SHIPVIA, :TAXRATE, :TERMS)')
    RefreshSQL.Strings = (
      'Select '
      '  ORDERNO,'
      '  CUSTNO,'
      '  SALEDATE,'
      '  SHIPDATE,'
      '  EMPNO,'
      '  SHIPTOCONTACT,'
      '  SHIPTOADDR1,'
      '  SHIPTOADDR2,'
      '  SHIPTOCITY,'
      '  SHIPTOSTATE,'
      '  SHIPTOZIP,'
      '  SHIPTOCOUNTRY,'
      '  SHIPTOPHONE,'
      '  SHIPVIA,'
      '  PO,'
      '  TERMS,'
      '  PAYMENTMETHOD,'
      '  ITEMSTOTAL,'
      '  TAXRATE,'
      '  FREIGHT,'
      '  AMOUNTPAID'
      'from ORDERS '
      'where'
      '  ORDERNO = :ORDERNO')
    SelectSQL.Strings = (
      'select * from ORDERS')
    ModifySQL.Strings = (
      'update ORDERS'
      'set'
      '  AMOUNTPAID = :AMOUNTPAID,'
      '  CUSTNO = :CUSTNO,'
      '  EMPNO = :EMPNO,'
      '  FREIGHT = :FREIGHT,'
      '  ITEMSTOTAL = :ITEMSTOTAL,'
      '  ORDERNO = :ORDERNO,'
      '  PAYMENTMETHOD = :PAYMENTMETHOD,'
      '  PO = :PO,'
      '  SALEDATE = :SALEDATE,'
      '  SHIPDATE = :SHIPDATE,'
      '  SHIPTOADDR1 = :SHIPTOADDR1,'
      '  SHIPTOADDR2 = :SHIPTOADDR2,'
      '  SHIPTOCITY = :SHIPTOCITY,'
      '  SHIPTOCONTACT = :SHIPTOCONTACT,'
      '  SHIPTOCOUNTRY = :SHIPTOCOUNTRY,'
      '  SHIPTOPHONE = :SHIPTOPHONE,'
      '  SHIPTOSTATE = :SHIPTOSTATE,'
      '  SHIPTOZIP = :SHIPTOZIP,'
      '  SHIPVIA = :SHIPVIA,'
      '  TAXRATE = :TAXRATE,'
      '  TERMS = :TERMS'
      'where'
      '  ORDERNO = :OLD_ORDERNO')
    ParamCheck = True
    UniDirectional = False
    Active = True
    Left = 16
    Top = 72
  end
  object Items: TIBDataSet
    Database = Database
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from ITEMS'
      'where'
      '  ITEMNO = :OLD_ITEMNO and'
      '  ORDERNO = :OLD_ORDERNO')
    InsertSQL.Strings = (
      'insert into ITEMS'
      '  (DISCOUNT, ITEMNO, ORDERNO, PARTNO, QTY)'
      'values'
      '  (:DISCOUNT, :ITEMNO, :ORDERNO, :PARTNO, :QTY)')
    RefreshSQL.Strings = (
      'Select '
      '  ITEMNO,'
      '  ORDERNO,'
      '  PARTNO,'
      '  QTY,'
      '  DISCOUNT'
      'from ITEMS '
      'where'
      '  ITEMNO = :ITEMNO and'
      '  ORDERNO = :ORDERNO')
    SelectSQL.Strings = (
      'select * from ITEMS')
    ModifySQL.Strings = (
      'update ITEMS'
      'set'
      '  DISCOUNT = :DISCOUNT,'
      '  ITEMNO = :ITEMNO,'
      '  ORDERNO = :ORDERNO,'
      '  PARTNO = :PARTNO,'
      '  QTY = :QTY'
      'where'
      '  ITEMNO = :OLD_ITEMNO and'
      '  ORDERNO = :OLD_ORDERNO')
    ParamCheck = True
    UniDirectional = False
    Active = True
    Left = 16
    Top = 128
  end
end
