// 
// Created by the DataSnap proxy generator.
// 7/22/2011 2:43:10 PM
// 

using System;
using System.Threading;

namespace Embarcadero.Datasnap.WindowsPhone7
{
  public class DSProxy
  {
    public class TCompanyTweet : DSAdmin
    {
      public TCompanyTweet(DSRESTConnection Connection, ExceptionCallback ExCal)
          : base(Connection, ExCal)
      {
      }

      private DSRESTParameterMetaData[] TCompanyTweet_Logout_Metadata;
      private DSRESTParameterMetaData[] get_TCompanyTweet_Logout_Metadata()
      {
        if (TCompanyTweet_Logout_Metadata == null)
        {
          TCompanyTweet_Logout_Metadata = new DSRESTParameterMetaData[]
          {
          };
        }
        return TCompanyTweet_Logout_Metadata;
      }

      public delegate void LogoutCallback();

      public void Logout(LogoutCallback callback = null, ExceptionCallback ExCal = null)
      {
        DSRESTCommand cmd = getConnection().CreateCommand();
        cmd.setRequestType(DSHTTPRequestType.GET);
        cmd.setText("TCompanyTweet.Logout");
        cmd.prepare(get_TCompanyTweet_Logout_Metadata());
        InternalConnectionDelegate LogoutDel = () =>
        {
          if (callback != null)
          {
            try
            {
              callback.DynamicInvoke();
            }
            catch (Exception ex)
            {
              if (ExCal != null) getConnection().syncContext.Send(new SendOrPostCallback(x => ExCal.DynamicInvoke(ex.InnerException)), null);
              else getConnection().syncContext.Send(new SendOrPostCallback(x => BaseExCal.DynamicInvoke(ex.InnerException)), null);
            }
          }
        };
        getConnection().execute(cmd, this, LogoutDel, ExCal);
      }
      private DSRESTParameterMetaData[] TCompanyTweet_LoginUser_Metadata;
      private DSRESTParameterMetaData[] get_TCompanyTweet_LoginUser_Metadata()
      {
        if (TCompanyTweet_LoginUser_Metadata == null)
        {
          TCompanyTweet_LoginUser_Metadata = new DSRESTParameterMetaData[]
          {
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
      public class LoginUserReturns
      {
        public String ReturnMessage;
        public bool returnValue;
      }
      public delegate void LoginUserCallback(LoginUserReturns Returns);

      public void LoginUser(String UserName, LoginUserCallback callback = null, ExceptionCallback ExCal = null)
      {
        DSRESTCommand cmd = getConnection().CreateCommand();
        cmd.setRequestType(DSHTTPRequestType.GET);
        cmd.setText("TCompanyTweet.LoginUser");
        cmd.prepare(get_TCompanyTweet_LoginUser_Metadata());
        InternalConnectionDelegate LoginUserDel = () =>
        {
          if (callback != null)
          {
            try
            {
              LoginUserReturns ret = new LoginUserReturns();
              ret.ReturnMessage = cmd.getParameter(1).getValue().GetAsString();
              ret.returnValue = cmd.getParameter(2).getValue().GetAsBoolean();
              callback.DynamicInvoke(ret);
            }
            catch (Exception ex)
            {
              if (ExCal != null) getConnection().syncContext.Send(new SendOrPostCallback(x => ExCal.DynamicInvoke(ex.InnerException)), null);
              else getConnection().syncContext.Send(new SendOrPostCallback(x => BaseExCal.DynamicInvoke(ex.InnerException)), null);
            }
          }
        };
        cmd.getParameter(0).getValue().SetAsString(UserName);
        getConnection().execute(cmd, this, LoginUserDel, ExCal);
      }
      private DSRESTParameterMetaData[] TCompanyTweet_UsersList_Metadata;
      private DSRESTParameterMetaData[] get_TCompanyTweet_UsersList_Metadata()
      {
        if (TCompanyTweet_UsersList_Metadata == null)
        {
          TCompanyTweet_UsersList_Metadata = new DSRESTParameterMetaData[]
          {
            new DSRESTParameterMetaData("", DSRESTParamDirection.ReturnValue, DBXDataTypes.JsonValueType, "TJSONArray"),
          };
        }
        return TCompanyTweet_UsersList_Metadata;
      }

      /**
       * @return result - Type on server: TJSONArray
       */
      public delegate void UsersListCallback(TJSONArray Result);

      public void UsersList(UsersListCallback callback = null, ExceptionCallback ExCal = null)
      {
        DSRESTCommand cmd = getConnection().CreateCommand();
        cmd.setRequestType(DSHTTPRequestType.GET);
        cmd.setText("TCompanyTweet.UsersList");
        cmd.prepare(get_TCompanyTweet_UsersList_Metadata());
        InternalConnectionDelegate UsersListDel = () =>
        {
          if (callback != null)
          {
            try
            {
              callback.DynamicInvoke((TJSONArray)cmd.getParameter(0).getValue().GetAsJSONValue());
            }
            catch (Exception ex)
            {
              if (ExCal != null) getConnection().syncContext.Send(new SendOrPostCallback(x => ExCal.DynamicInvoke(ex.InnerException)), null);
              else getConnection().syncContext.Send(new SendOrPostCallback(x => BaseExCal.DynamicInvoke(ex.InnerException)), null);
            }
          }
        };
        getConnection().execute(cmd, this, UsersListDel, ExCal);
      }
      private DSRESTParameterMetaData[] TCompanyTweet_ConnectedUsers_Metadata;
      private DSRESTParameterMetaData[] get_TCompanyTweet_ConnectedUsers_Metadata()
      {
        if (TCompanyTweet_ConnectedUsers_Metadata == null)
        {
          TCompanyTweet_ConnectedUsers_Metadata = new DSRESTParameterMetaData[]
          {
            new DSRESTParameterMetaData("", DSRESTParamDirection.ReturnValue, DBXDataTypes.JsonValueType, "TJSONArray"),
          };
        }
        return TCompanyTweet_ConnectedUsers_Metadata;
      }

      /**
       * @return result - Type on server: TJSONArray
       */
      public delegate void ConnectedUsersCallback(TJSONArray Result);

      public void ConnectedUsers(ConnectedUsersCallback callback = null, ExceptionCallback ExCal = null)
      {
        DSRESTCommand cmd = getConnection().CreateCommand();
        cmd.setRequestType(DSHTTPRequestType.GET);
        cmd.setText("TCompanyTweet.ConnectedUsers");
        cmd.prepare(get_TCompanyTweet_ConnectedUsers_Metadata());
        InternalConnectionDelegate ConnectedUsersDel = () =>
        {
          if (callback != null)
          {
            try
            {
              callback.DynamicInvoke((TJSONArray)cmd.getParameter(0).getValue().GetAsJSONValue());
            }
            catch (Exception ex)
            {
              if (ExCal != null) getConnection().syncContext.Send(new SendOrPostCallback(x => ExCal.DynamicInvoke(ex.InnerException)), null);
              else getConnection().syncContext.Send(new SendOrPostCallback(x => BaseExCal.DynamicInvoke(ex.InnerException)), null);
            }
          }
        };
        getConnection().execute(cmd, this, ConnectedUsersDel, ExCal);
      }
      private DSRESTParameterMetaData[] TCompanyTweet_SetUsersToFollow_Metadata;
      private DSRESTParameterMetaData[] get_TCompanyTweet_SetUsersToFollow_Metadata()
      {
        if (TCompanyTweet_SetUsersToFollow_Metadata == null)
        {
          TCompanyTweet_SetUsersToFollow_Metadata = new DSRESTParameterMetaData[]
          {
            new DSRESTParameterMetaData("Users", DSRESTParamDirection.Input, DBXDataTypes.JsonValueType, "TJSONArray"),
          };
        }
        return TCompanyTweet_SetUsersToFollow_Metadata;
      }

      /**
       * @param Users [in] - Type on server: TJSONArray
       */
      public delegate void SetUsersToFollowCallback();

      public void SetUsersToFollow(TJSONArray Users, SetUsersToFollowCallback callback = null, ExceptionCallback ExCal = null)
      {
        DSRESTCommand cmd = getConnection().CreateCommand();
        cmd.setRequestType(DSHTTPRequestType.POST);
        cmd.setText("TCompanyTweet.SetUsersToFollow");
        cmd.prepare(get_TCompanyTweet_SetUsersToFollow_Metadata());
        InternalConnectionDelegate SetUsersToFollowDel = () =>
        {
          if (callback != null)
          {
            try
            {
              callback.DynamicInvoke();
            }
            catch (Exception ex)
            {
              if (ExCal != null) getConnection().syncContext.Send(new SendOrPostCallback(x => ExCal.DynamicInvoke(ex.InnerException)), null);
              else getConnection().syncContext.Send(new SendOrPostCallback(x => BaseExCal.DynamicInvoke(ex.InnerException)), null);
            }
          }
        };
        cmd.getParameter(0).getValue().SetAsJSONValue(Users);
        getConnection().execute(cmd, this, SetUsersToFollowDel, ExCal);
      }
      private DSRESTParameterMetaData[] TCompanyTweet_SendTweet_Metadata;
      private DSRESTParameterMetaData[] get_TCompanyTweet_SendTweet_Metadata()
      {
        if (TCompanyTweet_SendTweet_Metadata == null)
        {
          TCompanyTweet_SendTweet_Metadata = new DSRESTParameterMetaData[]
          {
            new DSRESTParameterMetaData("Tweet", DSRESTParamDirection.Input, DBXDataTypes.WideStringType, "string"),
          };
        }
        return TCompanyTweet_SendTweet_Metadata;
      }

      /**
       * @param Tweet [in] - Type on server: string
       */
      public delegate void SendTweetCallback();

      public void SendTweet(String Tweet, SendTweetCallback callback = null, ExceptionCallback ExCal = null)
      {
        DSRESTCommand cmd = getConnection().CreateCommand();
        cmd.setRequestType(DSHTTPRequestType.GET);
        cmd.setText("TCompanyTweet.SendTweet");
        cmd.prepare(get_TCompanyTweet_SendTweet_Metadata());
        InternalConnectionDelegate SendTweetDel = () =>
        {
          if (callback != null)
          {
            try
            {
              callback.DynamicInvoke();
            }
            catch (Exception ex)
            {
              if (ExCal != null) getConnection().syncContext.Send(new SendOrPostCallback(x => ExCal.DynamicInvoke(ex.InnerException)), null);
              else getConnection().syncContext.Send(new SendOrPostCallback(x => BaseExCal.DynamicInvoke(ex.InnerException)), null);
            }
          }
        };
        cmd.getParameter(0).getValue().SetAsString(Tweet);
        getConnection().execute(cmd, this, SendTweetDel, ExCal);
      }
    }

  }
}
