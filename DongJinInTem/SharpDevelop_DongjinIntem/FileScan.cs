using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;

namespace DongJinInTem
{
    public class FileScan
    {
        System.Timers.Timer _timerScan;

        public string WatchFileName {get { return DateTime.Now.ToString("yyyy-MM-dd");}}
        public string WatchDirectory { get; set; }
        public bool Enabled { get; private set; }

        public string FileExtensions { get; set; }

        public Dictionary<string, FileWatcher> FileWatchers { get; private set; }

        public event Action<FileWatcher, TestModal> Notify;

        public FileScan(string fileExtension)
        {
            FileExtensions = fileExtension;
            _timerScan = new System.Timers.Timer(100);
            _timerScan.Elapsed += _timerScan_Elapsed;
            FileWatchers = new Dictionary<string, FileWatcher>();
        }

        public void Start()
        {
            Enabled = true;
            _timerScan.Start();
        }

        public void Stop()
        {
            Enabled = false;
            _timerScan.Stop();

            foreach (var kv in FileWatchers)
            {
                kv.Value.Dispose();
            }
            FileWatchers.Clear();
        }

        private void _timerScan_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            _timerScan.Stop();
            try
            {
                if (Directory.Exists(WatchDirectory))
                {
                    var dbfFiles = Directory.GetFiles(WatchDirectory, FileExtensions, SearchOption.AllDirectories);
                    List<string> validFiles = new List<string>();
                    foreach (var file in dbfFiles)
                    {
                        if (Path.GetFileNameWithoutExtension(file) == WatchFileName)
                        {
                            validFiles.Add(file);
                        }
                    }

                    foreach (var key in FileWatchers.Keys.ToArray())
                    {
                        if (!dbfFiles.Contains(key))
                        {
                            FileWatchers[key].Notify -= FileWatcher_Notify;
                            FileWatchers[key].Dispose();
                            FileWatchers.Remove(key);
                        }
                    }

                    foreach (var file in validFiles)
                    {
                        if (!FileWatchers.ContainsKey(file))
                        {
                            var fileWatcher = GetFileWatcher(file);
                            Form1.Instance.Log("Founded log file '{file}' ");
                            fileWatcher.Notify += FileWatcher_Notify;
                            fileWatcher.Start();
                            FileWatchers[file] = fileWatcher;
                        }
                    }
                }
            }
            catch { }

            if (Enabled)
                _timerScan.Start();
        }

        protected FileWatcher GetFileWatcher(string file)
        {
            if (FileExtensions == "*.DBF")
                return new DBFFileWatcher(file);
            else if (FileExtensions == "*.XLS")
                return new XLSFileWatcher(file);
            return null;
        }

        private void FileWatcher_Notify(FileWatcher arg1, TestModal arg2)
        {
            Notify.Invoke(arg1, arg2);
        }
    }
}
