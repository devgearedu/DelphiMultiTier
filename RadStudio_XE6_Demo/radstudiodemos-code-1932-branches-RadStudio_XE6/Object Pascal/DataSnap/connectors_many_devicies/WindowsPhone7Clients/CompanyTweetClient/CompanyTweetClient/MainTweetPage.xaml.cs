using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;
using System.Collections.ObjectModel;
using Newtonsoft.Json.Linq;
using Embarcadero.Datasnap.WindowsPhone7;
using System.IO.IsolatedStorage;

namespace CompanyTweetClient
{
    public partial class MainTweetPage : PhoneApplicationPage
    {
        public MainTweetPage()
        {
            InitializeComponent();
        }

        private void btnSendTweet_Click(object sender, RoutedEventArgs e)
        {
            CTConnection.getCompanyTweet().SendTweet(txtMsg.Text.ToString(), () =>
            {
                this.Dispatcher.BeginInvoke(() => txtMsg.Text = "");
            },
            ManageExceptionCallback);
        }

        protected void ManageExceptionCallback(Exception e)
        {
            this.Dispatcher.BeginInvoke(() => MessageBox.Show("Session Expired. Please, try to login again."));
            this.NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
        }

        private void ApplicationBarIconButton_Click(object sender, EventArgs e)
        {
            CTConnection.LogOut();
            this.Dispatcher.BeginInvoke(() =>
            {
                this.NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
            });
        }
    }
}