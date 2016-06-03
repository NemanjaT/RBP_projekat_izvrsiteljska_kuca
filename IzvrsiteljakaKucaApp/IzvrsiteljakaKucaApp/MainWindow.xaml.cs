using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Data.SqlClient;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace IzvrsiteljakaKucaApp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            SqlConnectionStringBuilder konekcioniString = new SqlConnectionStringBuilder();
            konekcioniString.UserID = textBox.Text;
            konekcioniString.Password = passwordBox.Password;
            konekcioniString.InitialCatalog = "IZVRSITELJSKA_KUCA";
            konekcioniString.DataSource = "localhost";
            //konekcioniString.IntegratedSecurity = true;
            SqlConnection konekcija = new SqlConnection(konekcioniString.ToString());
            try
            {
                konekcija.Open();
                MessageBox.Show("Uspesno povezivanje sa bazom!");
                switch (textBox.Text)
                {
                    case "DB_KORISNIK": new Korisnik(konekcija).Show(); this.Close(); break;
                    case "DB_PRIV": new PRIV.Priv(konekcija).Show(); this.Close();  break;
                    case "DB_ADMIN": new Admin(konekcija).Show(); this.Close(); break;
                }
            }catch(Exception exc)
            {
                MessageBox.Show(exc.ToString());
                MessageBox.Show("Gresak pri logovanju! Proverite unete podatke!");
            }
        }
    }
}
