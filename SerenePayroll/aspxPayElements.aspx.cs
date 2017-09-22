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


namespace SerenePayroll
{
    public partial class aspxPayElements : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (txtPelCode.Text == "")
            {
                pnlPayrolls.Visible = false;
            }
            else
            {
                pnlPayrolls.Visible = true;
            }
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
            pnlPayrolls.Visible = true;
            clearCtrls();

            AttachColor(ddlType, "white", "#eeeeee");
        }

        protected void clearCtrls()
        {
            txtPelCode.Text = "";
            txtShtDesc.Text = "";
            txtDesc.Text = "";
            ddlTaxable.SelectedValue = "";
            ddlDeduction.SelectedValue = "";
            ddlDependsOn.SelectedValue = "";
            ddlType.SelectedValue = "";
            txtNontaxAllowedAmt.Text = "";
            txtPrescribedAmt.Text = "";

            if (txtPelCode.Text == "")
            {
                pnlPayrolls.Visible = false;
            }
            else
            {
                pnlPayrolls.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (PayElements_Update())
            {
                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                GridView1.Visible = true;
                pnlPayrolls.Visible = true;
                GridView1.DataBind();

                clearCtrls();
            }
            else
            {

            }
        }

        protected void btnSaveNAddNew_Click(object sender, EventArgs e)
        {
            if (PayElements_Update())
            {
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = false;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                GridView1.Visible = false;
                pnlPayrolls.Visible = false;
                GridView1.DataBind();
                
                clearCtrls();
            }
            else
            {

            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {            
            int v_txtPelCode;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txtPelCode.Text))
                {
                    v_txtPelCode = 0;
                }
                else
                {
                    v_txtPelCode = Convert.ToInt32(txtPelCode.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.delete_payelements", new MySqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("v_txtPelCode =====>" + v_txtPelCode);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_pel_code", v_txtPelCode));
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
        private Boolean PayElements_Update()
        {
            Boolean v_bool;
            String errMessage;
            try
            {
                int v_PelCode;
                decimal v_NontaxAllowedAmt, v_PrescribedAmt;

                if (String.IsNullOrEmpty(txtPelCode.Text))
                {
                    v_PelCode = 0;
                }
                else
                {
                    v_PelCode = Convert.ToInt32(txtPelCode.Text);
                }
                if (String.IsNullOrEmpty(txtNontaxAllowedAmt.Text))
                {
                    v_NontaxAllowedAmt = 0;
                }
                else
                {
                    v_NontaxAllowedAmt = Convert.ToDecimal(txtNontaxAllowedAmt.Text);
                }
                if (String.IsNullOrEmpty(txtPrescribedAmt.Text))
                {
                    v_PrescribedAmt = 0;
                }
                else
                {
                    v_PrescribedAmt = Convert.ToDecimal(txtPrescribedAmt.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.update_payelements", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_pel_code", v_PelCode));
                cmd.Parameters.Add(new MySqlParameter("v_sht_desc", txtShtDesc.Text));
                cmd.Parameters.Add(new MySqlParameter("v_desc", txtDesc.Text));
                cmd.Parameters.Add(new MySqlParameter("v_taxable", ddlTaxable.SelectedValue));
                cmd.Parameters.Add(new MySqlParameter("v_deduction", ddlDeduction.SelectedValue));
                cmd.Parameters.Add(new MySqlParameter("v_depends_on", null));
                cmd.Parameters.Add(new MySqlParameter("v_type", ddlType.SelectedValue));
                cmd.Parameters.Add(new MySqlParameter("v_pelcode", MySqlDbType.Int32));
                cmd.Parameters["v_pelcode"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(new MySqlParameter("v_applied_to", ddlAppliedTo.SelectedValue));
                cmd.Parameters.Add(new MySqlParameter("v_nontax_allowed_amt", v_NontaxAllowedAmt));
                cmd.Parameters.Add(new MySqlParameter("v_prescribed_amt", v_PrescribedAmt));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();

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

            string name = GridView1.SelectedRow.Cells[2].Text;
            txtPelCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
            txtShtDesc.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
            txtDesc.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
            ddlTaxable.SelectedValue = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
            ddlDeduction.SelectedValue = GridView1.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");
            ddlDependsOn.SelectedValue = GridView1.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", "");
            ddlType.SelectedValue = GridView1.SelectedRow.Cells[7].Text.Trim().Replace("&nbsp;", "");
            ddlAppliedTo.SelectedValue = GridView1.SelectedRow.Cells[8].Text.Trim().Replace("&nbsp;", "");
            txtNontaxAllowedAmt.Text = GridView1.SelectedRow.Cells[9].Text.Trim().Replace("&nbsp;", "");
            txtPrescribedAmt.Text = GridView1.SelectedRow.Cells[10].Text.Trim().Replace("&nbsp;", "");

            btnAdd.Enabled = false;
            btnSave.Enabled = true;
            btnSaveNAddNew.Enabled = true;
            btnDelete.Enabled = true;
            Editing.Visible = true;
            pnlEditingData.Visible = true;
            GridView1.Visible = false;
            pnlPayrolls.Visible = true;
            AttachColor(ddlType, "white", "#eeeeee");
        }

        protected void btnAttachPyrll_Click(object sender, EventArgs e)
        {

            String errMessage;
            try
            {
                int v_PelCode, v_PrCode;
                if (String.IsNullOrEmpty(txtPelCode.Text))
                {
                    v_PelCode = 0;
                }
                else
                {
                    v_PelCode = Convert.ToInt32(txtPelCode.Text);
                }
                v_PrCode = Convert.ToInt32(ddlPayrolls.SelectedValue);
                MySqlCommand cmd = new MySqlCommand("serenehrdb.update_proll_pelements", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_pel_code", v_PelCode));
                cmd.Parameters.Add(new MySqlParameter("v_pr_code", v_PrCode));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                cmd.Dispose();
                System.Diagnostics.Debug.WriteLine("ERROR v_pel_code====>" + v_PelCode + " v_PrCode=" + v_PrCode);
                
                //Populate pay elements to employees
                populate_pe_fr_proll(v_PelCode, v_PrCode);
                
                GridView2.DataBind();
                pnlPayrolls.Visible = true;

            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }
                
        }

        protected void populate_pe_fr_proll(int v_PelCode, int v_PrCode)
        {
            String errMessage;
            try
            {
                String v_user;
                MySqlCommand cmd = new MySqlCommand("serenehrdb.populate_pe_fr_proll", new MySqlConnection(GetConnectionString()));
                v_user = System.Web.HttpContext.Current.User.Identity.Name;

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_pel_code", v_PelCode));
                cmd.Parameters.Add(new MySqlParameter("v_pr_code", v_PrCode));
                cmd.Parameters.Add(new MySqlParameter("v_amt", null));
                cmd.Parameters.Add(new MySqlParameter("v_created_by", v_user));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }

        }
        protected void proll_pelement_delete()
        {
            int v_pp_code;
            String errMessage;
            TextBox txtPpCode = new TextBox();
            try
            {
                txtPpCode.Text = GridView2.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                
                System.Diagnostics.Debug.WriteLine("v_xxxxpp_code =====>" + GridView2.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", ""));
                txtPpCode.Text = txtPpCode.Text.Replace(" ","");
                if (String.IsNullOrEmpty(txtPpCode.Text))
                {
                    v_pp_code = 0;
                }
                else
                {
                    v_pp_code = Convert.ToInt32(txtPpCode.Text);
                }

                MySqlCommand cmd = new MySqlCommand("serenehrdb.delete_proll_pelements", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_pp_code", v_pp_code));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                GridView2.DataBind();
                System.Diagnostics.Debug.WriteLine("v_pp_code =====>" + v_pp_code.ToString());

            }
            catch (Exception ex)
            {
                errMessage = "Error deleting record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            
            }

        }

        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String errMessage;
            String str_pp_code;
            int v_pp_code;
            try
            {
                //System.Diagnostics.Debug.WriteLine("GV2 cell[1] =====> " + GridView2.Rows[e.RowIndex].Cells[1].Text);
                str_pp_code = GridView2.Rows[e.RowIndex].Cells[1].Text.Trim().Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(str_pp_code))
                {
                    v_pp_code = 0;
                }
                else
                {
                    v_pp_code = Convert.ToInt32(str_pp_code);
                }
                TextBox txt_txr_code = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_txr_code");
                MySqlCommand cmd = new MySqlCommand("serenehrdb.delete_proll_pelements", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_pp_code", v_pp_code));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                GridView2.DataBind();
                
            }
            catch (Exception ex)
            {
                errMessage = "Error deleting record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }

        }
        protected void AttachColor(ListControl listControl, string itemColor, string alternatingColor)
        {
            string color = itemColor;

            foreach (ListItem li in listControl.Items)
            {
                color = (color == itemColor) ? alternatingColor : itemColor;
                li.Attributes["style"] = " background-color: " + color;
            }
        }

        protected void btnPopulatePEtoEmp_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                String v_user;
                MySqlCommand cmd = new MySqlCommand("serenehrdb.populate_pe_to_employees", new MySqlConnection(GetConnectionString()));
                v_user = System.Web.HttpContext.Current.User.Identity.Name;

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_created_by", v_user));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                cmd.Dispose();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records populated succesfully.');", true);
                
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }

        }

        protected void btnPostAmount_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                String v_user;
                decimal v_amt;
                int v_pel_code, v_pr_code;

                if (String.IsNullOrEmpty(txtAmountToPost.Text))
                {
                    v_amt = 0;
                }
                else
                {
                    v_amt = Convert.ToDecimal(txtAmountToPost.Text);
                }

                if (String.IsNullOrEmpty(txtPelCode.Text))
                {
                    v_pel_code = 0;
                }
                else
                {
                    v_pel_code = Convert.ToInt32(txtPelCode.Text);
                }
                if (String.IsNullOrEmpty(ddlPayrolls.SelectedValue))
                {
                    v_pr_code = 0;
                }
                else
                {
                    v_pr_code = Convert.ToInt32(ddlPayrolls.SelectedValue);
                }

                MySqlCommand cmd = new MySqlCommand("serenehrdb.post_amt_to_employees", new MySqlConnection(GetConnectionString()));
                v_user = System.Web.HttpContext.Current.User.Identity.Name;

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_amt", v_amt));
                cmd.Parameters.Add(new MySqlParameter("v_pel_code", v_pel_code));
                cmd.Parameters.Add(new MySqlParameter("v_pr_code", v_pr_code));
                cmd.Parameters.Add(new MySqlParameter("v_created_by", v_user));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                cmd.Dispose();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Amount posted succesfully.');", true);

            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }

        }

        protected void imgbtnUpArrow_Click(object sender, ImageClickEventArgs e)
        {
            String errMessage;
            try
            {
                int v_PelCode, v_PelCode2;
                String str_PelCode, str_pel_desc;
                MySqlCommand cmd;

                foreach (GridViewRow row in GridView1.Rows)
                {
                    cmd = new MySqlCommand("serenehrdb.update_payelement_upwrds", new MySqlConnection(GetConnectionString()));

                    str_pel_desc = row.Cells[3].Text.Trim().Replace("&nbsp;", "");
                    System.Diagnostics.Debug.WriteLine("Pel_desc  === " + str_pel_desc);
                    if (((CheckBox)row.FindControl("chkOrder")).Checked)
                    {
                        System.Diagnostics.Debug.WriteLine("Checked Pel_desc  === " + str_pel_desc);
                        str_PelCode = row.Cells[1].Text.Trim().Replace("&nbsp;", "");
                        if (String.IsNullOrEmpty(str_PelCode))
                        {
                            v_PelCode = 0;
                        }
                        else
                        {
                            v_PelCode = Convert.ToInt32(str_PelCode);
                        }
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new MySqlParameter("v_pel_code", v_PelCode));
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();

                        cmd.Connection.Close();

                    }
                    cmd.Dispose();
                    GridView1.DataBind();
                }

            }
            catch(Exception ex){
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }
        
        protected void imgbtnDownArrow_Click(object sender, ImageClickEventArgs e)
        {
            String errMessage;
            try
            {
                int v_PelCode;
                String str_PelCode;
                MySqlCommand cmd;

                foreach (GridViewRow row in GridView1.Rows)
                {
                    cmd = new MySqlCommand("serenehrdb.update_payelement_downwrds", new MySqlConnection(GetConnectionString()));
                    if (((CheckBox)row.FindControl("chkOrder")).Checked)
                    {
                        str_PelCode = row.Cells[1].Text.Trim().Replace("&nbsp;", "");
                        if (String.IsNullOrEmpty(str_PelCode))
                        {
                            v_PelCode = 0;
                        }
                        else
                        {
                            v_PelCode = Convert.ToInt32(str_PelCode);
                        }
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new MySqlParameter("v_pel_code", v_PelCode));
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();

                        cmd.Connection.Close();

                    }
                    cmd.Dispose();
                    GridView1.DataBind();
                }
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }

        }

        protected void ChckedChanged(object sender, EventArgs e)
        {
            String errMessage;
            try
            {

                int v_PelCode, v_select;
                String str_PelCode;
                MySqlCommand cmd;

                foreach (GridViewRow row in GridView1.Rows)
                {
                    str_PelCode = row.Cells[1].Text.Trim().Replace("&nbsp;", "");
                    if (String.IsNullOrEmpty(str_PelCode))
                    {
                        v_PelCode = 0;
                    }
                    else
                    {
                        v_PelCode = Convert.ToInt32(str_PelCode);
                    }
                    
                    if (((CheckBox)row.FindControl("chkOrder")).Checked)
                    {v_select = 1;}
                    else{v_select = 0;}

                    cmd = new MySqlCommand("serenehrdb.update_payelement_select", new MySqlConnection(GetConnectionString()));
                    
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new MySqlParameter("v_pel_code", v_PelCode));
                    cmd.Parameters.Add(new MySqlParameter("v_select", v_select));
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                    cmd.Dispose();
                }
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }   
    }
}