
namespace DongJinInTem
{
    partial class Form1
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.folderBrowserDialog1 = new System.Windows.Forms.FolderBrowserDialog();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.label3 = new System.Windows.Forms.Label();
            this._btnSaveParameters = new System.Windows.Forms.Button();
            this._dataParameteres = new System.Windows.Forms.DataGridView();
            this.colName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colValue = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colAutoIndent = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.colDisplayFormat = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this._txbLog = new System.Windows.Forms.RichTextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.button1 = new System.Windows.Forms.Button();
            this._txbWatchFolder = new System.Windows.Forms.TextBox();
            this._btnFindWatchFolder = new System.Windows.Forms.Button();
            this._btnRemove = new System.Windows.Forms.Button();
            this._btnOpenDesign = new System.Windows.Forms.Button();
            this._btnSave = new System.Windows.Forms.Button();
            this._cobLabelType = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.btnReport = new System.Windows.Forms.Button();
            this.dgvReport = new System.Windows.Forms.DataGridView();
            this.label5 = new System.Windows.Forms.Label();
            this.dtpReport = new System.Windows.Forms.DateTimePicker();
            this.cobReport = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.checkBox1 = new System.Windows.Forms.CheckBox();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.label6 = new System.Windows.Forms.Label();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this._dataParameteres)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.tabPage2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReport)).BeginInit();
            this.SuspendLayout();
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(1139, 740);
            this.tabControl1.TabIndex = 0;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.label3);
            this.tabPage1.Controls.Add(this._btnSaveParameters);
            this.tabPage1.Controls.Add(this._dataParameteres);
            this.tabPage1.Controls.Add(this.groupBox2);
            this.tabPage1.Controls.Add(this.groupBox1);
            this.tabPage1.Location = new System.Drawing.Point(4, 27);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(1131, 709);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Cài đặt";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(504, 5);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(71, 18);
            this.label3.TabIndex = 10;
            this.label3.Text = "Thông số";
            // 
            // _btnSaveParameters
            // 
            this._btnSaveParameters.Location = new System.Drawing.Point(504, 252);
            this._btnSaveParameters.Name = "_btnSaveParameters";
            this._btnSaveParameters.Size = new System.Drawing.Size(116, 32);
            this._btnSaveParameters.TabIndex = 11;
            this._btnSaveParameters.Text = "Lưu";
            this._btnSaveParameters.UseVisualStyleBackColor = true;
            this._btnSaveParameters.Click += new System.EventHandler(this._btnSaveParameters_Click);
            // 
            // _dataParameteres
            // 
            this._dataParameteres.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this._dataParameteres.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this._dataParameteres.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.colName,
            this.colValue,
            this.colAutoIndent,
            this.colDisplayFormat});
            this._dataParameteres.Location = new System.Drawing.Point(504, 29);
            this._dataParameteres.Name = "_dataParameteres";
            this._dataParameteres.Size = new System.Drawing.Size(616, 215);
            this._dataParameteres.TabIndex = 9;
            // 
            // colName
            // 
            this.colName.DataPropertyName = "Name";
            this.colName.HeaderText = "Tên";
            this.colName.Name = "colName";
            // 
            // colValue
            // 
            this.colValue.DataPropertyName = "Value";
            this.colValue.HeaderText = "Giá trị";
            this.colValue.Name = "colValue";
            // 
            // colAutoIndent
            // 
            this.colAutoIndent.DataPropertyName = "AutoIndent";
            this.colAutoIndent.HeaderText = "Tự tăng khi in";
            this.colAutoIndent.Name = "colAutoIndent";
            this.colAutoIndent.Width = 150;
            // 
            // colDisplayFormat
            // 
            this.colDisplayFormat.DataPropertyName = "DisplayFormat";
            this.colDisplayFormat.HeaderText = "Display Format";
            this.colDisplayFormat.Name = "colDisplayFormat";
            this.colDisplayFormat.Width = 150;
            // 
            // groupBox2
            // 
            this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox2.Controls.Add(this._txbLog);
            this.groupBox2.Location = new System.Drawing.Point(4, 293);
            this.groupBox2.Margin = new System.Windows.Forms.Padding(4);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Padding = new System.Windows.Forms.Padding(9, 8, 9, 8);
            this.groupBox2.Size = new System.Drawing.Size(1115, 411);
            this.groupBox2.TabIndex = 8;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Logs";
            // 
            // _txbLog
            // 
            this._txbLog.Dock = System.Windows.Forms.DockStyle.Fill;
            this._txbLog.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this._txbLog.Location = new System.Drawing.Point(9, 25);
            this._txbLog.Margin = new System.Windows.Forms.Padding(4);
            this._txbLog.Name = "_txbLog";
            this._txbLog.ReadOnly = true;
            this._txbLog.Size = new System.Drawing.Size(1097, 378);
            this._txbLog.TabIndex = 0;
            this._txbLog.Text = "";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.checkBox1);
            this.groupBox1.Controls.Add(this.button1);
            this.groupBox1.Controls.Add(this._txbWatchFolder);
            this.groupBox1.Controls.Add(this._btnFindWatchFolder);
            this.groupBox1.Controls.Add(this._btnRemove);
            this.groupBox1.Controls.Add(this._btnOpenDesign);
            this.groupBox1.Controls.Add(this._btnSave);
            this.groupBox1.Controls.Add(this._cobLabelType);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(4, 4);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(4);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(4);
            this.groupBox1.Size = new System.Drawing.Size(488, 281);
            this.groupBox1.TabIndex = 7;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Cài Đặt";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(256, 80);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(176, 32);
            this.button1.TabIndex = 7;
            this.button1.Text = "In Thử";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.Button1_Click);
            // 
            // _txbWatchFolder
            // 
            this._txbWatchFolder.Location = new System.Drawing.Point(16, 236);
            this._txbWatchFolder.Name = "_txbWatchFolder";
            this._txbWatchFolder.Size = new System.Drawing.Size(404, 24);
            this._txbWatchFolder.TabIndex = 6;
            // 
            // _btnFindWatchFolder
            // 
            this._btnFindWatchFolder.Location = new System.Drawing.Point(428, 236);
            this._btnFindWatchFolder.Name = "_btnFindWatchFolder";
            this._btnFindWatchFolder.Size = new System.Drawing.Size(40, 24);
            this._btnFindWatchFolder.TabIndex = 5;
            this._btnFindWatchFolder.Text = "...";
            this._btnFindWatchFolder.UseVisualStyleBackColor = true;
            this._btnFindWatchFolder.Click += new System.EventHandler(this._btnFindWatchFolder_Click);
            // 
            // _btnRemove
            // 
            this._btnRemove.Location = new System.Drawing.Point(72, 160);
            this._btnRemove.Name = "_btnRemove";
            this._btnRemove.Size = new System.Drawing.Size(176, 32);
            this._btnRemove.TabIndex = 5;
            this._btnRemove.Text = "Xóa";
            this._btnRemove.UseVisualStyleBackColor = true;
            this._btnRemove.Click += new System.EventHandler(this._btnRemove_Click);
            // 
            // _btnOpenDesign
            // 
            this._btnOpenDesign.Location = new System.Drawing.Point(72, 120);
            this._btnOpenDesign.Name = "_btnOpenDesign";
            this._btnOpenDesign.Size = new System.Drawing.Size(176, 32);
            this._btnOpenDesign.TabIndex = 5;
            this._btnOpenDesign.Text = "Chỉnh Tem";
            this._btnOpenDesign.UseVisualStyleBackColor = true;
            this._btnOpenDesign.Click += new System.EventHandler(this._btnOpenDesign_Click);
            // 
            // _btnSave
            // 
            this._btnSave.Location = new System.Drawing.Point(72, 80);
            this._btnSave.Name = "_btnSave";
            this._btnSave.Size = new System.Drawing.Size(176, 32);
            this._btnSave.TabIndex = 2;
            this._btnSave.Text = "Lưu";
            this._btnSave.UseVisualStyleBackColor = true;
            this._btnSave.Click += new System.EventHandler(this._btnSave_Click);
            // 
            // _cobLabelType
            // 
            this._cobLabelType.FormattingEnabled = true;
            this._cobLabelType.Location = new System.Drawing.Point(72, 40);
            this._cobLabelType.Name = "_cobLabelType";
            this._cobLabelType.Size = new System.Drawing.Size(176, 26);
            this._cobLabelType.TabIndex = 1;
            this._cobLabelType.DropDown += new System.EventHandler(this._cobLabelType_DropDown);
            this._cobLabelType.TextChanged += new System.EventHandler(this._cobLabelType_TextChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(12, 212);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(123, 18);
            this.label4.TabIndex = 0;
            this.label4.Text = "Thư mục theo dõi";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(20, 44);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(44, 18);
            this.label1.TabIndex = 0;
            this.label1.Text = "Loại: ";
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.btnReport);
            this.tabPage2.Controls.Add(this.dgvReport);
            this.tabPage2.Controls.Add(this.label5);
            this.tabPage2.Controls.Add(this.dtpReport);
            this.tabPage2.Controls.Add(this.cobReport);
            this.tabPage2.Controls.Add(this.label2);
            this.tabPage2.Location = new System.Drawing.Point(4, 27);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(1131, 709);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Báo cáo";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // btnReport
            // 
            this.btnReport.Location = new System.Drawing.Point(308, 32);
            this.btnReport.Name = "btnReport";
            this.btnReport.Size = new System.Drawing.Size(100, 27);
            this.btnReport.TabIndex = 6;
            this.btnReport.Text = "Tìm kiếm";
            this.btnReport.UseVisualStyleBackColor = true;
            this.btnReport.Click += new System.EventHandler(this.BtnReport_Click);
            // 
            // dgvReport
            // 
            this.dgvReport.AllowUserToAddRows = false;
            this.dgvReport.AllowUserToDeleteRows = false;
            this.dgvReport.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgvReport.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvReport.Location = new System.Drawing.Point(4, 68);
            this.dgvReport.Name = "dgvReport";
            this.dgvReport.ReadOnly = true;
            this.dgvReport.Size = new System.Drawing.Size(1120, 636);
            this.dgvReport.TabIndex = 5;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(176, 12);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(76, 18);
            this.label5.TabIndex = 4;
            this.label5.Text = "Thời Gian:";
            // 
            // dtpReport
            // 
            this.dtpReport.Location = new System.Drawing.Point(176, 33);
            this.dtpReport.Name = "dtpReport";
            this.dtpReport.Size = new System.Drawing.Size(120, 24);
            this.dtpReport.TabIndex = 2;
            // 
            // cobReport
            // 
            this.cobReport.FormattingEnabled = true;
            this.cobReport.Location = new System.Drawing.Point(16, 32);
            this.cobReport.Name = "cobReport";
            this.cobReport.Size = new System.Drawing.Size(148, 26);
            this.cobReport.TabIndex = 1;
            this.cobReport.DropDown += new System.EventHandler(this.CobReport_DropDown);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(16, 12);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(40, 18);
            this.label2.TabIndex = 0;
            this.label2.Text = "Loại:";
            // 
            // checkBox1
            // 
            this.checkBox1.AutoSize = true;
            this.checkBox1.Location = new System.Drawing.Point(268, 42);
            this.checkBox1.Name = "checkBox1";
            this.checkBox1.Size = new System.Drawing.Size(62, 22);
            this.checkBox1.TabIndex = 8;
            this.checkBox1.Text = "Khóa";
            this.checkBox1.UseVisualStyleBackColor = true;
            this.checkBox1.CheckedChanged += new System.EventHandler(this.CheckBox1_CheckedChanged);
            // 
            // timer1
            // 
            this.timer1.Enabled = true;
            this.timer1.Interval = 1000;
            this.timer1.Tick += new System.EventHandler(this.Timer1_Tick);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(268, 168);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(46, 18);
            this.label6.TabIndex = 9;
            this.label6.Text = "label6";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1139, 740);
            this.Controls.Add(this.tabControl1);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "Form1";
            this.Text = "Phần mềm in tem - Dongjin";
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this._dataParameteres)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.tabPage2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReport)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog1;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button _btnSaveParameters;
        private System.Windows.Forms.DataGridView _dataParameteres;
        private System.Windows.Forms.DataGridViewTextBoxColumn colName;
        private System.Windows.Forms.DataGridViewTextBoxColumn colValue;
        private System.Windows.Forms.DataGridViewCheckBoxColumn colAutoIndent;
        private System.Windows.Forms.DataGridViewTextBoxColumn colDisplayFormat;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.RichTextBox _txbLog;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox _txbWatchFolder;
        private System.Windows.Forms.Button _btnFindWatchFolder;
        private System.Windows.Forms.Button _btnRemove;
        private System.Windows.Forms.Button _btnOpenDesign;
        private System.Windows.Forms.Button _btnSave;
        private System.Windows.Forms.ComboBox _cobLabelType;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.Button btnReport;
        private System.Windows.Forms.DataGridView dgvReport;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.DateTimePicker dtpReport;
        private System.Windows.Forms.ComboBox cobReport;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.CheckBox checkBox1;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Label label6;
    }
}

