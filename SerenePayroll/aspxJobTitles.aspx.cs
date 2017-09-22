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
    public partial class aspxJobTitles : System.Web.UI.Page
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
            ListView1.Visible = false;
            clearCtrls();
        }

        protected void clearCtrls()
        {
            txtJtCode.Text = "";
            txtJtShtDesc.Text = "";
            txtDesc.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            
            if (JobTitles_Update())
            {
                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                ListView1.Visible = true;
                ListView1.DataBind();

                clearCtrls();
            }
            else
            {

            }
        }

        protected void btnSaveNAddNew_Click(object sender, EventArgs e)
        {
            if (JobTitles_Update())
            {
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = false;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                ListView1.Visible = false;
                ListView1.DataBind();
                
                clearCtrls();
            }
            else
            {

            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {            
            int v_txtJtCode;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txtJtCode.Text))
                {
                    v_txtJtCode = 0;
                }
                else
                {
                    v_txtJtCode = Convert.ToInt32(txtJtCode.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.jobtitle_delete", new MySqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("v_txtJtCode =====>" + v_txtJtCode);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_jt_code", v_txtJtCode));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();

                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                ListView1.Visible = true;
                ListView1.DataBind();
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
            ListView1.Visible = true;

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
        private Boolean JobTitles_Update()
        {
            Boolean v_bool;
            String errMessage;
            try
            {
                int v_JtCode;
                if (String.IsNullOrEmpty(txtJtCode.Text))
                {
                    v_JtCode = 0;
                }
                else
                {
                    v_JtCode = Convert.ToInt32(txtJtCode.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.jobtitles_update", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_jt_code", v_JtCode));
                cmd.Parameters.Add(new MySqlParameter("v_sht_desc", txtJtShtDesc.Text));
                cmd.Parameters.Add(new MySqlParameter("v_desc", txtDesc.Text));
                cmd.Parameters.Add(new MySqlParameter("v_jtcode", MySqlDbType.Int32));
                cmd.Parameters["v_jtcode"].Direction = ParameterDirection.Output;
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

        protected void ListView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

            String errMessage;
            try
            {
                clearCtrls();
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = true;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                ListView1.Visible = true;

                System.Diagnostics.Debug.WriteLine("CommandName=====>" + e.CommandName);
                Label lblJtCode = (Label)e.Item.FindControl("lblJtCode");
                Label lblShtDesc = (Label)e.Item.FindControl("lblShtDesc");
                Label lblDesc = (Label)e.Item.FindControl("lblDesc");

                txtJtCode.Text = lblJtCode.Text;
                txtJtShtDesc.Text = lblShtDesc.Text;
                txtDesc.Text = lblDesc.Text;
                //string pid = ListView1.DataKeys[e.NewSelectedIndex].Value.ToString();


                System.Diagnostics.Debug.WriteLine("txtJtCode=====>" + txtJtCode.Text);

                //BindData();
            }
            catch (Exception ex)
            {
                errMessage = "Error..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }
        }
        protected void ListView1_SelectedIndexChanging(object sender, ListViewSelectEventArgs e)
        {
            String errMessage;
            try
            {
                ListView1.SelectedIndex = e.NewSelectedIndex;

                txtJtCode.Text = ListView1.SelectedDataKey.Value.ToString();
                //string pid = ListView1.DataKeys[e.NewSelectedIndex].Value.ToString();


                clearCtrls();
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = true;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                ListView1.Visible = true;

                System.Diagnostics.Debug.WriteLine("txtJtCode=====>" + txtJtCode.Text);

                //BindData();
            }
            catch (Exception ex)
            {
                errMessage = "Error..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);


            }
        } 
    }
}