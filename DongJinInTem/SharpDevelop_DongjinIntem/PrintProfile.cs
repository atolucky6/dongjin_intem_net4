using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DongJinInTem
{
    public class PrintProfile
    {
        private List<PrintParameter> parameters;

        public List<PrintParameter> Parameters
        {
            get
            {
                if (parameters == null)
                    parameters = new List<PrintParameter>();
                return parameters;
            }
            set
            {
                if (parameters != value)
                {
                    parameters = value;
                }
            }
        }

        public int PageWidth { get; set; }

        public int PageHeight { get; set; }
    }
}
