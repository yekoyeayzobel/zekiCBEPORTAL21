using System;
using System.Windows.Forms;

namespace Bank_Management_System
{
    public partial class TransferForm : Form
    {
        public TransferForm()
        {
            InitializeComponent();
        }

        
        

        private void btntransfer_Click_1(object sender, EventArgs e)
        {
            string receiverAccNo = txtToaccoount.Text.Trim();
            decimal amount;

            if (!decimal.TryParse(txtAmount.Text, out amount) || amount <= 0)
            {
                MessageBox.Show("Please enter a valid amount");
                return;
            }

            // Logged-in account (Sender)
            Account fromAccount = BankData.CurrentAccount;

            // Find receiver account from list
            Account receiver = BankData.Accounts
                .Find(a => a.AccountNumber == receiverAccNo);

            if (receiver == null)
            {
                MessageBox.Show("Receiver account not found");
                return;
            }

            if (receiver.AccountNumber == fromAccount.AccountNumber)
            {
                MessageBox.Show("You cannot transfer to your own account");
                return;
            }

            if (fromAccount.Balance < amount)
            {
                MessageBox.Show("Insufficient balance");
                return;
            }

            // ✔ Perform Transfer
            fromAccount.Balance -= amount;
            receiver.Balance += amount;

            MessageBox.Show("Transfer Successful");
            this.Close();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            // Close the current form (TransferForm)
            this.Close();

            // Create a new instance of Form1 and show it
            Form1 form1 = new Form1();
            form1.Show();

        }

        private void txtAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtToaccoount_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
        
    
