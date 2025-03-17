using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using project_ii_v3.View;

namespace project_ii_v3.Controller
{
    public class GameController
    {
        public static void Moveline(Form game,List<PictureBox> sosea,int speed)
        {
            foreach (PictureBox linie in sosea)
            {
                if (linie.Top >= game.ClientRectangle.Height)
                { linie.Top = -linie.Height; }
                else { linie.Top += speed; }
            }
        }
        
        public static void Inamic(Form game,List<PictureBox> inamici,PictureBox parapetSt,PictureBox parapetDr,int speed)
        {
            Random r = new Random();
            int _pozInamicX;
            foreach (PictureBox inamic in inamici)
            {
                if (inamic.Top >= game.ClientRectangle.Height)
                { 
                    inamic.Top = -inamic.Height;
                    _pozInamicX = r.Next(parapetSt.Width / 2,  game.ClientRectangle.Width - parapetDr.Width / 2-inamic.Width);
                    inamic.Left = _pozInamicX;
                }
                else{ inamic.Top += speed; }
            }

        }
        
        public static bool AiPierdut(GameWindow game,PictureBox masina,List<PictureBox> inamici,Timer timer1,GroupBox gameoverBox,GroupBox gameGroupBox)
        {
            bool _gameIsOver=false;
            foreach (PictureBox inamic in inamici)
            {
                if (masina.Bounds.IntersectsWith(inamic.Bounds))
                {
                    timer1.Enabled = false;
                    gameGroupBox.Visible = false;
                    gameoverBox.Location = new Point(136, 170);
                    gameoverBox.Visible = true;
                    _gameIsOver = true;
                }
            }
            game.PausegameBox.Hide();
            return _gameIsOver;
        }

        public static void saveScore(int money, string userName)
        {
            int userID = DatabaseController.getUserID(userName);
            DatabaseController.addScore(userID, userName, money * 2); // scorul este nr de banuti stransi * 2
            int totalMoney = DatabaseController.getMoney(userName);
            DatabaseController.modifyMoney(userName, totalMoney + money);
        }

        
        
        public static void MiscareBanuti(Form game,List<PictureBox> banuti,PictureBox parapetSt,PictureBox parapetDr,int speed)
        {
            Random r = new Random();
            int _pozBanut;
            foreach (PictureBox banut in banuti)
            {
                if (banut.Top >= game.ClientRectangle.Height)
                {
                    banut.Top = -banut.Height;
                    _pozBanut = r.Next(parapetSt.Width / 2, game.ClientRectangle.Width - parapetDr.Width / 2 - banut.Width);
                    banut.Left = _pozBanut;
                }
                else { banut.Top += speed; }
            }
        }
        
        public static void StrangeBanuti(Form game,PictureBox masina,List<PictureBox> banuti,Label scor,PictureBox parapetSt,PictureBox parapetDr,ref int _banutiColectati)
        {
            int _pozBanut;
            Random r = new Random();
            foreach (PictureBox banut in banuti)
            {
                if (masina.Bounds.IntersectsWith(banut.Bounds))
                {
                    banut.Top = -banut.Height;
                    _pozBanut = r.Next(parapetSt.Width / 2, game.ClientRectangle.Width - parapetDr.Width / 2 - banut.Width);
                    banut.Left = _pozBanut;
                    _banutiColectati += 50;
                    scor.Text = "Banuti: " + _banutiColectati;
                }
            }
        }
        
    }
}