using System.ComponentModel;

namespace project_ii_v3.View
{
    partial class SettingsMenu
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
            this.volumeBar = new System.Windows.Forms.TrackBar();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.soundOn = new System.Windows.Forms.CheckBox();
            ((System.ComponentModel.ISupportInitialize) (this.volumeBar)).BeginInit();
            this.SuspendLayout();
            // 
            // volumeBar
            // 
            this.volumeBar.Location = new System.Drawing.Point(174, 127);
            this.volumeBar.Name = "volumeBar";
            this.volumeBar.Size = new System.Drawing.Size(159, 56);
            this.volumeBar.TabIndex = 1;
            this.volumeBar.Scroll += new System.EventHandler(this.volume_Scroll);
            // 
            // label1
            // 
            this.label1.Font = new System.Drawing.Font("Viner Hand ITC", 16.2F, ((System.Drawing.FontStyle) ((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte) (0)));
            this.label1.Location = new System.Drawing.Point(51, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(141, 48);
            this.label1.TabIndex = 2;
            this.label1.Text = "Settings";
            // 
            // label2
            // 
            this.label2.Font = new System.Drawing.Font("Viner Hand ITC", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte) (0)));
            this.label2.Location = new System.Drawing.Point(51, 127);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(117, 36);
            this.label2.TabIndex = 4;
            this.label2.Text = "Volume";
            // 
            // soundOn
            // 
            this.soundOn.Font = new System.Drawing.Font("Viner Hand ITC", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte) (0)));
            this.soundOn.Location = new System.Drawing.Point(51, 192);
            this.soundOn.Name = "soundOn";
            this.soundOn.Size = new System.Drawing.Size(117, 40);
            this.soundOn.TabIndex = 5;
            this.soundOn.Text = "Sound";
            this.soundOn.UseVisualStyleBackColor = true;
            this.soundOn.CheckedChanged += new System.EventHandler(this.soundOn_CheckedChanged_1);
            // 
            // SettingsMenu
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(344, 253);
            this.Controls.Add(this.soundOn);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.volumeBar);
            this.MaximizeBox = false;
            this.Name = "SettingsMenu";
            this.Text = "SettingsMenu";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.SettingsMenu_FormClosed);
            this.Load += new System.EventHandler(this.SettingsMenu_Load);
            ((System.ComponentModel.ISupportInitialize) (this.volumeBar)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        private System.Windows.Forms.CheckBox soundOn;

        private System.Windows.Forms.Label label2;

        private System.Windows.Forms.Label label1;

        private System.Windows.Forms.TrackBar volumeBar;

        #endregion
    }
}