using System.Media;
using project_ii_v3.View;

namespace project_ii_v3.Controller
{
    public class NewMenuController
    {
        public static void newSettingsMenu(SoundPlayer musicPlayer)
        {
            SettingsMenu.GetInstance(musicPlayer).Show();
        }

        public static void newSignUpMenu(SoundPlayer soundPlayer)
        {
            SignUpMenu.getInstance(soundPlayer).Show();
        }

        public static void newLogInMenu(SoundPlayer soundPlayer, bool market)
        {
            LogInMenu.getInstance(soundPlayer,market).Show();
        }


        public static void newScoreBoard(SoundPlayer soundPlayer)
        {
            ScoreBoard.getInstance(soundPlayer).Show();
        }
    }
}