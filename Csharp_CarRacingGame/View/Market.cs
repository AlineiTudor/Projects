using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using project_ii_v3.Controller;
using System.Media;

namespace project_ii_v3.View
{
    public partial class Market : Form
    {

        private string userName;
        private static Market innstance = null;
        private int userMoney;
        private List<PictureBox> pictureBoxes = new List<PictureBox>();
        private List<string> itemNames = new List<string>();
        private List<Button> buttons = new List<Button>();
        private SoundPlayer soundPlayer;
        
        private Market(string userN, SoundPlayer sound)
        {
            InitializeComponent();
            userName = userN;
            soundPlayer = sound;
            pictureBoxes.Add(car1Picture);
            pictureBoxes.Add(car2Picture);
            pictureBoxes.Add(car3Picture);
            pictureBoxes.Add(car4Picture);
            pictureBoxes.Add(car5Picture);
            pictureBoxes.Add(car6Picture);
            itemNames.Add(car1.Text);
            itemNames.Add(car2.Text);
            itemNames.Add(car3.Text);
            itemNames.Add(car4.Text);
            itemNames.Add(car5.Text);
            itemNames.Add(car6.Text);
            buttons.Add(car1Button);
            buttons.Add(car2Button);
            buttons.Add(car3Button);
            buttons.Add(car4Button);
            buttons.Add(car5Button);
            buttons.Add(car6Button);
        }

        public static Market getInstance(string userN, SoundPlayer sound)
        {
            if(innstance == null)
            {
                innstance = new Market(userN, sound);
            }
            return innstance;
        }

        private void Market_Load(object sender, EventArgs e)
        {
            try
            {
                Username.Text += userName;
                userMoney = DatabaseController.getMoney(userName);
                moneyLabel.Text += " " + userMoney;

                int i = 0;
                foreach (PictureBox pictureBox in pictureBoxes)
                {
                    DatabaseController.getItemPhoto3D(itemNames[i], pictureBox);
                    i++;
                }
                List<string> ownedItems = DatabaseController.getItems(userName);
                i = 0;
                foreach (string ownedItem in ownedItems)
                {
                    foreach (string item in itemNames)
                    {
                        if (item.Equals(ownedItem))
                        {
                            buttons[i].Text = "Use";
                            
                        }
                        i++;
                    }
                    i = 0;
                }
            } catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void Market_FormClosed(object sender, FormClosedEventArgs e)
        {
            innstance = null;
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void carOption_Click(object sender, EventArgs e)
        {
            if (car6Button.Text == "Use")
            {
                DatabaseController.changeCurrentCar(car6.Text, userName);
                MessageBox.Show("Your current car is changed to " + car6.Text);
            }
        }

        private void car1Button_Click(object sender, EventArgs e)
        {
            if (car1Button.Text == "Buy")
            {
                if (DatabaseController.buyItem(userName, car1.Text))
                {
                    MessageBox.Show("Item added to your inventory");
                    car1Button.Text = "Use";
                    userMoney = DatabaseController.getMoney(userName);
                    moneyLabel.Text = "Bani: " + userMoney + " lei";
                }
            }
            else if (car1Button.Text == "Use")
            {
                DatabaseController.changeCurrentCar(car1.Text, userName);
                MessageBox.Show("Your current car is changed to " + car1.Text);
            }
        }

        private void car2Button_Click(object sender, EventArgs e)
        {
            if (car2Button.Text == "Buy")
            {
                if (DatabaseController.buyItem(userName, car2.Text))
                {
                    MessageBox.Show("Item added to your inventory");
                    car2Button.Text = "Use";
                    userMoney = DatabaseController.getMoney(userName);
                    moneyLabel.Text = "Bani: " + userMoney + " lei";
                }
            }
            else if (car2Button.Text == "Use")
            {
                DatabaseController.changeCurrentCar(car2.Text, userName);
                MessageBox.Show("Your current car is changed to " + car2.Text);
            }
        }

        private void car3Button_Click(object sender, EventArgs e)
        {
            if (car3Button.Text == "Buy")
            {
                if(DatabaseController.buyItem(userName, car3.Text))
                {
                    MessageBox.Show("Item added to your inventory");
                    car3Button.Text = "Use";
                    userMoney = DatabaseController.getMoney(userName);
                    moneyLabel.Text = "Bani: " + userMoney + " lei";
                }
            }
            else if (car3Button.Text == "Use")
            {
                DatabaseController.changeCurrentCar(car3.Text, userName);
                MessageBox.Show("Your current car is changed to " + car3.Text);
            }
        }

        private void car4Button_Click(object sender, EventArgs e)
        {
            if (car4Button.Text == "Buy")
            {
                if (DatabaseController.buyItem(userName, car4.Text))
                {
                    MessageBox.Show("Item added to your inventory");
                    car4Button.Text = "Use";
                    userMoney = DatabaseController.getMoney(userName);
                    moneyLabel.Text = "Bani: " + userMoney + " lei";
                }
            }
            else if (car4Button.Text == "Use")
            {
                DatabaseController.changeCurrentCar(car4.Text, userName);
                MessageBox.Show("Your current car is changed to " + car4.Text);
            }
        }

        private void car5Button_Click(object sender, EventArgs e)
        {
            if (car5Button.Text == "Buy")
            {
                if (DatabaseController.buyItem(userName, car5.Text))
                {
                    MessageBox.Show("Item added to your inventory");
                    car5Button.Text = "Use";
                    userMoney = DatabaseController.getMoney(userName);
                    moneyLabel.Text = "Bani: " + userMoney + " lei";
                }
            }
            else if (car5Button.Text == "Use")
            {
                DatabaseController.changeCurrentCar(car5.Text, userName);
                MessageBox.Show("Your current car is changed to " + car5.Text);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
            innstance = null;
        }
    }
}
