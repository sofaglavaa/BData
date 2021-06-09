using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SofaDB67
{
    public partial class ChooseYourForm : Form
    {
        public ChooseYourForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form toWor = new Worker();
            toWor.Owner = this;
            toWor.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form toPo = new PostWorker();
            toPo.Owner = this;
            toPo.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Form toPr = new Product();
            toPr.Owner = this;
            toPr.Show();
        }
    }
}
