using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DongJinInTem
{
    public class XLSFileWatcher : FileWatcher, IDisposable
    {
        const int SCAN_INTERVAL = 100;

        private bool _isFirstScan;

        private System.Timers.Timer _timerScan;

        public override event Action<FileWatcher, TestModal> Notify;

        public XLSFileWatcher(string fileName)
        {
            WatchFile = fileName;

            var parent = Directory.GetParent(fileName);
            WatchDirectory = parent.FullName;
            Name = parent.Name;

            _timerScan = new System.Timers.Timer(SCAN_INTERVAL);
            _timerScan.Elapsed += _timerScan_Elapsed;
        }

        public override void Start()
        {
            Enabled = true;
            _isFirstScan = true;
            LastResult = null;
            _timerScan.Start();
        }

        public override void Stop()
        {
            LastResult = null;
            Enabled = false;
            _timerScan.Stop();
        }

        private void _timerScan_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            _timerScan?.Stop();

            try
            {
                if (File.Exists(WatchFile))
                {
                    if (_isFirstScan || LastResult == null)
                    {
                        var lastLine = ReadLastLine(WatchFile);
                        LastResult = GetTestModel(lastLine);

                        _isFirstScan = !(LastResult?.TEST_NO != null);
                    }
                    else
                    {
                        var lastLine = ReadLastLine(WatchFile);

                        var lastTest = GetTestModel(lastLine);

                        if (lastTest == null || lastTest.TEST_NO == null)
                        {
                            _isFirstScan = true;
                        }
                        else
                        {
                            if (LastResult.TEST_NO != lastTest.TEST_NO)
                            {
                                LastResult = lastTest;
                                try
                                {
                                    Notify?.Invoke(this, lastTest);
                                }
                                catch { }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // MessageBox.Show(ex.ToString());
                Debug.Write(ex.ToString());
            }

            if (Enabled)
                _timerScan?.Start();
        }

        public override void Dispose()
        {
            Stop();
            _timerScan.Dispose();
            _timerScan = null;
        }

        private string ReadLastLine(string filePath)
        {
            try
            {
                string str2;
                using (FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                {
                    using (StreamReader reader = new StreamReader(stream))
                    {
                        char[] separator = new char[] { '\n' };
                        string[] strArray = reader.ReadToEnd().Split(separator);
                        int index = strArray.Length - 1;
                        if (index < 0)
                        {
                            return "";
                        }
                        if (string.IsNullOrEmpty(strArray[index]))
                        {
                            index--;
                            if (index < 0)
                            {
                                return "";
                            }
                            return strArray[index];
                        }
                        str2 = strArray[index];
                    }
                }
                return str2;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
                return "";
            }
        }

        private XLSTestModal GetTestModel(string input)
        {
            if (!string.IsNullOrWhiteSpace(input))
            {
                string[] split = input.Split('\t');
                XLSTestModal modal = new XLSTestModal();
                modal.TEST_NO = decimal.Parse(split[0]);
                modal.RESULT = split[split.Length - 1];
                modal.TIME = split[1];
                modal.Content = input;
                return modal;
            }
            return null;
        }
    }
}
