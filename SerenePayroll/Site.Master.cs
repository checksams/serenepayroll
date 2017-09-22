using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using MySql.Data.MySqlClient;

using System.Configuration;
/*
 * Author: Samuel Nyong'a
 * Date: January 1st, 2015
 * 
 */
namespace SerenePayroll
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Query Strings
            //System.Diagnostics.Debug.WriteLine("Current URL=====> \n" + Request.Url.ToString());
            //System.Diagnostics.Debug.WriteLine("Current AbsoluteUri=====> \n" + Request.Url.AbsoluteUri);

            String errMessage;
            try
            {
                String strURL = ReverseString(Request.Url.ToString());
                int initialOcr;
                System.Diagnostics.Debug.WriteLine(" Reversed strURL=====> \n" + strURL);
                initialOcr = strURL.IndexOf("/");
                strURL = strURL.Substring(0, initialOcr);
                strURL = ReverseString(strURL) + "";
                System.Diagnostics.Debug.WriteLine("Final strURL=====> " + strURL);
                
                if (strURL == "Default.aspx" || strURL == "default.aspx")
                { strURL = "Home"; }
                else if (strURL == "aspxOrganization.aspx")
                { strURL = "Organization Structure"; }
                else if (strURL == "aspxJobTitles.aspx")
                { strURL = "Job Titles"; }
                else if (strURL == "aspxPayrolls.aspx")
                { strURL = "Payrolls"; }
                else if (strURL == "aspxEmployeeDetails.aspx")
                { strURL = "Employee Details"; }
                else if (strURL == "aspxTaxes.aspx")
                { strURL = "Taxes And Charges"; }
                else if (strURL == "aspxPayElements.aspx")
                { strURL = "Pay Elements"; }
                else if (strURL == "aspxLoans.aspx")
                { strURL = "Employee Loan Types"; }
                else if (strURL == "aspxLoanAmin.aspx")
                { strURL = "Loan Administration"; }
                else if (strURL == "aspxSystemPrivilages.aspx")
                { strURL = "System Privilages"; }
                else if (strURL == "aspxSystemRoles.aspx")
                { strURL = "System Roles"; }
                else if (strURL == "aspxUsers.aspx")
                { strURL = "Users"; }
                else if (strURL == "Global.asax")
                { strURL = "Global"; }
                else if (strURL == "aspxProcessPayroll.aspx")
                { strURL = "Process Payroll"; }
                else if (strURL == "aspxAuthorisePayroll.aspx")
                { strURL = "Authorise Payroll"; }
                else if (strURL == "aspxPayrollEnquiry.aspx")
                { strURL = "Payroll Enquiry"; }
                else if (strURL == "aspxExcepEmplys.aspx")
                { strURL = "Exceptional Employees"; }
                else if (strURL == "aspxAllowExcepEmplys.aspx")
                { strURL = "Allow Exceptional Employees"; }
                else if (strURL == "aspxImportFromExcel.aspx")
                { strURL = "Import From Excel"; }
                else if (strURL == "aspxTaxeRates.aspx")
                { strURL = "Taxes And Charges Rate Setup"; }
                else if (strURL == "aspxBanks.aspx")
                { strURL = "Banks"; }
                else if (strURL == "aspxEmpPayElements.aspx")
                { strURL = "Employee Pay Elements"; }
                else if (strURL == "aspxUserPasswordChange.aspx")
                { strURL = "Change Password"; }
                else if (strURL == "About.aspx")
                { strURL = "About"; }

                Session["ProcessArea"] = strURL;

                lblWorkFlow.Text = strURL;

                ProcAccessRoles();

                csPublic pb = new csPublic();
                String strGreetings = txtProductKey.Text;
                String strResponce = "";
                strResponce = pb.HelloWorld(strGreetings);
                System.Diagnostics.Debug.WriteLine("Site strResponce  ==== " + strResponce);
                if (strResponce == "Hello."){
                    System.Diagnostics.Debug.WriteLine("Site thru strResponce  ==== " + strResponce);
                  
                }                
                else
                {
                    System.Diagnostics.Debug.WriteLine("Site not thru strResponce  ==== " + strResponce);
                    if (strResponce == "Your trial version has expired.") {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MySiteFunction('Product Key Required.','Product Key Required.');", true);
                    }
                    else{
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MySiteFunction('Product Key Required.','Product Key Required.');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                errMessage = "Main Screen error..."+ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
            
            }

        }

        protected void ProcAccessRoles() {
            String errMessage;
            try
            {
                String v_user = System.Web.HttpContext.Current.User.Identity.Name;

                MySqlCommand cmd = new MySqlCommand("serenehrdb.get_curr_user_priv", new MySqlConnection(GetConnectionString()));
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_user", v_user));

                MySqlDataAdapter da = new MySqlDataAdapter();
                DataTable dt = new DataTable();

                da.SelectCommand = cmd;
                da.Fill(dt);

                cmd.Connection.Close();
                cmd.Dispose();

                if (dt.Columns.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        //System.Diagnostics.Debug.WriteLine("row[2]===>" + row[2].ToString());
                        
                        foreach (MenuItem item in NavigationMenu.Items)
                        {
                            if (row[2].ToString() == item.Text.Trim())
                            {
                                item.Enabled = true; item.Selectable = true;
                                //System.Diagnostics.Debug.WriteLine("Enabling Men===>" + item.Text);
                            }
                            //System.Diagnostics.Debug.WriteLine("Menu===>" + item.Text);
                            foreach (MenuItem childItem in item.ChildItems)
                            {
                                if (row[2].ToString() == childItem.Text.Trim())
                                {
                                    childItem.Enabled = true; childItem.Selectable = true;
                                    //System.Diagnostics.Debug.WriteLine("Enabling childItem Menu===>" + childItem.Text);
                                }
                                //System.Diagnostics.Debug.WriteLine("childItem Menu===>" + childItem.Text);
                            }
                        }                        
                    }
                }
                dt.Clear();
                da.Dispose();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                errMessage = "Main Screen error..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);

            }
            finally { 
                
            }

        }

        protected void NavigationMenu_MenuItemClick(object sender, MenuEventArgs e)
        {

        }

        public static string ReverseString(string s)
        {
            char[] arr = s.ToCharArray();
            Array.Reverse(arr);
            return new string(arr);
        }
        
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings
                ["serenehrdbConnectionString"].ConnectionString;
        }

        protected void btnOk_Click(object sender, EventArgs e)
        { 
            String errMessage;
            try{
                csPublic pb = new csPublic();
                String strGreetings = txtProductKey.Text;
                String strResponce = "";
                strResponce = pb.HelloWorld(strGreetings);
                System.Diagnostics.Debug.WriteLine("Site strResponce  ==== " + strResponce);
                if (strResponce == "Hello.")
                {
                    System.Diagnostics.Debug.WriteLine("Site thru strResponce  ==== " + strResponce);

                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Site not thru strResponce  ==== " + strResponce);
                    if (strResponce == "Your trial version has expired.")
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MySiteFunction('Product Key Required.','Your trial version has expired. \nProduct Key Required.');", true);
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MySiteFunction('Product Key Required.','Product Key Required.');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                errMessage = ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MySiteFunction('Error.','Product Key Required.');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }
        }
                
    }
}
