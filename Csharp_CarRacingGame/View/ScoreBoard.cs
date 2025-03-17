using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Media;
using project_ii_v3.Controller;

namespace project_ii_v3.View
{
    public partial class ScoreBoard : Form
    {
        private static ScoreBoard instance = null;
        private SoundPlayer soundPlayer;
        
        private ScoreBoard(SoundPlayer sound)
        {
            InitializeComponent();
            soundPlayer = sound;
        }

        public static ScoreBoard getInstance(SoundPlayer sound)
        {
            if (instance == null)
            {
                instance = new ScoreBoard(sound);
            }
            return instance;
        }

        private void ScoreBoard_Load(object sender, EventArgs e)
        {
            List<string> scores = DatabaseController.getScoreBoard();
            int i = 1;
            int nrCrt = 1;
            int y = 2;
            Font f = new Font("Segoe Script", 14, FontStyle.Bold);
            foreach (string s in scores)
            {
                if (i % 2 == 1)
                {
                    Label l1 = new Label(); //label cu nr.crt
                    l1.Text = nrCrt.ToString() + ".";
                    nrCrt++;
                    l1.Location = new Point(5, y);
                    l1.Font = f;
                    l1.ForeColor = Color.White;
                    l1.BackColor = Color.Black;
                    l1.AutoSize = true;
                    scoruriPanel.Controls.Add(l1);

                    Label l = new Label();
                    l.Text = s;
                    l.Location = new Point(55, y);
                    l.Font = f;
                    l.ForeColor = Color.White;
                    l.BackColor = Color.Black;
                    l.AutoSize = true;
                    scoruriPanel.Controls.Add(l);
                }
                else
                {
                    Label l = new Label();
                    l.Text = s;
                    l.Location = new Point(210, y);
                    l.Font = f;
                    l.ForeColor = Color.White;
                    l.BackColor = Color.Black;
                    y += 30;
                    l.AutoSize = true;
                    scoruriPanel.Controls.Add(l);
                }
                if(nrCrt == 10)
                {
                    scoruriPanel.AutoScroll = true;
                }
                i++;
            }

        }

        private void ScoreBoard_FormClosed(object sender, FormClosedEventArgs e)
        {
            instance = null;
        }

        private void buttonMainMenu_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }
    }
}
