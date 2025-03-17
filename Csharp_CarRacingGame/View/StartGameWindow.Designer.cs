using System.ComponentModel;

namespace project_ii_v3.View
{
    partial class StartGameWindow
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private IContainer components = null;

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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(StartGameWindow));
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.startGameButton = new System.Windows.Forms.Button();
            this.exitGButton = new System.Windows.Forms.Button();
            this.loginButton = new System.Windows.Forms.Button();
            this.optionsButton = new System.Windows.Forms.Button();
            this.scoreboardButton = new System.Windows.Forms.Button();
            this.copyrightLabel = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(12, 12);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(511, 340);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // startGameButton
            // 
            this.startGameButton.BackColor = System.Drawing.Color.LightSteelBlue;
            this.startGameButton.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.startGameButton.Cursor = System.Windows.Forms.Cursors.Hand;
            this.startGameButton.FlatAppearance.BorderColor = System.Drawing.Color.LightSteelBlue;
            this.startGameButton.FlatAppearance.BorderSize = 0;
            this.startGameButton.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.startGameButton.Font = new System.Drawing.Font("Viner Hand ITC", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.startGameButton.ForeColor = System.Drawing.Color.Red;
            this.startGameButton.Location = new System.Drawing.Point(95, 374);
            this.startGameButton.Margin = new System.Windows.Forms.Padding(0);
            this.startGameButton.Name = "startGameButton";
            this.startGameButton.Size = new System.Drawing.Size(339, 57);
            this.startGameButton.TabIndex = 1;
            this.startGameButton.Text = "NEW GAME (NEW USER)";
            this.startGameButton.UseVisualStyleBackColor = false;
            this.startGameButton.Click += new System.EventHandler(this.startGameButton_Click);
            // 
            // exitGButton
            // 
            this.exitGButton.Cursor = System.Windows.Forms.Cursors.Hand;
            this.exitGButton.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.exitGButton.Font = new System.Drawing.Font("Viner Hand ITC", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.exitGButton.ForeColor = System.Drawing.Color.Red;
            this.exitGButton.Location = new System.Drawing.Point(95, 691);
            this.exitGButton.Name = "exitGButton";
            this.exitGButton.Size = new System.Drawing.Size(339, 65);
            this.exitGButton.TabIndex = 2;
            this.exitGButton.Text = "EXIT GAME";
            this.exitGButton.UseVisualStyleBackColor = true;
            this.exitGButton.Click += new System.EventHandler(this.exitGButton_Click);
            // 
            // loginButton
            // 
            this.loginButton.Cursor = System.Windows.Forms.Cursors.Hand;
            this.loginButton.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.loginButton.Font = new System.Drawing.Font("Viner Hand ITC", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.loginButton.ForeColor = System.Drawing.Color.Red;
            this.loginButton.Location = new System.Drawing.Point(95, 434);
            this.loginButton.Name = "loginButton";
            this.loginButton.Size = new System.Drawing.Size(339, 58);
            this.loginButton.TabIndex = 3;
            this.loginButton.Text = "LOG IN (CONTINUE GAME)";
            this.loginButton.UseVisualStyleBackColor = true;
            this.loginButton.Click += new System.EventHandler(this.loginButton_Click);
            // 
            // optionsButton
            // 
            this.optionsButton.Cursor = System.Windows.Forms.Cursors.Hand;
            this.optionsButton.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.optionsButton.Font = new System.Drawing.Font("Viner Hand ITC", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.optionsButton.ForeColor = System.Drawing.Color.Red;
            this.optionsButton.Location = new System.Drawing.Point(95, 562);
            this.optionsButton.Name = "optionsButton";
            this.optionsButton.Size = new System.Drawing.Size(339, 58);
            this.optionsButton.TabIndex = 4;
            this.optionsButton.Text = "SETTINGS";
            this.optionsButton.UseVisualStyleBackColor = true;
            this.optionsButton.Click += new System.EventHandler(this.optionsButton_Click);
            // 
            // scoreboardButton
            // 
            this.scoreboardButton.Cursor = System.Windows.Forms.Cursors.Hand;
            this.scoreboardButton.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.scoreboardButton.Font = new System.Drawing.Font("Viner Hand ITC", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.scoreboardButton.ForeColor = System.Drawing.Color.Red;
            this.scoreboardButton.Location = new System.Drawing.Point(95, 626);
            this.scoreboardButton.Name = "scoreboardButton";
            this.scoreboardButton.Size = new System.Drawing.Size(339, 59);
            this.scoreboardButton.TabIndex = 5;
            this.scoreboardButton.Text = "SCOREBOARD";
            this.scoreboardButton.UseVisualStyleBackColor = true;
            this.scoreboardButton.Click += new System.EventHandler(this.scoreboardButton_Click);
            // 
            // copyrightLabel
            // 
            this.copyrightLabel.Location = new System.Drawing.Point(376, 786);
            this.copyrightLabel.Name = "copyrightLabel";
            this.copyrightLabel.Size = new System.Drawing.Size(162, 23);
            this.copyrightLabel.TabIndex = 6;
            this.copyrightLabel.Text = "© 2022 ÎncăNeGândim";
            // 
            // button1
            // 
            this.button1.Cursor = System.Windows.Forms.Cursors.Hand;
            this.button1.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.button1.Font = new System.Drawing.Font("Viner Hand ITC", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button1.ForeColor = System.Drawing.Color.Red;
            this.button1.Location = new System.Drawing.Point(95, 498);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(339, 58);
            this.button1.TabIndex = 7;
            this.button1.Text = "MARKET (LOG IN)";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // StartGameWindow
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.LightSteelBlue;
            this.ClientSize = new System.Drawing.Size(535, 818);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.copyrightLabel);
            this.Controls.Add(this.scoreboardButton);
            this.Controls.Add(this.optionsButton);
            this.Controls.Add(this.loginButton);
            this.Controls.Add(this.exitGButton);
            this.Controls.Add(this.startGameButton);
            this.Controls.Add(this.pictureBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Name = "StartGameWindow";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Load += new System.EventHandler(this.StartGameWindow_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        private System.Windows.Forms.Label copyrightLabel;

        private System.Windows.Forms.Button loginButton;
        private System.Windows.Forms.Button optionsButton;
        private System.Windows.Forms.Button scoreboardButton;

        private System.Windows.Forms.Button exitGButton;

        private System.Windows.Forms.Button startGameButton;

        private System.Windows.Forms.PictureBox pictureBox1;

        #endregion

        private System.Windows.Forms.Button button1;
    }
}