object DM: TDM
  OldCreateOrder = False
  Height = 311
  Width = 471
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/books'
    ContentType = 'application/json'
    Params = <>
    Left = 264
    Top = 256
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body5F4F5CE0A2894CCAAD9090E64826B513'
        Value = 
          '{'#13#10#13#10'  "book":'#13#10#13#10'  {'#13#10#13#10'    "BOOK_TITLE":"???'#35029'????'#29788#44280#51239'",'#13#10#13#10'    ' +
          '"BOOK_ISBN":"1234567890123",'#13#10#13#10'    "BOOK_AUTHOR":"???'#45433#52664'??,'#13#10#13#10' ' +
          '   "BOOK_PRICE":"10000",'#13#10#13#10'    "BOOK_LINK":"",'#13#10#13#10'    "BOOK_DES' +
          'CRIPTION":"12345."'#13#10#13#10'  }'#13#10#13#10'}'
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse
    Left = 376
    Top = 256
  end
  object RESTResponse: TRESTResponse
    RootElement = 'books.book'
    Left = 376
    Top = 184
  end
  object RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter
    Dataset = BookList
    FieldDefs = <>
    Response = RESTResponse
    Left = 376
    Top = 120
  end
  object BookList: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 376
    Top = 48
  end
end
