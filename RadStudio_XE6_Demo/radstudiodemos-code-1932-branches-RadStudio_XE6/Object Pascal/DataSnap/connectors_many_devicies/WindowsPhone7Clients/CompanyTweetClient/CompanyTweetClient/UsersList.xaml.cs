﻿using System;
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

using Newtonsoft.Json.Linq;
using Embarcadero.Datasnap.WindowsPhone7;
using System.IO.IsolatedStorage;
using System.Windows.Navigation;


namespace CompanyTweetClient
{
    public partial class UsersList : PhoneApplicationPage
    {

        public UsersList()
        {
            InitializeComponent();
            Loaded += UsersList_Loaded;
        }

        private void UsersList_Loaded(object sender, RoutedEventArgs e)
        {
            if (CTConnection.IsNull())
                this.NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
            else
                LoadUsersList();
        }

        private void LoadUsersList()
        {
            CTConnection.getCompanyTweet().UsersList(users =>
            {
                this.Dispatcher.BeginInvoke(() =>
                {
                    int i = 0;
                    for (i = 0; i < users.size(); i++)
                    {
                        listBox1.Items.Add(users.getJSONObject(i).getString("username"));
                    }
                });
            }, ManageExceptionCallback);
        }

        private void Follow_Users(object sender, EventArgs e)
        {
            TJSONArray users = new TJSONArray();
            if (listBox1.SelectedItems.Count != 0)
            {
                for (int i = 0; i < listBox1.SelectedItems.Count; i++)
                {
                    users.add(new TJSONString(listBox1.SelectedItems[i].ToString()));
                }
                CTConnection.getCompanyTweet().SetUsersToFollow(users, () =>
                {
                    this.Dispatcher.BeginInvoke(() => { this.NavigationService.Navigate(new Uri("/MainTweetPage.xaml", UriKind.Relative)); });
                });
            }
            else
            {
                this.Dispatcher.BeginInvoke(() => { this.NavigationService.Navigate(new Uri("/MainTweetPage.xaml", UriKind.Relative)); });
            }
        }

        protected void ManageExceptionCallback(Exception e)
        {
            this.Dispatcher.BeginInvoke(() => MessageBox.Show("Session Expired. Please, try to login again."));
            this.NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            listBox1.Items.Clear();
            LoadUsersList();
        }

        private void ApplicationBarIconButton_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
            LoadUsersList();
        }

        private void PhoneApplicationPage_BackKeyPress(object sender, System.ComponentModel.CancelEventArgs e)
        {
            CTConnection.LogOut();
        }

        private void ApplicationBarIconButton_Click_2(object sender, EventArgs e)
        {
            CTConnection.LogOut();
            this.Dispatcher.BeginInvoke(() =>
            {
                this.NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
            });
        }
    }


}