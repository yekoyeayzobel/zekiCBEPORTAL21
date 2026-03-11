using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Bank_Management_System
{
    public class Account
    {
        public string AccountNumber { get; set; }
        public string Pin { get; set; }
        public decimal Balance { get; set; }

        public Account(string acc, string pin, decimal bal)
        {
            AccountNumber = acc;
            Pin = pin;
            Balance = bal;
        }
    }
}