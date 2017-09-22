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
    public partial class aspxEmpPayElements : System.Web.UI.Page
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
            ClearEmpPelDtls();
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
                cmd.Parameters.Add(new SqlParameter("@v_ot_hours", 0));
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
                string name = GridView1.SelectedRow.Cells[2].Text;
                txtEmpCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                txtShtDesc.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
                txtSurname.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
                txtOtherNames.Text = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");

                txtSurname.Text = txtSurname.Text + ", " + txtOtherNames.Text;

                Editing.Visible = true;
                pnlEditingData.Visible = true;
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
            int v_epe_code, v_emp_code, v_pel_code;
            decimal v_epe_amt, v_ot_hours;

            try
            {
            v_emp_code = 0;
            v_pel_code = 0;
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
                
                TextBox txt_epe_ot_hours = (TextBox)GridView2.Rows[e.RowIndex].FindControl("txt_epe_ot_hours");
                txt_epe_ot_hours.Text = txt_epe_ot_hours.Text.Replace("&nbsp;", "");

                if (String.IsNullOrEmpty(txt_epe_ot_hours.Text))
                {
                    v_ot_hours = 0;
                }
                else
                {
                    v_ot_hours = Convert.ToDecimal(txt_epe_ot_hours.Text);
                }

                cmd = new SqlCommand("update_emp_pay_elements", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_epe_code", v_epe_code));
                cmd.Parameters.Add(new SqlParameter("@v_emp_code", v_emp_code));
                cmd.Parameters.Add(new SqlParameter("@v_pel_code", v_pel_code));
                cmd.Parameters.Add(new SqlParameter("@v_amt", v_epe_amt));
                cmd.Parameters.Add(new SqlParameter("@v_created_by", v_user));
                cmd.Parameters.Add(new SqlParameter("@v_epecode", SqlDbType.Int));
                cmd.Parameters["@v_epecode"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(new SqlParameter("@v_ot_hours", v_ot_hours));

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

        protected void btnAddPayElements_Click(object sender, EventArgs e)
        {
            if (pnlPayElements.Visible == true)
            { pnlPayElements.Visible = false; }
            else{pnlPayElements.Visible=true;}

            ClearEmpPelDtls();
        }

        protected void ClearEmpPelDtls()
        {
            txtEpeCode.Text = "";
            txtAmt.Text = "";
        }

        protected void btnSaveAddedPayElement_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                String v_user;
                int v_EmpCode, v_epe_code;
                decimal v_amt, v_ot_hours;
                v_user = System.Web.HttpContext.Current.User.Identity.Name;

                if (String.IsNullOrEmpty(txtEmpCode.Text))
                {
                    v_EmpCode = 0;
                }
                else
                {
                    v_EmpCode = Convert.ToInt32(txtEmpCode.Text);
                }
                if (String.IsNullOrEmpty(txtEpeCode.Text))
                {
                    v_epe_code = 0;
                }
                else
                {
                    v_epe_code = Convert.ToInt32(txtEpeCode.Text);
                }
                if (String.IsNullOrEmpty(txtAmt.Text))
                {
                    v_amt = 0;
                }
                else
                {
                    v_amt = Convert.ToDecimal(txtAmt.Text);
                }
                if (String.IsNullOrEmpty(txtOtHours.Text))
                {
                    v_ot_hours = 0;
                }
                else
                {
                    v_ot_hours = Convert.ToDecimal(txtOtHours.Text);
                }
                SqlCommand cmd = new SqlCommand("update_emp_pay_elements", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_epe_code", v_epe_code));
                cmd.Parameters.Add(new SqlParameter("@v_emp_code", v_EmpCode));
                cmd.Parameters.Add(new SqlParameter("@v_pel_code", ddlPelCode.SelectedValue));
                cmd.Parameters.Add(new SqlParameter("@v_amt", v_amt));
                cmd.Parameters.Add(new SqlParameter("@v_created_by", v_user));
                cmd.Parameters.Add(new SqlParameter("@v_epecode", SqlDbType.Int));
                cmd.Parameters["@v_epecode"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(new SqlParameter("@v_ot_hours", v_ot_hours));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                cmd.Dispose();
                pnlPayElements.Visible = false;
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

        
    }
}