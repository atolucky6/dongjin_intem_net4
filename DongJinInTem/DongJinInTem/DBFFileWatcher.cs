using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DongJinInTem
{
    public class DBFFileWatcher : FileWatcher, IDisposable
    {
        const int SCAN_INTERVAL = 100;

        private bool _isFirstScan;
        
        private System.Timers.Timer _timerScan;

        public override event Action<FileWatcher, TestModal> Notify;

        public DBFFileWatcher(string fileName)
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
                        LastResult = DbfReader.GetAll(WatchFile)?.LastOrDefault();
                        if (LastResult != null && LastResult.TEST_NO != null)
                        {
                            _isFirstScan = false;
                            Form1.Instance.Log($"First scan result: {LastResult.TEST_NO}");
                        }
                        else
                        { 
                            Form1.Instance.Log($"First scan result null");
                            _isFirstScan = true;
                        }

                    }
                    else
                    {
                        var lastTest = DbfReader.GetAll(WatchFile)?.LastOrDefault();

                        if (lastTest != null && lastTest.TEST_NO != null)
                        {
                            if (LastResult.TEST_NO != lastTest.TEST_NO)
                            {
                                LastResult = lastTest;
                                Form1.Instance.Log($"Next scan result: {LastResult.TEST_NO}");
                                try
                                {
                                    Notify?.Invoke(this, lastTest);
                                }
                                catch { }
                            }
                        }
                        else
                        {
                            Form1.Instance.Log($"Next scan result:  null");
                        }
                    }
                }
                else

                {
                    Form1.Instance.Log($"File not found: {WatchFile}");
                }
            }
            catch (Exception ex)
            {
                Form1.Instance.Log(ex.ToString());
            
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
    }
}
