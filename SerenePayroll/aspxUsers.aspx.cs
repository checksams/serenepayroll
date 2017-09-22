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


namespace SerenePayroll
{
    public partial class aspxUsers : System.Web.UI.Page
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
            txtUsrCode.Text = "";
            txtname.Text = "";
            txtFullName.Text = "";
            txtEmpCode.Text = "";
            ddlPwdReset.SelectedValue = "";
            txtLastLogin.Text = "";
            txtLastLoginAttempts.Text = "";

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (User_Update())
            {
                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
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
            if (User_Update())
            {
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = false;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                GridView1.Visible = true;
                GridView1.DataBind();
                
                clearCtrls();
            }
            else
            {

            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {            
            int v_txtUsrCode;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txtUsrCode.Text))
                {
                    v_txtUsrCode = 0;
                }
                else
                {
                    v_txtUsrCode = Convert.ToInt32(txtUsrCode.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.delete_user", new MySqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("v_txtUsrCode =====>" + v_txtUsrCode);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_usr_code", v_txtUsrCode));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                cmd.Dispose();

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
        private Boolean User_Update()
        {
            Boolean v_bool;
            String errMessage;
            try
            {
                int v_UsrCode, v_EmpCode;
                if (String.IsNullOrEmpty(txtUsrCode.Text))
                {
                    v_UsrCode = 0;
                }
                else
                {
                    v_UsrCode = Convert.ToInt32(txtUsrCode.Text);
                }

                if (String.IsNullOrEmpty(txtEmpCode.Text))
                {
                    v_EmpCode = 0;
                }
                else
                {
                    v_EmpCode = Convert.ToInt32(txtEmpCode.Text);
                }

                MySqlCommand cmd = new MySqlCommand("serenehrdb.update_users", new MySqlConnection(GetConnectionString()));
                
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_usr_code", v_UsrCode));
                cmd.Parameters.Add(new MySqlParameter("v_name", txtname.Text));
                cmd.Parameters.Add(new MySqlParameter("v_full_name", txtFullName.Text));
                cmd.Parameters.Add(new MySqlParameter("v_emp_code", v_EmpCode));
                cmd.Parameters.Add(new MySqlParameter("v_pwd_reset", ddlPwdReset.SelectedValue.ToString()));
                cmd.Parameters.Add(new MySqlParameter("v_usrcode", MySqlDbType.Int32));
                cmd.Parameters["v_usrcode"].Direction = ParameterDirection.Output;
                cmd.Connection.Open();

                cmd.ExecuteNonQuery();


                cmd.Connection.Close();
                cmd.Dispose();

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
                txtUsrCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                txtname.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
                txtFullName.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
                txtEmpCode.Text = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
                ddlPwdReset.SelectedValue = GridView1.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");
                txtLastLogin.Text = GridView1.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", "");
                txtLastLoginAttempts.Text = GridView1.SelectedRow.Cells[7].Text.Trim().Replace("&nbsp;", "");

                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = true;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                //GridView1.Visible = true;
            }
            catch (Exception ex)
            {
                errMessage = "Error saving record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }        
        }

        protected void btnGrant_Click(object sender, EventArgs e)
        {
            int v_UsrCode, v_UrCode;
            String errMessage;

            try
            {
                String v_user = System.Web.HttpContext.Current.User.Identity.Name;
                if (String.IsNullOrEmpty(txtUsrCode.Text))
                {
                    v_UsrCode = 0;
                }
                else
                {
                    v_UsrCode = Convert.ToInt32(txtUsrCode.Text);
                }
                foreach (GridViewRow row in GridView2.Rows)
                {
                    MySqlCommand cmd;

                    Label lbl_ur_code = ((Label)row.FindControl("lbl_ur_code"));
                    if (String.IsNullOrEmpty(lbl_ur_code.Text))
                    {
                        v_UrCode = 0;
                    }
                    else
                    {
                        v_UrCode = Convert.ToInt32(lbl_ur_code.Text);
                    }

                    if (((CheckBox)row.FindControl("chkRightSelect")).Checked)
                    {
                        cmd = new MySqlCommand("serenehrdb.update_user_roles_granted", new MySqlConnection(GetConnectionString()));

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new MySqlParameter("v_usg_code", null));
                        cmd.Parameters.Add(new MySqlParameter("v_usr_code", v_UsrCode));
                        cmd.Parameters.Add(new MySqlParameter("v_ur_code", v_UrCode));
                        cmd.Parameters.Add(new MySqlParameter("v_created_by", v_user));
                        cmd.Parameters.Add(new MySqlParameter("v_usgcode", MySqlDbType.Int32));
                        cmd.Parameters["v_usgcode"].Direction = ParameterDirection.Output;
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();

                        cmd.Connection.Close();
                        cmd.Parameters.Clear();
                        cmd.Dispose();

                    }
                    GridView2.DataBind();
                    GridView3.DataBind();

                }
            }
            catch (Exception ex)
            {
                errMessage = "Error updating record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }

        protected void btnGrantAll_Click(object sender, EventArgs e)
        {

        }

        protected void btnRevoke_Click(object sender, EventArgs e)
        {
            int v_usg_code;
            String errMessage;

            try
            {
                foreach (GridViewRow row in GridView3.Rows)
                {
                    MySqlCommand cmd;
                    Label lbl_usg_code = ((Label)row.FindControl("lbl_usg_code"));
                    if (String.IsNullOrEmpty(lbl_usg_code.Text))
                    {
                        v_usg_code = 0;
                    }
                    else
                    {
                        v_usg_code = Convert.ToInt32(lbl_usg_code.Text);
                    }

                    if (((CheckBox)row.FindControl("chkRightGrantedSelect")).Checked)
                    {
                        cmd = new MySqlCommand("serenehrdb.delete_user_roles_granted", new MySqlConnection(GetConnectionString()));

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new MySqlParameter("v_usg_code", v_usg_code));
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();

                        cmd.Connection.Close();
                        cmd.Parameters.Clear();
                        cmd.Dispose();

                    }
                    GridView2.DataBind();
                    GridView3.DataBind();

                }
            }
            catch (Exception ex)
            {
                errMessage = "Error revoking privillages ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }

        }

        protected void btnRevokeAll_Click(object sender, EventArgs e)
        {

        }

    }
}