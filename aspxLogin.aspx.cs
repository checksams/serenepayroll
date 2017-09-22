using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Web.Security;

//using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication2
{
    public partial class aspxLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private String errMessage;
        private bool ValidateUser( string userName, string passWord )
        {
	        SqlConnection conn;
	        SqlCommand cmd;
	        string lookupPassword = null;

            SqlConnection mysqlConn;
            SqlCommand mysqlCmm;

	        // Check for invalid userName.
	        // userName must not be null and must be between 1 and 15 characters.
	        if ( (  null == userName ) || ( 0 == userName.Length ) || ( userName.Length > 15 ) )
            {
                System.Diagnostics.Trace.WriteLine("[ValidateUser] Input validation of userName failed.");

                errMessage = "The username length should be between 0 and 15 characters..";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                return false;
	        }

	        // Check for invalid passWord.
	        // passWord must not be null and must be between 1 and 25 characters.
	        if ( (  null == passWord ) || ( 0 == passWord.Length ) || ( passWord.Length > 25 ) )
            {
                System.Diagnostics.Trace.WriteLine("[ValidateUser] Input validation of passWord failed.");
                errMessage = "The password length should be between 0 and 25 characters...";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                return false;
	        }

	        try
	        {
		        // ===>Consult with your SQL Server administrator for an appropriate connection
		        //sql server
                // string to use to connect to your local SQL Server.
		        //conn = new SqlConnection( "server=localhost;Integrated Security=SSPI;database=Northwind" );
                //conn = new SqlConnection("Data Source=SAMUEL-PC;Initial Catalog=Northwind;Integrated Security=True");
                //conn.Open(); 

                //mysqlConn = new SqlConnection("Data Source=localhost;Initial Catalog=serenehrdb;Integrated Security=True");
                mysqlConn = new SqlConnection(GetConnectionString());
                mysqlConn.Open();

		        // ===>Create SqlCommand to select pwd field from users table given supplied userName.
		        //sql server
                //cmd = new SqlCommand( "Select pwd from users where uname=@userName", conn );
		        //cmd.Parameters.Add( "@userName", SqlDbType.VarChar, 25 );
		        //cmd.Parameters["@userName"].Value = userName;

                //mysqlCmm = new SqlCommand("Select usr_pwd from shr_users where usr_name=@userName and usr_pwd=SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', @pwd)),3,32)", mysqlConn);
                mysqlCmm = new SqlCommand("Select usr_pwd from shr_users where usr_name=@userName and usr_pwd=dbo.MD5(@pwd)", mysqlConn);
                mysqlCmm.Parameters.Add("@userName",SqlDbType.VarChar);
                mysqlCmm.Parameters["@userName"].Value = userName;

                mysqlCmm.Parameters.Add("@pwd", SqlDbType.VarChar);
                mysqlCmm.Parameters["@pwd"].Value = passWord;

		        // Execute command and fetch pwd field into lookupPassword string.
                //sql server
		        //lookupPassword = (string) cmd.ExecuteScalar();

                //mysql
                lookupPassword = (string)mysqlCmm.ExecuteScalar();

                //System.Diagnostics.Trace.WriteLine("lookupPassword " + lookupPassword);

		        // Cleanup command and connection objects.
		        //sql server
                //cmd.Dispose();
		        //conn.Dispose();

                mysqlCmm.Dispose();
                mysqlConn.Close();
	        }
	        catch ( Exception ex )
	        {
		        // Add error handling here for debugging.
                // This error message should not be sent back to the caller.
                System.Diagnostics.Trace.WriteLine("[ValidateUser] Exception " + ex.Message);

                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
	        }
            System.Diagnostics.Debug.WriteLine("lookupPassword=" + lookupPassword + "; userName=" + userName + " passWord=" + passWord);

	        // If no password found, return false.
            if (null == lookupPassword)
            {
                // You could write failed login attempts here to event log for additional security.
                System.Diagnostics.Debug.WriteLine("cccccccccccccc false");
                return false;  
            }
            else
            {
                // Compare lookupPassword and input passWord, using a case-sensitive comparison.
                //sql server
                //return ( 0 == string.Compare( lookupPassword, passWord, false ) );

                //mysql
                System.Diagnostics.Debug.WriteLine("ccccccccccc true");
                return true;
            }
            
        }

        private void cmdLogin_ServerClick(object sender, System.EventArgs e)
        {
            if (ValidateUser(txtUserName.Value, txtUserPass.Value))
                FormsAuthentication.RedirectFromLoginPage(txtUserName.Value,
                    chkPersistCookie.Checked);
            else
                Response.Redirect("~/aspxlogin.aspx", true);
        }

        protected void cmdLogin_Click(object sender, EventArgs e)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("Validating username and password ------------->");
                if (ValidateUser(txtUserName.Value, txtUserPass.Value))
                {

                    System.Diagnostics.Debug.WriteLine("Right username or password============>");

                    errMessage = "Right username or password.................";
                    FormsAuthentication.RedirectFromLoginPage(txtUserName.Value,
                        chkPersistCookie.Checked);
                }
                else
                {

                    System.Diagnostics.Debug.WriteLine("Error wrong username or password============>");
                    errMessage = ("Wrong username or password....");
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);

                    //Response.Redirect("~/aspxlogin.aspx", true); 
                }
            }
            catch (Exception ex)
            {

                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);

            }


        }

        private void InitializeComponent() 
        {
            //this.cmdLogin.Click += new System.EventHandler(this.cmdLogin_Click);
        }
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings
                ["serenehrdbConnectionString"].ConnectionString;
        }
					
    }
}