using System;
using System.Media;
using System.Windows.Forms;
using project_ii_v3.Controller;

namespace project_ii_v3.View
{
    public partial class SettingsMenu : Form
    {
        //clasele sunt singleton pentru ca sa nu apara mai multe ferestre la apasarea multipla a unui buton
        private SoundPlayer musicPlayer;
        private static SettingsMenu _settingsMenuInstance;
        private static bool firstOpen=true;
        private static bool lastMusicOnStatus = true;

        private SettingsMenu(SoundPlayer musicPlayer)
        {
            InitializeComponent();
            this.musicPlayer = musicPlayer;
            SettingsMenuController.getVolume(volumeBar);
            soundOn.Checked = lastMusicOnStatus;
        }
        
        public static SettingsMenu GetInstance(SoundPlayer musicPlayer)
        {
            if (_settingsMenuInstance == null)
            {
                _settingsMenuInstance = new SettingsMenu(musicPlayer);
            }

            return _settingsMenuInstance;
        }

        public static SettingsMenu GetInstance()
        {
            return _settingsMenuInstance;
        }
        private void volume_Scroll(object sender, EventArgs e)
        {
            SettingsMenuController.setVolume(volumeBar);
        }


        private void soundOn_CheckedChanged_1(object sender, EventArgs e)
        {
            if (firstOpen)
            { 
                firstOpen = false;
            }else{SettingsMenuController.enableVolume(musicPlayer, soundOn.Checked);}
        }

        private void SettingsMenu_FormClosed(object sender, FormClosedEventArgs e)
        {
            _settingsMenuInstance = null;//it was necessary because after closing
            //the settings menu, it couldn't be opened again due to the singleton pattern
            firstOpen = true;
            lastMusicOnStatus = soundOn.Checked;
        }

        private void SettingsMenu_Load(object sender, EventArgs e)
        {
            //because the button is already unchecked so, the soundOn_CheckedChanged()
            //event listener will not be activated and after checking for the first time
            //the checkButton, firstOpen variable will be true(else will be active) so
            //volume will be enabled
            if (lastMusicOnStatus == false)
            {
                firstOpen = false;
            }
        }
    }
}