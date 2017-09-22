using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
//using System.Data.SqlClient;

using System.Configuration;
using System.ComponentModel;

using System.Globalization;


namespace SerenePayroll
{
    public partial class aspxPayrolls : System.Web.UI.Page
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
            txtPrCode.Text = "";
            txtShtDesc.Text = "";
            txtDesc.Text = "";
            txtWef.Text = "";
            txtWet.Text = "";
            txtDay1Hrs.Text = "";
            txtDay2Hrs.Text = "";
            txtDay3Hrs.Text = "";
            txtDay4Hrs.Text = "";
            txtDay5Hrs.Text = "";
            txtDay6Hrs.Text = "";
            txtDay7Hrs.Text = "";

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (Payroll_Update())
            {
                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
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
            if (Payroll_Update())
            {
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = false;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                GridView1.Visible = false;
                GridView1.DataBind();
                
                clearCtrls();
            }
            else
            {

            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {            
            int v_txtPrCode;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txtPrCode.Text))
                {
                    v_txtPrCode = 0;
                }
                else
                {
                    v_txtPrCode = Convert.ToInt32(txtPrCode.Text);
                }
                SqlCommand cmd = new SqlCommand("delete_payroll", new SqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("@v_txtPrCode =====>" + v_txtPrCode);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_pr_code", v_txtPrCode));
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
        private Boolean Payroll_Update()
        {
            Boolean v_bool;
            String errMessage;
            try
            {
                int v_PrCode;
                decimal v_day1_hrs, v_day2_hrs, v_day3_hrs, v_day4_hrs, v_day5_hrs, v_day6_hrs, v_day7_hrs;

                if (String.IsNullOrEmpty(txtPrCode.Text))
                {
                    v_PrCode = 0;
                }
                else
                {
                    v_PrCode = Convert.ToInt32(txtPrCode.Text);
                }

                if (String.IsNullOrEmpty(txtDay1Hrs.Text)) { v_day1_hrs = 0; }
                else { v_day1_hrs = Convert.ToDecimal(txtDay1Hrs.Text); }

                if (String.IsNullOrEmpty(txtDay2Hrs.Text)) { v_day2_hrs = 0; }
                else { v_day2_hrs = Convert.ToDecimal(txtDay2Hrs.Text); }

                if (String.IsNullOrEmpty(txtDay3Hrs.Text)) { v_day3_hrs = 0; }
                else { v_day3_hrs = Convert.ToDecimal(txtDay3Hrs.Text); }

                if (String.IsNullOrEmpty(txtDay4Hrs.Text)) { v_day4_hrs = 0; }
                else { v_day4_hrs = Convert.ToDecimal(txtDay4Hrs.Text); }

                if (String.IsNullOrEmpty(txtDay5Hrs.Text)) { v_day5_hrs = 0; }
                else { v_day5_hrs = Convert.ToDecimal(txtDay5Hrs.Text); }

                if (String.IsNullOrEmpty(txtDay6Hrs.Text)) { v_day6_hrs = 0; }
                else { v_day6_hrs = Convert.ToDecimal(txtDay6Hrs.Text); }

                if (String.IsNullOrEmpty(txtDay7Hrs.Text)) { v_day7_hrs = 0; }
                else { v_day7_hrs = Convert.ToDecimal(txtDay7Hrs.Text); }


                SqlCommand cmd = new SqlCommand("update_payroll", new SqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@v_Pr_code", v_PrCode));
                cmd.Parameters.Add(new SqlParameter("@v_sht_desc", txtShtDesc.Text));
                cmd.Parameters.Add(new SqlParameter("@v_desc", txtDesc.Text));
                cmd.Parameters.Add(new SqlParameter("@v_org_code", ddlOrg.SelectedValue));
                cmd.Parameters.Add(new SqlParameter("@v_wef", txtWef.Text));
                cmd.Parameters.Add(new SqlParameter("@v_wet", txtWet.Text));
                cmd.Parameters.Add(new SqlParameter("@v_prcode", SqlDbType.Int));
                cmd.Parameters["@v_prcode"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(new SqlParameter("@v_day1_hrs", v_day1_hrs));
                cmd.Parameters.Add(new SqlParameter("@v_day2_hrs", v_day2_hrs));
                cmd.Parameters.Add(new SqlParameter("@v_day3_hrs", v_day3_hrs));
                cmd.Parameters.Add(new SqlParameter("@v_day4_hrs", v_day4_hrs));
                cmd.Parameters.Add(new SqlParameter("@v_day5_hrs", v_day5_hrs));
                cmd.Parameters.Add(new SqlParameter("@v_day6_hrs", v_day6_hrs));
                cmd.Parameters.Add(new SqlParameter("@v_day7_hrs", v_day7_hrs));
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

            string name = GridView1.SelectedRow.Cells[2].Text;
            txtPrCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
            txtShtDesc.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
            txtDesc.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
            ddlOrg.SelectedValue = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
            txtWef.Text = GridView1.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", "");
            txtWet.Text = GridView1.SelectedRow.Cells[7].Text.Trim().Replace("&nbsp;", "");
            txtDay1Hrs.Text = GridView1.SelectedRow.Cells[8].Text.Trim().Replace("&nbsp;", "");
            txtDay2Hrs.Text = GridView1.SelectedRow.Cells[9].Text.Trim().Replace("&nbsp;", "");
            txtDay3Hrs.Text = GridView1.SelectedRow.Cells[10].Text.Trim().Replace("&nbsp;", "");
            txtDay4Hrs.Text = GridView1.SelectedRow.Cells[11].Text.Trim().Replace("&nbsp;", "");
            txtDay5Hrs.Text = GridView1.SelectedRow.Cells[12].Text.Trim().Replace("&nbsp;", "");
            txtDay6Hrs.Text = GridView1.SelectedRow.Cells[13].Text.Trim().Replace("&nbsp;", "");
            txtDay7Hrs.Text = GridView1.SelectedRow.Cells[14].Text.Trim().Replace("&nbsp;", "");


            btnAdd.Enabled = false;
            btnSave.Enabled = true;
            btnSaveNAddNew.Enabled = true;
            btnDelete.Enabled = true;
            Editing.Visible = true;
            pnlEditingData.Visible = true;
            GridView1.Visible = false;
        
        }

        protected void GridView1_ItemCommand(object sender, ListViewCommandEventArgs e)
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
                GridView1.Visible = true;

                System.Diagnostics.Debug.WriteLine("CommandName=====>" + e.CommandName);
                Label lblPrCode = (Label)e.Item.FindControl("lblJtCode");
                Label lblShtDesc = (Label)e.Item.FindControl("lblShtDesc");
                Label lblDesc = (Label)e.Item.FindControl("lblDesc");

                txtPrCode.Text = lblPrCode.Text;
                txtShtDesc.Text = lblShtDesc.Text;
                txtDesc.Text = lblDesc.Text;
                //string pid = GridView1.DataKeys[e.NewSelectedIndex].Value.ToString();


                System.Diagnostics.Debug.WriteLine("txtPrCode=====>" + txtPrCode.Text);

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