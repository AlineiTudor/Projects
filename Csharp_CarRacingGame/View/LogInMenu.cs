using project_ii_v3.Controller;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Media;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace project_ii_v3.View
{
    public partial class LogInMenu : Form
    {

        private static LogInMenu _logInMenuInstance = null;
        private SoundPlayer soundPlayer;
        private static bool cerintaMarket;
        private LogInMenu(SoundPlayer sound)
        {
            InitializeComponent();
            soundPlayer = sound;
        }
        public static LogInMenu getInstance(SoundPlayer sound, bool market)
        {
            cerintaMarket = market;
            if (_logInMenuInstance == null)
            {
                _logInMenuInstance = new LogInMenu(sound);
            }
            return _logInMenuInstance;
        }

        private void LogInMenu_FormClosed(object sender, FormClosedEventArgs e)
        {
            _logInMenuInstance = null;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (LogInController.logInToAccount(username.Text, password.Text))
            {
                if (!cerintaMarket)
                {
                    GameWindow gameWindow = new GameWindow(username.Text);
                    gameWindow.Show();
                    this.Hide();
                    soundPlayer.Stop();
                } else
                {
                    Market market = Market.getInstance(username.Text, soundPlayer);
                    this.Hide();
                    market.Show();
                }
            }
            else { MessageBox.Show("No account found"); }
        }
    }
}
