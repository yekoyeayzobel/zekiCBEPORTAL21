using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace Bank_Management_System
{
    public partial class Register : Form
    {
        // የዳታቤዝ ግንኙነት መስመር
        string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\TEST\Documents\BankData.mdf;Integrated Security=True;Connect Timeout=30";

        public Register()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // ባዶ ቦታ መኖሩን ማረጋገጥ
            if (string.IsNullOrEmpty(Accnum.Text) || string.IsNullOrEmpty(name.Text))
            {
                MessageBox.Show("እባክዎ ሁሉንም መረጃዎች በትክክል ይሙሉ!");
                return;
            }

            try
            {
                // 'using' መጠቀም ኮኔክሽኑ በራሱ እንዲዘጋ ይረዳል
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // ጥያቄውን (Query) በፓራሜትር ማዘጋጀት - ለደህንነት አስተማማኝ ነው
                    string query = "INSERT INTO BankData (AccNum, Name, FName, Phone, Pin, Balance) VALUES (@Acc, @Name, @FName, @Phone, @Pin, @Bal)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // መረጃዎቹን መተካት
                        cmd.Parameters.AddWithValue("@Acc", Accnum.Text);
                        cmd.Parameters.AddWithValue("@Name", name.Text);
                        cmd.Parameters.AddWithValue("@FName", fname.Text);
                        cmd.Parameters.AddWithValue("@Phone", phone.Text);
                        cmd.Parameters.AddWithValue("@Pin", pin.Text);
                        cmd.Parameters.AddWithValue("@Bal", balance.Text);

                        cmd.ExecuteNonQuery();
                        MessageBox.Show("አካውንት በትክክል ተከፍቷል!");
                    }
                }
            }
            catch (Exception Ex)
            {
                MessageBox.Show("ስህተት ተከስቷል: " + Ex.Message);
            }
        }

        private void btnloog_Click(object sender, EventArgs e)
        {
            Form1 login = new Form1();
            login.Show();
            this.Hide(); // 'Close' ፋንታ 'Hide' መጠቀም ይመረጣል (ዋናው ፎርም ከሆነ)
        }
    }
}