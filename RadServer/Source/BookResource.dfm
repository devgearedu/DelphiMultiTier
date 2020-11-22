object BooksResource1: TBooksResource1
  OldCreateOrder = False
  Height = 300
  Width = 600
  object ConBookRental: TFDConnection
    Params.Strings = (
      'Database=E:\'#50728#46972#51064#44368#50977'\202010'#50900'_'#50952#46020#50864#44284#51221'\'#48516#49328#52376#47532'\RadServer\DB\BOOKRENTAL.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    LoginPrompt = False
    BeforeConnect = ConBookRentalBeforeConnect
    Left = 64
    Top = 40
  end
  object qryBook: TFDQuery
    Connection = ConBookRental
    Left = 296
    Top = 40
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 168
    Top = 40
  end
  object BookQuery: TFDQuery
    Connection = ConBookRental
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from book')
    Left = 296
    Top = 128
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 304
    Top = 216
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 400
    Top = 128
  end
end
