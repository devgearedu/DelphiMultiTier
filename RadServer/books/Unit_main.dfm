object BooksResource1: TBooksResource1
  OldCreateOrder = False
  Height = 271
  Width = 365
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\RadServer\BOOKRENTAL.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object QryBook: TFDQuery
    Connection = FDConnection1
    Left = 176
    Top = 32
  end
end
