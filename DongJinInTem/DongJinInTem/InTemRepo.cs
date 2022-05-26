using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SQLite;

namespace DongJinInTem
{
    public class InTemRepo
    {
        public static string SqlFileName = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) + "/dongjin_intem.db";


        private static SQLiteConnection _conn;
        public static SQLiteConnection Connection
        {
            get
            {
                if (_conn == null)
                {
                    string conStr = $"URI=file:{SqlFileName}";
                    _conn = new SQLiteConnection(conStr);
                }
                return _conn;
            }
        }

        public static void Insert(string model, decimal test_no, string result, string data, DateTime time)
        {
            try
            {
                Connection.Open();

                using (var cmd = new SQLiteCommand())
                {
                    cmd.Connection = Connection;
                    cmd.CommandText = $"INSERT INTO intem(Model, Time, TEST_NO, Result, Data) VALUES ('{model}', '{time:yyyy-MM-dd HH:mm:ss}', {test_no}, '{result}', '{data}')";
                    cmd.ExecuteNonQuery();
                }

                Connection.Close();
            }
            catch { }
        }

        public static List<ReportModel> Get(string model, DateTime time)
        {
            List<ReportModel> result = new List<ReportModel>();

            try
            {
                Connection.Open();

                using (var cmd = new SQLiteCommand())
                {
                    cmd.Connection = Connection;
                    cmd.CommandText = $"select * from intem where Model = '{model}' and Time >= '{time:yyyy-MM-dd 00:00:00}' and Time <= '{time:yyyy-MM-dd 23:59:59}'";
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            try
                            {
                                ReportModel reportModel = new ReportModel();
                                reportModel.Id = reader.GetInt32(0);
                                reportModel.Model = reader.GetString(1);
                                reportModel.Time = reader.GetDateTime(2);
                                reportModel.TEST_NO = reader.GetInt32(3);
                                reportModel.Result = reader.GetString(4);
                                reportModel.Data = reader.GetString(5);
                                result.Add(reportModel);
                            }
                            catch { }
                        }
                    }
                }

                Connection.Close();
            }
            catch { }

            return result;
        }

    }

    public class ReportModel
    {
        public int Id { get; set; }
        public string Model { get; set; }
        public DateTime Time { get; set; }
        public int TEST_NO { get; set; }
        public string Result { get; set; }
        public string Data { get; set; }
    }

}
