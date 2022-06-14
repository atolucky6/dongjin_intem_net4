using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DongJinInTem
{
    public abstract class FileWatcher : IDisposable
    {
        public TestModal LastResult { get; protected set; }
        public string WatchDirectory { get; set; }
        public string WatchFile { get; set; }
        public string Name { get; set; }
        public bool Enabled { get; protected set; }

        public virtual event Action<FileWatcher, TestModal> Notify;

        public virtual void Start() { }
        public virtual void Stop() { }
        public virtual void Dispose() { }
    }
}
