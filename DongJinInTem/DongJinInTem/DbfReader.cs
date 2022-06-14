using DevExpress.XtraPrinting.Native.Lines;
using NDbfReader;
using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DongJinInTem
{
    public static class DbfReader
    {
        private static string ReadAllLine(string filePath)
        {
            try
            {
                string str = "";
                using (FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read))
                {
                    using (StreamReader reader = new StreamReader(stream))
                    {
                        str = reader.ReadToEnd();

                    }
                }
                return str;
            }
            catch (Exception ex)
            {
                // MessageBox.Show(ex.ToString());
                Form1.Instance.Log($"Lỗi đọc file: {filePath}{Environment.NewLine}{ex.ToString()}");
                return "";
            }
        }


        public static List<TestModal> GetAll(string fileName)
        {
            List<TestModal> result = new List<TestModal>();

            if (File.Exists(fileName))
            {
                string data = ReadAllLine(fileName);

                using (MemoryStream ms = new MemoryStream(Encoding.ASCII.GetBytes(data)))
                {
                    using (var table = Table.Open(ms))
                    {
                        var reader = table.OpenReader(Encoding.ASCII);
                        while (reader.Read())
                        {
                            try
                            {
                                TestModal modal = new TestModal();

                                modal.TEST_NO = reader.GetDecimal("TEST_NO");

                                modal.TIME = reader.GetString("TIME");

                                modal.RESULT = reader.GetString("RESULT");
                                // modal.PUNCT = reader.GetString("PUNCT");

                                result.Add(modal);
                            }
                            catch (Exception ex)
                            {
                                Form1.Instance.Log($"Error convert to modal: {ex.ToString()}");
                                // MessageBox.Show(ex.ToString());
                            }
                        }
                    }
                }

                //using (var sr = new FileStream(fileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                //{
                //    using (var table = Table.Open(sr))
                //    {
                //        var reader = table.OpenReader(Encoding.ASCII);
                //        while (reader.Read())
                //        {
                //            try
                //            {
                //                TestModal modal = new TestModal();

                //                modal.TEST_NO = reader.GetDecimal("TEST_NO");

                //                modal.TIME = reader.GetString("TIME");

                //                //modal.POWER_AMP1 = reader.GetDecimal("POWER_AMP1");
                //                //modal.POWER_RPM1 = reader.GetDecimal("POWER_RPM1");
                //                //modal.POWER_AMP2 = reader.GetDecimal("POWER_AMP2");
                //                //modal.POWER_RPM2 = reader.GetDecimal("POWER_RPM2");
                //                //modal.INSULATION = reader.GetString("INSULATION");
                //                //modal.ROTATION = reader.GetString("ROTATION");
                //                modal.RESULT = reader.GetString("RESULT");
                //                // modal.PUNCT = reader.GetString("PUNCT");

                //                result.Add(modal);
                //            }
                //            catch { }
                //        }
                //    }
                // }
            }

            return result;
        }
    }
}
