using System;
using System.Drawing;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Reflection;
using project_ii_v3.Controller;

namespace project_ii_v3.View
{
    public partial class GameWindow : Form
    {
        int _banutiColectati = 0;
        private bool _paused;
        private bool _gameIsOver;
        private string userName;

        Random r = new Random();
        int _vitezaJoc = 5;
        
        private void initAllComponents()
        {
            //LINIILE DE SOSEA
            sosea.Add(pictureBox1);
            sosea.Add(pictureBox2);
            sosea.Add(pictureBox3);
            sosea.Add(pictureBox4);
            sosea.Add(pictureBox5);
            //BANUTI
            banuti.Add(banut1);
            banuti.Add(banut2);
            banuti.Add(banut3);
            banuti.Add(banut4);
            banuti.Add(banut5);
            //INAMICI
            inamici.Add(inamic1);
            inamici.Add(inamic2);
            inamici.Add(inamic3);
            button3.DisableSelect();
            button4.DisableSelect();
            button5.DisableSelect();
            resumeButton.DisableSelect();
            mainmenuButton.DisableSelect();
            button1.DisableSelect();



        }
        public GameWindow(string userN)
        {
            InitializeComponent();
            initAllComponents();
            gameGroupBox.Visible = true;
            gameoverBox.Visible = false;
            pausegameBox.Visible = false;
            _paused = false;
            _gameIsOver = false;
            Size = new Size(500, 488);
            userName = userN;
        }

        private void Form1_Load(object sender, EventArgs e){
            DatabaseController.getCurrentCar(userName, masina);
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            GameController.Moveline(this,sosea,_vitezaJoc);
            GameController.Inamic(this,inamici,pictureBox6,pictureBox7,_vitezaJoc);
            _gameIsOver=GameController.AiPierdut(this,masina,inamici,timer1,gameoverBox,gameGroupBox);
            if (_gameIsOver) GameController.saveScore(_banutiColectati, userName);
            GameController.MiscareBanuti(this,banuti,pictureBox6,pictureBox7,_vitezaJoc);
            GameController.StrangeBanuti(this,masina,banuti,scor,pictureBox6,pictureBox7,ref _banutiColectati);
        }
        
        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            int spdLR = 10;
            if (e.KeyCode == Keys.Left)
            {
                if (masina.Left > pictureBox7.Width/2)
                { masina.Left -= spdLR; }
            }
            if (e.KeyCode == Keys.Right)
            {
                if (masina.Left < ClientRectangle.Width-masina.Width-pictureBox7.Width/2) 
                { masina.Left += spdLR; }
            }
            if (e.KeyCode == Keys.Up)
            {
                if (_vitezaJoc <= 15)
                {
                    _vitezaJoc++;
                }
            }
            if (e.KeyCode == Keys.Down)
            {
                if (_vitezaJoc >=5)
                {
                    _vitezaJoc--;
                }
            }

            if (e.KeyCode == Keys.Escape)
            {
                if (!_gameIsOver)
                {
                    if (!_paused)
                    {
                        timer1.Enabled = false;
                        pausegameBox.Location = new Point(116, 164);
                        gameGroupBox.Visible = false;
                        pausegameBox.Visible = true;
                        _paused = true;
                    }
                    else
                    {
                        pausegameBox.Location = new Point(232, 284);
                        pausegameBox.Visible = false;
                        gameGroupBox.Visible = true;
                        timer1.Enabled = true;
                        _paused = false;
                    }
                }
            }
            //Debug.WriteLine("TASTA APASATA");
        }

        void RestartGame()
        {
            //TODO: important cand fac restart game, nu mai pot comanda masina -> rezolvat
            
            _banutiColectati = 0;
            _vitezaJoc = 5;
            gameGroupBox.Visible = true;
            inamic1.Location = new Point(39, 50);
            inamic2.Location = new Point(256, 31);
            inamic3.Location = new Point(383, 98);
            banut1.Location = new Point(73, 222);
            banut3.Location = new Point(132, 83);
            banut5.Location = new Point(256, 222);
            banut2.Location = new Point(319, 31);
            banut4.Location = new Point(340, 240);
            masina.Location = new Point(141, 318);
            gameoverBox.Location = new Point(263, 536);
            gameoverBox.Visible = false;
            _gameIsOver = false;
            _paused = false;
            timer1.Enabled = true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            RestartGame();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        private void mainmenuButton_Click(object sender, EventArgs e)
        {
            Application.Restart();
        }

        private void resumeButton_Click(object sender, EventArgs e)
        {
            pausegameBox.Location = new Point(232, 284);
            pausegameBox.Visible = false;
            gameGroupBox.Visible = true;
            timer1.Enabled = true;
            _paused = false;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            //restart button from game over groupbox
            RestartGame();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            //exit button from game over groupbox
            Application.Exit();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            //main menu button from game over groupbox
            Application.Restart();
        }

        public GroupBox PausegameBox
        {
            get => pausegameBox;
            set => pausegameBox = value;
        }

        private void gameGroupBox_Enter(object sender, EventArgs e)
        {

        }
    }
    public static class Utils
    {
        private static readonly Action<Control, ControlStyles, bool> SetStyle =
            (Action<Control, ControlStyles, bool>)Delegate.CreateDelegate(typeof(Action<Control, ControlStyles, bool>),
                typeof(Control).GetMethod("SetStyle", BindingFlags.NonPublic | BindingFlags.Instance, null, new[] { typeof(ControlStyles), typeof(bool) }, null));
        public static void DisableSelect(this Control target)
        {
            SetStyle(target, ControlStyles.Selectable, false);
        }
    }
}