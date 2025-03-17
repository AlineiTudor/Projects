using System;
using System.Media;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using project_ii_v3.View;

namespace project_ii_v3.Controller
{
    public class SettingsMenuController
    {
        [DllImport("winmm.dll")]
        public static extern int waveOutGetVolume(IntPtr hwo, out uint dwVolume);

        [DllImport("winmm.dll")]
        public static extern int waveOutSetVolume(IntPtr hwo, uint dwVolume);

        public static void setVolume(TrackBar volumeBar)
        {
            int volumNou= ((ushort.MaxValue / 10) * volumeBar.Value);
            uint NewVolumeAllChannels = (((uint)volumNou & 0x0000ffff) | ((uint)volumNou << 16));
            waveOutSetVolume(IntPtr.Zero, NewVolumeAllChannels);
        }

        public static void getVolume(TrackBar volumeBar)
        {
            uint CurrVol = 0;
            waveOutGetVolume(IntPtr.Zero, out CurrVol);
            ushort CalcVol = (ushort)(CurrVol & 0x0000ffff);
            volumeBar.Value = CalcVol / (ushort.MaxValue / 10);
        }

        public static void enableVolume(SoundPlayer musicPlayer,bool enable)
        {
            if (enable)
            {
                musicPlayer.PlayLooping();
            }else{musicPlayer.Stop();}
        }

        public static void closeMenu()
        {
            Form settingsMenu;
            if ((settingsMenu = SettingsMenu.GetInstance())!=null)
            {
                settingsMenu.Close();
            }
        }
        
    }
}