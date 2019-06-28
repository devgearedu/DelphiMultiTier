using System;
using System.IO.IsolatedStorage;
using Embarcadero.Datasnap.WindowsPhone7;
using System.Diagnostics;
using System.Threading;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Threading;
using System.Windows.Navigation;

namespace CompanyTweetClient
{
    static public class CTConnection
    {
        static private DSProxy.TCompanyTweet instance;
        static private DSCallbackChannelManager manager;
        static private DSCallbackChannelManager manager_cmd;
        static private IsolatedStorageSettings settings = IsolatedStorageSettings.ApplicationSettings;

        static public DSProxy.TCompanyTweet getCompanyTweet(DSAdmin.ExceptionCallback ManageExceptionCallback = null)
        {
            if (instance == null)
            {
                string hostname;
                string port;
               if (!settings.TryGetValue<string>("hostname", out hostname))
                    hostname = "datasnap.embarcadero.com";

                if (!settings.TryGetValue<string>("port", out port))
                    port = "8086";

                DSRESTConnection connection = new DSRESTConnection();
                connection.setHost(hostname);
                connection.setPort(Convert.ToInt32(port));
                connection.setProtocol("http");
                if (ManageExceptionCallback == null)
                    instance = new DSProxy.TCompanyTweet(connection, (e) => { MessageBox.Show("Session expired. Try to login again."); });
                else
                    instance = new DSProxy.TCompanyTweet(connection, ManageExceptionCallback);
            }
            return instance;
        }

        public static bool IsNull()
        {
            if (instance == null)
                return true;
            else return false;
        }

        public static void ResetProxy()
        {
            instance = null;
            manager = null;
            manager_cmd = null;
        }

        private static void RegisterCallbacks()
        {
            manager = new DSCallbackChannelManager(getCompanyTweet()
              .getConnection(), "ct", Convert.ToString((new Random()).Next(10000) + 1),
              (ex) =>
              {
                  MessageBox.Show(ex.Message);
              });
            DBXCallback cb = new CTCallback(SynchronizationContext.Current);
            try
            {
                manager.registerCallback(settings["Username"].ToString(), cb);
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.StackTrace);
            }

            manager_cmd = new DSCallbackChannelManager(getCompanyTweet()
              .getConnection(), "cmd", Convert.ToString((new Random()).Next(10000) + 1),
              (ex) =>
              {
                  MessageBox.Show(ex.Message);
              });
            DBXCallback cb_cmd = new CTCMDCallback(SynchronizationContext.Current);
            try
            {
                manager_cmd.registerCallback("cbcmd", cb_cmd);
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.StackTrace);
            }
        }



        public static void LoginUser(String username, Delegate OnLogin, Delegate OnExceptionLogin)
        {
            getCompanyTweet().LoginUser(username, (DSProxy.TCompanyTweet.LoginUserReturns result) =>
            {
                if (result.returnValue)
                {
                    if (!settings.Contains("Username")) settings.Add("Username", username);
                    else settings["Username"] = username;
                    settings.Save();

                    RegisterCallbacks();
                    OnLogin.DynamicInvoke();
                }
                else
                {
                    OnExceptionLogin.DynamicInvoke(new Exception(result.ReturnMessage));
                }
            }, 
            e =>
            {
                OnExceptionLogin.DynamicInvoke(e);
            });
        }

        public static void LogOut()
        {
            if (manager_cmd != null)
            {
                getCompanyTweet().Logout();
                ResetProxy();
            }
        }
    } 
}
