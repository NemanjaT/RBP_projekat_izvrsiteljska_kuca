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
    /// Interaction logic for Admin.xaml
    /// </summary>
    public partial class Admin : Window
    {
        SqlConnection konekcija;
        public Admin(SqlConnection konekcija)
        {
            InitializeComponent();
            this.konekcija = konekcija;
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            try
            {
                konekcija.Close();
                new MainWindow().Show();
            }
            catch(Exception exc) { MessageBox.Show(exc.ToString()); }

        }

        private void btnIzvrsi_Click(object sender, RoutedEventArgs e)
        {
            Grid.Columns.Clear();
            lista.ItemsSource = null;
            using (SqlCommand komanda = new SqlCommand(txtSQL.Text, konekcija))
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
                        }
                    }
                }
            }
        }

        private void bntNazad_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
