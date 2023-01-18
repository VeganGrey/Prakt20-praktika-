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
    /// Логика взаимодействия для CenturyZakaz.xaml
    /// </summary>
    public partial class CenturyZakaz : Window
    {
        public CenturyZakaz()
        {
            InitializeComponent();
        }
        ZakasEntitiesContext db = ZakasEntitiesContext.GetContext();
        private void FindMonth_Button(object sender, RoutedEventArgs e)
        {
            var monthsumm = from p in db.Zakazs
                            where p.DateZakaz.Month == dataPicker.DisplayDate.Month
                            select p;
            centurygrib.ItemsSource = monthsumm.ToList();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            Data.check1 = false;
        }

        private void Quit(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
