object dmDataAccess: TdmDataAccess
  OldCreateOrder = False
  Height = 334
  Width = 518
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/'
    Params = <>
    Left = 32
    Top = 24
  end
  object reqList: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'books'
    Response = resList
    SynchronizedEvents = False
    Left = 32
    Top = 88
  end
  object resList: TRESTResponse
    ContentType = 'application/json'
    Left = 152
    Top = 88
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = memBookList
    FieldDefs = <>
    Response = resList
    RootElement = 'books.book'
    Left = 272
    Top = 88
  end
  object memBookList: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'BOOK_SEQ'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'BOOK_TITLE'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'BOOK_AUTHOR'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'BOOK_PRICE'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 424
    Top = 88
  end
  object reqDetail: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'item'
        Options = [poAutoCreated]
        Value = '15'
      end>
    Resource = 'books/{item}/'
    Response = rspDetail
    SynchronizedEvents = False
    Left = 32
    Top = 160
  end
  object rspDetail: TRESTResponse
    ContentType = 'application/json'
    Left = 152
    Top = 160
  end
  object RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter
    Active = True
    Dataset = memBookDetail
    FieldDefs = <>
    Response = rspDetail
    RootElement = 'book'
    Left = 272
    Top = 160
  end
  object memBookDetail: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'BOOK_SEQ'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'BOOK_TITLE'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'BOOK_ISBN'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'BOOK_AUTHOR'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'BOOK_PRICE'
        DataType = ftInteger
      end
      item
        Name = 'BOOK_LINK'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'BOOK_DESCRIPTION'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 424
    Top = 160
    object memBookDetailBOOK_SEQ: TWideStringField
      FieldName = 'BOOK_SEQ'
      Size = 255
    end
    object memBookDetailBOOK_TITLE: TWideStringField
      FieldName = 'BOOK_TITLE'
      Size = 255
    end
    object memBookDetailBOOK_ISBN: TWideStringField
      FieldName = 'BOOK_ISBN'
      Size = 255
    end
    object memBookDetailBOOK_AUTHOR: TWideStringField
      FieldName = 'BOOK_AUTHOR'
      Size = 255
    end
    object memBookDetailBOOK_PRICE: TIntegerField
      FieldName = 'BOOK_PRICE'
      DisplayFormat = '#,#'
    end
    object memBookDetailBOOK_LINK: TWideStringField
      FieldName = 'BOOK_LINK'
      Size = 255
    end
    object memBookDetailBOOK_DESCRIPTION: TWideStringField
      FieldName = 'BOOK_DESCRIPTION'
      Size = 255
    end
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 32
    Top = 256
  end
  object RESTResponse: TRESTResponse
    Left = 152
    Top = 256
  end
end
