using System;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace Bank_Management_System
{
    public partial class Form1 : Form
    {
        SqlConnection conn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Habesha Computers\Documents\ATM.mdf"";Integrated Security=True;Connect Timeout=30");
        public Form1()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            
                conn.Open();
            String sql = "select COUNT(*) from Register where Accnum='" + int.Parse(txtAccount.Text)+"',pin='"+int.Parse(txtPin.Text)+"'";
            SqlCommand cmd=new SqlCommand(sql, conn);
            int row=(int)cmd.ExecuteScalar();
            if (row ==1)
            {
                MenuForm menu = new MenuForm();
                menu.Show();
                this.Hide();
                return;
            }
               
            
           
        }

        private void txtAccount_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();

        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            Register RRR = new Register();
            RRR.Show();
            this.Hide();
            return;
        }
    }
}



