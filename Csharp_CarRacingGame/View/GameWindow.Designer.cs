using System.Collections.Generic;
using System.Windows.Forms;

namespace project_ii_v3.View
{
    partial class GameWindow
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }

            base.Dispose(disposing);
        }


        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(GameWindow));
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.pictureBox3 = new System.Windows.Forms.PictureBox();
            this.pictureBox4 = new System.Windows.Forms.PictureBox();
            this.pictureBox5 = new System.Windows.Forms.PictureBox();
            this.pictureBox6 = new System.Windows.Forms.PictureBox();
            this.pictureBox7 = new System.Windows.Forms.PictureBox();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.masina = new System.Windows.Forms.PictureBox();
            this.inamic1 = new System.Windows.Forms.PictureBox();
            this.inamic3 = new System.Windows.Forms.PictureBox();
            this.inamic2 = new System.Windows.Forms.PictureBox();
            this.gameOver = new System.Windows.Forms.Label();
            this.banut1 = new System.Windows.Forms.PictureBox();
            this.banut4 = new System.Windows.Forms.PictureBox();
            this.banut5 = new System.Windows.Forms.PictureBox();
            this.banut3 = new System.Windows.Forms.PictureBox();
            this.banut2 = new System.Windows.Forms.PictureBox();
            this.scor = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.mainmenuButton = new System.Windows.Forms.Button();
            this.pausegameBox = new System.Windows.Forms.GroupBox();
            this.resumeButton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.gameoverBox = new System.Windows.Forms.GroupBox();
            this.button5 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.gameGroupBox = new System.Windows.Forms.GroupBox();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox6)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox7)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.masina)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.inamic1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.inamic3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.inamic2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut2)).BeginInit();
            this.pausegameBox.SuspendLayout();
            this.gameoverBox.SuspendLayout();
            this.gameGroupBox.SuspendLayout();
            this.SuspendLayout();
            // 
            // pictureBox2
            // 
            this.pictureBox2.BackColor = System.Drawing.Color.White;
            this.pictureBox2.Location = new System.Drawing.Point(220, 20);
            this.pictureBox2.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(30, 72);
            this.pictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pictureBox2.TabIndex = 1;
            this.pictureBox2.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackColor = System.Drawing.Color.White;
            this.pictureBox1.Location = new System.Drawing.Point(220, 112);
            this.pictureBox1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(30, 72);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pictureBox1.TabIndex = 2;
            this.pictureBox1.TabStop = false;
            // 
            // pictureBox3
            // 
            this.pictureBox3.BackColor = System.Drawing.Color.White;
            this.pictureBox3.Location = new System.Drawing.Point(220, 222);
            this.pictureBox3.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pictureBox3.Name = "pictureBox3";
            this.pictureBox3.Size = new System.Drawing.Size(30, 72);
            this.pictureBox3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pictureBox3.TabIndex = 3;
            this.pictureBox3.TabStop = false;
            // 
            // pictureBox4
            // 
            this.pictureBox4.BackColor = System.Drawing.Color.White;
            this.pictureBox4.Location = new System.Drawing.Point(220, 341);
            this.pictureBox4.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pictureBox4.Name = "pictureBox4";
            this.pictureBox4.Size = new System.Drawing.Size(30, 72);
            this.pictureBox4.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pictureBox4.TabIndex = 4;
            this.pictureBox4.TabStop = false;
            // 
            // pictureBox5
            // 
            this.pictureBox5.BackColor = System.Drawing.Color.White;
            this.pictureBox5.Location = new System.Drawing.Point(220, 447);
            this.pictureBox5.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pictureBox5.Name = "pictureBox5";
            this.pictureBox5.Size = new System.Drawing.Size(30, 72);
            this.pictureBox5.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pictureBox5.TabIndex = 5;
            this.pictureBox5.TabStop = false;
            // 
            // pictureBox6
            // 
            this.pictureBox6.BackColor = System.Drawing.Color.White;
            this.pictureBox6.Location = new System.Drawing.Point(0, 8);
            this.pictureBox6.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pictureBox6.Name = "pictureBox6";
            this.pictureBox6.Size = new System.Drawing.Size(23, 695);
            this.pictureBox6.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pictureBox6.TabIndex = 6;
            this.pictureBox6.TabStop = false;
            // 
            // pictureBox7
            // 
            this.pictureBox7.BackColor = System.Drawing.Color.White;
            this.pictureBox7.Location = new System.Drawing.Point(466, 8);
            this.pictureBox7.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pictureBox7.Name = "pictureBox7";
            this.pictureBox7.Size = new System.Drawing.Size(23, 677);
            this.pictureBox7.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pictureBox7.TabIndex = 7;
            this.pictureBox7.TabStop = false;
            // 
            // timer1
            // 
            this.timer1.Enabled = true;
            this.timer1.Interval = 10;
            this.timer1.Tag = "";
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // masina
            // 
            this.masina.Image = ((System.Drawing.Image)(resources.GetObject("masina.Image")));
            this.masina.InitialImage = ((System.Drawing.Image)(resources.GetObject("masina.InitialImage")));
            this.masina.Location = new System.Drawing.Point(119, 510);
            this.masina.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.masina.Name = "masina";
            this.masina.Size = new System.Drawing.Size(55, 106);
            this.masina.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.masina.TabIndex = 8;
            this.masina.TabStop = false;
            // 
            // inamic1
            // 
            this.inamic1.Image = ((System.Drawing.Image)(resources.GetObject("inamic1.Image")));
            this.inamic1.InitialImage = ((System.Drawing.Image)(resources.GetObject("inamic1.InitialImage")));
            this.inamic1.Location = new System.Drawing.Point(39, 50);
            this.inamic1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.inamic1.Name = "inamic1";
            this.inamic1.Size = new System.Drawing.Size(50, 115);
            this.inamic1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.inamic1.TabIndex = 9;
            this.inamic1.TabStop = false;
            // 
            // inamic3
            // 
            this.inamic3.Image = ((System.Drawing.Image)(resources.GetObject("inamic3.Image")));
            this.inamic3.Location = new System.Drawing.Point(256, 31);
            this.inamic3.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.inamic3.Name = "inamic3";
            this.inamic3.Size = new System.Drawing.Size(50, 105);
            this.inamic3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.inamic3.TabIndex = 10;
            this.inamic3.TabStop = false;
            // 
            // inamic2
            // 
            this.inamic2.Image = ((System.Drawing.Image)(resources.GetObject("inamic2.Image")));
            this.inamic2.Location = new System.Drawing.Point(383, 98);
            this.inamic2.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.inamic2.Name = "inamic2";
            this.inamic2.Size = new System.Drawing.Size(44, 86);
            this.inamic2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.inamic2.TabIndex = 11;
            this.inamic2.TabStop = false;
            // 
            // gameOver
            // 
            this.gameOver.AutoSize = true;
            this.gameOver.BackColor = System.Drawing.Color.Yellow;
            this.gameOver.Font = new System.Drawing.Font("Segoe UI", 19.8F);
            this.gameOver.ForeColor = System.Drawing.Color.Red;
            this.gameOver.Location = new System.Drawing.Point(11, 12);
            this.gameOver.Name = "gameOver";
            this.gameOver.Size = new System.Drawing.Size(202, 45);
            this.gameOver.TabIndex = 12;
            this.gameOver.Text = "GAME OVER";
            // 
            // banut1
            // 
            this.banut1.Image = ((System.Drawing.Image)(resources.GetObject("banut1.Image")));
            this.banut1.InitialImage = global::project_ii_v3.Properties.Resources._50bani;
            this.banut1.Location = new System.Drawing.Point(73, 222);
            this.banut1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.banut1.Name = "banut1";
            this.banut1.Size = new System.Drawing.Size(57, 59);
            this.banut1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.banut1.TabIndex = 13;
            this.banut1.TabStop = false;
            // 
            // banut4
            // 
            this.banut4.Image = ((System.Drawing.Image)(resources.GetObject("banut4.Image")));
            this.banut4.Location = new System.Drawing.Point(340, 240);
            this.banut4.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.banut4.Name = "banut4";
            this.banut4.Size = new System.Drawing.Size(56, 44);
            this.banut4.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.banut4.TabIndex = 14;
            this.banut4.TabStop = false;
            // 
            // banut5
            // 
            this.banut5.Image = ((System.Drawing.Image)(resources.GetObject("banut5.Image")));
            this.banut5.Location = new System.Drawing.Point(256, 222);
            this.banut5.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.banut5.Name = "banut5";
            this.banut5.Size = new System.Drawing.Size(64, 57);
            this.banut5.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.banut5.TabIndex = 15;
            this.banut5.TabStop = false;
            // 
            // banut3
            // 
            this.banut3.Image = ((System.Drawing.Image)(resources.GetObject("banut3.Image")));
            this.banut3.Location = new System.Drawing.Point(132, 83);
            this.banut3.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.banut3.Name = "banut3";
            this.banut3.Size = new System.Drawing.Size(55, 44);
            this.banut3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.banut3.TabIndex = 16;
            this.banut3.TabStop = false;
            // 
            // banut2
            // 
            this.banut2.Image = ((System.Drawing.Image)(resources.GetObject("banut2.Image")));
            this.banut2.Location = new System.Drawing.Point(319, 31);
            this.banut2.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.banut2.Name = "banut2";
            this.banut2.Size = new System.Drawing.Size(56, 52);
            this.banut2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.banut2.TabIndex = 17;
            this.banut2.TabStop = false;
            // 
            // scor
            // 
            this.scor.AutoSize = true;
            this.scor.Font = new System.Drawing.Font("Segoe UI", 12F);
            this.scor.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.scor.Location = new System.Drawing.Point(12, 8);
            this.scor.Name = "scor";
            this.scor.Size = new System.Drawing.Size(87, 28);
            this.scor.TabIndex = 18;
            this.scor.Text = "Banuti: 0";
            // 
            // button1
            // 
            this.button1.BackColor = System.Drawing.Color.Yellow;
            this.button1.Location = new System.Drawing.Point(17, 139);
            this.button1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(202, 37);
            this.button1.TabIndex = 19;
            this.button1.Text = "Restart Game";
            this.button1.UseVisualStyleBackColor = false;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.BackColor = System.Drawing.Color.Yellow;
            this.button2.Location = new System.Drawing.Point(17, 225);
            this.button2.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(202, 38);
            this.button2.TabIndex = 20;
            this.button2.Text = "Exit Game";
            this.button2.UseVisualStyleBackColor = false;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // mainmenuButton
            // 
            this.mainmenuButton.BackColor = System.Drawing.Color.Yellow;
            this.mainmenuButton.Location = new System.Drawing.Point(17, 180);
            this.mainmenuButton.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.mainmenuButton.Name = "mainmenuButton";
            this.mainmenuButton.Size = new System.Drawing.Size(202, 41);
            this.mainmenuButton.TabIndex = 21;
            this.mainmenuButton.Text = "Main Menu";
            this.mainmenuButton.UseVisualStyleBackColor = false;
            this.mainmenuButton.Click += new System.EventHandler(this.mainmenuButton_Click);
            // 
            // pausegameBox
            // 
            this.pausegameBox.Controls.Add(this.resumeButton);
            this.pausegameBox.Controls.Add(this.label1);
            this.pausegameBox.Controls.Add(this.button2);
            this.pausegameBox.Controls.Add(this.button1);
            this.pausegameBox.Controls.Add(this.mainmenuButton);
            this.pausegameBox.Location = new System.Drawing.Point(267, 706);
            this.pausegameBox.Name = "pausegameBox";
            this.pausegameBox.Size = new System.Drawing.Size(232, 284);
            this.pausegameBox.TabIndex = 22;
            this.pausegameBox.TabStop = false;
            // 
            // resumeButton
            // 
            this.resumeButton.BackColor = System.Drawing.Color.Yellow;
            this.resumeButton.Location = new System.Drawing.Point(17, 98);
            this.resumeButton.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.resumeButton.Name = "resumeButton";
            this.resumeButton.Size = new System.Drawing.Size(202, 37);
            this.resumeButton.TabIndex = 23;
            this.resumeButton.Text = "Resume Game";
            this.resumeButton.UseVisualStyleBackColor = false;
            this.resumeButton.Click += new System.EventHandler(this.resumeButton_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.Yellow;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 19.8F);
            this.label1.ForeColor = System.Drawing.Color.DarkGreen;
            this.label1.Location = new System.Drawing.Point(51, 18);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(137, 45);
            this.label1.TabIndex = 22;
            this.label1.Text = "PAUSED";
            // 
            // gameoverBox
            // 
            this.gameoverBox.Controls.Add(this.button5);
            this.gameoverBox.Controls.Add(this.button4);
            this.gameoverBox.Controls.Add(this.button3);
            this.gameoverBox.Controls.Add(this.gameOver);
            this.gameoverBox.Location = new System.Drawing.Point(33, 694);
            this.gameoverBox.Name = "gameoverBox";
            this.gameoverBox.Size = new System.Drawing.Size(219, 250);
            this.gameoverBox.TabIndex = 23;
            this.gameoverBox.TabStop = false;
            // 
            // button5
            // 
            this.button5.BackColor = System.Drawing.Color.Yellow;
            this.button5.Location = new System.Drawing.Point(11, 154);
            this.button5.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(202, 38);
            this.button5.TabIndex = 23;
            this.button5.Text = "Exit Game";
            this.button5.UseVisualStyleBackColor = false;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // button4
            // 
            this.button4.BackColor = System.Drawing.Color.Yellow;
            this.button4.Location = new System.Drawing.Point(11, 109);
            this.button4.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(202, 41);
            this.button4.TabIndex = 22;
            this.button4.Text = "Main Menu";
            this.button4.UseVisualStyleBackColor = false;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // button3
            // 
            this.button3.BackColor = System.Drawing.Color.Yellow;
            this.button3.Location = new System.Drawing.Point(11, 68);
            this.button3.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(202, 37);
            this.button3.TabIndex = 20;
            this.button3.Text = "Restart Game";
            this.button3.UseVisualStyleBackColor = false;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // gameGroupBox
            // 
            this.gameGroupBox.Controls.Add(this.scor);
            this.gameGroupBox.Controls.Add(this.banut2);
            this.gameGroupBox.Controls.Add(this.banut3);
            this.gameGroupBox.Controls.Add(this.pictureBox7);
            this.gameGroupBox.Controls.Add(this.banut5);
            this.gameGroupBox.Controls.Add(this.pictureBox6);
            this.gameGroupBox.Controls.Add(this.banut4);
            this.gameGroupBox.Controls.Add(this.banut1);
            this.gameGroupBox.Controls.Add(this.inamic2);
            this.gameGroupBox.Controls.Add(this.inamic3);
            this.gameGroupBox.Controls.Add(this.inamic1);
            this.gameGroupBox.Controls.Add(this.masina);
            this.gameGroupBox.Controls.Add(this.pictureBox2);
            this.gameGroupBox.Controls.Add(this.pictureBox1);
            this.gameGroupBox.Controls.Add(this.pictureBox3);
            this.gameGroupBox.Controls.Add(this.pictureBox4);
            this.gameGroupBox.Controls.Add(this.pictureBox5);
            this.gameGroupBox.Location = new System.Drawing.Point(4, 3);
            this.gameGroupBox.Name = "gameGroupBox";
            this.gameGroupBox.Size = new System.Drawing.Size(495, 685);
            this.gameGroupBox.TabIndex = 24;
            this.gameGroupBox.TabStop = false;
            this.gameGroupBox.Enter += new System.EventHandler(this.gameGroupBox_Enter);
            // 
            // GameWindow
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.DarkGray;
            this.ClientSize = new System.Drawing.Size(482, 853);
            this.Controls.Add(this.gameGroupBox);
            this.Controls.Add(this.pausegameBox);
            this.Controls.Add(this.gameoverBox);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(500, 900);
            this.MinimumSize = new System.Drawing.Size(500, 685);
            this.Name = "GameWindow";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Drift Club Valcea";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.Form1_FormClosed);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Form1_KeyDown);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox6)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox7)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.masina)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.inamic1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.inamic3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.inamic2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.banut2)).EndInit();
            this.pausegameBox.ResumeLayout(false);
            this.pausegameBox.PerformLayout();
            this.gameoverBox.ResumeLayout(false);
            this.gameoverBox.PerformLayout();
            this.gameGroupBox.ResumeLayout(false);
            this.gameGroupBox.PerformLayout();
            this.ResumeLayout(false);

        }

        private System.Windows.Forms.Button resumeButton;

        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Label label1;

        private System.Windows.Forms.GroupBox gameoverBox;

        private System.Windows.Forms.GroupBox gameGroupBox;

        private System.Windows.Forms.GroupBox pausegameBox;
        private System.Windows.Forms.GroupBox groupBox2;

        private System.Windows.Forms.Button mainmenuButton;

        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.PictureBox pictureBox3;
        private System.Windows.Forms.PictureBox pictureBox4;
        private System.Windows.Forms.PictureBox pictureBox5;
        private System.Windows.Forms.PictureBox pictureBox6;
        private System.Windows.Forms.PictureBox pictureBox7;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.PictureBox masina;
        private System.Windows.Forms.PictureBox inamic1;
        private System.Windows.Forms.PictureBox inamic3;
        private System.Windows.Forms.PictureBox inamic2;
        private System.Windows.Forms.Label gameOver;
        private System.Windows.Forms.PictureBox banut1;
        private System.Windows.Forms.PictureBox banut4;
        private System.Windows.Forms.PictureBox banut5;
        private System.Windows.Forms.PictureBox banut3;
        private System.Windows.Forms.PictureBox banut2;
        private System.Windows.Forms.Label scor;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private List<PictureBox> sosea=new List<PictureBox>();
        private List<PictureBox> banuti = new List<PictureBox>();
        private List<PictureBox> inamici = new List<PictureBox>();
    }
    }
