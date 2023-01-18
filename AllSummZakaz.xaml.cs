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
    /// Логика взаимодействия для AllSummZakaz.xaml
    /// </summary>
    public partial class AllSummZakaz : Window
    {
        ZakasEntitiesContext db = ZakasEntitiesContext.GetContext();
        public AllSummZakaz()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            db.Zakazikis.Load();
            allgrib.ItemsSource = db.Zakazikis.Local.ToBindingList();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            Data.check = false;
        }

        private void Quit(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
