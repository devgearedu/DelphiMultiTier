object ServerContainer1: TServerContainer1
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 316
  Width = 486
  object DSServer1: TDSServer
    AutoStart = False
    Left = 96
    Top = 11
  end
  object DSHTTPService1: TDSHTTPService
    HttpPort = 8086
    Server = DSServer1
    Filters = <>
    SessionTimeout = 1800000
    Left = 96
    Top = 135
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 200
    Top = 11
  end
  object DSProxyGenerator1: TDSProxyGenerator
    MetaDataProvider = DSServerMetaDataProvider1
    Left = 200
    Top = 88
  end
  object DSServerMetaDataProvider1: TDSServerMetaDataProvider
    Server = DSServer1
    Left = 200
    Top = 184
  end
  object DSHTTPServiceProxyDispatcher1: TDSHTTPServiceProxyDispatcher
    Service = DSHTTPService1
    WebFileExtensions = <
      item
        MimeType = 'application/x-zip-compressed'
        Extensions = 'zip'
      end>
    WebDirectories = <
      item
        DirectoryAction = dirInclude
        DirectoryMask = '\proxy\*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '\proxy\*\*'
      end>
    DSProxyGenerator = DSProxyGenerator1
    Left = 344
    Top = 88
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
      end
      item
        MimeType = 'text/plain'
        Extensions = 'apk'
      end
      item
        MimeType = 'application/java-archive'
        Extensions = 'jar'
      end
      item
        MimeType = 'application/x-zip-compressed'
        Extensions = 'zip'
      end
      item
        MimeType = 'application/x-msdos-program'
        Extensions = 'exe'
      end
      item
        MimeType = 'text/vnd.sun.j2me.app-descriptor'
        Extensions = 'jad'
      end
      item
        MimeType = 'application/vnd.rim.cod'
        Extensions = 'cod'
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
    Left = 200
    Top = 240
  end
end
