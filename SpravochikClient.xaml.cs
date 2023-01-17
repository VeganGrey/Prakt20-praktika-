using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data;
using System.Data.Entity;

namespace Prakt20_praktika_
{
    /// <summary>
    /// Логика взаимодействия для SpravochikClient.xaml
    /// </summary>
    public partial class SpravochikClient : Window
    {
        ZakasEntitiesContext db = ZakasEntitiesContext.GetContext();
        public SpravochikClient()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            db.Clients.Load();
            datagribclient.ItemsSource = db.Clients.Local.ToBindingList();
        }

        private void Quit_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void DeleteClient_Button(object sender, RoutedEventArgs e)
        {
            var row = (Client)datagribclient.SelectedItem;
            db.Clients.Remove(row);
            db.SaveChanges();
            datagribclient.Items.Refresh();
        }

        private void AddClient_Button(object sender, RoutedEventArgs e)
        {
            Client kent = new Client();
            StringBuilder error = new StringBuilder();
            if (name.Text.Length == 0) error.AppendLine("Введите имя");
            if (error.Length > 0)
            {
                MessageBox.Show(error.ToString());
                return;
            }
            kent.ClientName = name.Text;
            kent.City = city.Text;
            kent.Adress = adress.Text;
            kent.PhoneNumber = phone.Text;
            db.Clients.Add(kent);
            db.SaveChanges();
            datagribclient.Items.Refresh();
            name.Clear();
            city.Clear();
            adress.Clear();
            phone.Clear();
        }
    }
}
