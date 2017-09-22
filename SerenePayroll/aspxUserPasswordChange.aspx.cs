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
    public partial class aspxUserPasswordChange : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                txtUserName.Text = System.Web.HttpContext.Current.User.Identity.Name;
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);
            
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

        protected void clearCtrls()
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (Password_Update())
            {

                //clearCtrls();
            }
            else
            {

            }
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

        private Boolean Verify_pwd() {
            String errMessage=null, lookupPassword = null;
            bool v_bool;
            MySqlCommand cmd;
            try {
                cmd = new MySqlCommand("Select usr_pwd from shr_users where usr_name=@userName and usr_pwd=MD5(@pwd)", new MySqlConnection(GetConnectionString()));
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add(new MySqlParameter("@userName", txtUserName.Text.Trim().Replace("&nbsp;", "")));
                cmd.Parameters.Add(new MySqlParameter("@pwd", txtPassword.Text.Trim().Replace("&nbsp;", "")));
                cmd.Connection.Open();

                lookupPassword = (string)cmd.ExecuteScalar();
                if (String.IsNullOrEmpty(lookupPassword)) {
                    v_bool = false;
                    IncreamentLoginAttempts();
                }else{
                    v_bool = true;
                    ResetLoginAttempts();
                }
                cmd.Connection.Close();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                v_bool = false;
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);
                
            }
            return v_bool;
        }

        private void IncreamentLoginAttempts()
        {
            String errMessage = null;
            int v_login_atempts = 0;
            try
            {
                MySqlCommand cmd = new MySqlCommand("update shr_users set usr_login_atempts = case when usr_login_atempts is null then 0 else usr_login_atempts end +1 where usr_name=@userName and usr_pwd=MD5(@pwd)", new MySqlConnection(GetConnectionString()));
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add(new MySqlParameter("@userName", txtUserName.Text.Trim().Replace("&nbsp;", "")));
                cmd.Parameters.Add(new MySqlParameter("@pwd", txtPassword.Text.Trim().Replace("&nbsp;", "")));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Transaction.Commit();
                cmd.Connection.Close();

                cmd = new MySqlCommand("Select usr_login_atempts from shr_users where usr_name=@userName and usr_pwd=MD5(@pwd)", new MySqlConnection(GetConnectionString()));
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add(new MySqlParameter("@userName", txtUserName.Text.Trim().Replace("&nbsp;", "")));
                cmd.Parameters.Add(new MySqlParameter("@pwd", txtPassword.Text.Trim().Replace("&nbsp;", "")));
                cmd.Connection.Open();

                v_login_atempts = Convert.ToInt32(cmd.ExecuteScalar());

                if (v_login_atempts > 10)
                {
                    //TODO lOCK ACCOUNT
                }
                cmd.Transaction.Commit();
                cmd.Connection.Close();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }

        private void ResetLoginAttempts()
        {
            String errMessage = null;
            try
            {
                MySqlCommand cmd = new MySqlCommand("update shr_users set usr_login_atempts = 0 where usr_name=@userName and usr_pwd=MD5(@pwd)", new MySqlConnection(GetConnectionString()));
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add(new MySqlParameter("@userName", txtUserName.Text.Trim().Replace("&nbsp;", "")));
                cmd.Parameters.Add(new MySqlParameter("@pwd", txtPassword.Text.Trim().Replace("&nbsp;", "")));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

            }
        }


        [DataObjectMethod(DataObjectMethodType.Insert)]
        private Boolean Password_Update()
        {
            Boolean v_bool;
            String errMessage;

            try
            {
                String v_user = System.Web.HttpContext.Current.User.Identity.Name;
                
                MySqlCommand cmd = new MySqlCommand("serenehrdb.update_u", new MySqlConnection(GetConnectionString()));
                    
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_name", v_user));
                cmd.Parameters.Add(new MySqlParameter("v_pwd", txtPassword.Text));
                cmd.Parameters.Add(new MySqlParameter("v_new_pwd", txtNewPassword.Text));
                cmd.Parameters.Add(new MySqlParameter("v_re_new_pwd", txtReEnterNewPwd.Text));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                cmd.Dispose();

                v_bool = true;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Your password has been changed successfully');", true);
                
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

        
    }
}