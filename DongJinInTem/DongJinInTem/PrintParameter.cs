using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DongJinInTem
{
    public class PrintParameter
    {
        public string Name { get; set; }
        public string Value { get; set; }
        public string DisplayFormat { get; set; }
        public bool AutoIndent { get; set; }
    }

    public enum ParameterType
    {
        Number,
        Text,
    }
}
