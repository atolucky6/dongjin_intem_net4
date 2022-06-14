using DevExpress.Utils.Helpers;
using DevExpress.XtraReports.UI;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Windows.Forms;

namespace DongJinInTem
{
    public class PrintController
    {
        string _appDir = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
        private System.Timers.Timer _timerPrint;
        private bool _enabled;
        public ConcurrentQueue<PrintRequest> PrintQueue { get; set; }


        public PrintController()
        {
            PrintQueue = new ConcurrentQueue<PrintRequest>();
            _timerPrint = new System.Timers.Timer(400);
            _timerPrint.Elapsed += _timerPrint_Elapsed;
        }

        public void Start()
        {
            _enabled = true;
            _timerPrint.Start();
        }   

        public void Stop()
        {
            _timerPrint.Stop();
            _enabled = false;
        }

        private void _timerPrint_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            _timerPrint.Stop();
            try
            {
                if (PrintQueue.Count > 0)
                {
                    if (PrintQueue.TryDequeue(out PrintRequest request))
                    {
                        Form1.Instance.Invoke((MethodInvoker)delegate
                        {
                            foreach (var parameter in request.Profile.Parameters)
                            {
                                if (parameter.Name == "TEST_NO")
                                { 
                                    parameter.Value = (int.Parse(parameter.Value) + 1).ToString(parameter.DisplayFormat);
                                }
                            }
                            Form1.SaveProfile(request.Name, request.Profile);

                            string reportFile = $"{_appDir}\\Template\\{request.Name}\\ReportTemplate.repx";

                            if (File.Exists(reportFile))
                            {
                                XtraReport templateReport = XtraReport.FromFile(reportFile, true);
                                templateReport.ReportUnit = ReportUnit.TenthsOfAMillimeter;
                                templateReport.Margins = new System.Drawing.Printing.Margins(0, 0, 0, 0);
                                templateReport.PageWidth = request.Profile.PageWidth;
                                templateReport.PageHeight = request.Profile.PageHeight;
                                templateReport.PageSize = new System.Drawing.Size(request.Profile.PageWidth, request.Profile.PageHeight);
                                templateReport.Padding = new DevExpress.XtraPrinting.PaddingInfo(0f);
                                templateReport.PaperKind = System.Drawing.Printing.PaperKind.Custom;
                                templateReport.SnapToGrid = false;
                                templateReport.SnapGridSize = 1;
                                templateReport.Name = "Report";
                                // templateReport.CreateDocument();

                                //templateReport.ExportToImage(",", new DevExpress.XtraPrinting.ImageExportOptions()
                                //{
                                //    ExportMode = DevExpress.XtraPrinting.ImageExportMode.SingleFile,

                                //});

                                foreach (var item in templateReport.Parameters)
                                {
                                    if (request.Profile.Parameters.FirstOrDefault(x => x.Name == item.Name) is PrintParameter parameter)
                                    {
                                        item.Value = parameter.Value;
                                    }
                                }

                                templateReport.PrintingSystem.PrintingDocument.AutoFitToPagesWidth = 1;
                                templateReport.PrintingSystem.PrintingDocument.ScaleFactor = 1f;
                                templateReport.PrintingSystem.Document.AutoFitToPagesWidth = 1;
                                templateReport.PrintingSystem.Document.ScaleFactor = 1f;
                                templateReport.ShowPrintStatusDialog = false;
                                templateReport.ShowPrintMarginsWarning = false;
                                templateReport.RequestParameters = false;

                                templateReport.CreateDocument(false);

                                //string fileName = $"{_appDir}\\Template\\{request.FileWatcher.Name}\\{Path.GetRandomFileName()}.png";

                                //templateReport.ExportToImage(fileName, new DevExpress.XtraPrinting.ImageExportOptions()
                                //{
                                //    Resolution = 300,
                                //    PageBorderColor = System.Drawing.Color.Black,
                                //    PageBorderWidth = 1,
                                //});


                                // templateReport.ShowPreviewDialog();
                                templateReport.Print();
                                templateReport.Dispose();


                            }
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
            if (_enabled)
            _timerPrint.Start();

        }
    }
}
