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


namespace SerenePayroll
{
    public partial class aspxProcessPayroll : System.Web.UI.Page
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

        protected void clearCtrls()
        {
            txtPrCode.Text = "";
            txtDesc.Text = "";
            txtEmpCode.Text = "";
            txtTrCode.Text = "";
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


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                string name = GridView1.SelectedRow.Cells[2].Text;
                txtPrCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                txtDesc.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");

                Editing.Visible = true;
                pnlEditingData.Visible = true;
                GridView1.Visible = true;
                System.Diagnostics.Debug.WriteLine("txtPrCode=" + txtPrCode.Text);
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
                GridView3.DataBind();

                if (GridView3.Rows.Count > 0)
                {
                    GridView3.SelectedIndex = 0;
                    GridView3_SelectedIndexChanged(null, null);
                }
                if (GridView2.Rows.Count > 0)
                {
                    GridView2.SelectedIndex = 0;
                    GridView2_SelectedIndexChanged(null, null);
                } 
                GridView4.DataSource = null;
                GridView4.DataSource = SqlDataSource4;
                GridView4.DataBind();
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }

        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                txtEmpCode.Text = GridView2.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                GridView1.Visible = true;
                //System.Diagnostics.Debug.WriteLine("GV2 txtEmpCode=" + txtEmpCode.Text);
                GridView4.DataSource = null;
                GridView4.DataSource = SqlDataSource4;
                GridView4.DataBind();
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }
        
        }

        protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                txtTrCode.Text = GridView3.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                ddlMonth.SelectedValue = GridView3.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "").PadLeft(2, '0');
                ddlYear.SelectedValue = GridView3.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", "").PadLeft(4, '0');

                System.Diagnostics.Debug.WriteLine("ddlMonth=" + GridView3.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "").PadLeft(2, '0')
                    +" ddlYear=" + GridView3.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", ""));
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                GridView1.Visible = true;
                System.Diagnostics.Debug.WriteLine("txtPrCode=" + txtPrCode.Text + " txtTrCode=" + txtTrCode.Text + " txtEmpCode=" + txtEmpCode.Text);
                GridView4.DataSource = null;
                GridView4.DataSource = SqlDataSource4;
                GridView4.DataBind();
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                GridView1.DataBind();
                GridView1.Visible = true;
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }

        protected void btnHideSrch_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                if (pnlSearch.Visible == true) { pnlSearch.Visible = false; }
                else
                { pnlSearch.Visible = true; }
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }
        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            String errMessage;
            try
            {
                //System.Diagnostics.Debug.WriteLine("CommandName =====>" + e.CommandName);
                if (e.CommandName == "Insert")
                {
                    GridView2.DataSource = null;
                    GridView2.DataSource = SqlDataSource2;
                    GridView2.DataBind();
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

        protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
        {      }

        protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            String errMessage;
            SqlCommand cmd;
            int v_epe_code;
            decimal v_epe_amt;

            try
            {
                String v_user = System.Web.HttpContext.Current.User.Identity.Name;
                Label lbl_epe_code = (Label)GridView2.Rows[e.RowIndex].FindControl("lbl_epe_code");
                lbl_epe_code.Text = lbl_epe_code.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(lbl_epe_code.Text))
                {
                    v_epe_code = 0;
                }
                else
                {
                    v_epe_code = Convert.ToInt32(lbl_epe_code.Text);
                }

                TextBox txt_epe_amt = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_epe_amt");
                txt_epe_amt.Text = txt_epe_amt.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(txt_epe_amt.Text))
                {
                    v_epe_amt = 0;
                }
                else
                {
                    v_epe_amt = Convert.ToDecimal(txt_epe_amt.Text);
                }

                cmd = new SqlCommand("update_emp_pay_elements", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_epe_code", v_epe_code));
                cmd.Parameters.Add(new SqlParameter("@v_emp_code", null));
                cmd.Parameters.Add(new SqlParameter("@v_pel_code", null));
                cmd.Parameters.Add(new SqlParameter("@v_amt", v_epe_amt));
                cmd.Parameters.Add(new SqlParameter("@v_created_by", v_user));
                cmd.Parameters.Add(new SqlParameter("@v_epecode", SqlDbType.Int));
                cmd.Parameters["@v_epecode"].Direction = ParameterDirection.Output;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                System.Diagnostics.Debug.WriteLine("@v_epe_code=======>" + v_epe_code.ToString() + "@v_epe_amt===>" + v_epe_amt.ToString());

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
            String errMessage;
            try
            {
                SqlCommand cmd;
                int v_epe_code;
                Label lbl_epe_code = (Label)GridView2.Rows[e.RowIndex].FindControl("lbl_epe_code");
                System.Diagnostics.Debug.WriteLine("lbl_epe_code =====>" + lbl_epe_code.Text);
                lbl_epe_code.Text = lbl_epe_code.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(lbl_epe_code.Text))
                {
                    v_epe_code = 0;
                }
                else
                {
                    v_epe_code = Convert.ToInt32(lbl_epe_code.Text);
                }
                cmd = new SqlCommand("delete_emp_pay_elements", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_epe_code", v_epe_code));

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();

                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Record deleted successfully');", true);
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }

        protected void btnPopPayroll_Click(object sender, EventArgs e)
        {
            String errMessage;
            int v_pr_code;
            try {

                String v_user = System.Web.HttpContext.Current.User.Identity.Name;
                if (String.IsNullOrEmpty(txtPrCode.Text))
                {
                    v_pr_code = -1;
                }
                else
                {
                    v_pr_code = Convert.ToInt32(txtPrCode.Text);
                }

                SqlCommand cmd = new SqlCommand("populate_prd_pay_elements", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_pr_code", v_pr_code));
                cmd.Parameters.Add(new SqlParameter("@v_created_by", v_user));
                cmd.Parameters.Add(new SqlParameter("@v_month", ddlMonth.SelectedValue));
                cmd.Parameters.Add(new SqlParameter("@v_year", ddlYear.SelectedValue));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                System.Diagnostics.Debug.WriteLine("@v_pr_code=======>" + v_pr_code.ToString() + "@v_user===>" + v_user);

                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
                GridView3.DataBind();
                GridView4.DataSource = null;
                GridView4.DataSource = SqlDataSource4;
                GridView4.DataBind();
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

        protected void btnProcessPayroll_Click(object sender, EventArgs e)
        {
            String errMessage;
            try {

                String v_user = System.Web.HttpContext.Current.User.Identity.Name;
                int v_tr_code;
                if (String.IsNullOrEmpty(txtTrCode.Text))
                {
                    v_tr_code = 0;
                }
                else
                {
                    v_tr_code = Convert.ToInt32(txtTrCode.Text);
                }

                System.Diagnostics.Debug.WriteLine("txtTrCode===>" + txtTrCode.Text + " v_tr_code====>" + v_tr_code.ToString());
                SqlCommand cmd = new SqlCommand("process_payroll", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_tr_code", v_tr_code));
                cmd.Parameters.Add(new SqlParameter("@v_processed_by", v_user));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                System.Diagnostics.Debug.WriteLine("@v_tr_code=======>" + v_tr_code.ToString() + "@v_user===>" + v_user);

                GridView4.DataSource = null;
                GridView4.DataSource = SqlDataSource4;
                GridView4.DataBind();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Payroll processing completed successfully');", true);
            
            }
            catch (Exception ex)
            {
                errMessage = "Error processing record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }

        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            GridView2.DataSource = null;
            GridView2.DataSource = SqlDataSource2;
            GridView2.DataBind();
            GridView2.SelectRow(0);

            GridView4.DataSource = null;
            GridView4.DataSource = SqlDataSource4;
            GridView4.DataBind();

        }

        protected void btnEmployees_Click(object sender, EventArgs e)
        {
            if (GridView2.Visible == true) { GridView2.Visible = false; }
            else{GridView2.Visible = true;}
        }

        protected void lnkPaySlip_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("txtPrCode=" + txtPrCode.Text + " txtEmpCode=" + txtEmpCode.Text + " txtTrCode=" + txtTrCode.Text);
            rvPaySlip_001.LocalReport.Refresh();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "DisplayReports('Information.','Report ran successfully.');", true);
            
        }

        protected void btnAuthPayroll_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Payroll processing completed successfully');", true);
            
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }

        protected void btnAuthPayroll_Click1(object sender, EventArgs e)
        {
            String errMessage;
            try
            {

                String v_user = System.Web.HttpContext.Current.User.Identity.Name;
                int v_tr_code;
                if (String.IsNullOrEmpty(txtTrCode.Text))
                {
                    v_tr_code = 0;
                }
                else
                {
                    v_tr_code = Convert.ToInt32(txtTrCode.Text);
                }

                System.Diagnostics.Debug.WriteLine("txtTrCode===>" + txtTrCode.Text + " v_tr_code====>" + v_tr_code.ToString());
                SqlCommand cmd = new SqlCommand("auth_payroll", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_tr_code", v_tr_code));
                cmd.Parameters.Add(new SqlParameter("@v_auth_by", v_user));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                System.Diagnostics.Debug.WriteLine("@v_tr_code=======>" + v_tr_code.ToString() + "@v_user===>" + v_user);

                GridView4.DataSource = null;
                GridView4.DataSource = SqlDataSource4;
                GridView4.DataBind();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Payroll authorization completed successfully');", true);

            }
            catch (Exception ex)
            {
                errMessage = "Error authorising record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }


        }

        protected void ddlAuth_SelectedIndexChanged(object sender, EventArgs e)
        {
            String errMessage;
            try{            
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
                GridView3.DataBind();

                if (GridView3.Rows.Count > 0)
                {
                    GridView3.SelectedIndex = 0;
                    GridView3_SelectedIndexChanged(null, null);
                }
                if (GridView2.Rows.Count > 0)
                {
                    GridView2.SelectedIndex = 0;
                    GridView2_SelectedIndexChanged(null, null);
                } 
                GridView4.DataSource = null;
                GridView4.DataSource = SqlDataSource4;
                GridView4.DataBind();
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }
        }
        
    }
}