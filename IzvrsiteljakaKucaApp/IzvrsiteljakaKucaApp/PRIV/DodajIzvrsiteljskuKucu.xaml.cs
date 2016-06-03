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
    /// Interaction logic for DodajIzvrsiteljskuKucu.xaml
    /// </summary>
    public partial class DodajIzvrsiteljskuKucu : Window
    {
        SqlConnection konekcija;
        public DodajIzvrsiteljskuKucu(SqlConnection konekcija)
        {
            InitializeComponent();
            this.konekcija = konekcija;
        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {
            if (proveraPolja())
            {
                using (SqlCommand komanda = new SqlCommand("SP_DODAJ_IZVRSITELJSKU_KUCU", konekcija))
                {
                    komanda.CommandType = System.Data.CommandType.StoredProcedure;
                    komanda.Parameters.AddWithValue("@ime_veze", int.Parse(txtImeVeze.Text));
                    komanda.Parameters.AddWithValue("@traje_do", datePicker.SelectedDate);
                    komanda.Parameters.AddWithValue("@datum_dodavanja", DateTime.Now);
                    komanda.Parameters.AddWithValue("@lice_odobrilo", int.Parse(txtLiceOdobrilo.Text));
                    komanda.Parameters.AddWithValue("@lice_id", int.Parse(txtIDLica.Text));
                    komanda.Parameters.AddWithValue("@prganizaciona_jedinica", int.Parse(txtOrganizacionaJednica.Text));
                    komanda.Parameters.AddWithValue("@izvrsitelj_id", int.Parse(txtIDIzvrsitelja.Text));
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
                if (txt.Text.Equals("")) return false;
            if (datePicker.SelectedDate == null || datePicker.SelectedDate < DateTime.Now) return false;
            return true;
        }
    }
}
