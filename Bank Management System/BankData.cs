using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bank_Management_System
{
    public static class BankData
    {
        public static List<Account> Accounts = new List<Account>()
        {
            new Account("1001","1111",5000),
            new Account("1002","2222",8000),
            new Account("1003","3333",12000)
        };

        public static Account CurrentAccount;
    }
}
