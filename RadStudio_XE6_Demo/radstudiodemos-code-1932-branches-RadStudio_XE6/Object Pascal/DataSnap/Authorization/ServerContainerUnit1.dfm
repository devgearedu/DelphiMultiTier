object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    PoolSize = 0
    Server = DSServer1
    Filters = <>
    AuthenticationManager = DSAuthenticationManager1
    Left = 96
    Top = 73
  end
  object DSAuthenticationManager1: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManager1UserAuthenticate
    OnUserAuthorize = DSAuthenticationManager1UserAuthorize
    Roles = <
      item
        AuthorizedRoles.Strings = (
          'EchoStringAuthorizedRole')
        ApplyTo.Strings = (
          'EchoString')
      end>
    Left = 96
    Top = 197
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    OnPrepare = DSServerClass1Prepare
    Server = DSServer1
    Left = 200
    Top = 11
  end
  object DSHTTPService1: TDSHTTPService
    Server = DSServer1
    Filters = <>
    AuthenticationManager = DSAuthenticationManager1
    HttpPort = 8081
    Left = 208
    Top = 128
  end
end
