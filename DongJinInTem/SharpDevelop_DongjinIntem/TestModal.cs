using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DongJinInTem
{
    public class TestModal
    {
        public decimal? TEST_NO { get; set; }
        public string TIME { get; set; }
        public decimal? POWER_AMP1 { get; set; }
        public decimal? POWER_RPM1 { get; set; }
        public decimal? POWER_AMP2 { get; set; }
        public decimal? POWER_RPM2 { get; set; }
        public string ROTATION { get; set; }
        public string INSULATION { get; set; }
        public string PUNCT { get; set; }
        public string RESULT { get; set; }

        public override string ToString()
        {
            return $" - NO: {TEST_NO}, TIME: {TIME}, RESULT: {RESULT}";
        }
    }

    public class XLSTestModal : TestModal
    {
        public string Content { get; set; }


        public override string ToString()
        {
            return Content;
        }
    }
}
