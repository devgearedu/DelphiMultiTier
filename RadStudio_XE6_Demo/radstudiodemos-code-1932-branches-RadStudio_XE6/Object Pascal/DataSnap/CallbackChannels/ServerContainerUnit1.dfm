object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object DSHTTPService1: TDSHTTPService
    Server = DSServer1
    Filters = <>
    HttpPort = 8087
    Left = 96
    Top = 135
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    PoolSize = 0
    Server = DSServer1
    Filters = <>
    Left = 232
    Top = 96
  end
  object DSHTTPServiceFileDispatcher1: TDSHTTPServiceFileDispatcher
    Service = DSHTTPService1
    WebFileExtensions = <
      item
        MimeType = 'text/css'
        Extensions = 'css'
      end
      item
        MimeType = 'text/html'
        Extensions = 'html;htm'
      end
      item
        MimeType = 'text/javascript'
        Extensions = 'js'
      end
      item
        MimeType = 'image/jpeg'
        Extensions = 'jpeg;jpg'
      end
      item
        MimeType = 'image/x-png'
        Extensions = 'png'
      end>
    WebDirectories = <
      item
        DirectoryAction = dirInclude
        DirectoryMask = '*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '\templates\*'
      end>
    Left = 272
    Top = 176
  end
end
