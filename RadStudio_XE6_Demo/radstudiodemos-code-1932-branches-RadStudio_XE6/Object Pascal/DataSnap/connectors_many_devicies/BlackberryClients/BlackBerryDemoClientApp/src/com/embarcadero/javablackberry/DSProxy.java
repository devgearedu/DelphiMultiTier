// 
// Created by the DataSnap proxy generator.
// 03/06/2011 17:25:03
// 

package com.embarcadero.javablackberry;


public class DSProxy {
  public static class TCompanyTweet extends DSAdmin {
    public TCompanyTweet(DSRESTConnection Connection) {
      super(Connection);
    }
    
    
    private DSRESTParameterMetaData[] TCompanyTweet_Logout_Metadata;
    private DSRESTParameterMetaData[] get_TCompanyTweet_Logout_Metadata() {
      if (TCompanyTweet_Logout_Metadata == null) {
        TCompanyTweet_Logout_Metadata = new DSRESTParameterMetaData[]{
        };
      }
      return TCompanyTweet_Logout_Metadata;
    }

    public void Logout() throws DBXException {
      DSRESTCommand cmd = getConnection().CreateCommand();
      cmd.setRequestType(DSHTTPRequestType.GET);
      cmd.setText("TCompanyTweet.Logout");
      cmd.prepare(get_TCompanyTweet_Logout_Metadata());
      getConnection().execute(cmd);
      return;
    }
    
    
    private DSRESTParameterMetaData[] TCompanyTweet_LoginUser_Metadata;
    private DSRESTParameterMetaData[] get_TCompanyTweet_LoginUser_Metadata() {
      if (TCompanyTweet_LoginUser_Metadata == null) {
        TCompanyTweet_LoginUser_Metadata = new DSRESTParameterMetaData[]{
          new DSRESTParameterMetaData("UserName", DSRESTParamDirection.Input, DBXDataTypes.WideStringType, "string"),
          new DSRESTParameterMetaData("ReturnMessage", DSRESTParamDirection.Output, DBXDataTypes.WideStringType, "string"),
          new DSRESTParameterMetaData("", DSRESTParamDirection.ReturnValue, DBXDataTypes.BooleanType, "Boolean"),
        };
      }
      return TCompanyTweet_LoginUser_Metadata;
    }

    /**
     * @param UserName [in] - Type on server: string
     * @param ReturnMessage [out] - Type on server: string
     * @return result - Type on server: Boolean
     */
    public static class LoginUserReturns {
      public String ReturnMessage;
      public boolean returnValue;
    }
    public LoginUserReturns LoginUser(String UserName) throws DBXException {
      DSRESTCommand cmd = getConnection().CreateCommand();
      cmd.setRequestType(DSHTTPRequestType.GET);
      cmd.setText("TCompanyTweet.LoginUser");
      cmd.prepare(get_TCompanyTweet_LoginUser_Metadata());
      cmd.getParameter(0).getValue().SetAsString(UserName);
      getConnection().execute(cmd);
      LoginUserReturns ret = new LoginUserReturns();
      ret.ReturnMessage = cmd.getParameter(1).getValue().GetAsString();
      ret.returnValue = cmd.getParameter(2).getValue().GetAsBoolean();
      return ret;
    }
    
    
    private DSRESTParameterMetaData[] TCompanyTweet_UsersList_Metadata;
    private DSRESTParameterMetaData[] get_TCompanyTweet_UsersList_Metadata() {
      if (TCompanyTweet_UsersList_Metadata == null) {
        TCompanyTweet_UsersList_Metadata = new DSRESTParameterMetaData[]{
          new DSRESTParameterMetaData("", DSRESTParamDirection.ReturnValue, DBXDataTypes.JsonValueType, "TJSONArray"),
        };
      }
      return TCompanyTweet_UsersList_Metadata;
    }

