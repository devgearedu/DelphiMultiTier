object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    Server = DSServer1
    Filters = <>
    Left = 96
    Top = 73
  end
  object DSHTTPService1: TDSHTTPService
    Server = DSServer1
    Filters = <>
    HttpPort = 8080
    Left = 96
    Top = 135
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 200
    Top = 11
  end
  object DSServerMetaDataProvider1: TDSServerMetaDataProvider
    Server = DSServer1
    Left = 272
    Top = 88
  end
  object DSProxyGenerator1: TDSProxyGenerator
    MetaDataProvider = DSServerMetaDataProvider1
    TargetUnitName = 'ServerFunctions.js'
    TargetDirectory = 'web/js'
    Writer = 'Java Script REST'
    Left = 256
    Top = 168
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
    RootDirectory = 'web'
    Left = 312
    Top = 216
  end
end
