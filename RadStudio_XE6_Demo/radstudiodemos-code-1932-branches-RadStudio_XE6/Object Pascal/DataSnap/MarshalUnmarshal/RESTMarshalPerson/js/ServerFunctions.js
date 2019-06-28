// 
// Created by the DataSnap proxy generator.
// 10/26/2010 1:37:30 PM
// 

function DSAdmin(connectionInfo)
{
  this.executor = new ServerFunctionExecutor("DSAdmin",connectionInfo);

  /*
   * @return result - Type on server: string
   */
  this.GetPlatformName = function() {
    var returnObject = this.executor.executeMethod('GetPlatformName', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetPlatformName_URL = function() {
    return this.executor.getMethodURL("GetPlatformName", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: Boolean
   */
  this.ClearResources = function() {
    var returnObject = this.executor.executeMethod('ClearResources', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  this.ClearResources_URL = function() {
    return this.executor.getMethodURL("ClearResources", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TDBXReader
   */
  this.FindPackages = function() {
    var returnObject = this.executor.executeMethod('FindPackages', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.FindPackages_URL = function() {
    return this.executor.getMethodURL("FindPackages", "GET", [], arguments[0])[0];
  };

  /*
   * @param PackageName [in] - Type on server: string
   * @param ClassPattern [in] - Type on server: string
   * @return result - Type on server: TDBXReader
   */
  this.FindClasses = function(PackageName, ClassPattern) {
    var returnObject = this.executor.executeMethod('FindClasses', "GET", [PackageName, ClassPattern], arguments[2], true, arguments[3], arguments[4]);
    if (arguments[2] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.PackageName = PackageName;
        resultObject.ClassPattern = ClassPattern;
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.FindClasses_URL = function(PackageName, ClassPattern) {
    return this.executor.getMethodURL("FindClasses", "GET", [PackageName, ClassPattern], arguments[2])[0];
  };

  /*
   * @param PackageName [in] - Type on server: string
   * @param ClassPattern [in] - Type on server: string
   * @param MethodPattern [in] - Type on server: string
   * @return result - Type on server: TDBXReader
   */
  this.FindMethods = function(PackageName, ClassPattern, MethodPattern) {
    var returnObject = this.executor.executeMethod('FindMethods', "GET", [PackageName, ClassPattern, MethodPattern], arguments[3], true, arguments[4], arguments[5]);
    if (arguments[3] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.PackageName = PackageName;
        resultObject.ClassPattern = ClassPattern;
        resultObject.MethodPattern = MethodPattern;
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.FindMethods_URL = function(PackageName, ClassPattern, MethodPattern) {
    return this.executor.getMethodURL("FindMethods", "GET", [PackageName, ClassPattern, MethodPattern], arguments[3])[0];
  };

  /*
   * @param ClassReader [in] - Type on server: TDBXReader
   */
  this.CreateServerClasses = function(ClassReader) {
    this.executor.executeMethod('"CreateServerClasses"', "POST", [ClassReader], arguments[1], false, arguments[2], arguments[3]);
  };

  /*
   * @param ClassReader [in] - Type on server: TDBXReader
   */
  this.DropServerClasses = function(ClassReader) {
    this.executor.executeMethod('"DropServerClasses"', "POST", [ClassReader], arguments[1], false, arguments[2], arguments[3]);
  };

  /*
   * @param MethodReader [in] - Type on server: TDBXReader
   */
  this.CreateServerMethods = function(MethodReader) {
    this.executor.executeMethod('"CreateServerMethods"', "POST", [MethodReader], arguments[1], false, arguments[2], arguments[3]);
  };

  /*
   * @param MethodReader [in] - Type on server: TDBXReader
   */
  this.DropServerMethods = function(MethodReader) {
    this.executor.executeMethod('"DropServerMethods"', "POST", [MethodReader], arguments[1], false, arguments[2], arguments[3]);
  };

  /*
   * @return result - Type on server: TDBXReader
   */
  this.GetServerClasses = function() {
    var returnObject = this.executor.executeMethod('GetServerClasses', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetServerClasses_URL = function() {
    return this.executor.getMethodURL("GetServerClasses", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TJSONArray
   */
  this.ListClasses = function() {
    var returnObject = this.executor.executeMethod('ListClasses', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.ListClasses_URL = function() {
    return this.executor.getMethodURL("ListClasses", "GET", [], arguments[0])[0];
  };

  /*
   * @param ClassName [in] - Type on server: string
   * @return result - Type on server: TJSONObject
   */
  this.DescribeClass = function(ClassName) {
    var returnObject = this.executor.executeMethod('DescribeClass', "GET", [ClassName], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ClassName = ClassName;
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.DescribeClass_URL = function(ClassName) {
    return this.executor.getMethodURL("DescribeClass", "GET", [ClassName], arguments[1])[0];
  };

  /*
   * @param ClassName [in] - Type on server: string
   * @return result - Type on server: TJSONArray
   */
  this.ListMethods = function(ClassName) {
    var returnObject = this.executor.executeMethod('ListMethods', "GET", [ClassName], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ClassName = ClassName;
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.ListMethods_URL = function(ClassName) {
    return this.executor.getMethodURL("ListMethods", "GET", [ClassName], arguments[1])[0];
  };

  /*
   * @param ServerMethodName [in] - Type on server: string
   * @return result - Type on server: TJSONObject
   */
  this.DescribeMethod = function(ServerMethodName) {
    var returnObject = this.executor.executeMethod('DescribeMethod', "GET", [ServerMethodName], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ServerMethodName = ServerMethodName;
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.DescribeMethod_URL = function(ServerMethodName) {
    return this.executor.getMethodURL("DescribeMethod", "GET", [ServerMethodName], arguments[1])[0];
  };

  /*
   * @return result - Type on server: TDBXReader
   */
  this.GetServerMethods = function() {
    var returnObject = this.executor.executeMethod('GetServerMethods', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetServerMethods_URL = function() {
    return this.executor.getMethodURL("GetServerMethods", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TDBXReader
   */
  this.GetServerMethodParameters = function() {
    var returnObject = this.executor.executeMethod('GetServerMethodParameters', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetServerMethodParameters_URL = function() {
    return this.executor.getMethodURL("GetServerMethodParameters", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TDBXReader
   */
  this.GetDatabaseConnectionProperties = function() {
    var returnObject = this.executor.executeMethod('GetDatabaseConnectionProperties', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetDatabaseConnectionProperties_URL = function() {
    return this.executor.getMethodURL("GetDatabaseConnectionProperties", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: string
   */
  this.GetDSServerName = function() {
    var returnObject = this.executor.executeMethod('GetDSServerName', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetDSServerName_URL = function() {
    return this.executor.getMethodURL("GetDSServerName", "GET", [], arguments[0])[0];
  };

  /*
   * @param ChannelName [in] - Type on server: string
   * @param ClientManagerId [in] - Type on server: string
   * @param CallbackId [in] - Type on server: string
   * @param SecurityToken [in] - Type on server: string
   * @param ResponseData [in] - Type on server: TJSONValue
   * @return result - Type on server: TJSONValue
   */
  this.ConsumeClientChannel = function(ChannelName, ClientManagerId, CallbackId, SecurityToken, ResponseData) {
    var returnObject = this.executor.executeMethod('"ConsumeClientChannel"', "POST", [ChannelName, ClientManagerId, CallbackId, SecurityToken, ResponseData], arguments[5], true, arguments[6], arguments[7]);
    if (arguments[5] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ChannelName = ChannelName;
        resultObject.ClientManagerId = ClientManagerId;
        resultObject.CallbackId = CallbackId;
        resultObject.SecurityToken = SecurityToken;
        resultObject.ResponseData = ResponseData;
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param ChannelName [in] - Type on server: string
   * @param ClientManagerId [in] - Type on server: string
   * @param CallbackId [in] - Type on server: string
   * @param SecurityToken [in] - Type on server: string
   * @param Timeout [in] - Type on server: Integer
   * @param ResponseData [in] - Type on server: TJSONValue
   * @return result - Type on server: TJSONValue
   */
  this.ConsumeClientChannelTimeout = function(ChannelName, ClientManagerId, CallbackId, SecurityToken, Timeout, ResponseData) {
    var returnObject = this.executor.executeMethod('"ConsumeClientChannelTimeout"', "POST", [ChannelName, ClientManagerId, CallbackId, SecurityToken, Timeout, ResponseData], arguments[6], true, arguments[7], arguments[8]);
    if (arguments[6] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ChannelName = ChannelName;
        resultObject.ClientManagerId = ClientManagerId;
        resultObject.CallbackId = CallbackId;
        resultObject.SecurityToken = SecurityToken;
        resultObject.Timeout = Timeout;
        resultObject.ResponseData = ResponseData;
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param ChannelName [in] - Type on server: string
   * @param ChannelId [in] - Type on server: string
   * @param SecurityToken [in] - Type on server: string
   * @return result - Type on server: Boolean
   */
  this.CloseClientChannel = function(ChannelName, ChannelId, SecurityToken) {
    var returnObject = this.executor.executeMethod('CloseClientChannel', "GET", [ChannelName, ChannelId, SecurityToken], arguments[3], true, arguments[4], arguments[5]);
    if (arguments[3] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ChannelName = ChannelName;
        resultObject.ChannelId = ChannelId;
        resultObject.SecurityToken = SecurityToken;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  this.CloseClientChannel_URL = function(ChannelName, ChannelId, SecurityToken) {
    return this.executor.getMethodURL("CloseClientChannel", "GET", [ChannelName, ChannelId, SecurityToken], arguments[3])[0];
  };

  /*
   * @param ChannelName [in] - Type on server: string
   * @param ChannelId [in] - Type on server: string
   * @param CallbackId [in] - Type on server: string
   * @param SecurityToken [in] - Type on server: string
   * @return result - Type on server: Boolean
   */
  this.RegisterClientCallbackServer = function(ChannelName, ChannelId, CallbackId, SecurityToken) {
    var returnObject = this.executor.executeMethod('RegisterClientCallbackServer', "GET", [ChannelName, ChannelId, CallbackId, SecurityToken], arguments[4], true, arguments[5], arguments[6]);
    if (arguments[4] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ChannelName = ChannelName;
        resultObject.ChannelId = ChannelId;
        resultObject.CallbackId = CallbackId;
        resultObject.SecurityToken = SecurityToken;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  this.RegisterClientCallbackServer_URL = function(ChannelName, ChannelId, CallbackId, SecurityToken) {
    return this.executor.getMethodURL("RegisterClientCallbackServer", "GET", [ChannelName, ChannelId, CallbackId, SecurityToken], arguments[4])[0];
  };

  /*
   * @param ChannelName [in] - Type on server: string
   * @param ChannelId [in] - Type on server: string
   * @param CallbackId [in] - Type on server: string
   * @param SecurityToken [in] - Type on server: string
   * @return result - Type on server: Boolean
   */
  this.UnregisterClientCallback = function(ChannelName, ChannelId, CallbackId, SecurityToken) {
    var returnObject = this.executor.executeMethod('UnregisterClientCallback', "GET", [ChannelName, ChannelId, CallbackId, SecurityToken], arguments[4], true, arguments[5], arguments[6]);
    if (arguments[4] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ChannelName = ChannelName;
        resultObject.ChannelId = ChannelId;
        resultObject.CallbackId = CallbackId;
        resultObject.SecurityToken = SecurityToken;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  this.UnregisterClientCallback_URL = function(ChannelName, ChannelId, CallbackId, SecurityToken) {
    return this.executor.getMethodURL("UnregisterClientCallback", "GET", [ChannelName, ChannelId, CallbackId, SecurityToken], arguments[4])[0];
  };

  /*
   * @param ChannelName [in] - Type on server: string
   * @param Msg [in] - Type on server: TJSONValue
   * @return result - Type on server: Boolean
   */
  this.BroadcastToChannel = function(ChannelName, Msg) {
    var returnObject = this.executor.executeMethod('"BroadcastToChannel"', "POST", [ChannelName, Msg], arguments[2], true, arguments[3], arguments[4]);
    if (arguments[2] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ChannelName = ChannelName;
        resultObject.Msg = Msg;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param ChannelName [in] - Type on server: string
   * @param Msg [in] - Type on server: TObject
   * @return result - Type on server: Boolean
   */
  this.BroadcastObjectToChannel = function(ChannelName, Msg) {
    var returnObject = this.executor.executeMethod('"BroadcastObjectToChannel"', "POST", [ChannelName, Msg], arguments[2], true, arguments[3], arguments[4]);
    if (arguments[2] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ChannelName = ChannelName;
        resultObject.Msg = Msg;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param ChannelName [in] - Type on server: string
   * @param ClientId [in] - Type on server: string
   * @param CallbackId [in] - Type on server: string
   * @param Msg [in] - Type on server: TJSONValue
   * @param Response [out] - Type on server: TJSONValue
   * @return result - Type on server: Boolean
   */
  this.NotifyCallback = function(ChannelName, ClientId, CallbackId, Msg) {
    var returnObject = this.executor.executeMethod('"NotifyCallback"', "POST", [ChannelName, ClientId, CallbackId, Msg], arguments[4], true, arguments[5], arguments[6]);
    if (arguments[4] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ChannelName = ChannelName;
        resultObject.ClientId = ClientId;
        resultObject.CallbackId = CallbackId;
        resultObject.Msg = Msg;
        resultObject.Response = resultArray[0];
        resultObject.result = resultArray[1];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param ChannelName [in] - Type on server: string
   * @param ClientId [in] - Type on server: string
   * @param CallbackId [in] - Type on server: string
   * @param Msg [in] - Type on server: TObject
   * @param Response [out] - Type on server: TObject
   * @return result - Type on server: Boolean
   */
  this.NotifyObject = function(ChannelName, ClientId, CallbackId, Msg) {
    var returnObject = this.executor.executeMethod('"NotifyObject"', "POST", [ChannelName, ClientId, CallbackId, Msg], arguments[4], true, arguments[5], arguments[6]);
    if (arguments[4] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.ChannelName = ChannelName;
        resultObject.ClientId = ClientId;
        resultObject.CallbackId = CallbackId;
        resultObject.Msg = Msg;
        resultObject.Response = resultArray[0];
        resultObject.result = resultArray[1];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };
}

function TServerMethods2(connectionInfo)
{
  this.executor = new ServerFunctionExecutor("TServerMethods2",connectionInfo);

  /*
   * @param Value [in] - Type on server: string
   * @return result - Type on server: string
   */
  this.EchoString = function(Value) {
    var returnObject = this.executor.executeMethod('EchoString', "GET", [Value], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.Value = Value;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  this.EchoString_URL = function(Value) {
    return this.executor.getMethodURL("EchoString", "GET", [Value], arguments[1])[0];
  };

  /*
   * @param Value [in] - Type on server: string
   * @return result - Type on server: string
   */
  this.ReverseString = function(Value) {
    var returnObject = this.executor.executeMethod('ReverseString', "GET", [Value], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.Value = Value;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  this.ReverseString_URL = function(Value) {
    return this.executor.getMethodURL("ReverseString", "GET", [Value], arguments[1])[0];
  };

  /*
   * @return result - Type on server: TPerson1
   */
  this.GetPerson = function() {
    var returnObject = this.executor.executeMethod('GetPerson', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetPerson_URL = function() {
    return this.executor.getMethodURL("GetPerson", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TPerson1Collection
   */
  this.GetPersonCollection = function() {
    var returnObject = this.executor.executeMethod('GetPersonCollection', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetPersonCollection_URL = function() {
    return this.executor.getMethodURL("GetPersonCollection", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TPersonISODate_Attribute
   */
  this.GetPerson_Attribute = function() {
    var returnObject = this.executor.executeMethod('GetPerson_Attribute', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetPerson_Attribute_URL = function() {
    return this.executor.getMethodURL("GetPerson_Attribute", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TPersonISODate_Register
   */
  this.GetPerson_Register = function() {
    var returnObject = this.executor.executeMethod('GetPerson_Register', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetPerson_Register_URL = function() {
    return this.executor.getMethodURL("GetPerson_Register", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TClassWithTStringsField_Attribute
   */
  this.GetClassWithTStrings_Attribute = function() {
    var returnObject = this.executor.executeMethod('GetClassWithTStrings_Attribute', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetClassWithTStrings_Attribute_URL = function() {
    return this.executor.getMethodURL("GetClassWithTStrings_Attribute", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TClassWithTStringsField_Register
   */
  this.GetClassWithTStrings_Register = function() {
    var returnObject = this.executor.executeMethod('GetClassWithTStrings_Register', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetClassWithTStrings_Register_URL = function() {
    return this.executor.getMethodURL("GetClassWithTStrings_Register", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TClassWithGenericListField
   */
  this.GetGenericListField = function() {
    var returnObject = this.executor.executeMethod('GetGenericListField', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetGenericListField_URL = function() {
    return this.executor.getMethodURL("GetGenericListField", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TClassWithGenericListField_Register
   */
  this.GetGenericListField_Register = function() {
    var returnObject = this.executor.executeMethod('GetGenericListField_Register', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetGenericListField_Register_URL = function() {
    return this.executor.getMethodURL("GetGenericListField_Register", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TClassWithGenericDictionaryField
   */
  this.GetGenericDictionaryField = function() {
    var returnObject = this.executor.executeMethod('GetGenericDictionaryField', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetGenericDictionaryField_URL = function() {
    return this.executor.getMethodURL("GetGenericDictionaryField", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TClassWithGenericDictionaryField_Register
   */
  this.GetGenericDictionaryField_Register = function() {
    var returnObject = this.executor.executeMethod('GetGenericDictionaryField_Register', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetGenericDictionaryField_Register_URL = function() {
    return this.executor.getMethodURL("GetGenericDictionaryField_Register", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TUnsupportedFieldsClass
   */
  this.GetUnsupportedFields = function() {
    var returnObject = this.executor.executeMethod('GetUnsupportedFields', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetUnsupportedFields_URL = function() {
    return this.executor.getMethodURL("GetUnsupportedFields", "GET", [], arguments[0])[0];
  };

  /*
   * @return result - Type on server: TUnsupportedFieldsClass_Register
   */
  this.GetUnsupportedFields_Register = function() {
    var returnObject = this.executor.executeMethod('GetUnsupportedFields_Register', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetUnsupportedFields_Register_URL = function() {
    return this.executor.getMethodURL("GetUnsupportedFields_Register", "GET", [], arguments[0])[0];
  };

  /*
   * @param AValue [in] - Type on server: TClassWithTStringsField_Attribute
   * @return result - Type on server: Boolean
   */
  this.ValidateClassWithTStrings_Attribute = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateClassWithTStrings_Attribute"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TClassWithTStringsField_Register
   * @return result - Type on server: Boolean
   */
  this.ValidateClassWithTStrings_Register = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateClassWithTStrings_Register"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TClassWithGenericListField
   * @return result - Type on server: Boolean
   */
  this.ValidateGenericListField = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateGenericListField"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TClassWithGenericListField_Register
   * @return result - Type on server: Boolean
   */
  this.ValidateGenericListField_Register = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateGenericListField_Register"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TClassWithGenericDictionaryField
   * @return result - Type on server: Boolean
   */
  this.ValidateGenericDictionaryField = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateGenericDictionaryField"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TClassWithGenericDictionaryField_Register
   * @return result - Type on server: Boolean
   */
  this.ValidateGenericDictionaryField_Register = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateGenericDictionaryField_Register"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TPersonISODate_Register
   * @return result - Type on server: Boolean
   */
  this.ValidatePerson_Register = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidatePerson_Register"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TPerson1
   * @return result - Type on server: Boolean
   */
  this.ValidatePerson = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidatePerson"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TPersonISODate_Attribute
   * @return result - Type on server: Boolean
   */
  this.ValidatePerson_Attribute = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidatePerson_Attribute"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TPerson1Collection
   * @return result - Type on server: Boolean
   */
  this.ValidatePersonCollection = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidatePersonCollection"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TUnsupportedFieldsClass
   * @return result - Type on server: Boolean
   */
  this.ValidateUnsupportedFields = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateUnsupportedFields"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param AValue [in] - Type on server: TUnsupportedFieldsClass_Register
   * @return result - Type on server: Boolean
   */
  this.ValidateUnsupportedFields_Register = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateUnsupportedFields_Register"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @param Value [in] - Type on server: TJSONValue
   * @return result - Type on server: Boolean
   */
  this.ProcessArray = function(Value) {
    var returnObject = this.executor.executeMethod('"ProcessArray"', "POST", [Value], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.Value = Value;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @return result - Type on server: TMyDictionary
   */
  this.GetGenericDictionary = function() {
    var returnObject = this.executor.executeMethod('GetGenericDictionary', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetGenericDictionary_URL = function() {
    return this.executor.getMethodURL("GetGenericDictionary", "GET", [], arguments[0])[0];
  };

  /*
   * @param AValue [in] - Type on server: TMyDictionary
   * @return result - Type on server: Boolean
   */
  this.ValidateGenericDictionary = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateGenericDictionary"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };

  /*
   * @return result - Type on server: TMyDictionaryPairs
   */
  this.GetGenericDictionaryPairs = function() {
    var returnObject = this.executor.executeMethod('GetGenericDictionaryPairs', "GET", [], arguments[0], true, arguments[1], arguments[2]);
    if (arguments[0] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.result = resultArray[0];
        if (returnObject.cacheId != null && returnObject.cmdIndex != null) {
          resultObject._cacheId = returnObject.cacheId;
          resultObject._cmdIndex = returnObject.cmdIndex;
        }
        return resultObject;
      }
      return returnObject;
    }
  };

  this.GetGenericDictionaryPairs_URL = function() {
    return this.executor.getMethodURL("GetGenericDictionaryPairs", "GET", [], arguments[0])[0];
  };

  /*
   * @param AValue [in] - Type on server: TMyDictionaryPairs
   * @return result - Type on server: Boolean
   */
  this.ValidateGenericDictionaryPairs = function(AValue) {
    var returnObject = this.executor.executeMethod('"ValidateGenericDictionaryPairs"', "POST", [AValue], arguments[1], true, arguments[2], arguments[3]);
    if (arguments[1] == null) {
      if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {
        var resultArray = returnObject.result;
        var resultObject = new Object();
        resultObject.AValue = AValue;
        resultObject.result = resultArray[0];
        return resultObject;
      }
      return returnObject;
    }
  };
}

var JSProxyClassList = {
  "DSAdmin": ["GetPlatformName","ClearResources","FindPackages","FindClasses","FindMethods","CreateServerClasses","DropServerClasses","CreateServerMethods","DropServerMethods","GetServerClasses","ListClasses","DescribeClass","ListMethods","DescribeMethod","GetServerMethods","GetServerMethodParameters","GetDatabaseConnectionProperties","GetDSServerName","ConsumeClientChannel","ConsumeClientChannelTimeout","CloseClientChannel","RegisterClientCallbackServer","UnregisterClientCallback","BroadcastToChannel","BroadcastObjectToChannel","NotifyCallback","NotifyObject"],
  "TServerMethods2": ["EchoString","ReverseString","GetPerson","GetPersonCollection","GetPerson_Attribute","GetPerson_Register","GetClassWithTStrings_Attribute","GetClassWithTStrings_Register","GetGenericListField","GetGenericListField_Register","GetGenericDictionaryField","GetGenericDictionaryField_Register","GetUnsupportedFields","GetUnsupportedFields_Register","ValidateClassWithTStrings_Attribute","ValidateClassWithTStrings_Register","ValidateGenericListField","ValidateGenericListField_Register","ValidateGenericDictionaryField","ValidateGenericDictionaryField_Register","ValidatePerson_Register","ValidatePerson","ValidatePerson_Attribute","ValidatePersonCollection","ValidateUnsupportedFields","ValidateUnsupportedFields_Register","ProcessArray","GetGenericDictionary","ValidateGenericDictionary","GetGenericDictionaryPairs","ValidateGenericDictionaryPairs"]
};

