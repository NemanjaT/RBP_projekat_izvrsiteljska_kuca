using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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

namespace IzvrsiteljakaKucaApp.PRIV
{
    /// <summary>
    /// Interaction logic for DodajTransakciju.xaml
    /// </summary>
    public partial class DodajTransakciju : Window
    {
        SqlConnection konekcija;
        public DodajTransakciju(SqlConnection konekcija)
        {
            InitializeComponent();
            this.konekcija = konekcija;
        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {
            if (proveraPolja())
            {
                using (SqlCommand komanda = new SqlCommand("SP_DODAJ_TRANSAKCIJU", konekcija))
                {
                    komanda.CommandType = System.Data.CommandType.StoredProcedure;
                    komanda.Parameters.AddWithValue("@dugovanje_id", int.Parse(txtIDDugovanja.Text));
                    komanda.Parameters.AddWithValue("@datum_uplate", DateTime.Now);
                    komanda.Parameters.AddWithValue("@uplata", Double.Parse(txtUplata.Text));
                    komanda.Parameters.AddWithValue("@poruka", txtPoruka.Text);
                    try
                    {
                        komanda.ExecuteNonQuery();
                        MessageBox.Show("Uspesno dodato u bazu!");
                    }
                    catch (Exception exc)
                    {
                        MessageBox.Show(exc.ToString());
                        MessageBox.Show("Greska pri dodavanju!");
                    }
                }
            }
            else MessageBox.Show("Proverite da li ste uneli sve vrednsoti i da li su ispravne!!!");
        }

        private void btnNazad_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        private bool proveraPolja()
        {
            IEnumerable<TextBox> kolekcija = Grid.Children.OfType<TextBox>();
            foreach (TextBox txt in kolekcija)
            {
                if (txt.Name.Equals("txtPoruka")) continue;
                if (txt.Text.Equals("")) return false;
            }
            return true;
        }
    }
}
