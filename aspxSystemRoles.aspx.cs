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
    public partial class aspxSystemRoles : System.Web.UI.Page
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
            txtUrCode.Text = "";
            txtname.Text = "";
            txtDesc.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (Privillage_Update())
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
            int v_txtUrCode;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txtUrCode.Text))
                {
                    v_txtUrCode = 0;
                }
                else
                {
                    v_txtUrCode = Convert.ToInt32(txtUrCode.Text);
                }
                SqlCommand cmd = new SqlCommand("delete_user_roles", new SqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("@v_txtUrCode =====>" + v_txtUrCode);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_ur_code", v_txtUrCode));
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
        private Boolean Privillage_Update()
        {
            Boolean v_bool;
            String errMessage;
            try
            {
                int v_UrCode;
                if (String.IsNullOrEmpty(txtUrCode.Text))
                {
                    v_UrCode = 0;
                }
                else
                {
                    v_UrCode = Convert.ToInt32(txtUrCode.Text);
                }

                SqlCommand cmd = new SqlCommand("update_user_roles", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_ur_code", v_UrCode));
                cmd.Parameters.Add(new SqlParameter("@v_name", txtname.Text));
                cmd.Parameters.Add(new SqlParameter("@v_desc", txtDesc.Text));
                cmd.Parameters.Add(new SqlParameter("@v_urcode", SqlDbType.Int));
                cmd.Parameters["@v_urcode"].Direction = ParameterDirection.Output;
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
                string name = GridView1.SelectedRow.Cells[2].Text;
                txtUrCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                txtname.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
                txtDesc.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
                
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
            int v_UrCode, v_UpCode, v_urp_code;
            String errMessage;

            try
            {
                v_urp_code = 0;
                if (String.IsNullOrEmpty(txtUrCode.Text))
                {
                    v_UrCode = 0;
                }
                else
                {
                    v_UrCode = Convert.ToInt32(txtUrCode.Text);
                }
                foreach (GridViewRow row in GridView2.Rows)
                {
                    SqlCommand cmd;
                    decimal v_min_amt, v_max_amt;
                    String v_priv_name;

                    Label lbl_up_name = ((Label)row.FindControl("lbl_up_name"));
                    v_priv_name = lbl_up_name.Text.Replace("&nbsp;", "");

                    Label lbl_up_code = ((Label)row.FindControl("lbl_up_code"));
                    if (String.IsNullOrEmpty(lbl_up_code.Text))
                    {
                        v_UpCode = 0;
                    }
                    else
                    {
                        v_UpCode = Convert.ToInt32(lbl_up_code.Text);
                    }

                    Label lbl_up_min_amt = ((Label)row.FindControl("lbl_up_min_amt"));
                    if (String.IsNullOrEmpty(lbl_up_min_amt.Text))
                    {
                        v_min_amt = 0;
                    }
                    else
                    {
                        v_min_amt = Convert.ToDecimal(lbl_up_min_amt.Text);
                    }

                    Label lbl_up_max_amt = ((Label)row.FindControl("lbl_up_max_amt"));
                    if (String.IsNullOrEmpty(lbl_up_max_amt.Text))
                    {
                        v_max_amt = 0;
                    }
                    else
                    {
                        v_max_amt = Convert.ToDecimal(lbl_up_max_amt.Text);
                    }

                    if (v_max_amt < v_min_amt)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(),
                            "myScript",
                            "MyJavaFunction('Error.','Minimum amount cannot greater than Maximum Amount...Check Privillage..." + v_priv_name + "');",
                            true);
                        return;
                    }

                    if (((CheckBox)row.FindControl("chkPrivSelect")).Checked)
                    {
                        cmd = new SqlCommand("update_user_role_privlg", new SqlConnection(GetConnectionString()));

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@v_urp_code", v_urp_code));
                        cmd.Parameters.Add(new SqlParameter("@v_up_code", v_UpCode));
                        cmd.Parameters.Add(new SqlParameter("@v_ur_code", v_UrCode));
                        cmd.Parameters.Add(new SqlParameter("@v_min_amt", v_min_amt));
                        cmd.Parameters.Add(new SqlParameter("@v_max_amt", v_max_amt));
                        cmd.Parameters.Add(new SqlParameter("@v_urpcode", SqlDbType.Int));
                        cmd.Parameters["@v_urpcode"].Direction = ParameterDirection.Output;
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
            int v_urp_code;
            String errMessage;

            try
            {
                foreach (GridViewRow row in GridView3.Rows)
                {
                    SqlCommand cmd;
                    System.Diagnostics.Debug.WriteLine("XXXXXXXXXX");
                    Label lbl_urp_code = ((Label)row.FindControl("lbl_urp_code"));
                    System.Diagnostics.Debug.WriteLine("yyyyyyyyyy");
                    if (String.IsNullOrEmpty(lbl_urp_code.Text))
                    {
                        v_urp_code = 0;
                    }
                    else
                    {
                        v_urp_code = Convert.ToInt32(lbl_urp_code.Text);
                    }

                    System.Diagnostics.Debug.WriteLine("zzzzzzzzz");
                    if (((CheckBox)row.FindControl("chkGrantSelect")).Checked)
                    {
                        cmd = new SqlCommand("delete_user_role_privlg", new SqlConnection(GetConnectionString()));

                        System.Diagnostics.Debug.WriteLine("gggggggg");
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@v_urp_code", v_urp_code));
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();

                        cmd.Connection.Close();
                        cmd.Parameters.Clear();
                        cmd.Dispose();

                    }
                    System.Diagnostics.Debug.WriteLine("aaaaaaaaa");
                    GridView2.DataBind();
                    System.Diagnostics.Debug.WriteLine("bbbbbbbbbbbb");
                    GridView3.DataBind();
                    System.Diagnostics.Debug.WriteLine("ccccccccccccc");

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