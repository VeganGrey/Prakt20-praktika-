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
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        ZakasEntitiesContext db = ZakasEntitiesContext.GetContext();
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            db.Zakazs.Load();
            datagrib.ItemsSource = db.Zakazs.Local.ToBindingList();
        }

        private void AddZakaz_Button(object sender, RoutedEventArgs e)
        {
            AddZakaz add = new AddZakaz();
            add.ShowDialog();            
            datagrib.Items.Refresh();
            db.ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
            datagrib.Focus();
        }

        private void EditZakaz_Button(object sender, RoutedEventArgs e)
        {
            Data.Record = (Zakaz)datagrib.SelectedItem;
            EditZakaz edit = new EditZakaz();
            edit.ShowDialog();
            datagrib.Items.Refresh();
            datagrib.Focus();
        }

        private void DeleteZakazik_Button(object sender, RoutedEventArgs e)
        {
            var row = (Zakaz)datagrib.SelectedItem;
            db.Zakazs.Remove(row);
            db.SaveChanges();
            datagrib.Items.Refresh();
        }

        private void SpravochnikClient_Button(object sender, RoutedEventArgs e)
        {
            SpravochikClient spravclient = new SpravochikClient();
            spravclient.ShowDialog();
            datagrib.Items.Refresh();
        }

        private void SpavochnikTovar_Button(object sender, RoutedEventArgs e)
        {
            SpravochnikTovar sprtovar = new SpravochnikTovar();
            sprtovar.ShowDialog();
            datagrib.Items.Refresh();
        }
    }
}
namespace Prakt20_praktika_
{
    public static class Data
    {
        public static Zakaz Record;
    }
}