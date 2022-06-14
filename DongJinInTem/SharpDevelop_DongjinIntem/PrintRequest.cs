using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DongJinInTem
{
    public class PrintRequest
    {
        public string Name { get; set; }
        public TestModal TestResult { get; set; }

        public FileWatcher FileWatcher { get; set; }

        public PrintProfile Profile { get; set; }
    }
}
