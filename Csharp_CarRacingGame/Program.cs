using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using project_ii_v3.Controller;
using project_ii_v3.View;

namespace project_ii_v3
{

    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            StartGameWindow mainWindow = new StartGameWindow();
            Application.Run(mainWindow);
        }
    }
}