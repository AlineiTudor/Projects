using project_ii_v3.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace project_ii_v3.Controller
{
    class LogInController
    {
        public static bool logInToAccount(string username,string password)
        {
            bool test = DatabaseController.checkExistingAccount(username,SHA2hash.string2SHA(password));
            return test;
        }
    }
}
