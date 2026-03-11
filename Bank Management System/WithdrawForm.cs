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
    public partial class WithdrawForm : Form
    {
        public WithdrawForm()
        {
            InitializeComponent();
        }

        private void btnWithdraw_Click(object sender, EventArgs e)
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

            if (amount > BankData.CurrentAccount.Balance)
            {
                MessageBox.Show("Insufficient Balance");
                return;
            }

            BankData.CurrentAccount.Balance -= amount;
            MessageBox.Show("Withdraw Successful");
            this.Close();
        }

        private void btnx_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}