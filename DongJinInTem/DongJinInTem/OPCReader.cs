using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;
using TitaniumAS.Opc.Client.Common;
using TitaniumAS.Opc.Client.Da;
using TitaniumAS.Opc.Client.Da.Wrappers;

namespace DongJinInTem
{
    public class OPCReader
    {

        public static OPCReader Instance { get; private set; } = new OPCReader();


        private System.Timers.Timer _refreshTimer;
        OpcDaServer _server;

        public Dictionary<string, OpcDaItemValue> Values { get; set; } = new Dictionary<string, OpcDaItemValue>();

        public string Host { get; set; } = "localhost";
        public string OpcServerName { get; set; } = "Mitsubishi.MXOPC.6";

        public string LastValue { get; set; }

        public event Action Notify;

        public void Start()
        {
            if (_server == null)
            {
                Uri uri = UrlBuilder.Build(OpcServerName, Host);
                _server = new OpcDaServer(uri);
                _server.ConnectionStateChanged += _server_ConnectionStateChanged;
                _server.Shutdown += _server_Shutdown;
                _server.Connect();
            }
        }

        private void InitializeConnection()
        {
            if (_server != null)
            {
                _server.ConnectionStateChanged -= _server_ConnectionStateChanged;
                _server.Shutdown -= _server_Shutdown;
            }

            Uri uri = UrlBuilder.Build(OpcServerName, Host);
            _server = new OpcDaServer(uri);
            _server.ConnectionStateChanged += _server_ConnectionStateChanged;
            _server.Shutdown += _server_Shutdown;
            _server.Connect();
        }

        private void _server_Shutdown(object sender, OpcShutdownEventArgs e)
        {
            throw new NotImplementedException();
        }

        private void _server_ConnectionStateChanged(object sender, OpcDaServerConnectionStateChangedEventArgs e)
        {
            if (e.IsConnected)
            {
                if (_refreshTimer == null)
                {
                    _refreshTimer = new System.Timers.Timer();
                    _refreshTimer.Interval = 100;
                    _refreshTimer.Elapsed += OnRefresh;
                    _refreshTimer.Start();
                }
            }
            else
            {
                Thread.Sleep(1000);
                InitializeConnection();
            }
        }

        private void OnRefresh(object sender, System.Timers.ElapsedEventArgs e)
        {
            _refreshTimer.Stop();
            try
            {
                if (_server != null && _server.IsConnected)
                {

                    OpcDaVQTE[] data = _server.Read(new[] { "PLC.OK" }, new[] { TimeSpan.FromMilliseconds(10) });

                    if (data.Length > 0)
                    {
                        var value = data[0].Value;

                        if (value != null)
                        {

                            if (string.IsNullOrEmpty(LastValue))
                            {
                                LastValue = value.ToString().ToUpper();
                            }
                            else
                            {
                                if (LastValue == "TRUE")
                                {
                                    if (value.ToString().ToUpper() == "FALSE")
                                    {
                                        LastValue = "FALSE";
                                        Notify?.Invoke();
                                    }
                                }
                                else
                                {
                                    LastValue = value.ToString().ToUpper();
                                }
                            }
                        }
                    }
                }
            }
            catch
            {
                LastValue = null;
            }
            _refreshTimer.Start();
        }
    }
}
