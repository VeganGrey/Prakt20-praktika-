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
            try
            {
                var row = (Zakaz)datagrib.SelectedItem;
                db.Zakazs.Remove(row);
                db.SaveChanges();
                datagrib.Items.Refresh();
            }
            catch(ArgumentOutOfRangeException)
            {
                MessageBox.Show("Сначала выберите запись");
            }

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

        private void AllSumm_Button(object sender, RoutedEventArgs e)
        {
            if (Data.check == false)
            {
                AllSummZakaz allsumm = new AllSummZakaz();
                allsumm.Show();
                Data.check = true;
            }
            else
            {
                MessageBox.Show("Окно уже открыто!", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void FindZakaz_Button(object sender, RoutedEventArgs e)
        {
            if (Data.check1 == false)
            {
                CenturyZakaz century = new CenturyZakaz();
                century.Show();
                Data.check1 = true;
            }
            else
            {
                MessageBox.Show("Окно уже открыто","Предупреждение",MessageBoxButton.OK,MessageBoxImage.Warning);
            }
        }

        private void Quit(object sender, RoutedEventArgs e)
        {
            MessageBoxResult res = MessageBox.Show("Вы точно хотите выйти?","Выход",MessageBoxButton.YesNo,MessageBoxImage.Warning);
            if (res == MessageBoxResult.Yes)
            {
                this.Close();
            }

        }

        private void Spravka_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Задание 1.Создать таблицы: \nТаблица 1.Каталог товаров.Структура таблицы: Код товара, Наименование товара, Цена\nТаблица 2.Заказы.Структура таблицы: Номер заказа, Дата заказа, Код клиента, Код товара, Количество Таблица \n3.Клиенты.Структура таблицы: Код клиента, Наименование клиента, Город, Адрес, Телефон.\n\n" +
                "Задание 2. С помощью SQL-запроса подсчитать стоимость заказа. Запрос должен содержать поля: Номер заказа, Стоимость.\n" +
                "Задание 3. Составить SQL-запрос, позволяющий просмотреть заказы товаров по заданному месяцу. Запрос должен содержать поля: Номер месяца, Наименование товара, Всего заказано.","Задание",MessageBoxButton.OK,MessageBoxImage.Asterisk);
        }

        private void FindIdZakaz_Button(object sender, RoutedEventArgs e)
        {
            if (idzakazika.Text.Length == 0)
            {
                MessageBox.Show("Введите цифру");
                return;
            }
            for (int i = 0; i < datagrib.Items.Count; i++)
            {
                var row = (Zakaz)datagrib.Items[i];
                int findContent = row.IdZakaz;
                try
                {
                    if (findContent == Convert.ToInt32(idzakazika.Text))
                    {
                        object item = datagrib.Items[i];
                        datagrib.SelectedItem = item;
                        datagrib.ScrollIntoView(item);
                        datagrib.Focus();
                        break;
                    }
                }
                catch
                {
                    MessageBox.Show("Не найдено совпадений");
                }
            }
        }
    }
}
namespace Prakt20_praktika_
{
    public static class Data
    {
        public static Zakaz Record;
        public static bool check;
        public static bool check1;
    }
}