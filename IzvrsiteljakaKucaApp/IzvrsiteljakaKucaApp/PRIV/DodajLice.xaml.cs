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
using System.Windows.Shapes;

namespace IzvrsiteljakaKucaApp.PRIV
{
    /// <summary>
    /// Interaction logic for DodajLice.xaml
    /// </summary>
    public partial class DodajLice : Window
    {
        SqlConnection konekcija;
        public DodajLice(SqlConnection konekcija)
        {
            InitializeComponent();
            this.konekcija = konekcija;
        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {
            if (proveraPolja())
            {
                using (SqlCommand komanda = new SqlCommand("SP_DODAJ_LICE", konekcija))
                {
                    komanda.CommandType = System.Data.CommandType.StoredProcedure;
                    komanda.Parameters.AddWithValue("@ime", txtIme.Text);
                    komanda.Parameters.AddWithValue("@prezime", txtPrezime);
                    komanda.Parameters.AddWithValue("@datum_rodjenja", datePicker.SelectedDate);
                    komanda.Parameters.AddWithValue("@jmbg", txtJMBG.Text);
                    komanda.Parameters.AddWithValue("@adresa_stanovanja", txtAdresa.Text);
                    komanda.Parameters.AddWithValue("@dodatne_informacije", txtInformacije.Text);
                    komanda.Parameters.AddWithValue("@datum_dodavanja", DateTime.Now);
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
                if (txt.Name.Equals("txtInformacije")) continue;
                if (txt.Text.Equals("")) return false;
            }
            if (datePicker.SelectedDate == null || datePicker.SelectedDate < DateTime.Now) return false;
            return true;
        }
    }
}