    /**
     * @return result - Type on server: TJSONArray
     */
    public TJSONArray UsersList() throws DBXException {
      DSRESTCommand cmd = getConnection().CreateCommand();
      cmd.setRequestType(DSHTTPRequestType.GET);
      cmd.setText("TCompanyTweet.UsersList");
      cmd.prepare(get_TCompanyTweet_UsersList_Metadata());
      getConnection().execute(cmd);
      return (TJSONArray) cmd.getParameter(0).getValue().GetAsJSONValue();
    }
    
    
    private DSRESTParameterMetaData[] TCompanyTweet_ConnectedUsers_Metadata;
    private DSRESTParameterMetaData[] get_TCompanyTweet_ConnectedUsers_Metadata() {
      if (TCompanyTweet_ConnectedUsers_Metadata == null) {
        TCompanyTweet_ConnectedUsers_Metadata = new DSRESTParameterMetaData[]{
          new DSRESTParameterMetaData("", DSRESTParamDirection.ReturnValue, DBXDataTypes.JsonValueType, "TJSONArray"),
        };
      }
      return TCompanyTweet_ConnectedUsers_Metadata;
    }

    /**
     * @return result - Type on server: TJSONArray
     */
    public TJSONArray ConnectedUsers() throws DBXException {
      DSRESTCommand cmd = getConnection().CreateCommand();
      cmd.setRequestType(DSHTTPRequestType.GET);
      cmd.setText("TCompanyTweet.ConnectedUsers");
      cmd.prepare(get_TCompanyTweet_ConnectedUsers_Metadata());
      getConnection().execute(cmd);
      return (TJSONArray) cmd.getParameter(0).getValue().GetAsJSONValue();
    }
    
    
    private DSRESTParameterMetaData[] TCompanyTweet_SetUsersToFollow_Metadata;
    private DSRESTParameterMetaData[] get_TCompanyTweet_SetUsersToFollow_Metadata() {
      if (TCompanyTweet_SetUsersToFollow_Metadata == null) {
        TCompanyTweet_SetUsersToFollow_Metadata = new DSRESTParameterMetaData[]{
          new DSRESTParameterMetaData("Users", DSRESTParamDirection.Input, DBXDataTypes.JsonValueType, "TJSONArray"),
        };
      }
      return TCompanyTweet_SetUsersToFollow_Metadata;
    }

    /**
     * @param Users [in] - Type on server: TJSONArray
     */
    public void SetUsersToFollow(TJSONArray Users) throws DBXException {
      DSRESTCommand cmd = getConnection().CreateCommand();
      cmd.setRequestType(DSHTTPRequestType.POST);
      cmd.setText("TCompanyTweet.SetUsersToFollow");
      cmd.prepare(get_TCompanyTweet_SetUsersToFollow_Metadata());
      cmd.getParameter(0).getValue().SetAsJSONValue(Users);
      getConnection().execute(cmd);
      return;
    }
    
    
    private DSRESTParameterMetaData[] TCompanyTweet_SendTweet_Metadata;
    private DSRESTParameterMetaData[] get_TCompanyTweet_SendTweet_Metadata() {
      if (TCompanyTweet_SendTweet_Metadata == null) {
        TCompanyTweet_SendTweet_Metadata = new DSRESTParameterMetaData[]{
          new DSRESTParameterMetaData("Tweet", DSRESTParamDirection.Input, DBXDataTypes.WideStringType, "string"),
        };
      }
      return TCompanyTweet_SendTweet_Metadata;
    }

    /**
     * @param Tweet [in] - Type on server: string
     */
    public void SendTweet(String Tweet) throws DBXException {
      DSRESTCommand cmd = getConnection().CreateCommand();
      cmd.setRequestType(DSHTTPRequestType.GET);
      cmd.setText("TCompanyTweet.SendTweet");
      cmd.prepare(get_TCompanyTweet_SendTweet_Metadata());
      cmd.getParameter(0).getValue().SetAsString(Tweet);
      getConnection().execute(cmd);
      return;
    }
  }

}
