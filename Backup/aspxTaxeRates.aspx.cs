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


namespace SerenePayroll
{
    public partial class aspxTaxeRates : System.Web.UI.Page
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
            clearCtrls();
        }

        protected void clearCtrls()
        {
            txtTxCode.Text = "";
            txtShtDesc.Text = "";
            txtDesc.Text = "";
            txtWef.Text = "";
            txtWet.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (TaxesRates_Update())
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
            if (TaxesRates_Update())
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
            int v_txtTxCode;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txtTxCode.Text))
                {
                    v_txtTxCode = 0;
                }
                else
                {
                    v_txtTxCode = Convert.ToInt32(txtTxCode.Text);
                }
                SqlCommand cmd = new SqlCommand("delete_tax", new SqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("@v_txtTxCode =====>" + v_txtTxCode);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_tx_code", v_txtTxCode));
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
        private Boolean TaxesRates_Update()
        {
            Boolean v_bool;
            String errMessage;
            String val;
            GridViewRow row;
            SqlCommand cmd;
            int v_tx_code, v_txr_code;
            String v_Desc;            
			String v_rate_type, v_frequency;
			int v_rate,v_div_factr;
            String v_wef, v_wet;
            int v_range_from, v_range_to;

            try
            {
                txtTxCode.Text = txtTxCode.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txtTxCode.Text))
                {
                    v_tx_code = 0;
                }
                else
                {
                    v_tx_code = Convert.ToInt32(txtTxCode.Text);
                }
                for (int j = 0; j < GridView2.Rows.Count; j++)
                {
                    row = GridView2.Rows[j];

                    val = row.Cells[0].Text.Replace("&nbsp;", "");
                    if (String.IsNullOrEmpty(val))
                    {
                        v_txr_code = 0;
                    }
                    else
                    {
                        v_txr_code = Convert.ToInt32(val);
                    }

                    System.Diagnostics.Debug.WriteLine("@v_txr_code===xxxxxx=>"+v_txr_code);

                    v_Desc = row.Cells[1].Text.Replace("&nbsp;", "");
                    v_rate_type = row.Cells[2].Text.Replace("&nbsp;", "");
                    val = row.Cells[3].Text.Replace("&nbsp;", "");
                    if (String.IsNullOrEmpty(val))
                    {
                        v_rate = 0;
                    }
                    else
                    {
                        v_rate = Convert.ToInt32(val);
                    }

                    val = row.Cells[4].Text.Replace("&nbsp;", "");
                    if (String.IsNullOrEmpty(val))
                    {
                        v_div_factr = 1;
                    }
                    else
                    {
                        v_div_factr = Convert.ToInt32(val);
                    }

                    val = row.Cells[5].Text.Replace("&nbsp;", "");
                    if (String.IsNullOrEmpty(val))
                    {
                        v_range_from = 0;
                    }
                    else
                    {
                        v_range_from = Convert.ToInt32(val);
                    }
                    val = row.Cells[6].Text.Replace("&nbsp;", "");
                    if (String.IsNullOrEmpty(val))
                    {
                        v_range_to = 0;
                    }
                    else
                    {
                        v_range_to = Convert.ToInt32(val);
                    }

                    v_wef = row.Cells[7].Text.Replace("&nbsp;", "");
                    v_wet = row.Cells[8].Text.Replace("&nbsp;", "");
                    v_frequency = row.Cells[9].Text.Replace("&nbsp;", "");
                    
                    
                    cmd = new SqlCommand("update_tax_rates", new SqlConnection(GetConnectionString()));

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@v_txr_code", v_txr_code));
                    cmd.Parameters.Add(new SqlParameter("@v_desc", v_Desc));
                    cmd.Parameters.Add(new SqlParameter("@v_rate_type", v_rate_type));
                    cmd.Parameters.Add(new SqlParameter("@v_rate", v_rate));
                    cmd.Parameters.Add(new SqlParameter("@v_div_factr", v_div_factr));
                    cmd.Parameters.Add(new SqlParameter("@v_wef", v_wef));
                    cmd.Parameters.Add(new SqlParameter("@v_wet", v_wet));
                    cmd.Parameters.Add(new SqlParameter("@v_range_from", v_range_from));
                    cmd.Parameters.Add(new SqlParameter("@v_range_to", v_range_to));
                    cmd.Parameters.Add(new SqlParameter("@v_tx_code", v_tx_code));
                    cmd.Parameters.Add(new SqlParameter("@v_txrcode", SqlDbType.Int));
                    cmd.Parameters["@v_txrcode"].Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(new SqlParameter("@v_frequency", v_frequency));

                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();

                    cmd.Connection.Close();
                    System.Diagnostics.Debug.WriteLine("@v_Desc=======>" + v_Desc);
                }
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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dt;
            string name = GridView1.SelectedRow.Cells[2].Text;
            txtTxCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
            txtShtDesc.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
            txtDesc.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
            txtWef.Text = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
            txtWet.Text = GridView1.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");

            GridView2.DataSource = null;
            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();
            dt = Create_DtFromGv(GridView2);

            if (dt.Rows.Count <= 0) {
                dt.Columns.Add("txr_code");
                dt.Columns.Add("txr_desc");
                dt.Columns.Add("txr_rate_type");
                dt.Columns.Add("txr_rate");
                dt.Columns.Add("txr_div_factr");
                dt.Columns.Add("txr_range_from");
                dt.Columns.Add("txr_range_to");
                dt.Columns.Add("txr_wef");
                dt.Columns.Add("txr_wet");
                dt.Columns.Add("txr_frequency");



                DataRow dr;
                dr = dt.NewRow();
                dr[0] = "";
                dr[1] = "";
                dr[2] = "";
                dr[3] = "";
                dr[4] = "100";
                dr[5] = "";
                dr[6] = "";
                dr[7] = "";
                dr[8] = "";
                dr[9] = "";
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
            if (TaxRate_Update() == true) { }
            GridView2.DataSource = null;
            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','Testing');", true);
        }

        protected void GridView2_SelectedIndexChanging(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("Retesting GridView2_SelectedIndexChanging");
            if (TaxRate_Update() == true) { }
            GridView2.DataSource = null;
            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();


        }


        [DataObjectMethod(DataObjectMethodType.Insert)]
        private Boolean TaxRate_Update()
        {
            Boolean v_bool;
            String errMessage;
            SqlCommand cmd;
            int v_tx_code, v_txr_code;
            String v_Desc;
            String v_rate_type, v_frequency;
            int v_rate, v_div_factr;
            String v_wef, v_wet;
            int v_range_from, v_range_to;

            try
            {
                txtTxCode.Text = txtTxCode.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txtTxCode.Text))
                {
                    v_tx_code = 0;
                }
                else
                {
                    v_tx_code = Convert.ToInt32(txtTxCode.Text);
                }
                TextBox txt_txr_code = (TextBox)GridView2.FooterRow.FindControl("txt_txr_code");
                txt_txr_code.Text = txt_txr_code.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(txt_txr_code.Text))
                {
                    v_txr_code = 0;
                }
                else
                {
                    v_txr_code = Convert.ToInt32(txt_txr_code.Text);
                }

                TextBox txt_txr_desc = (TextBox)GridView2.FooterRow.FindControl("txt_txr_desc");
                v_Desc = txt_txr_desc.Text.Replace("&nbsp;", "");

                DropDownList ddlRateType = (DropDownList)GridView2.FooterRow.FindControl("ddlRateType");
                v_rate_type = ddlRateType.SelectedValue.Replace("&nbsp;", "");


                TextBox txt_txr_rate = (TextBox)GridView2.FooterRow.FindControl("txt_txr_rate");
                txt_txr_rate.Text = txt_txr_rate.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_txr_rate.Text))
                {
                    v_rate = 0;
                }
                else
                {
                    v_rate = Convert.ToInt32(txt_txr_rate.Text);
                }

                TextBox txt_txr_div_factr = (TextBox)GridView2.FooterRow.FindControl("txt_txr_div_factr");
                txt_txr_div_factr.Text = txt_txr_div_factr.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_txr_div_factr.Text))
                {
                    v_div_factr = 1;
                }
                else
                {

                    v_div_factr = Convert.ToInt32(txt_txr_div_factr.Text);
                }

                TextBox txt_txr_range_from = (TextBox)GridView2.FooterRow.FindControl("txt_txr_range_from");
                txt_txr_range_from.Text = txt_txr_range_from.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_txr_range_from.Text))
                {
                    v_range_from = 1;
                }
                else
                {

                    v_range_from = Convert.ToInt32(txt_txr_range_from.Text);
                }

                TextBox txt_txr_range_to = (TextBox)GridView2.FooterRow.FindControl("txt_txr_range_to");
                txt_txr_range_to.Text = txt_txr_range_to.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_txr_range_to.Text))
                {
                    v_range_to = 1;
                }
                else
                {

                    v_range_to = Convert.ToInt32(txt_txr_range_to.Text);
                }
                TextBox txt_txr_wef = (TextBox)GridView2.FooterRow.FindControl("txt_txr_wef");
                v_wef = txt_txr_wef.Text.Replace("&nbsp;", "");
                TextBox txt_txr_wet = (TextBox)GridView2.FooterRow.FindControl("txt_txr_wet");
                v_wet = txt_txr_wet.Text.Replace("&nbsp;", "");


                DropDownList ddl_txr_frequency = (DropDownList)GridView2.FooterRow.FindControl("ddl_txr_frequency");
                v_frequency = ddl_txr_frequency.SelectedValue.Replace("&nbsp;", "");
                
                cmd = new SqlCommand("update_tax_rates", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_txr_code", v_txr_code));
                cmd.Parameters.Add(new SqlParameter("@v_desc", v_Desc));
                cmd.Parameters.Add(new SqlParameter("@v_rate_type", v_rate_type));
                cmd.Parameters.Add(new SqlParameter("@v_rate", v_rate));
                cmd.Parameters.Add(new SqlParameter("@v_div_factr", v_div_factr));
                cmd.Parameters.Add(new SqlParameter("@v_wef", v_wef));
                cmd.Parameters.Add(new SqlParameter("@v_wet", v_wet));
                cmd.Parameters.Add(new SqlParameter("@v_range_from", v_range_from));
                cmd.Parameters.Add(new SqlParameter("@v_range_to", v_range_to));
                cmd.Parameters.Add(new SqlParameter("@v_tx_code", v_tx_code));
                cmd.Parameters.Add(new SqlParameter("@v_txrcode", SqlDbType.Int));
                cmd.Parameters["@v_txrcode"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(new SqlParameter("@v_frequency", v_frequency));

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                    
                cmd.Connection.Close();
                System.Diagnostics.Debug.WriteLine("@v_Desc=======>" + v_Desc + "@v_rate_type===>" + v_rate_type);
                
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
                if (TaxRate_Update() == true) { }
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
            int v_tx_code, v_txr_code;
            String v_Desc;
            String v_rate_type, v_frequency;
            int v_rate, v_div_factr;
            String v_wef, v_wet;
            int v_range_from, v_range_to;

            try
            {
                txtTxCode.Text = txtTxCode.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txtTxCode.Text))
                {
                    v_tx_code = 0;
                }
                else
                {
                    v_tx_code = Convert.ToInt32(txtTxCode.Text);
                }
                TextBox txt_txr_code = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_txr_code");
                txt_txr_code.Text = txt_txr_code.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(txt_txr_code.Text))
                {
                    v_txr_code = 0;
                }
                else
                {
                    v_txr_code = Convert.ToInt32(txt_txr_code.Text);
                }

                TextBox txt_txr_desc = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_txr_desc");
                v_Desc = txt_txr_desc.Text.Replace("&nbsp;", "");

                DropDownList ddlRateType = (DropDownList)GridView2.Rows[e.RowIndex].FindControl("ddlRateType");
                v_rate_type = ddlRateType.SelectedValue.Replace("&nbsp;", "");

                TextBox txt_txr_rate = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_txr_rate");
                txt_txr_rate.Text = txt_txr_rate.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_txr_rate.Text))
                {
                    v_rate = 0;
                }
                else
                {
                    v_rate = Convert.ToInt32(txt_txr_rate.Text);
                }

                TextBox txt_txr_div_factr = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_txr_div_factr");
                txt_txr_div_factr.Text = txt_txr_div_factr.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_txr_div_factr.Text))
                {
                    v_div_factr = 1;
                }
                else
                {

                    v_div_factr = Convert.ToInt32(txt_txr_div_factr.Text);
                }
                TextBox txt_txr_range_from = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_txr_range_from");
                txt_txr_range_from.Text = txt_txr_range_from.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_txr_range_from.Text))
                {
                    v_range_from = 1;
                }
                else
                {

                    v_range_from = Convert.ToInt32(txt_txr_range_from.Text);
                }

                TextBox txt_txr_range_to = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_txr_range_to");
                txt_txr_range_to.Text = txt_txr_range_to.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_txr_range_to.Text))
                {
                    v_range_to = 1;
                }
                else
                {

                    v_range_to = Convert.ToInt32(txt_txr_range_to.Text);
                }
                TextBox txt_txr_wef = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_txr_wef");
                v_wef = txt_txr_wef.Text.Replace("&nbsp;", "");
                TextBox txt_txr_wet = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_txr_wet");
                v_wet = txt_txr_wet.Text.Replace("&nbsp;", "");

                DropDownList ddl_txr_frequency = (DropDownList)GridView2.Rows[e.RowIndex].FindControl("ddl_txr_frequency");
                v_frequency = ddl_txr_frequency.SelectedValue.Replace("&nbsp;", "");

                cmd = new SqlCommand("update_tax_rates", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_txr_code", v_txr_code));
                cmd.Parameters.Add(new SqlParameter("@v_desc", v_Desc));
                cmd.Parameters.Add(new SqlParameter("@v_rate_type", v_rate_type));
                cmd.Parameters.Add(new SqlParameter("@v_rate", v_rate));
                cmd.Parameters.Add(new SqlParameter("@v_div_factr", v_div_factr));
                cmd.Parameters.Add(new SqlParameter("@v_wef", v_wef));
                cmd.Parameters.Add(new SqlParameter("@v_wet", v_wet));
                cmd.Parameters.Add(new SqlParameter("@v_range_from", v_range_from));
                cmd.Parameters.Add(new SqlParameter("@v_range_to", v_range_to));
                cmd.Parameters.Add(new SqlParameter("@v_tx_code", v_tx_code));
                cmd.Parameters.Add(new SqlParameter("@v_txrcode", SqlDbType.Int));
                cmd.Parameters["@v_txrcode"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(new SqlParameter("@v_frequency", v_frequency));

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                System.Diagnostics.Debug.WriteLine("@v_range_from=======>" + v_range_from.ToString() + "@v_range_to===>" + v_range_to.ToString());

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
            SqlCommand cmd;
            int v_txr_code;
            Label lbl_txr_code = (Label)GridView2.Rows[e.RowIndex].FindControl("lbl_txr_code");
            System.Diagnostics.Debug.WriteLine("lbl_txr_code =====>" + lbl_txr_code.Text);
            lbl_txr_code.Text = lbl_txr_code.Text.Replace("&nbsp;", "");

            if (String.IsNullOrEmpty(lbl_txr_code.Text))
            {
                v_txr_code = 0;
            }
            else
            {
                v_txr_code = Convert.ToInt32(lbl_txr_code.Text);
            }
            cmd = new SqlCommand("delete_tax_rates", new SqlConnection(GetConnectionString()));

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@v_txr_code", v_txr_code));

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
            txtTxCode.Text = txtTxCode.Text.Replace("&nbsp;", "");
            if (String.IsNullOrEmpty(txtTxCode.Text))
            {
                return;
            }

            Response.ContentType = "Application/x-msexcel";
            Response.AddHeader("content-disposition", "attachment;filename=Tax_Rates.csv");
            Response.Write(ExportToCSVFile(dt, txtTxCode.Text));
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
                        System.Diagnostics.Debug.WriteLine("col====>" + col.ToString());

                        for (int i = 1; i < data.Length; i++)
                        {
                            string[] row = data[i].Split(',');
                            dt.Rows.Add(row);
                            //System.Diagnostics.Debug.WriteLine("row====>"+row.ToString());
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
            if (TaxRatesDtls_Import()) { };
        }

        protected void btnExportErrData_Click(object sender, EventArgs e)
        {

        }


        [DataObjectMethod(DataObjectMethodType.Insert)]
        protected Boolean TaxRatesDtls_Import()
        {
            Boolean v_bool;
            String errMessage;
            

            try
            {   SqlCommand cmd;
                DataTable dt = Create_DtFromGv(gvImportData);
                String str_txr_tx_code;
                //String str_txr_code;
                String str_txr_desc;
                String str_txr_rate_type;
                String str_txr_rate;
                String str_txr_div_factr;
                String str_txr_wef;
                String str_txr_wet;
                String str_txr_range_from;
                String str_txr_range_to;
                String str_txr_frequency;
                int v_tx_code, v_rate, v_div_factr, v_range_from, v_range_to;

                if (dt.Columns.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        str_txr_tx_code = row[0].ToString();
                        str_txr_tx_code = str_txr_tx_code.Replace("&nbsp;", "");
                        str_txr_tx_code = str_txr_tx_code.Replace(" ", "");
                        if (String.IsNullOrEmpty(str_txr_tx_code))
                        {
                            v_tx_code = 0;
                        }
                        else
                        {
                            v_tx_code = Convert.ToInt32(str_txr_tx_code);
                        }
                        str_txr_desc = row[1].ToString();
                        str_txr_rate_type = row[2].ToString();
                        str_txr_rate = row[3].ToString();
                        str_txr_rate = str_txr_rate.Replace("&nbsp;", "");
                        str_txr_rate = str_txr_rate.Replace(" ", "");
                        if (String.IsNullOrEmpty(str_txr_rate))
                        {
                            v_rate = 0;
                        }
                        else
                        {
                            v_rate = Convert.ToInt32(str_txr_rate);
                        }
                        str_txr_div_factr = row[4].ToString();
                        str_txr_div_factr = str_txr_div_factr.Replace("&nbsp;", "");
                        str_txr_div_factr = str_txr_div_factr.Replace(" ", "");
                        if (String.IsNullOrEmpty(str_txr_div_factr))
                        {
                            v_div_factr = 0;
                        }
                        else
                        {
                            v_div_factr = Convert.ToInt32(str_txr_div_factr);
                        }
                        str_txr_range_from = row[5].ToString();
                        str_txr_range_from = str_txr_range_from.Replace("&nbsp;", "");
                        str_txr_range_from = str_txr_range_from.Replace(" ", "");
                        if (String.IsNullOrEmpty(str_txr_range_from))
                        {
                            v_range_from = 0;
                        }
                        else
                        {
                            v_range_from = Convert.ToInt32(str_txr_range_from);
                        }
                        str_txr_range_to = row[6].ToString();
                        str_txr_range_to = str_txr_range_to.Replace("&nbsp;", "");
                        str_txr_range_to = str_txr_range_to.Replace(" ", "");
                        if (String.IsNullOrEmpty(str_txr_range_to))
                        {
                            v_range_to = 0;
                        }
                        else
                        {
                            v_range_to = Convert.ToInt32(str_txr_range_to);
                        }
                        str_txr_wef = row[7].ToString();
                        str_txr_wet = row[8].ToString();
                        str_txr_frequency = row[9].ToString();

                        cmd = new SqlCommand("update_tax_rates", new SqlConnection(GetConnectionString()));

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add(new SqlParameter("@v_txr_code", 0));
                        cmd.Parameters.Add(new SqlParameter("@v_desc", str_txr_desc));
                        cmd.Parameters.Add(new SqlParameter("@v_rate_type", str_txr_rate_type));
                        cmd.Parameters.Add(new SqlParameter("@v_rate", v_rate));
                        cmd.Parameters.Add(new SqlParameter("@v_div_factr", v_div_factr));
                        cmd.Parameters.Add(new SqlParameter("@v_wef", str_txr_wef));
                        cmd.Parameters.Add(new SqlParameter("@v_wet", str_txr_wet));
                        cmd.Parameters.Add(new SqlParameter("@v_range_from", v_range_from));
                        cmd.Parameters.Add(new SqlParameter("@v_range_to", v_range_to));
                        cmd.Parameters.Add(new SqlParameter("@v_tx_code", v_tx_code));
                        cmd.Parameters.Add(new SqlParameter("@v_txrcode", SqlDbType.Int));
                        cmd.Parameters["@v_txrcode"].Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(new SqlParameter("@v_frequency", str_txr_frequency));

                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();

                        cmd.Connection.Close();
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
            txtTxCode.Text = txtTxCode.Text.Replace("&nbsp;", "");
            txtTxCode.Text = txtTxCode.Text.Replace(" ", "");
            int v_txtTxCode;
            if (String.IsNullOrEmpty(txtTxCode.Text))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Select a Tax Type to delete all it's rates.');", true);
            }
            else
            {
                try
                {
                    if (String.IsNullOrEmpty(txtTxCode.Text))
                    {
                        v_txtTxCode = 0;
                    }
                    else
                    {
                        v_txtTxCode = Convert.ToInt32(txtTxCode.Text);
                    }
                    SqlCommand cmd = new SqlCommand("delete_all_tax_rates", new SqlConnection(GetConnectionString()));
                    System.Diagnostics.Debug.WriteLine("@v_txtTxCode =====>" + v_txtTxCode);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@v_tx_code", v_txtTxCode));
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();

                    cmd.Dispose();
                    GridView2.DataSource = null;
                    GridView2.DataSource = SqlDataSource2;
                    GridView2.DataBind();
                    GridView2.Visible = true;


                    System.Diagnostics.Debug.WriteLine("txtTxCode.Text =====>" + txtTxCode.Text);
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