object WebModule8: TWebModule8
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule8DefaultHandlerAction
    end>
  Height = 230
  Width = 415
  object DSServer1: TDSServer
    AutoStart = True
    HideDSAdmin = False
    Left = 96
    Top = 11
  end
  object DSHTTPWebDispatcher1: TDSHTTPWebDispatcher
    DSContext = 'datasnap/'
    RESTContext = 'rest/'
    CacheContext = 'cache/'
    Server = DSServer1
    DSHostname = 'localhost'
    DSPort = 211
    Filters = <>
    CredentialsPassThrough = False
    SessionTimeout = 1200000
    WebDispatch.MethodType = mtAny
    WebDispatch.PathInfo = 'datasnap*'
    Left = 96
    Top = 75
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    LifeCycle = 'Session'
    Left = 200
    Top = 11
  end
  object DSProxyGenerator1: TDSProxyGenerator
    MetaDataProvider = DSServerMetaDataProvider1
    Writer = 'Java (Android) REST'
    Left = 232
    Top = 88
  end
  object DSServerMetaDataProvider1: TDSServerMetaDataProvider
    Server = DSServer1
    Left = 232
    Top = 144
  end
  object DSProxyDispatcher1: TDSProxyDispatcher
    DSProxyGenerator = DSProxyGenerator1
    Left = 96
    Top = 152
  end
end
