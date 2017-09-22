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
    public partial class aspxLoanAmin : System.Web.UI.Page
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
            txtEmpCode.Text = "";
            txtSurname.Text = "";
            txtOtherNames.Text = "";
            txtShtDesc.Text = "";
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
        private Boolean Emp_Pay_Element_Update()
        {
            Boolean v_bool;
            String errMessage;
            try
            {
                int v_EmpCode;
                if (String.IsNullOrEmpty(txtEmpCode.Text))
                {
                    v_EmpCode = 0;
                }
                else
                {
                    v_EmpCode = Convert.ToInt32(txtEmpCode.Text);
                }
                SqlCommand cmd = new SqlCommand("update_emp_pay_elements", new SqlConnection(GetConnectionString()));

                //TODOTODOTODOTODOTODOTODOTODOTODOTODOTODO
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_epe_code", 0));
                cmd.Parameters.Add(new SqlParameter("@v_emp_code", v_EmpCode));
                cmd.Parameters.Add(new SqlParameter("@v_pel_code", 0));
                cmd.Parameters.Add(new SqlParameter("@v_amt", 0));
                cmd.Parameters.Add(new SqlParameter("@v_created_by", ""));
                cmd.Parameters.Add(new SqlParameter("@v_epecode", SqlDbType.Int));
                cmd.Parameters["@v_epecode"].Direction = ParameterDirection.Output;
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
            String errMessage;
            try
            {
                clearCtrls();
                string name = GridView1.SelectedRow.Cells[2].Text;
                txtEmpCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                txtShtDesc.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
                txtSurname.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
                txtOtherNames.Text = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");

                Editing.Visible = true;
                pnlEditingData.Visible = true;
                pnlEmpLoans.Visible = false;
                clearLoanCtrls();

                GridView1.Visible = true;
                System.Diagnostics.Debug.WriteLine("txtEmpCode=" + txtEmpCode.Text);
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
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
                clearLoanCtrls();
                txt_el_code.Text = GridView2.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                System.Diagnostics.Debug.WriteLine("xxxxxxxxxxxxxxxx");                
                ddl_el_lt_code.SelectedValue = GridView2.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
                txt_el_eff_date.Text = GridView2.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
                txt_el_loan_applied_amt.Text = GridView2.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");
                txt_el_service_charge.Text = GridView2.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", "");
                txt_el_issued_amt.Text = GridView2.SelectedRow.Cells[7].Text.Trim().Replace("&nbsp;", "");
                txt_el_tot_tax_amt.Text = GridView2.SelectedRow.Cells[8].Text.Trim().Replace("&nbsp;", "");
                txt_el_intr_rate.Text = GridView2.SelectedRow.Cells[9].Text.Trim().Replace("&nbsp;", "");
                txt_el_intr_div_factr.Text = GridView2.SelectedRow.Cells[10].Text.Trim().Replace("&nbsp;", "");
                txt_el_done_by.Text = GridView2.SelectedRow.Cells[11].Text.Trim().Replace("&nbsp;", "");
                txt_el_authorised_by.Text = GridView2.SelectedRow.Cells[12].Text.Trim().Replace("&nbsp;", "");
                txt_el_authorised.Text = GridView2.SelectedRow.Cells[13].Text.Trim().Replace("&nbsp;", "");
                txt_el_authorised_date.Text = GridView2.SelectedRow.Cells[14].Text.Trim().Replace("&nbsp;", "");
                txt_el_instalment_amt.Text = GridView2.SelectedRow.Cells[15].Text.Trim().Replace("&nbsp;", "");
                txt_el_tot_instalments.Text = GridView2.SelectedRow.Cells[16].Text.Trim().Replace("&nbsp;", "");
                txt_el_final_repay_date.Text = GridView2.SelectedRow.Cells[17].Text.Trim().Replace("&nbsp;", "");

                Editing.Visible = true;
                pnlEditingData.Visible = true;
                pnlEmpLoans.Visible = true;
                if (txt_el_authorised.Text != "NO")
                {
                    pnlEmpLoans.Enabled = false;
                }
                else
                {
                    pnlEmpLoans.Enabled = true;
                }

                GridView2.Visible = true;
                //System.Diagnostics.Debug.WriteLine("txt_el_code======>" + txt_el_code.Text + " Cells[2]=====>" + GridView2.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", ""));
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;

                GridView2.DataBind();
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
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
                GridView2.Visible = false;
                pnlEmpLoans.Visible = false;
                pnlEmpLoanListing.Visible = false;
                clearCtrls();
                clearLoanCtrls();
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
            try
            {
            
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
            
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }

        protected void btnNewLoan_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                clearLoanCtrls();
                pnlEmpLoans.Visible = true;
                pnlEmpLoans.Enabled = true;
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int v_el_code;
            int v_emp_code;
            int v_lt_code;
            int v_tot_instalments;
            decimal v_loan_applied_amt, v_service_charge, v_instalment_amt;

            String errMessage;
            try
            {
                SqlCommand cmd;
                String v_user = System.Web.HttpContext.Current.User.Identity.Name;

                txt_el_code.Text = txt_el_code.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_el_code.Text))
                {
                    v_el_code = 0;
                }
                else
                {
                    v_el_code = Convert.ToInt32(txt_el_code.Text);
                }

                txtEmpCode.Text = txtEmpCode.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txtEmpCode.Text))
                {
                    v_emp_code = 0;
                }
                else
                {
                    v_emp_code = Convert.ToInt32(txtEmpCode.Text);
                }
                

                txt_el_loan_applied_amt.Text = txt_el_loan_applied_amt.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_el_loan_applied_amt.Text))
                {
                    v_loan_applied_amt = 0;
                }
                else
                {
                    v_loan_applied_amt = Convert.ToDecimal(txt_el_loan_applied_amt.Text);
                }

                txt_el_service_charge.Text = txt_el_service_charge.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_el_service_charge.Text))
                {
                    v_service_charge = 0;
                }
                else
                {
                    v_service_charge = Convert.ToDecimal(txt_el_service_charge.Text);
                }

                txt_el_tot_instalments.Text = txt_el_tot_instalments.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_el_tot_instalments.Text))
                {
                    v_tot_instalments = 0;
                }
                else
                {
                    v_tot_instalments = Convert.ToInt32(txt_el_tot_instalments.Text);
                }

                txt_el_instalment_amt.Text = txt_el_instalment_amt.Text.Replace("&nbsp;", "");
                if (String.IsNullOrEmpty(txt_el_instalment_amt.Text))
                {
                    v_instalment_amt = 0;
                }
                else
                {
                    v_instalment_amt = Convert.ToDecimal(txt_el_instalment_amt.Text);
                }

                if (Convert.ToInt32(ddl_el_lt_code.SelectedValue) <= 0 )
                {
                    v_lt_code = 0;
                }
                else
                {
                    v_lt_code = Convert.ToInt32(ddl_el_lt_code.SelectedValue);
                }

                cmd = new SqlCommand("update_emp_loans", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_el_code", v_el_code));
                cmd.Parameters.Add(new SqlParameter("@v_emp_code", v_emp_code));
                cmd.Parameters.Add(new SqlParameter("@v_eff_date", txt_el_eff_date.Text));
                cmd.Parameters.Add(new SqlParameter("@v_loan_applied_amt", v_loan_applied_amt));

                cmd.Parameters.Add(new SqlParameter("@v_service_charge", v_service_charge));
                cmd.Parameters.Add(new SqlParameter("@v_done_by", v_user));
                cmd.Parameters.Add(new SqlParameter("@v_lt_code", v_lt_code));
                cmd.Parameters.Add(new SqlParameter("@v_elcode", SqlDbType.Int));
                cmd.Parameters["@v_elcode"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(new SqlParameter("@v_tot_instalments", v_tot_instalments));
                cmd.Parameters.Add(new SqlParameter("@v_instalment_amt", v_instalment_amt));
                  
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                txt_el_code.Text = cmd.Parameters["@v_elcode"].Value.ToString();
                cmd.Dispose();

                Editing.Visible = true;
                pnlEditingData.Visible = true;
                pnlEmpLoans.Visible = true;

                GridView2.Visible = true;
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
                if ( v_el_code > 0 ){
                    GridView2_SelectedIndexChanged(null, null);
                    pnlEmpLoans.Enabled = true;
                }
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records saved successfully...');", true);

            }
            catch (Exception ex)
            {
                errMessage = "Error Saving Records..."+ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }

        }

        protected void btnProcess_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                SqlCommand cmd;
                String v_user = System.Web.HttpContext.Current.User.Identity.Name;

                int v_el_code;
                if (String.IsNullOrEmpty(txt_el_code.Text))
                {
                    v_el_code = 0;
                }
                else
                {
                    v_el_code = Convert.ToInt32(txt_el_code.Text);
                }
                cmd = new SqlCommand("process_emp_loan", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_el_code", v_el_code));
                cmd.Parameters.Add(new SqlParameter("@v_user", v_user));

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                cmd.Dispose();

                GridView2_SelectedIndexChanged(null, null);
                pnlEmpLoans.Enabled = true;
                /*
                //pnlEmpLoans.Visible = false;
                //clearLoanCtrls();
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();*/
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Loan has been processed successfully.');", true);
            }
            catch (Exception ex)
            {
                errMessage = "Error Processing Loan ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }

        protected void btnAuthoriseLoan_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                SqlCommand cmd;
                String v_user = System.Web.HttpContext.Current.User.Identity.Name;

                int v_el_code;
                if (String.IsNullOrEmpty(txt_el_code.Text))
                {
                    v_el_code = 0;
                }
                else
                {
                    v_el_code = Convert.ToInt32(txt_el_code.Text);
                }
                cmd = new SqlCommand("auth_emp_loan", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_el_code", v_el_code));
                cmd.Parameters.Add(new SqlParameter("@v_user", v_user));

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                cmd.Dispose();

                GridView2_SelectedIndexChanged(null, null);
                pnlEmpLoans.Enabled = false;
                /*
                pnlEmpLoans.Visible = false;
                clearLoanCtrls();
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();*/
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Loan has been Authorised successfully.');", true);
            }
            catch (Exception ex)
            {
                errMessage = "Error Authorising Loan ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }

        protected void clearLoanCtrls()
        {
            txt_el_authorised.Text = "";
            txt_el_authorised_by.Text = "";
            txt_el_authorised_date.Text = "";
            txt_el_code.Text = "";
            txt_el_done_by.Text = "";
            txt_el_eff_date.Text = "";
            txt_el_intr_div_factr.Text = "";
            txt_el_intr_rate.Text = "";
            txt_el_loan_applied_amt.Text = "";
            txt_el_service_charge.Text = "";
            txt_el_issued_amt.Text = "";
            txt_el_tot_tax_amt.Text = "";
            ddl_el_lt_code.SelectedValue = "";
            txt_el_instalment_amt.Text = "";
            txt_el_tot_instalments.Text = "";
            txt_el_final_repay_date.Text = "";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                pnlEmpLoans.Visible = false;
                clearLoanCtrls();
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                SqlCommand cmd;
                int v_el_code;
                if (String.IsNullOrEmpty(txt_el_code.Text))
                {
                    v_el_code = 0;
                }
                else
                {
                    v_el_code = Convert.ToInt32(txt_el_code.Text);
                }
                cmd = new SqlCommand("delete_emp_loan", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_el_code", v_el_code));

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                cmd.Dispose();

                pnlEmpLoans.Visible = false;
                clearLoanCtrls();
                GridView2.DataSource = null;
                GridView2.DataSource = SqlDataSource2;
                GridView2.DataBind();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Loan has been deleted successfully.');", true);
            }
            catch (Exception ex)
            {
                errMessage = "Error Deleting record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }
        }


    }
}