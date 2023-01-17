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
    /// Логика взаимодействия для SpravochnikTovar.xaml
    /// </summary>
    public partial class SpravochnikTovar : Window
    {
        ZakasEntitiesContext db = ZakasEntitiesContext.GetContext();
        public SpravochnikTovar()
        {
            InitializeComponent();
        }

        private void Quit(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void AddTovar_Click(object sender, RoutedEventArgs e)
        {
            Tovar tovar = new Tovar();
            StringBuilder error = new StringBuilder();
            if (Tovar.Text.Length == 0) error.AppendLine("Введите название");
            if (Price.Text.Length == 0) error.AppendLine("Введите цену");
            if (error.Length > 0)
            {
                MessageBox.Show(error.ToString());
                return;
            }
            tovar.TovarName = Tovar.Text;
            tovar.PriceTovar = Convert.ToInt32(Price.Text);
            db.Tovars.Add(tovar);
            db.SaveChanges();
            datagribTovar.Items.Refresh();
            Tovar.Clear();
            Price.Clear();
        }

        private void DeleteTovar_Click(object sender, RoutedEventArgs e)
        {
            var row = (Tovar)datagribTovar.SelectedItem;
            db.Tovars.Remove(row);
            db.SaveChanges();
            datagribTovar.Items.Refresh();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            db.Tovars.Load();
            datagribTovar.ItemsSource = db.Tovars.Local.ToBindingList();
        }
    }
}
