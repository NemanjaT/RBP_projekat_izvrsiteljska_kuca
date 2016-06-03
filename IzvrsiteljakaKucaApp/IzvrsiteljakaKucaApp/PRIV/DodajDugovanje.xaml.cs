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
    /// Interaction logic for DodajDugovanje.xaml
    /// </summary>
    public partial class DodajDugovanje : Window
    {
        SqlConnection konekcija;
        public DodajDugovanje(SqlConnection konekcija)
        {
            InitializeComponent();
            this.konekcija = konekcija;
        }
        private bool proveraPolja()
        {
            IEnumerable<TextBox> kolekcija = Grid.Children.OfType<TextBox>();
            foreach (TextBox txt in kolekcija)
                if (txt.Text.Equals("")) return false;
            if (datePicker.SelectedDate == null || datePicker.SelectedDate < DateTime.Now) return false;
            return true;
        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {
            if (proveraPolja())
            {
                using(SqlCommand komanda=new SqlCommand("SP_DODAJ_DUGOVANJE",konekcija))
                {
                    komanda.CommandType = System.Data.CommandType.StoredProcedure;
                    komanda.Parameters.AddWithValue("@lice_id", int.Parse(txtLiceID.Text));
                    komanda.Parameters.AddWithValue("@izvrsiteljska_kuca_id", int.Parse(txtIzvrsiteljksakKucaID.Text));
                    komanda.Parameters.AddWithValue("@suma_dugovanja", Double.Parse(txtSuma.Text));
                    komanda.Parameters.AddWithValue("@datum_unosa", DateTime.Now);
                    komanda.Parameters.AddWithValue("@rok_isplate", datePicker.SelectedDate);
                    komanda.Parameters.AddWithValue("@razlog", txtRazlog.Text);
                    try
                    {
                        komanda.ExecuteNonQuery();
                        MessageBox.Show("Uspesno dodato u bazu!");
                    }catch(Exception exc) {
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
    }
}
