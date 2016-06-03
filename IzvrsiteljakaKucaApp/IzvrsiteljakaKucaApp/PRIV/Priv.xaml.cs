using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace IzvrsiteljakaKucaApp.PRIV
{
    /// <summary>
    /// Interaction logic for Priv.xaml
    /// </summary>
    public partial class Priv : Window
    {
        SqlConnection konekcija;
        public Priv(SqlConnection konekcija)
        {
            InitializeComponent();
            this.konekcija = konekcija;
            ucitavanjeIzBaze("V_DUGOVANJA");
        }

        private void btnDugovanja_Click(object sender, RoutedEventArgs e)
        {
            ucitavanjeIzBaze("V_DUGOVANJA");
        }

        private void btnTransakcije_Click(object sender, RoutedEventArgs e)
        {
            ucitavanjeIzBaze("V_TRANSAKCIJE");
        }

        private void btnIzvrsiteljskeKuce_Click(object sender, RoutedEventArgs e)
        {
            ucitavanjeIzBaze("V_IZVRSITELJSKE_KUCE");
        }

        private void btnGrupe_Click(object sender, RoutedEventArgs e)
        {
            ucitavanjeIzBaze("V_GRUPE_ORG_JEDINICA");
        }

        //Metoda koja ucitava podatke iz baze i smesta ih u listu
        private void ucitavanjeIzBaze(string view)
        {
            Grid.Columns.Clear();
            lista.ItemsSource = null;
            using (SqlCommand komanda = new SqlCommand("SELECT * FROM " + view, konekcija))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(komanda))
                {
                    using (DataTable tabela = new DataTable())
                    {
                        try
                        {
                            adapter.Fill(tabela);
                            foreach (DataColumn kolona in tabela.Columns)
                            {
                                GridViewColumn coll = new GridViewColumn();
                                coll.Header = kolona.ToString();
                                coll.DisplayMemberBinding = new Binding(kolona.ToString());
                                coll.Width = 100;
                                Grid.Columns.Add(coll);
                            }
                            lista.ItemsSource = tabela.DefaultView;
                        }
                        catch (Exception exc)
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

        private void btnDodajDugovanje_Click(object sender, RoutedEventArgs e)
        {
            new DodajDugovanje(konekcija).Show();
        }

        private void btnDodajIzvrsiteljskuKucu_Click(object sender, RoutedEventArgs e)
        {
            new DodajIzvrsiteljskuKucu(konekcija).Show();
        }

        private void btnDodajIzvrsitelja_Click(object sender, RoutedEventArgs e)
        {
            new DodajIzvrsitelja(konekcija).Show();
        }

        private void btnDodajLice_Click(object sender, RoutedEventArgs e)
        {
            new DodajLice(konekcija).Show();
        }

        private void btnDodajTransakciju_Click(object sender, RoutedEventArgs e)
        {
            new DodajTransakciju(konekcija).Show();
        }

        private void btnNazad_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
