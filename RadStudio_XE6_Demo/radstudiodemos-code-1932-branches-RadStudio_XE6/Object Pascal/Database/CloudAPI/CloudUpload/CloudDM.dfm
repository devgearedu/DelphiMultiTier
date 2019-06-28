object Cloud: TCloud
  OldCreateOrder = False
  Height = 268
  Width = 536
  object AzureConnection: TAzureConnectionInfo
    UseDevelopmentStorage = False
    BlobEndpoint = '.blob.core.windows.net'
    QueueEndpoint = '.queue.core.windows.net'
    TableEndpoint = '.table.core.windows.net'
    Protocol = 'http'
    RequestProxyPort = 8888
    UseDefaultEndpoints = True
    Left = 80
    Top = 96
  end
  object AmazonConnection: TAmazonConnectionInfo
    Protocol = 'http'
    RequestProxyPort = 8888
    ConsistentRead = True
    TableEndpoint = 'sdb.amazonaws.com'
    QueueEndpoint = 'queue.amazonaws.com'
    StorageEndpoint = 's3.amazonaws.com'
    UseDefaultEndpoints = True
    Left = 208
    Top = 96
  end
end
