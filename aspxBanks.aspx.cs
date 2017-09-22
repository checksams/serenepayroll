using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

using System.Configuration;
using System.ComponentModel;

using System.Globalization;

using System.IO;
using System.Text;

using System.Drawing;


namespace SerenePayroll
{
    public partial class aspxBanks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lnkBankRptPrint_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("Bank listing report");
            lnkBankRpt.LocalReport.Refresh();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "DisplayReports('Information.','Report ran successfully.');", true);
            
        }
        protected void btnEditPnl_Click(object sender, EventArgs e)
        {
            if (pnlEditingData.Visible == true)
            {
                pnlEditingData.Visible = false;
            }
            else
            {
                pnlEditingData.Visible = true;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            btnAdd.Enabled = false;
            btnSave.Enabled = true;
            btnSaveNAddNew.Enabled = true;
            btnDelete.Enabled = false;
            Editing.Visible = true;
            pnlEditingData.Visible = true;
            GridView1.Visible = false;
            clearCtrls();
        }

        protected void clearCtrls()
        {
            txtBnkCode.Text = "";
            txtShtDesc.Text = "";
            txtBnkName.Text = "";
            txtPostalAddr.Text = "";
            txtPhysicalAddr.Text = "";
            txtKBAcode.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (Bank_Update())
            {
                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                GridView1.Visible = true;
                GridView1.DataBind();

                clearCtrls();
            }
            else
            {

            }
        }

        protected void btnSaveNAddNew_Click(object sender, EventArgs e)
        {
            if (Bank_Update())
            {
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = false;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                GridView1.Visible = false;
                GridView1.DataBind();
                
                clearCtrls();
            }
            else
            {

            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {            
            int v_txtBnkCode;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txtBnkCode.Text))
                {
                    v_txtBnkCode = 0;
                }
                else
                {
                    v_txtBnkCode = Convert.ToInt32(txtBnkCode.Text);
                }
                SqlCommand cmd = new SqlCommand("delete_banks", new SqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("@v_txtBnkCode =====>" + v_txtBnkCode);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_bnk_code", v_txtBnkCode));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();


                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                GridView1.Visible = true;
                GridView1.DataBind();
                clearCtrls();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records successfully deleted.');", true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error =====>" + ex.Message.ToString());

                errMessage = "Error deleting record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            btnAdd.Enabled = true;
            btnSave.Enabled = false;
            btnSaveNAddNew.Enabled = false;
            btnDelete.Enabled = false;
            Editing.Visible = false;
            pnlEditingData.Visible = false;
            GridView1.Visible = true;

            clearCtrls();
        }

        protected void btnPopup_Click(object sender, EventArgs e)
        {
            string title = "Information";
            string msg = "This is not an error man.";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('" + title + "','" + msg + "');", true);

        }
        
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings
                ["serenehrdbConnectionString"].ConnectionString;
        }

        [DataObjectMethod(DataObjectMethodType.Insert)]
        private Boolean Bank_Update() {
            Boolean v_bool;            
            String errMessage;
            int v_bnk_code;

            try {

                txtBnkCode.Text = txtBnkCode.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txtBnkCode.Text))
                {
                    v_bnk_code = 0;
                }
                else
                {
                    v_bnk_code = Convert.ToInt32(txtBnkCode.Text);
                }

                txtShtDesc.Text = txtShtDesc.Text.Replace("&nbsp;", "");
                txtBnkName.Text = txtBnkName.Text.Replace("&nbsp;", "");
                txtPostalAddr.Text = txtPostalAddr.Text.Replace("&nbsp;", "");
                txtPhysicalAddr.Text = txtPhysicalAddr.Text.Replace("&nbsp;", "");
                txtKBAcode.Text = txtKBAcode.Text.Replace("&nbsp;", "");
                SqlCommand cmd = new SqlCommand("update_banks", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_bnk_code", v_bnk_code));
                cmd.Parameters.Add(new SqlParameter("@v_sht_desc", txtShtDesc.Text));
                cmd.Parameters.Add(new SqlParameter("@v_name", txtBnkName.Text));
                cmd.Parameters.Add(new SqlParameter("@v_postal_address", txtPostalAddr.Text));
                cmd.Parameters.Add(new SqlParameter("@v_physical_address", txtPhysicalAddr.Text));
                cmd.Parameters.Add(new SqlParameter("@v_kba_code", txtKBAcode.Text));
                cmd.Parameters.Add(new SqlParameter("@v_bnkcode", SqlDbType.Int));
                cmd.Parameters["@v_bnkcode"].Direction = ParameterDirection.Output;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                v_bool = true;
            }catch(Exception ex){
                v_bool = false;
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);
            }
            return v_bool;        
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dt;
            string name = GridView1.SelectedRow.Cells[2].Text;
            txtBnkCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
            txtShtDesc.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
            txtBnkName.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
            txtPostalAddr.Text = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
            txtPhysicalAddr.Text = GridView1.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");
            txtKBAcode.Text = GridView1.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", "");

            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();
            dt = Create_DtFromGv(GridView2);

            if (dt.Rows.Count <= 0) {
                dt.Columns.Add("bbr_code");
                dt.Columns.Add("bbr_sht_desc");
                dt.Columns.Add("bbr_name");
                dt.Columns.Add("bbr_postal_address");
                dt.Columns.Add("bbr_physical_address");
                dt.Columns.Add("bbr_tel_no1");
                dt.Columns.Add("bbr_tel_no2");


                DataRow dr;
                dr = dt.NewRow();
                dr[0] = "";
                dr[1] = "";
                dr[2] = "";
                dr[3] = "";
                dr[4] = "";
                dr[5] = "";
                dr[6] = "";
                dt.Rows.Add(dr);
                GridView2.DataSource = null;
                GridView2.DataSource = dt;
                GridView2.DataBind();                
            }

            btnAdd.Enabled = false;
            btnSave.Enabled = true;
            btnSaveNAddNew.Enabled = true;
            btnDelete.Enabled = true;
            pnlTaxRates.Visible = true;
            //Editing.Visible = true;
            //pnlEditingData.Visible = true;
            //GridView1.Visible = false;
        
        }

        protected void ddlRateType_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected DataTable Create_DtFromGv(GridView gv)
        {
            DataTable dt = new DataTable();

            if (gv.HeaderRow != null)
            {

                for (int i = 0; i < gv.HeaderRow.Cells.Count; i++)
                {
                    dt.Columns.Add(gv.HeaderRow.Cells[i].Text.Replace("&nbsp;", ""));
                }
            }

            for (int j = 0; j < gv.Rows.Count; j++)
            {
                DataRow dr;
                GridViewRow row = gv.Rows[j];
                dr = dt.NewRow();

                for (int i = 0; i < row.Cells.Count; i++)
                {
                    dr[i] = row.Cells[i].Text.Replace("&nbsp;", "");
                    //System.Diagnostics.Debug.WriteLine("row.Cells["+i.ToString()+"].Text==>" + row.Cells[i].Text.ToString());
                }

                dt.Rows.Add(dr);
            }
            return dt;

        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("test GridView2_SelectedIndexChanged");
            BankBranch_Update();
            GridView2.DataSource = null;
            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','Testing');", true);
        }

        protected void GridView2_SelectedIndexChanging(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("Retesting GridView2_SelectedIndexChanging");
            BankBranch_Update();
            GridView2.DataSource = null;
            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();


        }


        [DataObjectMethod(DataObjectMethodType.Insert)]
        private Boolean BankBranch_Update()
        {
            Boolean v_bool;
            String errMessage;
            SqlCommand cmd;
            int v_bnk_code, v_bbr_code, v_bbrcode;
            String v_bbr_sht_desc;
            String v_bbr_name, v_bbr_postal_address, v_bbr_physical_address;
            String v_bbr_tel_no1, v_bbr_tel_no2;

            try
            {
                txtBnkCode.Text = txtBnkCode.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txtBnkCode.Text))
                {
                    v_bnk_code = 0;
                }
                else
                {
                    v_bnk_code = Convert.ToInt32(txtBnkCode.Text);
                }
                TextBox txt_bbr_code = (TextBox)GridView2.FooterRow.FindControl("txt_bbr_code");
                txt_bbr_code.Text = txt_bbr_code.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(txt_bbr_code.Text))
                {
                    v_bbr_code = 0;
                }
                else
                {
                    v_bbr_code = Convert.ToInt32(txt_bbr_code.Text);
                }

                TextBox txt_bbr_sht_desc = (TextBox)GridView2.FooterRow.FindControl("txt_bbr_sht_desc");
                v_bbr_sht_desc = txt_bbr_sht_desc.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_name = (TextBox)GridView2.FooterRow.FindControl("txt_bbr_name");
                v_bbr_name = txt_bbr_name.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_postal_address = (TextBox)GridView2.FooterRow.FindControl("txt_bbr_postal_address");
                v_bbr_postal_address = txt_bbr_postal_address.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_physical_address = (TextBox)GridView2.FooterRow.FindControl("txt_bbr_physical_address");
                v_bbr_physical_address = txt_bbr_physical_address.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_tel_no1 = (TextBox)GridView2.FooterRow.FindControl("txt_bbr_tel_no1");
                v_bbr_tel_no1 = txt_bbr_tel_no1.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_tel_no2 = (TextBox)GridView2.FooterRow.FindControl("txt_bbr_tel_no2");
                v_bbr_tel_no2 = txt_bbr_tel_no2.Text.Replace("&nbsp;", "");

                cmd = new SqlCommand("update_bank_branches", new SqlConnection(GetConnectionString()));
                
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_bbr_code", v_bbr_code));
                cmd.Parameters.Add(new SqlParameter("@v_sht_desc", v_bbr_sht_desc));
                cmd.Parameters.Add(new SqlParameter("@v_name", v_bbr_name));
                cmd.Parameters.Add(new SqlParameter("@v_postal_address", v_bbr_postal_address));
                cmd.Parameters.Add(new SqlParameter("@v_physical_address", v_bbr_physical_address));
                cmd.Parameters.Add(new SqlParameter("@v_tel_no1", v_bbr_tel_no1));
                cmd.Parameters.Add(new SqlParameter("@v_tel_no2", v_bbr_tel_no2));
                cmd.Parameters.Add(new SqlParameter("@v_bnk_code", v_bnk_code));
                cmd.Parameters.Add(new SqlParameter("@v_bbrcode", SqlDbType.Int));
                cmd.Parameters["@v_bbrcode"].Direction = ParameterDirection.Output;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                    
                cmd.Connection.Close();
                v_bbrcode = Convert.ToInt32(cmd.Parameters["@v_bbrcode"].Value);
                System.Diagnostics.Debug.WriteLine("@v_bbr_sht_desc=======>" + v_bbr_sht_desc + "@v_bbr_name===>" + v_bbr_name);
                
                v_bool = true;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records saved successfully');", true);
            }
            catch (Exception ex)
            {
                v_bool = false;
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }

            return v_bool;
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //System.Diagnostics.Debug.WriteLine("CommandName =====>" + e.CommandName);
            if (e.CommandName == "Insert")
            {
                BankBranch_Update();
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
            }
            else if (e.CommandName == "Edit") { }
            else if (e.CommandName == "Update") { }
            else if (e.CommandName == "Delete") { }

        }

        protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
        {
   
        }

        protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            String errMessage;
            SqlCommand cmd;
            int v_bnk_code, v_bbr_code, v_bbrcode;
            String v_bbr_sht_desc;
            String v_bbr_name, v_bbr_postal_address, v_bbr_physical_address;
            String v_bbr_tel_no1, v_bbr_tel_no2;

            try
            {
                txtBnkCode.Text = txtBnkCode.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txtBnkCode.Text))
                {
                    v_bnk_code = 0;
                }
                else
                {
                    v_bnk_code = Convert.ToInt32(txtBnkCode.Text);
                }
                TextBox txt_bbr_code = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_bbr_code");
                txt_bbr_code.Text = txt_bbr_code.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(txt_bbr_code.Text))
                {
                    v_bbr_code = 0;
                }
                else
                {
                    v_bbr_code = Convert.ToInt32(txt_bbr_code.Text);
                }

                TextBox txt_bbr_sht_desc = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_bbr_sht_desc");
                v_bbr_sht_desc = txt_bbr_sht_desc.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_name = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_bbr_name");
                v_bbr_name = txt_bbr_name.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_postal_address = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_bbr_postal_address");
                v_bbr_postal_address = txt_bbr_postal_address.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_physical_address = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_bbr_physical_address");
                v_bbr_physical_address = txt_bbr_physical_address.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_tel_no1 = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_bbr_tel_no1");
                v_bbr_tel_no1 = txt_bbr_tel_no1.Text.Replace("&nbsp;", "");

                TextBox txt_bbr_tel_no2 = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_bbr_tel_no2");
                v_bbr_tel_no2 = txt_bbr_tel_no2.Text.Replace("&nbsp;", "");

                cmd = new SqlCommand("update_bank_branches", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_bbr_code", v_bbr_code));
                cmd.Parameters.Add(new SqlParameter("@v_sht_desc", v_bbr_sht_desc));
                cmd.Parameters.Add(new SqlParameter("@v_name", v_bbr_name));
                cmd.Parameters.Add(new SqlParameter("@v_postal_address", v_bbr_postal_address));
                cmd.Parameters.Add(new SqlParameter("@v_physical_address", v_bbr_physical_address));
                cmd.Parameters.Add(new SqlParameter("@v_tel_no1", v_bbr_tel_no1));
                cmd.Parameters.Add(new SqlParameter("@v_tel_no2", v_bbr_tel_no2));
                cmd.Parameters.Add(new SqlParameter("@v_bnk_code", v_bnk_code));
                cmd.Parameters.Add(new SqlParameter("@v_bbrcode", SqlDbType.Int));
                cmd.Parameters["@v_bbrcode"].Direction = ParameterDirection.Output;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                v_bbrcode = Convert.ToInt32(cmd.Parameters["@v_bbrcode"].Value);
                cmd.Dispose();
                System.Diagnostics.Debug.WriteLine("@v_bbr_sht_desc=======>" + v_bbr_sht_desc + "@v_bbr_name===>" + v_bbr_name);

                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records saved successfully');", true);
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }

        }

        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SqlCommand cmd;
            int v_bbr_code;
            Label lbl_bbr_code = (Label)GridView2.Rows[e.RowIndex].FindControl("lbl_bbr_code");
            System.Diagnostics.Debug.WriteLine("lbl_bbr_code =====>" + lbl_bbr_code.Text);
            lbl_bbr_code.Text = lbl_bbr_code.Text.Replace("&nbsp;", "");

            if (String.IsNullOrEmpty(lbl_bbr_code.Text))
            {
                v_bbr_code = 0;
            }
            else
            {
                v_bbr_code = Convert.ToInt32(lbl_bbr_code.Text);
            }
            cmd = new SqlCommand("delete_bank_branches", new SqlConnection(GetConnectionString()));

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@v_bbr_code", v_bbr_code));

            cmd.Connection.Open();
            cmd.ExecuteNonQuery();

            cmd.Connection.Close();

            GridView2.DataSource = null;
            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Record deleted successfully');", true);

        }

        protected void btnImpTaxRates_Click(object sender, EventArgs e)
        {
            pnlDisplayImportData.Visible = true;
            pnlTaxRates.Visible = false;
        }

        protected void btnExpTaxRates_Click(object sender, EventArgs e)
        {
            DataTable dt = Create_DtFromGv(GridView2);
            txtBnkCode.Text = txtBnkCode.Text.Replace("&nbsp;", "");
            if (String.IsNullOrEmpty(txtBnkCode.Text))
            {
                return;
            }

            Response.ContentType = "Application/x-msexcel";
            Response.AddHeader("content-disposition", "attachment;filename=Tax_Rates.csv");
            Response.Write(ExportToCSVFile(dt, txtBnkCode.Text));
            Response.End();
        }

        protected void btnUpLoad_Click(object sender, EventArgs e)
        {

            String path;
            //path = Server.MapPath(FileUpload1.FileName).ToString();
            path = "C:\\Imports\\" + FileUpload1.FileName;
            lblUploadStatus.Text = path;
            lblUploadStatus.ForeColor = System.Drawing.Color.Azure;

            if (FileUpload1.HasFile)
                try
                {
                    if (File.Exists(path))
                    {
                        System.Diagnostics.Debug.WriteLine("gggggg====>");
                        string[] data = File.ReadAllLines(path);

                        DataTable dt = new DataTable();

                        string[] col = data[0].Split(',');

                        foreach (string s in col)
                        {
                            dt.Columns.Add(s, typeof(string));
                        }
                        System.Diagnostics.Debug.WriteLine("col====>" + dt.Columns.Count + " data.Length=====>" + data.Length);

                        for (int i = 1; i < data.Length; i++)
                        {
                            string[] row = data[i].Split(',');
                            dt.Rows.Add(row);
                            //System.Diagnostics.Debug.WriteLine("row====>" + row.ToString() + " data[i]===>" + data[i].ToString());
                        }
                        gvImportData.DataSource = dt;
                        gvImportData.DataBind();
                        gvImportData.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblUploadStatus.ForeColor = System.Drawing.Color.Red;
                    lblUploadStatus.Text = "ERROR: " + ex.Message.ToString();
                }
            else
            {
                lblUploadStatus.ForeColor = System.Drawing.Color.Red;
                lblUploadStatus.Text = "You have not specified a file.";
            }
        }

        protected void btnClearData_Click(object sender, EventArgs e)
        {

            pnlDisplayImportData.Visible = false;
            pnlTaxRates.Visible = true;
            gvImportData.DataSource = null;
            gvImportData.DataBind();
        }

        protected void btnSaveDataToDb_Click(object sender, EventArgs e)
        {
            if (BankBranches_Import()) { };
        }

        protected void btnExportErrData_Click(object sender, EventArgs e)
        {

        }


        [DataObjectMethod(DataObjectMethodType.Insert)]
        protected Boolean BankBranches_Import()
        {
            Boolean v_bool;
            String errMessage;
            

            try
            {   SqlCommand cmd;
                DataTable dt = Create_DtFromGv(gvImportData);
                String str_bnk_sht_desc;
                String str_bnk_name;
                String str_bbr_sht_desc;
                String str_bbr_name;
                String str_bbr_postal_address;
                String str_bbr_physical_address;
                String str_bbr_tel_no1;
                String str_bbr_tel_no2;
                String str_bnk_kba_code;
                int v_bnkcode;

                if (dt.Columns.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        str_bnk_name = row[0].ToString();
                        str_bnk_sht_desc = row[1].ToString();
                        str_bnk_sht_desc = str_bnk_sht_desc.Replace("&nbsp;", "");
                        str_bnk_sht_desc = str_bnk_sht_desc.Replace(" ", "");

                        str_bbr_sht_desc = row[2].ToString().Replace("&nbsp;", "");
                        str_bbr_name = row[3].ToString().Replace("&nbsp;", "");
                        str_bbr_postal_address = row[4].ToString().Replace("&nbsp;", "");
                        str_bbr_physical_address = row[5].ToString().Replace("&nbsp;", "");
                        str_bbr_tel_no1 = row[6].ToString().Replace("&nbsp;", "");
                        str_bbr_tel_no2 = row[7].ToString().Replace("&nbsp;", "");
                        str_bnk_kba_code = row[8].ToString().Replace("&nbsp;", "");

                        cmd = new SqlCommand("update_banks", new SqlConnection(GetConnectionString()));

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add(new SqlParameter("@v_bnk_code", 0));
                        cmd.Parameters.Add(new SqlParameter("@v_sht_desc", str_bnk_sht_desc));
                        cmd.Parameters.Add(new SqlParameter("@v_name", str_bnk_name));
                        cmd.Parameters.Add(new SqlParameter("@v_postal_address", null));
                        cmd.Parameters.Add(new SqlParameter("@v_physical_address", null));
                        cmd.Parameters.Add(new SqlParameter("@v_kba_code", str_bnk_kba_code));
                        cmd.Parameters.Add(new SqlParameter("@v_bnkcode", SqlDbType.Int));
                        cmd.Parameters["@v_bnkcode"].Direction = ParameterDirection.Output;

                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();

                        cmd.Connection.Close();
                        v_bnkcode = 0;
                        v_bnkcode = Convert.ToInt32(cmd.Parameters["@v_bnkcode"].Value);

                        cmd.Dispose();
                        if (v_bnkcode != 0) {

                            cmd = new SqlCommand("update_bank_branches", new SqlConnection(GetConnectionString()));

                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add(new SqlParameter("@v_bbr_code", 0));
                            cmd.Parameters.Add(new SqlParameter("@v_sht_desc", str_bbr_sht_desc));
                            cmd.Parameters.Add(new SqlParameter("@v_name", str_bbr_name));
                            cmd.Parameters.Add(new SqlParameter("@v_postal_address", str_bbr_postal_address));
                            cmd.Parameters.Add(new SqlParameter("@v_physical_address", str_bbr_physical_address));
                            cmd.Parameters.Add(new SqlParameter("@v_tel_no1", str_bbr_tel_no1));
                            cmd.Parameters.Add(new SqlParameter("@v_tel_no2", str_bbr_tel_no2));
                            cmd.Parameters.Add(new SqlParameter("@v_bnk_code", v_bnkcode));
                            cmd.Parameters.Add(new SqlParameter("@v_bbrcode", SqlDbType.Int));
                            cmd.Parameters["@v_bbrcode"].Direction = ParameterDirection.Output;

                            cmd.Connection.Open();
                            cmd.ExecuteNonQuery();

                            cmd.Connection.Close();
                            cmd.Dispose();
                        
                        }
                        
                    }
                }
                v_bool = true;
            }
            catch (Exception ex)
            {
                v_bool = false;
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);
                               
            
            }

            return v_bool;
        }

        protected void btnDeleteAll_Click(object sender, EventArgs e)
        {
            String errMessage;
            txtBnkCode.Text = txtBnkCode.Text.Replace("&nbsp;", "");
            txtBnkCode.Text = txtBnkCode.Text.Replace(" ", "");
            int v_txtBnkCode;
            if (String.IsNullOrEmpty(txtBnkCode.Text))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Select a Bank to delete all it's Branches.');", true);
            }
            else
            {
                try
                {
                    if (String.IsNullOrEmpty(txtBnkCode.Text))
                    {
                        v_txtBnkCode = 0;
                    }
                    else
                    {
                        v_txtBnkCode = Convert.ToInt32(txtBnkCode.Text);
                    }
                    SqlCommand cmd = new SqlCommand("delete_all_bank_branches", new SqlConnection(GetConnectionString()));
                    System.Diagnostics.Debug.WriteLine("@v_txtBnkCode =====>" + v_txtBnkCode);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@v_bnk_code", v_txtBnkCode));
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();

                    cmd.Dispose();
                    GridView2.DataSource = null;
                    GridView2.DataSource = SqlDataSource2;
                    GridView2.DataBind();
                    GridView2.Visible = true;


                    System.Diagnostics.Debug.WriteLine("txtBnkCode.Text =====>" + txtBnkCode.Text);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records deleted successfully.');", true);
                }
                catch (Exception ex) {

                    System.Diagnostics.Debug.WriteLine("Error =====>" + ex.Message.ToString());

                    errMessage = "Error deleting record ..." + ex.Message.ToString();
                    errMessage = errMessage.ToString().Replace("'", "");
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                }
            }
        }

        public string ExportToCSVFile(DataTable dtTable, String v_tx_code)
        {
            StringBuilder sbldr = new StringBuilder();
            if (dtTable.Columns.Count != 0)
            {
                sbldr.Append("Tax Type Id" + ',');
                foreach (DataColumn col in dtTable.Columns)
                {
                    sbldr.Append(col.ColumnName + ',');
                }
                sbldr.Append("\r\n");

                foreach (DataRow row in dtTable.Rows)
                {
                    sbldr.Append(v_tx_code + ',');
                    foreach (DataColumn column in dtTable.Columns)
                    {
                        sbldr.Append(row[column].ToString() + ',');
                    }
                    sbldr.Append("\r\n");
                }
            }
            return sbldr.ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GridView1.DataBind();
            GridView1.Visible = true;
            pnlDisplayAllRecs.Visible = true;
        }

        protected void btnDeleteAllBankDtls_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                SqlCommand cmd = new SqlCommand("delete_all_bank_details", new SqlConnection(GetConnectionString()));
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();

                cmd.Dispose();
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
                GridView1.DataBind();
                GridView2.Visible = true;


                System.Diagnostics.Debug.WriteLine("delete_all_bank_details");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records deleted successfully.');", true);
            }
            catch (Exception ex)
            {

                System.Diagnostics.Debug.WriteLine("Error =====>" + ex.Message.ToString());

                errMessage = "Error deleting record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
            }
        }

        /*
         * How to get the row index
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
            // Retrieve the row index stored in the 
            // CommandArgument property.
            int index = Convert.ToInt32(e.CommandArgument);

            // Retrieve the row that contains the button 
            // from the Rows collection.
            GridViewRow row = GridView1.Rows[index];

            // Add code here to add the item to the shopping cart.
            }
        }
        */

    }

}