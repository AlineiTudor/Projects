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
    public partial class SignUpMenu : Form
    {
        private static SignUpMenu _signUpMenuInstance = null;
        private SoundPlayer soundPlayer;
        private SignUpMenu(SoundPlayer sound)
        {
            InitializeComponent();
            soundPlayer = sound;
        }
        public static SignUpMenu getInstance(SoundPlayer sound)
        {
            if (_signUpMenuInstance == null)
            {
                _signUpMenuInstance = new SignUpMenu(sound);
            }
            return _signUpMenuInstance;
        }

        private void SignUpMenu_FormClosed(object sender, FormClosedEventArgs e)
        {
            _signUpMenuInstance = null;
        }

        private void signUpButton_Click(object sender, EventArgs e)
        {
            if (SignUpController.createAccount(username.Text, password.Text, confirmPassword.Text))
            {
                GameWindow gameWindow = new GameWindow(username.Text);
                gameWindow.Show();
                this.Hide();
                soundPlayer.Stop();
            }
            else if(password.Text!=confirmPassword.Text){ MessageBox.Show("Incorect password"); }
            else { MessageBox.Show("Username already exists"); }
        }
    }
}
