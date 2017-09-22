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

using System.IO;
using System.Text;

using System.Drawing;


namespace SerenePayroll
{
    public partial class aspxEmployeeDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            fupEmpPhotoUpload.Attributes.Add("onchange", "return checkFileExtension(this);");
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
            pnlDisplayImportData.Visible = false;
            clearCtrls();

            txt_emp_org_code.Text = DropDownList1.SelectedValue;
            txt_emp_organization.Text = DropDownList1.SelectedItem.Text;
            AttachColor(ddl_emp_bnk_code, "white", "#eeeeee");
            AttachColor(ddl_emp_bbr_code, "white", "#eeeeee");
        }

        protected void clearCtrls()
        { 
            txt_emp_code.Text = "";
            txt_emp_sht_desc.Text = "";
            txt_emp_surname.Text = "";
            txt_emp_other_names.Text = "";
            txt_emp_tel_no1.Text = "";
            txt_emp_tel_no2.Text = "";
            txt_emp_sms_no.Text = "";
            txt_emp_join_date.Text = "";
            txt_emp_contract_date.Text = "";
            txt_emp_final_date.Text = "";
            txt_emp_org_code.Text = "";
            txt_emp_organization.Text = "";
            txt_emp_gender.Text = "";
            txt_emp_work_email.Text = "";
            txt_emp_personal_email.Text = "";
            txt_emp_id_no.Text = "";
            txt_emp_nssf_no.Text = "";
            txt_emp_pin_no.Text = "";
            txt_emp_nhif_no.Text = "";
            txt_emp_lasc_no.Text = "";
            txt_emp_nxt_kin_sname.Text = "";
            txt_emp_nxt_kin_onames.Text = "";
            txt_emp_nxt_kin_tel_no.Text = "";
            ddl_emp_pr_code.SelectedValue = "";
            txt_emp_nxt_kin_onames.Text = "";
            txt_emp_nxt_kin_tel_no.Text = "";
            ddl_emp_pr_code.SelectedValue = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (EmployeeDtls_Update())
            {
                btnAdd.Enabled = true;
                btnSave.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                ListView1.Visible = true;
                ListView1.DataBind();
                pnlDisplayImportData.Visible = false;

                clearCtrls();
            }
            else
            {

            }
        }

        protected void btnSaveNAddNew_Click(object sender, EventArgs e)
        {
            if (EmployeeDtls_Update())
            {
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = false;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                ListView1.Visible = false;
                ListView1.DataBind();
                pnlDisplayImportData.Visible = false;

                clearCtrls();
            }
            else
            {

            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int v_txt_emp_code;
            String errMessage;
            try
            {
                if (String.IsNullOrEmpty(txt_emp_code.Text))
                {
                    v_txt_emp_code = 0;
                }
                else
                {
                    v_txt_emp_code = Convert.ToInt32(txt_emp_code.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.employee_delete", new MySqlConnection(GetConnectionString()));
                System.Diagnostics.Debug.WriteLine("v_txt_emp_code =====>" + v_txt_emp_code);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_emp_code", v_txt_emp_code));
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
                pnlDisplayImportData.Visible = false;
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
            pnlDisplayImportData.Visible = false;

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
        private Boolean EmployeeDtls_Update()
        {
            Boolean v_bool;
            String errMessage;
            String strSubString;
            try
            {
                int v_txt_emp_code, v_pr_code, v_bnk_code, v_bbr_code;
                int v_txt_emp_org_code;
                int v_cnt;
                txt_emp_org_code.Text = DropDownList1.SelectedValue;
                txt_emp_organization.Text = DropDownList1.SelectedItem.Text;

                if (ddl_emp_pr_code.SelectedValue == "") { v_pr_code = 0; }
                else { v_pr_code = Convert.ToInt32(ddl_emp_pr_code.SelectedValue); }

                if (ddl_emp_bnk_code.SelectedValue == "") { v_bnk_code = 0; }
                else { v_bnk_code = Convert.ToInt32(ddl_emp_bnk_code.SelectedValue); }

                if (ddl_emp_bbr_code.SelectedValue == "") { v_bbr_code = 0; }
                else { v_bbr_code = Convert.ToInt32(ddl_emp_bbr_code.SelectedValue); }


                if (String.IsNullOrEmpty(txt_emp_code.Text))
                {
                    v_txt_emp_code = 0;
                }
                else
                {
                    v_txt_emp_code = Convert.ToInt32(txt_emp_code.Text);
                }

                if (String.IsNullOrEmpty(txt_emp_org_code.Text))
                {
                    v_txt_emp_org_code = 0;
                }
                else
                {
                    v_txt_emp_org_code = Convert.ToInt32(txt_emp_org_code.Text);
                }

                if (String.IsNullOrEmpty(txt_emp_work_email.Text) == false)
                {
                    v_cnt = txt_emp_work_email.Text.IndexOf('@');
                    if (v_cnt <= 0)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Check Work email. An email address must have @ character');", true);
                        return false;
                    }
                    strSubString = txt_emp_work_email.Text.Substring(v_cnt);
                    //System.Diagnostics.Debug.WriteLine("Work email strSubString=====>" + strSubString);
                    v_cnt = strSubString.IndexOf('.');
                    if (v_cnt <= 0)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Check Work email. An email address must have . character after @ character');", true);
                        return false;
                    }

                }
                if (String.IsNullOrEmpty(txt_emp_personal_email.Text) == false)
                {
                    v_cnt = txt_emp_personal_email.Text.IndexOf('@');
                    if (v_cnt <= 0)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Check Pernonal email. An email address must have @ character');", true);
                        return false;
                    }
                    strSubString = txt_emp_personal_email.Text.Substring(v_cnt);
                    //System.Diagnostics.Debug.WriteLine("Personal email strSubString=====>" + strSubString);
                    v_cnt = strSubString.IndexOf('.');
                    if (v_cnt <= 0)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Check Personal email. An email address must have . character after @ character');", true);
                        return false;
                    }

                }

                MySqlCommand cmd = new MySqlCommand("serenehrdb.employee_update", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;

                System.Diagnostics.Debug.WriteLine("v_join_date=====>" + txt_emp_join_date.Text);
                System.Diagnostics.Debug.WriteLine("v_contract_date=====>" + txt_emp_contract_date.Text);
                System.Diagnostics.Debug.WriteLine("v_final_date=====>" + txt_emp_final_date.Text);

                cmd.Parameters.Add(new MySqlParameter("v_emp_code", v_txt_emp_code));
                cmd.Parameters.Add(new MySqlParameter("v_sht_desc", txt_emp_sht_desc.Text));
                cmd.Parameters.Add(new MySqlParameter("v_surname", txt_emp_surname.Text));
                cmd.Parameters.Add(new MySqlParameter("v_other_names", txt_emp_other_names.Text));
                cmd.Parameters.Add(new MySqlParameter("v_tel_no1", txt_emp_tel_no1.Text));
                cmd.Parameters.Add(new MySqlParameter("v_tel_no2", txt_emp_tel_no2.Text));
                cmd.Parameters.Add(new MySqlParameter("v_sms_no", txt_emp_sms_no.Text));
                cmd.Parameters.Add(new MySqlParameter("v_contract_date", txt_emp_contract_date.Text));
                cmd.Parameters.Add(new MySqlParameter("v_final_date", txt_emp_final_date.Text));
                cmd.Parameters.Add(new MySqlParameter("v_org_code", v_txt_emp_org_code));
                cmd.Parameters.Add(new MySqlParameter("v_organization", txt_emp_organization.Text));
                cmd.Parameters.Add(new MySqlParameter("v_gender", txt_emp_gender.Text));
                cmd.Parameters.Add(new MySqlParameter("v_join_date", txt_emp_join_date.Text));
                cmd.Parameters.Add(new MySqlParameter("v_work_email", txt_emp_work_email.Text));
                cmd.Parameters.Add(new MySqlParameter("v_personal_email", txt_emp_personal_email.Text));
                cmd.Parameters.Add(new MySqlParameter("v_empcode", MySqlDbType.Int32));
                cmd.Parameters["v_empcode"].Direction = ParameterDirection.Output;
                
                cmd.Parameters.Add(new MySqlParameter("v_id_no", txt_emp_id_no.Text));
                cmd.Parameters.Add(new MySqlParameter("v_nssf_no", txt_emp_nssf_no.Text));
                cmd.Parameters.Add(new MySqlParameter("v_pin_no", txt_emp_pin_no.Text));
                cmd.Parameters.Add(new MySqlParameter("v_nhif_no", txt_emp_nhif_no.Text));
                cmd.Parameters.Add(new MySqlParameter("v_lasc_no", txt_emp_lasc_no.Text));
                cmd.Parameters.Add(new MySqlParameter("v_nxt_kin_sname", txt_emp_nxt_kin_sname.Text));
                cmd.Parameters.Add(new MySqlParameter("v_nxt_kin_onames", txt_emp_nxt_kin_onames.Text));
                cmd.Parameters.Add(new MySqlParameter("v_nxt_kin_tel_no", txt_emp_nxt_kin_tel_no.Text));
                cmd.Parameters.Add(new MySqlParameter("v_pr_code", v_pr_code));
                cmd.Parameters.Add(new MySqlParameter("v_bnk_code", v_bnk_code));
                cmd.Parameters.Add(new MySqlParameter("v_bbr_code", v_bbr_code));
                cmd.Parameters.Add(new MySqlParameter("v_bank_acc_no", txt_emp_bank_acc_no.Text));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();

                v_bool = true;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
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

        [DataObjectMethod(DataObjectMethodType.Insert)]
        protected Boolean EmployeeDtls_Import()
        {
            Boolean v_bool;
            String errMessage;
            String strSubString;
            int v_txt_emp_code;
            int v_txt_emp_org_code;
            int v_cnt, v_pr_code, v_bnk_code, v_bbr_code;

            try
            {
                MySqlCommand cmd = new MySqlCommand("serenehrdb.employee_update", new MySqlConnection(GetConnectionString()));
                cmd.CommandType = CommandType.StoredProcedure;
                DataTable dt = Create_DtFromGv(gvImportEmpData);

                if (dt.Columns.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        txt_emp_code.Text = row[0].ToString();
                        txt_emp_sht_desc.Text = row[1].ToString();
                        txt_emp_surname.Text = row[2].ToString();
                        txt_emp_other_names.Text = row[3].ToString();
                        txt_emp_tel_no1.Text = row[4].ToString();
                        txt_emp_tel_no2.Text = row[5].ToString();
                        txt_emp_sms_no.Text = row[6].ToString();
                        txt_emp_contract_date.Text = row[7].ToString();
                        txt_emp_final_date.Text = row[8].ToString();
                        txt_emp_org_code.Text = row[9].ToString();
                        txt_emp_organization.Text = row[10].ToString();
                        txt_emp_gender.Text = row[11].ToString();
                        txt_emp_join_date.Text = row[12].ToString();
                        txt_emp_work_email.Text = row[13].ToString();
                        txt_emp_personal_email.Text = row[14].ToString();
                        
                        txt_emp_id_no.Text = row[15].ToString();
                        txt_emp_nssf_no.Text = row[16].ToString();
                        txt_emp_pin_no.Text = row[17].ToString();
                        txt_emp_nhif_no.Text = row[18].ToString();
                        txt_emp_lasc_no.Text = row[19].ToString();
                        txt_emp_nxt_kin_sname.Text = row[20].ToString();
                        txt_emp_nxt_kin_onames.Text = row[21].ToString();
                        txt_emp_nxt_kin_tel_no.Text = row[22].ToString();
                        //cmd.Parameters.Add(new MySqlParameter("v_pr_code", v_pr_code));
                        //cmd.Parameters.Add(new MySqlParameter("v_bnk_code", v_bnk_code));
                        //cmd.Parameters.Add(new MySqlParameter("v_bbr_code", v_bbr_code));
                        txt_emp_bank_acc_no.Text = row[23].ToString();
                        try
                        {
                            ddl_emp_bnk_code.SelectedValue = row[24].ToString();
                            ddl_emp_bbr_code.SelectedValue = row[26].ToString();
                        }
                        catch (Exception ex) {
                            ddl_emp_bnk_code.SelectedValue = "";
                            ddl_emp_bbr_code.SelectedValue = "";
                            System.Diagnostics.Debug.WriteLine("Error getting Bank dtls for " + txt_emp_surname.Text
                                + "\n Bank=" + row[24].ToString()
                                + "\n Bank Branch=" + row[25].ToString() + ex.Message);
                        }
                        if (ddl_emp_pr_code.SelectedValue == "") { v_pr_code = 0; }
                        else { v_pr_code = Convert.ToInt32(ddl_emp_pr_code.SelectedValue); }

                        if (ddl_emp_bnk_code.SelectedValue == "") { v_bnk_code = 0; }
                        else { v_bnk_code = Convert.ToInt32(ddl_emp_bnk_code.SelectedValue); }

                        if (ddl_emp_bbr_code.SelectedValue == "") { v_bbr_code = 0; }
                        else { v_bbr_code = Convert.ToInt32(ddl_emp_bbr_code.SelectedValue); }

                    
                        if (String.IsNullOrEmpty(txt_emp_code.Text))
                        {
                            v_txt_emp_code = 0;
                        }
                        else
                        {
                            v_txt_emp_code = Convert.ToInt32(txt_emp_code.Text);
                        }

                        if (String.IsNullOrEmpty(txt_emp_org_code.Text))
                        {
                            v_txt_emp_org_code = 0;
                        }
                        else
                        {
                            v_txt_emp_org_code = Convert.ToInt32(txt_emp_org_code.Text);
                        }

                        if (String.IsNullOrEmpty(txt_emp_work_email.Text) == false)
                        {
                            v_cnt = txt_emp_work_email.Text.IndexOf('@');
                            if (v_cnt <= 0)
                            {
                                //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Check Work email. An email address must have @ character');", true);
                                //return false;
                                continue;
                            }
                            strSubString = txt_emp_work_email.Text.Substring(v_cnt);
                            //System.Diagnostics.Debug.WriteLine("Work email strSubString=====>" + strSubString);
                            v_cnt = strSubString.IndexOf('.');
                            if (v_cnt <= 0)
                            {
                                //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Check Work email. An email address must have . character after @ character');", true);
                                //return false;
                                continue;
                            }

                        }
                        if (String.IsNullOrEmpty(txt_emp_personal_email.Text) == false)
                        {
                            v_cnt = txt_emp_personal_email.Text.IndexOf('@');
                            if (v_cnt <= 0)
                            {
                                //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Check Pernonal email. An email address must have @ character');", true);
                                //return false;
                                continue;
                            }
                            strSubString = txt_emp_personal_email.Text.Substring(v_cnt);
                            v_cnt = strSubString.IndexOf('.');
                            if (v_cnt <= 0)
                            {
                                //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Check Personal email. An email address must have . character after @ character');", true);
                                //return false;
                                continue;
                            }

                        }
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add(new MySqlParameter("v_emp_code", v_txt_emp_code));
                        cmd.Parameters.Add(new MySqlParameter("v_sht_desc", txt_emp_sht_desc.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_surname", txt_emp_surname.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_other_names", txt_emp_other_names.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_tel_no1", txt_emp_tel_no1.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_tel_no2", txt_emp_tel_no2.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_sms_no", txt_emp_sms_no.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_contract_date", txt_emp_contract_date.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_final_date", txt_emp_final_date.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_org_code", v_txt_emp_org_code));
                        cmd.Parameters.Add(new MySqlParameter("v_organization", txt_emp_organization.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_gender", txt_emp_gender.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_join_date", txt_emp_join_date.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_work_email", txt_emp_work_email.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_personal_email", txt_emp_personal_email.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_empcode", MySqlDbType.Int32));
                        cmd.Parameters["v_empcode"].Direction = ParameterDirection.Output;

                        cmd.Parameters.Add(new MySqlParameter("v_id_no", txt_emp_id_no.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_nssf_no", txt_emp_nssf_no.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_pin_no", txt_emp_pin_no.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_nhif_no", txt_emp_nhif_no.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_lasc_no", txt_emp_lasc_no.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_nxt_kin_sname", txt_emp_nxt_kin_sname.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_nxt_kin_onames", txt_emp_nxt_kin_onames.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_nxt_kin_tel_no", txt_emp_nxt_kin_tel_no.Text));
                        cmd.Parameters.Add(new MySqlParameter("v_pr_code", v_pr_code));
                        cmd.Parameters.Add(new MySqlParameter("v_bnk_code", v_bnk_code));
                        cmd.Parameters.Add(new MySqlParameter("v_bbr_code", v_bbr_code));
                        cmd.Parameters.Add(new MySqlParameter("v_bank_acc_no", txt_emp_bank_acc_no.Text));
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();

                        cmd.Connection.Close();

                    }
                }

                cmd.Dispose();
                v_bool = true;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records saved successfully');", true);
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
                pnlDisplayImportData.Visible = false;

                Label emp_codeLabel = (Label)e.Item.FindControl("emp_codeLabel");
                Label emp_sht_descLabel = (Label)e.Item.FindControl("emp_sht_descLabel");
                Label emp_surnameLabel = (Label)e.Item.FindControl("emp_surnameLabel");
                Label emp_other_namesLabel = (Label)e.Item.FindControl("emp_other_namesLabel");
                Label emp_tel_no1Label = (Label)e.Item.FindControl("emp_tel_no1Label");
                Label emp_tel_no2Label = (Label)e.Item.FindControl("emp_tel_no2Label");
                Label emp_sms_noLabel = (Label)e.Item.FindControl("emp_sms_noLabel");
                Label emp_join_dateLabel = (Label)e.Item.FindControl("emp_join_dateLabel");
                Label emp_contract_dateLabel = (Label)e.Item.FindControl("emp_contract_dateLabel");
                Label emp_final_dateLabel = (Label)e.Item.FindControl("emp_final_dateLabel");
                Label emp_org_codeLabel = (Label)e.Item.FindControl("emp_org_codeLabel");
                Label emp_organizationLabel = (Label)e.Item.FindControl("emp_organizationLabel");
                Label emp_genderLabel = (Label)e.Item.FindControl("emp_genderLabel");
                Label emp_work_emailLabel = (Label)e.Item.FindControl("emp_work_emailLabel");
                Label emp_personal_emailLabel = (Label)e.Item.FindControl("emp_personal_emailLabel");
                Label emp_id_noLabel = (Label)e.Item.FindControl("emp_id_noLabel");
                Label emp_nssf_noLabel = (Label)e.Item.FindControl("emp_nssf_noLabel");
                Label emp_pin_noLabel = (Label)e.Item.FindControl("emp_pin_noLabel");
                Label emp_nhif_noLabel = (Label)e.Item.FindControl("emp_nhif_noLabel");
                Label emp_lasc_noLabel = (Label)e.Item.FindControl("emp_lasc_noLabel");
                Label emp_nxt_kin_snameLabel = (Label)e.Item.FindControl("emp_nxt_kin_snameLabel");
                Label emp_nxt_kin_onamesLabel = (Label)e.Item.FindControl("emp_nxt_kin_onamesLabel");
                Label emp_nxt_kin_tel_noLabel = (Label)e.Item.FindControl("emp_nxt_kin_tel_noLabel");
                Label emp_pr_codeLabel = (Label)e.Item.FindControl("emp_pr_codeLabel");
                Label emp_bnk_codeLabel = (Label)e.Item.FindControl("emp_bnk_codeLabel");
                Label emp_bbr_codeLabel = (Label)e.Item.FindControl("emp_bbr_codeLabel");
                Label emp_bank_acc_noLabel = (Label)e.Item.FindControl("emp_bank_acc_noLabel");

                System.Diagnostics.Debug.WriteLine("emp_join_dateLabel=====>" + emp_join_dateLabel.Text);

                txt_emp_code.Text = emp_codeLabel.Text;
                txt_emp_sht_desc.Text = emp_sht_descLabel.Text;
                txt_emp_surname.Text = emp_surnameLabel.Text;
                txt_emp_other_names.Text = emp_other_namesLabel.Text;
                txt_emp_tel_no1.Text = emp_tel_no1Label.Text;
                txt_emp_tel_no2.Text = emp_tel_no2Label.Text;
                txt_emp_sms_no.Text = emp_sms_noLabel.Text;
                txt_emp_join_date.Text = emp_join_dateLabel.Text;
                txt_emp_contract_date.Text = emp_contract_dateLabel.Text;
                txt_emp_final_date.Text = emp_final_dateLabel.Text;
                txt_emp_org_code.Text = emp_org_codeLabel.Text;
                txt_emp_organization.Text = emp_organizationLabel.Text;
                txt_emp_gender.Text = emp_genderLabel.Text;
                txt_emp_work_email.Text = emp_work_emailLabel.Text;
                txt_emp_personal_email.Text = emp_personal_emailLabel.Text;
                txt_emp_id_no.Text = emp_id_noLabel.Text;
                txt_emp_nssf_no.Text = emp_nssf_noLabel.Text;
                txt_emp_pin_no.Text = emp_pin_noLabel.Text;
                txt_emp_nhif_no.Text = emp_nhif_noLabel.Text;
                txt_emp_lasc_no.Text = emp_lasc_noLabel.Text;
                txt_emp_nxt_kin_sname.Text = emp_nxt_kin_snameLabel.Text;
                txt_emp_nxt_kin_onames.Text = emp_nxt_kin_onamesLabel.Text;
                txt_emp_nxt_kin_tel_no.Text = emp_nxt_kin_tel_noLabel.Text;
                ddl_emp_pr_code.SelectedValue = emp_pr_codeLabel.Text;
                DispalyImgFromDb();

                if (emp_genderLabel.Text == "MALE"){
                    ddlGender.SelectedIndex = 0;}
                else if (emp_genderLabel.Text == "FEMALE")
                {
                    ddlGender.SelectedIndex = 1;
                }
                else{
                    ddlGender.SelectedIndex = 0;
                }
                SqlDataSource4.DataBind();
                ddl_emp_bnk_code.DataBind();
                ddl_emp_bnk_code.SelectedValue = emp_bnk_codeLabel.Text;
                SqlDataSource5.DataBind();
                ddl_emp_bbr_code.DataBind();
                //System.Threading.Thread.Sleep(100);
                ddl_emp_bbr_code.SelectedValue = emp_bbr_codeLabel.Text;
                txt_emp_bank_acc_no.Text = emp_bank_acc_noLabel.Text;

                AttachColor(ddl_emp_bnk_code, "white", "#eeeeee");
                AttachColor(ddl_emp_bbr_code, "white", "#eeeeee");

                //System.Diagnostics.Debug.WriteLine("emp_bnk_codeLabel.Text=====>" + emp_bnk_codeLabel.Text + "  bbr_code==>" + emp_bbr_codeLabel.Text);
                //System.Diagnostics.Debug.WriteLine("ddl_emp_bnk_code.SelectedValue=====>" + ddl_emp_bnk_code.SelectedValue.ToString());
                //System.Diagnostics.Debug.WriteLine("ddl_emp_bbr_code.SelectedValue=====>" + ddl_emp_bbr_code.SelectedValue.ToString());

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

                txt_emp_code.Text = ListView1.SelectedDataKey.Value.ToString();
                //string pid = ListView1.DataKeys[e.NewSelectedIndex].Value.ToString();


                clearCtrls();
                btnAdd.Enabled = false;
                btnSave.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = true;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                ListView1.Visible = true;
                pnlDisplayImportData.Visible = false;

                System.Diagnostics.Debug.WriteLine("txtJtCode=====>" + txt_emp_code.Text);

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

        protected void txt_emp_tel_no1_TextChanged(object sender, EventArgs e)
        {
            txt_emp_tel_no1.Text = Regex.Replace(txt_emp_tel_no1.Text, "[^0-9]", "");
            //System.Diagnostics.Debug.WriteLine("Key changed =====>" + txt_emp_tel_no1.Text);
        }

        protected void txt_emp_tel_no2_TextChanged(object sender, EventArgs e)
        {
            txt_emp_tel_no2.Text = Regex.Replace(txt_emp_tel_no2.Text, "[^0-9]", "");
        }

        protected void txt_emp_sms_no_TextChanged(object sender, EventArgs e)
        {
            txt_emp_sms_no.Text = Regex.Replace(txt_emp_tel_no2.Text, "[^0-9]", "");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int v_cnt;
            clearCtrls();
            btnAdd.Enabled = true;
            btnSave.Enabled = false;
            btnSaveNAddNew.Enabled = false;
            btnDelete.Enabled = false;
            Editing.Visible = false;
            pnlEditingData.Visible = false;
            ListView1.Visible = true;
            pnlDisplayImportData.Visible = false;
            /*
            if (String.IsNullOrEmpty(txtEmpCodeSrch.Text)
                && String.IsNullOrEmpty(txtSurnameSrch.Text)
                && String.IsNullOrEmpty(txtOtherNameSrch.Text)
                && String.IsNullOrEmpty(txtOrganizationSrch.Text)
                )
            {
                txtEmpCodeSrch.Text = "%";
                txtSurnameSrch.Text = "%";
                txtOtherNameSrch.Text = "%";
                txtOrganizationSrch.Text = "%";
            }*/

            v_cnt = txtEmpCodeSrch.Text.IndexOf('%');
            if (v_cnt < 0) { txtEmpCodeSrch.Text = "%"; }
            v_cnt = txtSurnameSrch.Text.IndexOf('%');
            if (v_cnt < 0) { txtSurnameSrch.Text = "%"; }
            v_cnt = txtOtherNameSrch.Text.IndexOf('%');
            if (v_cnt < 0) { txtOtherNameSrch.Text = "%"; }
            v_cnt = txtOrganizationSrch.Text.IndexOf('%');
            if (v_cnt < 0) { txtOrganizationSrch.Text = "%"; }

            ListView1.Visible = true;
            ListView1.DataBind();
            System.Diagnostics.Debug.WriteLine("txtEmpCodeSrch =====>" + txtEmpCodeSrch.Text
                + "\n txtSurnameSrch ====>" + txtSurnameSrch.Text
                + "\n txtOtherNameSrch ====>" + txtOtherNameSrch.Text
                + "\n txtOrganizationSrch ====>" + txtOrganizationSrch.Text);
        }

        protected void ddlGender_SelectedIndexChanged(object sender, EventArgs e)
        {
            txt_emp_gender.Text = ddlGender.SelectedValue;
            //System.Diagnostics.Debug.WriteLine("ddlGender.SelectedValue =====>" + ddlGender.SelectedValue);
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            txt_emp_org_code.Text = DropDownList1.SelectedValue;
            txt_emp_organization.Text = DropDownList1.SelectedItem.Text;
        }

        protected void btnImpEmployees_Click(object sender, EventArgs e)
        {
            clearCtrls();
            btnAdd.Enabled = true;
            btnSave.Enabled = false;
            btnSaveNAddNew.Enabled = false;
            btnDelete.Enabled = false;
            Editing.Visible = false;
            pnlEditingData.Visible = false;
            ListView1.Visible = true;
            pnlDisplayImportData.Visible = true;

        }

        protected void btnUpLoad_Click(object sender, EventArgs e)
        {
            String path;
            //path = Server.MapPath(FileUpload1.FileName).ToString();
            path = "C:\\Imports\\" + FileUpload1.FileName;
            lblUploadStatus.Text = path;
            lblUploadStatus.ForeColor = System.Drawing.Color.Azure;

            if (FileUpload1.HasFile)
                try
                {
                    if (File.Exists(path))
                    {
                        System.Diagnostics.Debug.WriteLine("gggggg====>");
                        string[] data = File.ReadAllLines(path);

                        DataTable dt = new DataTable();

                        string[] col = data[0].Split(',');

                        foreach (string s in col)
                        {
                            dt.Columns.Add(s, typeof(string));
                        }
                        System.Diagnostics.Debug.WriteLine("col====>" + col.ToString());

                        for (int i = 1; i < data.Length; i++)
                        {
                            string[] row = data[i].Split(',');
                            dt.Rows.Add(row);
                            //System.Diagnostics.Debug.WriteLine("row====>"+row.ToString());
                        }
                        gvImportEmpData.DataSource = dt;
                        gvImportEmpData.DataBind();
                        gvImportEmpData.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblUploadStatus.ForeColor = System.Drawing.Color.Red;
                    lblUploadStatus.Text = "ERROR: " + ex.Message.ToString();
                }
            else
            {
                lblUploadStatus.ForeColor = System.Drawing.Color.Red;
                lblUploadStatus.Text = "You have not specified a file.";
            }
        }

        protected void btnClearData_Click(object sender, EventArgs e)
        {
            gvImportEmpData.DataSource = null;
            gvImportEmpData.DataBind();
        }

        protected void btnExportErrData_Click(object sender, EventArgs e)
        {
            DataTable dt = Create_DtFromGv(gvImportEmpData);

            Response.ContentType = "Application/x-msexcel";
            Response.AddHeader("content-disposition", "attachment;filename=test.csv");
            Response.Write(ExportToCSVFile(dt));
            Response.End();
        }
            
        protected DataTable Create_DtFromGv(GridView gv)
        {
            DataTable dt = new DataTable();

            if (gv.HeaderRow != null)
            {

                for (int i = 0; i < gv.HeaderRow.Cells.Count; i++)
                {
                    dt.Columns.Add(gv.HeaderRow.Cells[i].Text);
                }
            } 
                
            for (int j = 0; j < gv.Rows.Count; j++)
            {
                DataRow dr;
                GridViewRow row = gv.Rows[j];
                dr = dt.NewRow();
                
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    //dr[i] = row.Cells[i].Text;
                    dr[i] = row.Cells[i].Text.Replace("&nbsp;", "");
                    System.Diagnostics.Debug.WriteLine("row.Cells[i].Text==>" + row.Cells[i].Text.ToString());
                }

                dt.Rows.Add(dr);
            }
            return dt;
            
        }

        public string ExportToCSVFile(DataTable dtTable)
        {
            StringBuilder sbldr = new StringBuilder();
            if (dtTable.Columns.Count != 0)
            {
                foreach (DataColumn col in dtTable.Columns)
                {
                    sbldr.Append(col.ColumnName + ',');
                }
                sbldr.Append("\r\n");
                foreach (DataRow row in dtTable.Rows)
                {
                    foreach (DataColumn column in dtTable.Columns)
                    {
                        sbldr.Append(row[column].ToString() + ',');
                    }
                    sbldr.Append("\r\n");
                }
            }
            return sbldr.ToString();
        }

        protected void btnSaveDataToDb_Click(object sender, EventArgs e)
        {
            EmployeeDtls_Import();
        }

        protected void ddl_emp_bnk_code_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                //System.Diagnostics.Debug.WriteLine("DDL Refresh");
                ddl_emp_bbr_code.DataBind();
                ddl_emp_bbr_code.SelectedValue = "";
                AttachColor(ddl_emp_bbr_code, "white", "#eeeeee");
            }
            catch (Exception ex)
            {

                System.Diagnostics.Debug.WriteLine("DDL Refresh error..."+ex.Message.ToString());
            }

        }

        protected void AttachColor(ListControl listControl, string itemColor, string alternatingColor)
        {
            string color = itemColor;
            
            foreach (ListItem li in listControl.Items)
            {
                color = (color == itemColor) ? alternatingColor : itemColor;
                li.Attributes["style"] = " background-color: " + color;
            }
        }

        protected void lnkEmpList_Click(object sender, EventArgs e)
        {
            ReportViewer1.LocalReport.Refresh();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "DisplayReport('Information.','Records successfully deleted.');", true);
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "DisplayReport();", true);
        }

        protected void btnEmpPhoto_Click(object sender, EventArgs e)
        {
            if (imgEmpPhoto.Visible == false)
            {
                imgEmpPhoto.Visible = true;
                DispalyImgFromDb();
            }
            else
            {
                imgEmpPhoto.Visible = false;

            }
        }

        protected void btnUploadEmpPhoto_Click(object sender, EventArgs e)
        {
            String errMessage;
            try
            {
                System.Diagnostics.Debug.WriteLine("Uploading =====>");
                if (!fupEmpPhotoUpload.HasFile)
                {
                    //checking if file uploader has no file selected 
                }
                else
                {
                    int fileLength = fupEmpPhotoUpload.PostedFile.ContentLength;
                    byte[] pic = new byte[fileLength];

                    fupEmpPhotoUpload.PostedFile.InputStream.Read(pic, 0, fileLength);

                    /*
                    System.IO.MemoryStream stream1 = new System.IO.MemoryStream(pic, true);
                    System.Diagnostics.Debug.WriteLine("Uploading ttttttttt  ");
                    stream1.Write(pic, 0, pic.Length);
                    System.Diagnostics.Debug.WriteLine("Uploading xxxxxxxxx  ");
                    Bitmap m_bitmap = (Bitmap)Bitmap.FromStream(stream1, true);
                    System.Diagnostics.Debug.WriteLine("Uploading yyyyyyyy  ");
                    Response.ContentType = "Image/jpeg";
                    m_bitmap.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
                    */
 
                    string base64String = Convert.ToBase64String(pic, 0, pic.Length);
                    imgEmpPhoto.ImageUrl = "data:image/png;base64," + base64String;
                    imgEmpPhoto.Visible = true;

                    //System.Diagnostics.Debug.WriteLine("imgEmpPhoto Url=" + imgEmpPhoto.ImageUrl);
                }
            }
            catch (Exception ex)
            {
                errMessage = "Error..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);
            }
        }

        protected void btnSaveEmpPhoto_Click(object sender, EventArgs e)
        {
            String errMessage;
            String v_user;
            string v_photo_stream;

            MySqlCommand cmd = new MySqlCommand("serenehrdb.update_emp_photo", new MySqlConnection(GetConnectionString()));
            int v_txt_emp_code;
            v_user = System.Web.HttpContext.Current.User.Identity.Name;

            try
            {
                if (String.IsNullOrEmpty(txt_emp_code.Text))
                {
                    v_txt_emp_code = 0;
                }
                else
                {
                    v_txt_emp_code = Convert.ToInt32(txt_emp_code.Text);
                }
                v_photo_stream = imgEmpPhoto.ImageUrl; // MyImageToBase64(imgEmpPhoto, System.Drawing.Imaging.ImageFormat.Bmp);
                System.Diagnostics.Debug.WriteLine("imgEmpPhoto Url="+ imgEmpPhoto.ImageUrl);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_emp_code", v_txt_emp_code));
                cmd.Parameters.Add(new MySqlParameter("v_photo_stream", v_photo_stream));
                cmd.Parameters.Add(new MySqlParameter("v_photo_updatedby", v_user));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                errMessage = "Error..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);
            }
            finally {
                cmd.Dispose();           
            }
        }

        protected void DispalyImgFromDb() {
            String errMessage;
            MySqlCommand cmd = new MySqlCommand("serenehrdb.get_employee_photo", new MySqlConnection(GetConnectionString()));
                
            try {
                int v_txt_emp_code;

                if (String.IsNullOrEmpty(txt_emp_code.Text))
                {
                    v_txt_emp_code = 0;
                }
                else
                {
                    v_txt_emp_code = Convert.ToInt32(txt_emp_code.Text);
                }
                
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_emp_code", v_txt_emp_code));
                cmd.Connection.Open();
                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    try{
                        imgEmpPhoto.ImageUrl = reader.GetString(0);
                        imgEmpPhoto.Visible = true;
                    }
                    catch(Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Empty Image =====> " +ex.Message.ToString());
                        imgEmpPhoto.ImageUrl = "Empty";
                        
                    }
                }
                cmd.Connection.Close();
                cmd.Dispose();


            }
            catch (Exception ex)
            {
                errMessage = "Error..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);
            }
            finally
            {
                cmd.Dispose();
            }
            
        
        }

    }
}