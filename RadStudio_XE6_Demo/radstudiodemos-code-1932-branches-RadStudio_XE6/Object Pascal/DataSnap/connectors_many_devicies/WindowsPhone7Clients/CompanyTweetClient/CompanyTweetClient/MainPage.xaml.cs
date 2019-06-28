﻿using System;
using System.IO.IsolatedStorage;
using System.Threading;
using System.Windows;
using Embarcadero.Datasnap.WindowsPhone7;
using Microsoft.Phone.Controls;
using System.Windows.Navigation;

namespace CompanyTweetClient
{
    public partial class MainPage : PhoneApplicationPage
    {
        protected DSRESTConnection Connection;
        private IsolatedStorageSettings settings = IsolatedStorageSettings.ApplicationSettings;
        // Constructor

        public MainPage()
        {
            InitializeComponent();
            if (settings.Contains("Username")) txtName.Text = settings["Username"].ToString();
        }

        private delegate void OnLogin();
        private delegate void OnException(Exception e);
        private void btn_Login(object sender, EventArgs e)
        {
            OnLogin LoginDelegate = () =>
                 Dispatcher.BeginInvoke(() => NavigationService.Navigate(new Uri("/UsersList.xaml", UriKind.Relative)));
            OnException ExceptionDelegate = (ex) =>
                 Dispatcher.BeginInvoke(() => MessageBox.Show(ex.Message));
            CTConnection.ResetProxy();
            CTConnection.LoginUser(txtName.Text, LoginDelegate, ExceptionDelegate);
        }

        protected void ManageExceptionCallback(Exception e)
        {
            this.Dispatcher.BeginInvoke(() => MessageBox.Show(e.Message));
        }

        private void mnuSetHost_Click(object sender, EventArgs e)
        {
            this.Dispatcher.BeginInvoke(() => { this.NavigationService.Navigate(new Uri("/Settings.xaml", UriKind.Relative)); });
        }
    }
}