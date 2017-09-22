using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using MySql.Data.MySqlClient;

using System.Configuration;
using System.ComponentModel;

using System.Globalization;
using System.Text.RegularExpressions;

using System.IO;
using System.Text;

namespace SerenePayroll
{
    public partial class aspxLoans : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
            pnlRates.Visible = false;
            clearCtrls();
        }

        protected void clearCtrls()
        {
            txtLtCode.Text = "";
            txtShtDesc.Text = "";
            txtDesc.Text = "";
            txt_min_repay_prd.Text = "";
            txt_max_repay_prd.Text = "";
            txt_min_amt.Text = "";
            txt_max_amt.Text = "";
            txtWef.Text = "";
            txtWet.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (LoanType_Update())
            {
                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                GridView1.Visible = true;
                GridView1.DataBind();
                pnlRates.Visible = false;

                clearCtrls();
            }
            else
            {

            }
        }

        protected void btnSaveNAddNew_Click(object sender, EventArgs e)
        {
            if (LoanType_Update())
            {
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = false;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                GridView1.Visible = false;
                GridView1.DataBind();
                pnlRates.Visible = false;
                
                clearCtrls();
            }
            else
            {

            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {            
            int v_txtLtCode;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txtLtCode.Text))
                {
                    v_txtLtCode = 0;
                }
                else
                {
                    v_txtLtCode = Convert.ToInt32(txtLtCode.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.delete_loan_type", new MySqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("v_txtLtCode =====>" + v_txtLtCode);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_lt_code", v_txtLtCode));
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
                pnlRates.Visible = false;
                clearCtrls();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Record successfully deleted.');", true);
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
            pnlRates.Visible = false;

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
        private Boolean LoanType_Update()
        {
            Boolean v_bool;
            String errMessage;
            try
            {
                int v_LtCode;
                int v_min_repay_prd, v_max_repay_prd;
                int v_min_amt, v_max_amt;
                if (String.IsNullOrEmpty(txtLtCode.Text))
                {
                    v_LtCode = 0;
                }
                else
                {
                    v_LtCode = Convert.ToInt32(txtLtCode.Text);
                }
                if (String.IsNullOrEmpty(txt_min_repay_prd.Text))
                {
                    v_min_repay_prd = 0;
                }
                else
                {
                    v_min_repay_prd = Convert.ToInt32(txt_min_repay_prd.Text);
                }
                if (String.IsNullOrEmpty(txt_max_repay_prd.Text))
                {
                    v_max_repay_prd = 0;
                }
                else
                {
                    v_max_repay_prd = Convert.ToInt32(txt_max_repay_prd.Text);
                }
                if (String.IsNullOrEmpty(txt_min_amt.Text))
                {
                    v_min_amt = 0;
                }
                else
                {
                    v_min_amt = Convert.ToInt32(txt_min_amt.Text);
                }
                if (String.IsNullOrEmpty(txt_max_amt.Text))
                {
                    v_max_amt = 0;
                }
                else
                {
                    v_max_amt = Convert.ToInt32(txt_max_amt.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.update_loan_types", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_lt_code", v_LtCode));
                cmd.Parameters.Add(new MySqlParameter("v_sht_desc", txtShtDesc.Text));
                cmd.Parameters.Add(new MySqlParameter("v_desc", txtDesc.Text));
                cmd.Parameters.Add(new MySqlParameter("v_min_repay_prd", v_min_repay_prd));
                cmd.Parameters.Add(new MySqlParameter("v_max_repay_prd", v_max_repay_prd));
                cmd.Parameters.Add(new MySqlParameter("v_min_amt", v_min_amt));
                cmd.Parameters.Add(new MySqlParameter("v_max_amt", v_max_amt));
                cmd.Parameters.Add(new MySqlParameter("v_wef", txtWef.Text));
                cmd.Parameters.Add(new MySqlParameter("v_wet", txtWet.Text));
                cmd.Parameters.Add(new MySqlParameter("v_ltcode", MySqlDbType.Int32));
                cmd.Parameters["v_ltcode"].Direction = ParameterDirection.Output;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();

                v_bool = true;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Record saved successfully');", true);
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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dt;

            txtLtCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
            txtShtDesc.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
            txtDesc.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
            txt_min_repay_prd.Text = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
            txt_max_repay_prd.Text = GridView1.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");
            txt_min_amt.Text = GridView1.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", "");
            txt_max_amt.Text = GridView1.SelectedRow.Cells[7].Text.Trim().Replace("&nbsp;", "");
            txtWef.Text = GridView1.SelectedRow.Cells[8].Text.Trim().Replace("&nbsp;", "");
            txtWet.Text = GridView1.SelectedRow.Cells[9].Text.Trim().Replace("&nbsp;", "");


            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();
            dt = Create_DtFromGv(GridView2);

            if (dt.Rows.Count <= 0)
            {
                dt.Columns.Add("lir_code");
                dt.Columns.Add("lir_rate");
                dt.Columns.Add("lir_div_factr");
                dt.Columns.Add("lir_wef");
                dt.Columns.Add("lir_wet");

                DataRow dr;
                dr = dt.NewRow();
                dr[0] = "";
                dr[1] = "";
                dr[2] = "100";
                dr[3] = "";
                dr[4] = "";
                dt.Rows.Add(dr);
                GridView2.DataSource = null;
                GridView2.DataSource = dt;
                GridView2.DataBind();
            }

            btnAdd.Enabled = false;
            btnSave.Enabled = true;
            btnSaveNAddNew.Enabled = true;
            btnDelete.Enabled = true;
            Editing.Visible = true;
            pnlEditingData.Visible = true;
            GridView1.Visible = false;
            pnlRates.Visible = true;
        
        }

        protected void btnAddRate_Click(object sender, EventArgs e)
        {

        }

        protected void btnSaveRate_Click(object sender, EventArgs e)
        {

        }

        protected void btnSaveNAddRate_Click(object sender, EventArgs e)
        {

        }

        protected void btnDeleteRate_Click(object sender, EventArgs e)
        {

        }

        protected void btnCancelRate_Click(object sender, EventArgs e)
        {

        }


        [DataObjectMethod(DataObjectMethodType.Insert)]
        private Boolean Rate_Update()
        {
            Boolean v_bool;
            String errMessage;
            MySqlCommand cmd;
            int v_lt_code, v_lir_code;
            int v_rate, v_div_factr;
            String v_wef, v_wet;

            try
            {
                txtLtCode.Text = txtLtCode.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txtLtCode.Text))
                {
                    v_lt_code = 0;
                }
                else
                {
                    v_lt_code = Convert.ToInt32(txtLtCode.Text);
                }
                TextBox txt_lir_code = (TextBox)GridView2.FooterRow.FindControl("txt_lir_code");
                txt_lir_code.Text = txt_lir_code.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(txt_lir_code.Text))
                {
                    v_lir_code = 0;
                }
                else
                {
                    v_lir_code = Convert.ToInt32(txt_lir_code.Text);
                }

                TextBox txt_lir_rate = (TextBox)GridView2.FooterRow.FindControl("txt_lir_rate");
                txt_lir_rate.Text = txt_lir_rate.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_lir_rate.Text))
                {
                    v_rate = 0;
                }
                else
                {
                    v_rate = Convert.ToInt32(txt_lir_rate.Text);
                }

                TextBox txt_lir_div_factr = (TextBox)GridView2.FooterRow.FindControl("txt_lir_div_factr");
                txt_lir_div_factr.Text = txt_lir_div_factr.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_lir_div_factr.Text))
                {
                    v_div_factr = 1;
                }
                else
                {

                    v_div_factr = Convert.ToInt32(txt_lir_div_factr.Text);
                }

                TextBox txt_lir_wef = (TextBox)GridView2.FooterRow.FindControl("txt_lir_wef");
                v_wef = txt_lir_wef.Text.Replace("&nbsp;", "");
                TextBox txt_lir_wet = (TextBox)GridView2.FooterRow.FindControl("txt_lir_wet");
                v_wet = txt_lir_wet.Text.Replace("&nbsp;", "");
                cmd = new MySqlCommand("serenehrdb.update_loan_intr_rates", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_lir_code", v_lir_code));
                cmd.Parameters.Add(new MySqlParameter("v_rate", v_rate));
                cmd.Parameters.Add(new MySqlParameter("v_div_factr", v_div_factr));
                cmd.Parameters.Add(new MySqlParameter("v_wef", v_wef));
                cmd.Parameters.Add(new MySqlParameter("v_wet", v_wet));
                cmd.Parameters.Add(new MySqlParameter("v_lt_code", v_lt_code));
                cmd.Parameters.Add(new MySqlParameter("v_lircode", MySqlDbType.Int32));
                cmd.Parameters["v_lircode"].Direction = ParameterDirection.Output;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                System.Diagnostics.Debug.WriteLine("v_lir_code=======>");

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
                if (Rate_Update() == true) { }
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
            MySqlCommand cmd;
            int v_lt_code, v_lir_code;
            int v_rate, v_div_factr;
            String v_wef, v_wet;

            try
            {
                txtLtCode.Text = txtLtCode.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txtLtCode.Text))
                {
                    v_lt_code = 0;
                }
                else
                {
                    v_lt_code = Convert.ToInt32(txtLtCode.Text);
                }
                TextBox txt_lir_code = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_lir_code");
                txt_lir_code.Text = txt_lir_code.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(txt_lir_code.Text))
                {
                    v_lir_code = 0;
                }
                else
                {
                    v_lir_code = Convert.ToInt32(txt_lir_code.Text);
                }

                TextBox txt_lir_rate = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_lir_rate");
                txt_lir_rate.Text = txt_lir_rate.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_lir_rate.Text))
                {
                    v_rate = 0;
                }
                else
                {
                    v_rate = Convert.ToInt32(txt_lir_rate.Text);
                }

                TextBox txt_lir_div_factr = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_lir_div_factr");
                txt_lir_div_factr.Text = txt_lir_div_factr.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_lir_div_factr.Text))
                {
                    v_div_factr = 1;
                }
                else
                {

                    v_div_factr = Convert.ToInt32(txt_lir_div_factr.Text);
                }
                TextBox txt_lir_wef = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_lir_wef");
                v_wef = txt_lir_wef.Text.Replace("&nbsp;", "");
                TextBox txt_lir_wet = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_lir_wet");
                v_wet = txt_lir_wet.Text.Replace("&nbsp;", "");
                cmd = new MySqlCommand("serenehrdb.update_loan_intr_rates", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_lir_code", v_lir_code));
                cmd.Parameters.Add(new MySqlParameter("v_rate", v_rate));
                cmd.Parameters.Add(new MySqlParameter("v_div_factr", v_div_factr));
                cmd.Parameters.Add(new MySqlParameter("v_wef", v_wef));
                cmd.Parameters.Add(new MySqlParameter("v_wet", v_wet));
                cmd.Parameters.Add(new MySqlParameter("v_lt_code", v_lt_code));
                cmd.Parameters.Add(new MySqlParameter("v_lircode", MySqlDbType.Int32));
                cmd.Parameters["v_lircode"].Direction = ParameterDirection.Output;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                System.Diagnostics.Debug.WriteLine("v_lir_code=======>" + v_lir_code.ToString());

                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
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
            MySqlCommand cmd;
            int v_lir_code;
            Label lbl_lir_code = (Label)GridView2.Rows[e.RowIndex].FindControl("lbl_lir_code");
            System.Diagnostics.Debug.WriteLine("lbl_lir_code =====>" + lbl_lir_code.Text);
            lbl_lir_code.Text = lbl_lir_code.Text.Replace("&nbsp;", "");

            if (String.IsNullOrEmpty(lbl_lir_code.Text))
            {
                v_lir_code = 0;
            }
            else
            {
                v_lir_code = Convert.ToInt32(lbl_lir_code.Text);
            }
            cmd = new MySqlCommand("serenehrdb.delete_loan_intr_rates", new MySqlConnection(GetConnectionString()));

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new MySqlParameter("v_lir_code", v_lir_code));

            cmd.Connection.Open();
            cmd.ExecuteNonQuery();

            cmd.Connection.Close();

            GridView2.DataSource = null;
            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Record deleted successfully');", true);

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

        protected void txt_min_repay_prd_TextChanged(object sender, EventArgs e)
        {
            txt_min_repay_prd.Text = Regex.Replace(txt_min_repay_prd.Text, "[^0-9]", "");
        }
        protected void txt_max_repay_prd_TextChanged(object sender, EventArgs e)
        {
            txt_max_repay_prd.Text = Regex.Replace(txt_max_repay_prd.Text, "[^0-9]", "");
        }
        protected void txt_min_amt_TextChanged(object sender, EventArgs e)
        {
            txt_min_amt.Text = Regex.Replace(txt_min_amt.Text, "[^0-9]", "");
        }
        protected void txt_max_amt_TextChanged(object sender, EventArgs e)
        {
            txt_max_amt.Text = Regex.Replace(txt_max_amt.Text, "[^0-9]", "");
        }
        
    }
}