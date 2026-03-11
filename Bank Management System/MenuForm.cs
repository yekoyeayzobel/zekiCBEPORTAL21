using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
namespace Bank_Management_System
{
    public partial class MenuForm : Form
    {
        public MenuForm()
        {
            InitializeComponent();
        }

        SqlConnection conn = new SqlConnection(
"Data Source = (localdb)\\MSSQLLocalDB; Initial Catalog = C:\\USERS\\TEST\\DOCUMENTS\\AMDB.MDF;Integrated Security = True; Connect Timeout = 30; Encrypt=True;TrustServerCertificate=False;");
        private void btndeposie_Click(object sender, EventArgs e)
        {
            DepositeForm d = new DepositeForm();
            d.ShowDialog();
        }

        private void btnwithdraw_Click(object sender, EventArgs e)
        {
            WithdrawForm w = new WithdrawForm();
            w.ShowDialog();
        }

        private void btnbalance_Click(object sender, EventArgs e)
        {
            MessageBox.Show(
                "Current Balance: " +
                BankData.CurrentAccount.Balance.ToString("C"));
        }

        private void btnexit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnx_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btntransfer_Click(object sender, EventArgs e)
        {
            TransferForm t = new TransferForm();
            t.ShowDialog();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            // Close the current form (TransferForm)
            this.Close();

            // Create a new instance of Form1 and show it
            Form1 form1 = new Form1();
            form1.Show();
        }

        private void MenuForm_Load(object sender, EventArgs e)
        {

        }
    }
}
