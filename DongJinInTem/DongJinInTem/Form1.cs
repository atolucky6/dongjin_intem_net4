using DevExpress.ReportServer.ServiceModel.DataContracts;
using Newtonsoft.Json;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DongJinInTem
{

    public partial class Form1 : Form
    {
        public static Form1 Instance { get; protected set; }

        readonly FileScan _fileScan;
        string AppDir = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
        string TemplateFolder = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) + "\\Template";
        PrintController printController = new PrintController();
        
        public Form1()
        {
            var dayOfYear = DateTime.Now.DayOfYear;
            InitializeComponent();
            if (!Properties.Settings.Default.OPC)
            {
                _fileScan = new FileScan(Properties.Settings.Default.FileExt);
                _fileScan.Notify += _fileScan_Notify;
            }

            Load += Form1_Load;
            _btnSave.Enabled = false;
            _btnRemove.Enabled = false;
            _btnOpenDesign.Enabled = false;
            _btnSaveParameters.Enabled = false;
            _dataParameteres.Enabled = false;
            _dataParameteres.AutoGenerateColumns = false;
            _cobLabelType.TextChanged += _cobLabelType_TextChanged;
            _btnOpenDesign.Click += _btnOpenDesign_Click;
            _btnSave.Click += _btnSave_Click;

            printController.Start();
            Instance = this;

            if (Properties.Settings.Default.OPC)
            {
                try
                {
                    OPCReader.Instance.Notify += Instance_Notify;
                    OPCReader.Instance.Start();
                }
                catch { }
            }
        }

        private void Instance_Notify()
        {
            try
            {
                this.Invoke((MethodInvoker)delegate
                {
                    Console.WriteLine($"OK Notify");
                    if (checkBox1.Checked && !string.IsNullOrWhiteSpace(_cobLabelType.Text))
                    {
                        TestModal modal = new TestModal()
                        {
                            RESULT = "OK"
                        };


                        var profile = GetPrintProfileByName(_cobLabelType.Text);

                        if (profile != null)
                        {
                            decimal numValue = 1;
                            if (profile.Parameters.FirstOrDefault(x => x.Name == "TEST_NO") is PrintParameter parameter)
                            {
                                if (decimal.TryParse(parameter.Value, out numValue))
                                    parameter.Value = $"{numValue + 1}";
                                SavePrintProfile(_cobLabelType.Text, profile);
                            }

                            PrintRequest request = new PrintRequest();
                            request.FileWatcher = null;
                            request.Profile = profile;
                            request.TestResult = new TestModal()
                            {
                                TEST_NO = numValue,
                                RESULT = "OK"
                            };

                            request.Name = _cobLabelType.Text;
                            printController.PrintQueue.Enqueue(request);
                        }
                        else
                        {
                            // _txbLog.Text += $"{Environment.NewLine}Error: Không tìm thấy thông tin file in của {_cobLabelType.Text}";
                        }
                    }
                });
            }
            catch { }
        }

        private void _fileScan_Notify(FileWatcher arg1, TestModal arg2)
        {
            try
            {
                Log(arg1, arg2);

                try
                {
                    InTemRepo.Insert(arg1.Name, arg2.TEST_NO.Value, arg2.RESULT.Trim('\r'), arg2.ToString(), DateTime.Now);    
                }
                catch
                {

                }

                if (arg2.RESULT != null)
                {
                    if (arg2.RESULT.ToUpper().Contains("OK"))
                    {
                        PrintRequest request = new PrintRequest();
                        request.FileWatcher = arg1;
                        request.TestResult = arg2;
                        request.Name = arg1.Name;
                        request.Profile = GetPrintProfileByName(arg1.Name);
                        if (request.Profile != null)
                        {
                            printController.PrintQueue.Enqueue(request);
                        }
                        else
                        {
                            _txbLog.Text += $"{Environment.NewLine}Error: Không tìm thấy thông tin của {arg1.Name}";
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                _txbLog.Text += $"{Environment.NewLine}Error: {ex.Message}";
            }
        }

        private void Log(FileWatcher fileWatcher, TestModal modal)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append($"  [{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}] - ");

            sb.Append($"[{fileWatcher.Name}]: {modal.ToString()}");

            Invoke((MethodInvoker)delegate
            {
                _txbLog.Text += $"{Environment.NewLine}{sb.ToString()}";
            });
        }

        public void Log(string message)
        {
            Invoke((MethodInvoker)delegate
            {
                _txbLog.Text += $"{Environment.NewLine}{message}";
            });
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //string watchDir = File.ReadAllText("watch.txt");
            //_txbWatchFolder.Text = watchDir;
            //if (Directory.Exists(watchDir))
            //{
            //    _fileScan.WatchDirectory = watchDir;
            //    _fileScan.Start();

            //    _txbLog.Text += $"{Environment.NewLine}Bat Dau Theo Doi: {watchDir}";
            //}
            //else
            //{
            //    _txbLog.Text += $"{Environment.NewLine}Khong Tim Thay Thu Muc Log: {watchDir}";
            //}
        }

        private void _cobLabelType_DropDown(object sender, EventArgs e)
        {
            _cobLabelType.Items.Clear();
            if (Directory.Exists(TemplateFolder))
            {
                var directory = new DirectoryInfo(TemplateFolder);
                foreach (DirectoryInfo dirInfo in directory.GetDirectories())
                {
                    _cobLabelType.Items.Add(dirInfo.Name);
                }
            }
        }

        private void _cobLabelType_TextChanged(object sender, EventArgs e)
        {
            _btnSave.Enabled = !string.IsNullOrWhiteSpace(_cobLabelType.Text);

            if (!string.IsNullOrWhiteSpace(_cobLabelType.Text))
            {
                string dir = $"{TemplateFolder}\\{_cobLabelType.Text}";
                if (Directory.Exists(dir))
                {
                    _btnRemove.Enabled = true;
                    _btnOpenDesign.Enabled = true;
                    _btnSaveParameters.Enabled = true;
                    _dataParameteres.Enabled = true;
                }
                else
                {
                    _btnOpenDesign.Enabled = false;
                    _btnRemove.Enabled = false;
                    _btnSaveParameters.Enabled = false;
                    _dataParameteres.Enabled = false;
                }

                //string sampleImgFile = dir + "\\Sample.png";

                //if (File.Exists(sampleImgFile))
                //{
                //    _imgSample.ImageLocation = sampleImgFile;
                //}
                //else
                //{
                //    _imgSample.ImageLocation = "";
                //}

                string profileFile = $"{dir}\\Profile.json";
                if (File.Exists(profileFile))
                {
                    var profile = GetSelectedPrintProfile();

                    var dt = new DataTable();
                    dt.Columns.Add(new DataColumn() { ColumnName = "Name" });
                    dt.Columns.Add(new DataColumn() { ColumnName = "Value" });
                    dt.Columns.Add(new DataColumn() { ColumnName = "AutoIndent" });
                    dt.Columns.Add(new DataColumn() { ColumnName = "DisplayFormat" });
                    foreach (var item in profile.Parameters)
                    {
                        dt.Rows.Add(item.Name, item.Value, item.AutoIndent, item.DisplayFormat);
                    }

                    
                    _dataParameteres.DataSource = dt;

                }
                else
                {
                    var dt = new DataTable();
                    dt.Columns.Add(new DataColumn() { ColumnName = "Name" });
                    dt.Columns.Add(new DataColumn() { ColumnName = "Value" });
                    dt.Columns.Add(new DataColumn() { ColumnName = "AutoIndent" });
                    dt.Columns.Add(new DataColumn() { ColumnName = "DisplayFormat" });
                    _dataParameteres.DataSource = dt;
                }
            }
            else
            {
                _dataParameteres.DataSource = null;
                _btnSaveParameters.Enabled = false;
                _btnOpenDesign.Enabled = false;
                _btnRemove.Enabled = false;
                // _imgSample.ImageLocation = "";
            }
        }

        private void _btnSave_Click(object sender, EventArgs e)
        {
            string reportDir = $"{TemplateFolder}\\{_cobLabelType.Text}";
            if (!Directory.Exists(reportDir))
            {
                Directory.CreateDirectory(reportDir);

                string profileFile = reportDir + "\\Profile.Json";
                PrintProfile profile = new PrintProfile();
                var form = new PageSizeForm();
                form.StartPosition = FormStartPosition.CenterParent;
                form.Owner = this;
                if (form.ShowDialog() == DialogResult.OK)
                {

                    profile.PageHeight = Convert.ToInt32(form.PageHeight);
                    profile.PageWidth = Convert.ToInt32(form.PageWidth);
                    string json = JsonConvert.SerializeObject(profile, Formatting.Indented);
                    File.WriteAllText(profileFile, json);
                }
                else
                {
                    Directory.Delete(reportDir, true);
                    return;
                }    
            }
            _btnOpenDesign.Enabled = true;
        }

        private void _btnOpenDesign_Click(object sender, EventArgs e)
        {
            string reportFileName = $"{TemplateFolder}\\{_cobLabelType.Text}";
            if (Directory.Exists(reportFileName))
            {
                string profileFile = reportFileName + "\\Profile.Json";
                reportFileName = reportFileName + "\\ReportTemplate.repx";
                PrintProfile profile = JsonConvert.DeserializeObject<PrintProfile>(File.ReadAllText(profileFile));
                PrintDesignForm form = new PrintDesignForm(reportFileName, profile);
                form.ShowDialog();
            }
        }

        private void _imgSample_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(_cobLabelType.Text))
            {
                string dir = $"{TemplateFolder}\\{_cobLabelType.Text}";
                if (Directory.Exists(dir))
                {
                    openFileDialog1.Title = "Upload";
                    openFileDialog1.Filter = "Image File|*.png";
                    if (openFileDialog1.ShowDialog() == DialogResult.OK)
                    {
                        string sampleImgFile = dir + "\\Sample.png";

                        // File.Copy(openFileDialog1.FileName, sampleImgFile, true);
                        // _imgSample.ImageLocation = sampleImgFile;
                    }
                }
            }
        }

        private void _btnRemove_Click(object sender, EventArgs e)
        {
            try
            {
                string dir = $"{TemplateFolder}\\{_cobLabelType.Text}";
                Directory.Delete(dir, true);
                _cobLabelType.Text = "";
            }
            catch { }
        }

        private void _btnSaveParameters_Click(object sender, EventArgs e)
        {
            var profile = GetSelectedPrintProfile(); 
            if (profile != null)
            {
                if (_dataParameteres.DataSource is DataTable dt)
                {
                    profile.Parameters.Clear();
                    foreach (DataRow dataRow in dt.Rows)
                    {
                        PrintParameter parameter = new PrintParameter();
                        parameter.Name = dataRow.ItemArray[0].ToString();
                        parameter.Value = dataRow.ItemArray[1].ToString();
                        parameter.AutoIndent = bool.Parse(dataRow.ItemArray[2].ToString());
                        parameter.DisplayFormat = dataRow.ItemArray[3].ToString();
                        profile.Parameters.Add(parameter);
                    }
                    SavePrintProfile(_cobLabelType.Text, profile);
                }
            }
        }

        private PrintProfile GetSelectedPrintProfile()
        {
            return GetPrintProfileByName(_cobLabelType.Text);
        }

        private PrintProfile GetPrintProfileByName(string name)
        {
            try
            {
                string dir = $"{TemplateFolder}\\{name}\\Profile.json";
                if (File.Exists(dir))
                {
                    return JsonConvert.DeserializeObject<PrintProfile>(File.ReadAllText(dir));
                }
            }
            catch { }
            return null;
        }

        private bool SavePrintProfile(string name, PrintProfile profile)
        {
            try
            {
                string fileName = $"{TemplateFolder}\\{_cobLabelType.Text}\\Profile.json";
                string json = JsonConvert.SerializeObject(profile);
                File.WriteAllText(fileName, json);
                return true;
            }
            catch { }
            return false;
        }

        private void _btnFindWatchFolder_Click(object sender, EventArgs e)
        {
            if (folderBrowserDialog1.ShowDialog() == DialogResult.OK)
            {
                string path = folderBrowserDialog1.SelectedPath.Replace('\\', '/');
                _txbWatchFolder.Text = path;
                Properties.Settings.Default["WatchFolder"] = folderBrowserDialog1.SelectedPath;
                Properties.Settings.Default.Save();

                File.WriteAllText("watch.txt", folderBrowserDialog1.SelectedPath.Replace('\\', '/'));

                _fileScan.Stop();

                _fileScan.WatchDirectory = _txbWatchFolder.Text;
                _fileScan.Start();

            }
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            PrintRequest request = new PrintRequest();
            request.FileWatcher = null;
            request.TestResult = new TestModal()
            {
                TEST_NO = 1,
                RESULT = "OK"
            };
            request.Name = _cobLabelType.Text;

            request.Profile = GetPrintProfileByName(_cobLabelType.Text);
            if (request.Profile != null)
            {
                printController.PrintQueue.Enqueue(request);
            }
            else
            {
                _txbLog.Text += $"{Environment.NewLine}Error: Không tìm thấy thông tin file in của {_cobLabelType.Text}";
            }
        }

        private void CobReport_DropDown(object sender, EventArgs e)
        {
            cobReport.Items.Clear();
            if (Directory.Exists(TemplateFolder))
            {
                var directory = new DirectoryInfo(TemplateFolder);
                foreach (DirectoryInfo dirInfo in directory.GetDirectories())
                {
                    cobReport.Items.Add(dirInfo.Name);
                }
            }
        }

        private void BtnReport_Click(object sender, EventArgs e)
        {
            dgvReport.DataSource = null;
            dgvReport.DataSource = InTemRepo.Get(cobReport.Text, dtpReport.Value);
        }

        private void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            _cobLabelType.Enabled = !checkBox1.Checked;
        }

        private void Timer1_Tick(object sender, EventArgs e)
        {
            try
            {
                label6.Text = OPCReader.Instance.LastValue;
            }
            catch { }
        }
    }
}
