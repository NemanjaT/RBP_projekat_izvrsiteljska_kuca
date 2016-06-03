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
using System.Windows.Shapes;
using System.Data.SqlClient;

namespace IzvrsiteljakaKucaApp.PRIV
{
    /// <summary>
    /// Interaction logic for DodajIzvrsitelja.xaml
    /// </summary>
    public partial class DodajIzvrsitelja : Window
    {
        SqlConnection konekcija;
        public DodajIzvrsitelja(SqlConnection konekcija)
        {
            InitializeComponent();
            this.konekcija = konekcija;
        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {
            if (proveraPolja())
            {
                using (SqlCommand komanda = new SqlCommand("SP_DODAJ_IZVRSITELJA", konekcija))
                {
                    komanda.CommandType = System.Data.CommandType.StoredProcedure;
                    komanda.Parameters.AddWithValue("@ime", txtIme.Text);
                    komanda.Parameters.AddWithValue("@prezime", txtPrezime.Text);
                    komanda.Parameters.AddWithValue("@sifra_ugovora", txtSifraUgovora.Text);
                    komanda.Parameters.AddWithValue("@plata", Double.Parse(txtPlata.Text));
                    komanda.Parameters.AddWithValue("@datum_zaposljavanja", datePicker.SelectedDate);
                    komanda.Parameters.AddWithValue("@tip_izvrsitelja_id", int.Parse(txtTipIzvrsitelja.Text));
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
                if (txt.Text.Equals("")) return false;
            }
            if (datePicker.SelectedDate == null || datePicker.SelectedDate < DateTime.Now) return false;
            return true;
        }
    }
}
