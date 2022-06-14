using DevExpress.XtraReports.UI;
using System.IO;
using System.Windows.Forms;

namespace DongJinInTem
{
    public partial class PrintDesignForm : Form
    {
        public PrintDesignForm(string reportFileName, PrintProfile profile)
        {
            InitializeComponent();

            if (File.Exists(reportFileName))
            {
                reportDesigner1.OpenReport(reportFileName);
            }
            else
            {
                XtraReport templateReport = new XtraReport();
                templateReport.ReportUnit = ReportUnit.TenthsOfAMillimeter;
                templateReport.Margins.Top = 0;
                templateReport.Margins.Bottom = 0;
                templateReport.Margins.Left = 0;
                templateReport.Margins.Right = 0;
                templateReport.PageWidth = profile.PageWidth;
                templateReport.PageHeight = profile.PageHeight;
                templateReport.PageSize = new System.Drawing.Size(profile.PageWidth, profile.PageHeight);
                templateReport.Padding = new DevExpress.XtraPrinting.PaddingInfo(0f);

                templateReport.SnapToGrid = false;
                templateReport.SnapGridSize = 1;

                templateReport.SaveLayout(reportFileName);
                reportDesigner1.OpenReport(reportFileName);
            }
        }
    }
}
