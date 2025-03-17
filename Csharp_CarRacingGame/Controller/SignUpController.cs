using project_ii_v3.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace project_ii_v3.Controller
{
    class SignUpController
    {
        public static bool createAccount(string username,string password,string checkPassword)
        {
            bool test = false;
            if (password==checkPassword && !DatabaseController.checkExistingUser(username))
            {
                test = true;//successfully inserted
                DatabaseController.insertNewUser(username, SHA2hash.string2SHA(password));
            }
            return test;
        }
    }
}
