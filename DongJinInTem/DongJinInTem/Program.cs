using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using TitaniumAS.Opc.Client;

namespace DongJinInTem
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            try
            {
                Thread t = new Thread(new ThreadStart(() =>
                {
                    try
                    {
                        Bootstrap.Initialize();
                    }
                    catch { }
                }));
                t.ApartmentState = ApartmentState.MTA;
                t.Start();
            }
            catch { }

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }
    }
}
