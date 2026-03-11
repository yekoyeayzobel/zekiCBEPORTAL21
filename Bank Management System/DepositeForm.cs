using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Bank_Management_System
{
    public partial class DepositeForm : Form
    {
        public DepositeForm()
        {
            InitializeComponent();
        }

        private void btnbalance_Click(object sender, EventArgs e)
        {
            decimal amount;

            if (!decimal.TryParse(txtAmount.Text, out amount))
            {
                MessageBox.Show("Enter valid amount");
                return;
            }

            if (amount <= 0)
            {
                MessageBox.Show("Invalid amount");
                return;
            }

            BankData.CurrentAccount.Balance += amount;
            MessageBox.Show("Deposit Successful");
            this.Close();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void btnx_Click(object sender, EventArgs e)
        {
            Application.Exit(); 
        }
    }
}