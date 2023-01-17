using System;
using System.Collections.Generic;
using System.Data.Entity;
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
using System.Windows.Shapes;
using System.Data;

namespace Prakt20_praktika_
{
    /// <summary>
    /// Логика взаимодействия для AddZakaz.xaml
    /// </summary>
    public partial class AddZakaz : Window
    {
        ZakasEntitiesContext db = ZakasEntitiesContext.GetContext();
        Zakaz _zakaz;
        public AddZakaz()
        {
            InitializeComponent();
        }

        private void Quit_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            db.Clients.Load();
            cbClient.ItemsSource = db.Clients.ToList();
            cbClient.DisplayMemberPath = "ClientName";
            db.Tovars.Load();
            cbTovar.ItemsSource = db.Tovars.ToList();
            cbTovar.DisplayMemberPath = "TovarName";
            DataPicker.SelectedDate = DateTime.Now;
        }

        private void AddZakazik_Click(object sender, RoutedEventArgs e)
        {
            _zakaz = new Zakaz();
            StringBuilder error = new StringBuilder();
            if (cbClient.SelectedItem == null) error.AppendLine("Выберите клиента");
            if (cbTovar.SelectedItem == null) error.AppendLine("Выберите товар");
            if (error.Length > 0)
            {
                MessageBox.Show(error.ToString());
                return;
            }
            _zakaz.IdClient = ((Client)(cbClient.SelectedItem)).IdClient;
            _zakaz.IdTovar = ((Tovar)(cbTovar.SelectedItem)).IdTovar;
            _zakaz.DateZakaz = (DateTime)DataPicker.SelectedDate;
            db.Zakazs.Add(_zakaz);
            db.SaveChanges();
            Close();
        }
    }
}
