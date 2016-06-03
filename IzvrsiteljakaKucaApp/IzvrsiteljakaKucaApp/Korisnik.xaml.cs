using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Data.SqlClient;
using System.Data;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace IzvrsiteljakaKucaApp
{
    /// <summary>
    /// Interaction logic for Korisnik.xaml
    /// </summary>
    public partial class Korisnik : Window
    {
        SqlConnection konekcija;
        public Korisnik(SqlConnection konekcija)
        {
            InitializeComponent();
            this.konekcija = konekcija;
            ucitavanjeIzBaze("V_LICA");
        }

        private void btnDugovanja_Click(object sender, RoutedEventArgs e)
        {
            ucitavanjeIzBaze("V_DUGOVANJA");
        }

        private void btnLica_Click(object sender, RoutedEventArgs e)
        {
            ucitavanjeIzBaze("V_LICA");
        }

        private void btnIzvrsitelji_Click(object sender, RoutedEventArgs e)
        {
            ucitavanjeIzBaze("V_IZVRSITELJI");
        }

        private void btnGrupe_Click(object sender, RoutedEventArgs e)
        {
            ucitavanjeIzBaze("V_ORG_JED_GRUPE");
        }

        private void btnJedinice_Click(object sender, RoutedEventArgs e)
        {
            ucitavanjeIzBaze("V_ORGANIZACIONE_JEDINICE");
        }

        //Metoda koja ucitava podatke iz baze i smesta ih u listu
        private void ucitavanjeIzBaze(string view)
        {
            Grid.Columns.Clear();
            lista.ItemsSource = null;
            using(SqlCommand komanda=new SqlCommand("SELECT * FROM " + view, konekcija))
            {
                using(SqlDataAdapter adapter= new SqlDataAdapter(komanda))
                {
                    using (DataTable tabela = new DataTable())
                    {
                        try
                        {
                            adapter.Fill(tabela);
                            foreach(DataColumn kolona in tabela.Columns)
                            {
                                GridViewColumn coll = new GridViewColumn();
                                coll.Header = kolona.ToString();
                                coll.DisplayMemberBinding = new Binding(kolona.ToString());
                                coll.Width = 100;
                                Grid.Columns.Add(coll);
                            }
                            lista.ItemsSource = tabela.DefaultView;
                        }catch(Exception exc)
                        {
                            MessageBox.Show(exc.ToString());
                            MessageBox.Show("Gresak pri ucitavanju podataka!");
                        }
                    }
                }
            }
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            try
            {
                konekcija.Close();
            }catch(Exception exc) { MessageBox.Show(exc.ToString()); }
            new MainWindow().Show();
        }
    }
}
