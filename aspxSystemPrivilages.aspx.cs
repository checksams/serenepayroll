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
using System.Text.RegularExpressions;


namespace SerenePayroll
{
    public partial class aspxSystemPrivilages : System.Web.UI.Page
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
            txtUpCode.Text = "";
            txtname.Text = "";
            txtDesc.Text = "";
            txtMinAmt.Text = "";
            txtMaxAmt.Text = "";
            ddlType.SelectedValue = "ACCESS";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (Privillage_Update())
            {
                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
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
            if (Privillage_Update())
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
            int v_txtUpCode;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txtUpCode.Text))
                {
                    v_txtUpCode = 0;
                }
                else
                {
                    v_txtUpCode = Convert.ToInt32(txtUpCode.Text);
                }
                SqlCommand cmd = new SqlCommand("delete_user_privillages", new SqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("@v_txtUpCode =====>" + v_txtUpCode);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_up_code", v_txtUpCode));
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
        private Boolean Privillage_Update()
        {
            Boolean v_bool;
            String errMessage;
            try
            {
                int v_UpCode;
                decimal v_min_amt, v_max_amt;
                if (String.IsNullOrEmpty(txtUpCode.Text))
                {
                    v_UpCode = 0;
                }
                else
                {
                    v_UpCode = Convert.ToInt32(txtUpCode.Text);
                }

                if (String.IsNullOrEmpty(txtMinAmt.Text))
                {
                    v_min_amt = 0;
                }
                else
                {
                    v_min_amt = Convert.ToDecimal(txtMinAmt.Text);
                }
                if (String.IsNullOrEmpty(txtMaxAmt.Text))
                {
                    v_max_amt = 0;
                }
                else
                {
                    v_max_amt = Convert.ToDecimal(txtMaxAmt.Text);
                }
                SqlCommand cmd = new SqlCommand("update_user_privillages", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_up_code", v_UpCode));
                cmd.Parameters.Add(new SqlParameter("@v_name", txtname.Text));
                cmd.Parameters.Add(new SqlParameter("@v_desc", txtDesc.Text));
                cmd.Parameters.Add(new SqlParameter("@v_min_amt", v_min_amt));
                cmd.Parameters.Add(new SqlParameter("@v_max_amt", v_max_amt));
                cmd.Parameters.Add(new SqlParameter("@v_upcode", SqlDbType.Int));
                cmd.Parameters["@v_upcode"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(new SqlParameter("@v_type", ddlType.Text));
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

            string name = GridView1.SelectedRow.Cells[2].Text;
            txtUpCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
            txtname.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
            txtDesc.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
            txtMinAmt.Text = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
            txtMaxAmt.Text = GridView1.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");
            ddlType.SelectedValue = GridView1.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", "");
            
            btnAdd.Enabled = false;
            btnSave.Enabled = true;
            btnSaveNAddNew.Enabled = true;
            btnDelete.Enabled = true;
            Editing.Visible = true;
            pnlEditingData.Visible = true;
            //GridView1.Visible = true;
        
        }

        protected void txtMinAmt_TextChanged(object sender, EventArgs e)
        {
            txtMinAmt.Text = Regex.Replace(txtMinAmt.Text, "[^0-9]", "");
        }

        protected void txtMaxAmt_TextChanged(object sender, EventArgs e)
        {
            txtMaxAmt.Text = Regex.Replace(txtMaxAmt.Text, "[^0-9]", "");
        }
        
    }
}