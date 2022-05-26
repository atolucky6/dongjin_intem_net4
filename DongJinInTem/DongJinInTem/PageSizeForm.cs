using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DongJinInTem
{
    public partial class PageSizeForm : Form
    {
        public decimal PageWidth { get; set; }
        public decimal PageHeight { get; set; }

        public PageSizeForm()
        {
            InitializeComponent();
        }

        public PageSizeForm(decimal width, decimal height)
        {
            InitializeComponent();
            PageHeight = height;
            PageWidth = width;
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            if (numWidth.Value > 0 && numHeight.Value > 0)
            {
                PageHeight = numHeight.Value;
                PageWidth = numWidth.Value;
                DialogResult = DialogResult.OK;
                Close();
            }
            else
            {
                MessageBox.Show("Chiều dài và chiều cao phải lớn hơn 0");
            }
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
