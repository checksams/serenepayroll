using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.OleDb;
using System.IO;

namespace SerenePayroll
{
    public partial class aspxImportFromExcel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_ImportCSV_Click(object sender, EventArgs e)
        {
            //System.Diagnostics.Debug.WriteLine("hhhhh====>");
            lblOsPlatform.Visible = true;
            lblOsPlatform2.Visible = true;
            lblOsPlatform.Text = Request.Browser.Platform;
            lblOsPlatform2.Text = Request.UserAgent;
            if (File.Exists("C:\\Imports\\testimport.csv"))
            {
                System.Diagnostics.Debug.WriteLine("gggggg====>");
                string[] data = File.ReadAllLines("C:\\Imports\\testimport.csv");

                DataTable dt = new DataTable();

                string[] col = data[0].Split(',');

                foreach (string s in col)
                {
                    dt.Columns.Add(s, typeof(string));
                }
                System.Diagnostics.Debug.WriteLine("col====>" + col.ToString());

                for (int i = 0; i < data.Length; i++)
                {
                    string[] row = data[i].Split(',');
                    dt.Rows.Add(row);
                    //System.Diagnostics.Debug.WriteLine("row====>"+row.ToString());
                }
                GridView1.DataSource = dt;
                GridView1.DataBind();
                GridView1.Visible = true;

            }
        }

        /*
        protected void btn_ImportCSV_Click(object sender, EventArgs e)
        {
            string filePath = string.Empty;

            System.Diagnostics.Debug.WriteLine("contenttype =====>" + fu_ImportCSV.PostedFile.ContentType);
            //if (fu_ImportCSV.HasFile && fu_ImportCSV.PostedFile.ContentType.Equals("application/vnd.ms-excel"))
            if (fu_ImportCSV.HasFile && fu_ImportCSV.PostedFile.ContentType.Equals("text/csv"))
            {
                //gv_GridView.DataSource = (DataTable)ReadToEnd(fu_ImportCSV.PostedFile.FileName);
                gv_GridView.DataSource = (DataTable)ReadToEnd("C:\\Imports\\EmployeeTemplate.csv");
                gv_GridView.DataBind();
                System.Diagnostics.Debug.WriteLine("Successfull import =====>");
                lbl_ErrorMsg.Visible = false;
            }
            else
            {
                lbl_ErrorMsg.Text = "Please check the selected file type";
                lbl_ErrorMsg.Visible = true;
            }
        }

        private object ReadToEnd(string filePath)
        {
            DataTable dtDataSource = new DataTable();
            string[] fileContent = File.ReadAllLines(filePath);
            if (fileContent.Count() > 0)
            {
                //Create data table columns
                string[] columns = fileContent[0].Split(',');
                for (int i = 0; i < columns.Count(); i++)
                {
                    dtDataSource.Columns.Add(columns[i]);
                }

                //Add row data
                for (int i = 1; i < fileContent.Count(); i++)
                {
                    string[] rowData = fileContent[i].Split(',');
                    dtDataSource.Rows.Add(rowData);
                }
            }
            return dtDataSource;
        }*/
    }
}