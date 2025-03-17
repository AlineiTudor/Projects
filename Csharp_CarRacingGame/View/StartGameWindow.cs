using System;
using System.Diagnostics;
using System.IO;
using System.Media;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using project_ii_v3.Controller;
using project_ii_v3.Model;

//using System.Windows.Media;

namespace project_ii_v3.View
{
    public partial class StartGameWindow : Form
    {
        private SoundPlayer introMusic;
        
        public StartGameWindow()
        {
            InitializeComponent();
            
            //music
            string musicFile = Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName;
            musicFile += "/Project-Industrial-Informatics/Resources/sounds/burn_it_down.wav";
            introMusic = new SoundPlayer(musicFile);
        }

        private void startGameButton_Click(object sender, EventArgs e)
        {
            SettingsMenuController.closeMenu();
            NewMenuController.newSignUpMenu(introMusic);
            //TODO: add buttons: exit, settings, load game, career
            //TODO: resolve when closing game, main menu appears
            //TODO: add pause game feature
            //TODO: add sound to the game
            //TODO: database
            //TODO: memory management
        }

        private void exitGButton_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void StartGameWindow_Load(object sender, EventArgs e)
        {
            introMusic.PlayLooping();
            //DatabaseController.incarcaImagini(); //doar odata pentru a pune imaginile masinilor in baza de date
        }

        private void optionsButton_Click(object sender, EventArgs e)
        {
            NewMenuController.newSettingsMenu(introMusic);
        }

        private void loginButton_Click(object sender, EventArgs e)
        {
            NewMenuController.newLogInMenu(introMusic, false);
        }

        private void scoreboardButton_Click(object sender, EventArgs e)
        {
            NewMenuController.newScoreBoard(introMusic);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            NewMenuController.newLogInMenu(introMusic, true);
        }
    }
}