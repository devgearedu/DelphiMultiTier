object ClientModule_FishFactsIndy: TClientModule_FishFactsIndy
  OldCreateOrder = False
  Height = 271
  Width = 415
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'Port=8089'
      'CommunicationProtocol=http'
      'DatasnapContext=datasnap/')
    Left = 48
    Top = 40
    UniqueId = '{C98EC897-E372-4EED-8E8A-B67C50BB8C75}'
  end
end
