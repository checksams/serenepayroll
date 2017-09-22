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
    [DataObject(true)]
    public partial class aspxOrganization : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                DataTable dt = this.GetData("SELECT org_code, org_desc FROM serenehrdb.shr_organizations where org_parent_org_code is null or org_parent_org_code = 0");
                this.PopulateTreeView(dt, 0, null);
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
            //errMsg("Enter the correct name.");
            //showPopup("Here we go ...");
        }

        protected void errMsg(string v_msg, string v_title= "Information")
        {
            //One way to raise errors
            //string script = "<script type=\"text/javascript\">alert('" + v_msg + "');</script>";
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script);

            //A beter way
            //string title = "Information";
            //string msg = "This is not an error man.";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('" + v_title + "','" + v_msg + "');", true);
        }

        protected void showPopup(string v_msg)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup('" + v_msg + "');", true);
        }

        protected void Popup_Click(object sender, EventArgs e)
        {
            string title = "Information";
            string msg = "This is not an error man.";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('" + title + "','" + msg + "');", true);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            btnAdd.Enabled = false;
            btnSaveOrg.Enabled = true;
            btnSaveNAddNew.Enabled = true;
            btnDelete.Enabled = false;
            Editing.Visible = true;
            pnlEditingData.Visible = true;
            GridView1.Visible = false;
            clearCtrls();
        }

        protected void btnSaveOrg_Click(object sender, EventArgs e)
        {
            if (updateOrg() == true)
            {
                btnAdd.Enabled = true;
                btnSaveOrg.Enabled = false;
                btnSaveNAddNew.Enabled = false; 
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                GridView1.Visible = true;
                GridView1.DataBind();

                clearCtrls();
            }
            else {
                string title = "Information";
                string msg = "This is not an error man.";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('" + title + "','" + msg + "');", true);
            }

        }

        protected void btnSaveNAddNew_Click(object sender, EventArgs e)
        {
            if (updateOrg() == true)
            {
                btnAdd.Enabled = false;
                btnSaveOrg.Enabled = true;
                btnSaveNAddNew.Enabled = true;
                btnDelete.Enabled = false;
                Editing.Visible = true;
                pnlEditingData.Visible = true;
                GridView1.Visible = false;
                GridView1.DataBind();

                clearCtrls();
            }
        }
        protected void clearCtrls()
        {
            txtOrgCode.Text = "";
            txtShtDesc.Text = "";
            txtDesc.Text = "";
            txtPostalAddress.Text = "";
            txtPhysicalAddress.Text = "";
            txtType.Text = "";
            txtParentOrgCode.Text = "";
            txtParentShtDesc.Text = "";
            txtParentOrg.Text = "";
            txtWef.Text = "";
            txtWet.Text = "";
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int v_txtOrgCode;
            String errMessage;
            try {
                if (String.IsNullOrEmpty(txtOrgCode.Text))
                {
                    v_txtOrgCode = 0;
                }
                else
                {
                    v_txtOrgCode = Convert.ToInt32(txtOrgCode.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.org_delete", new MySqlConnection(GetConnectionString()));

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_org_code", v_txtOrgCode));
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();

                btnAdd.Enabled = true;
                btnSaveOrg.Enabled = false;
                btnSaveNAddNew.Enabled = false;
                btnDelete.Enabled = false;
                Editing.Visible = false;
                pnlEditingData.Visible = false;
                GridView1.Visible = true;
                GridView1.DataBind();
                clearCtrls();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records successfully deleted.');", true);
            
            }
            catch(Exception ex){
                System.Diagnostics.Debug.WriteLine("Error =====>" + ex.Message.ToString());

                errMessage = "Error deleting record ..." + ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                //errMsg(errMessage, "Error.");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                
            }
        }
        protected void btnCancelSaving_Click(object sender, EventArgs e)
        {
            btnAdd.Enabled = true;
            btnSaveOrg.Enabled = false;
            btnSaveNAddNew.Enabled = false;
            btnDelete.Enabled = false;
            Editing.Visible = false;
            pnlEditingData.Visible = false;
            GridView1.Visible = true;

            clearCtrls();
        }

        public static string GetConnectionString()
        {

            return ConfigurationManager.ConnectionStrings

                ["serenehrdbConnectionString"].ConnectionString;

        }

        [DataObjectMethod(DataObjectMethodType.Insert)]
        private Boolean updateOrg()
        {
            int v_orgcode;
            int v_ParentOrgCode;
            int v_txtOrgCode;
            string errMessage;
            Boolean v_bool;
            try{
                if (String.IsNullOrEmpty(txtParentOrgCode.Text))
                {
                    v_ParentOrgCode = 0;
                }
                else
                {
                   v_ParentOrgCode = Convert.ToInt32(txtParentOrgCode.Text);
                }
                if (String.IsNullOrEmpty(txtOrgCode.Text))
                {
                    v_txtOrgCode = 0;
                }
                else
                {
                    v_txtOrgCode = Convert.ToInt32(txtOrgCode.Text);
                }
                MySqlCommand cmd = new MySqlCommand("serenehrdb.update_org", new MySqlConnection(GetConnectionString()));

                System.Diagnostics.Debug.WriteLine("txtWef====>" + txtWef.Text
                    + "\n txtWet====>" + txtWet.Text);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("v_org_code", v_txtOrgCode));
                cmd.Parameters["v_org_code"].Direction = ParameterDirection.Input;
                cmd.Parameters.Add(new MySqlParameter("v_sht_desc", txtShtDesc.Text));
                cmd.Parameters.Add(new MySqlParameter("v_desc", txtDesc.Text));
                cmd.Parameters.Add(new MySqlParameter("v_postal_address", txtPostalAddress.Text));
                cmd.Parameters.Add(new MySqlParameter("v_physical_address", txtPhysicalAddress.Text));
                cmd.Parameters.Add(new MySqlParameter("v_type", null));
                cmd.Parameters.Add(new MySqlParameter("v_parent_org_code", v_ParentOrgCode));
                cmd.Parameters.Add(new MySqlParameter("v_wef", txtWef.Text));
                cmd.Parameters.Add(new MySqlParameter("v_wet", txtWet.Text));
                cmd.Parameters.Add(new MySqlParameter("v_orgcode", MySqlDbType.Int32));
                cmd.Parameters["v_orgcode"].Direction = ParameterDirection.Output;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                v_orgcode = (int)cmd.Parameters["v_orgcode"].Value;
                System.Diagnostics.Debug.WriteLine("v_orgcode=====>" + v_orgcode + "  v_txtOrgCode====> " + v_txtOrgCode
                    + "\n v_ParentOrgCode=" + v_ParentOrgCode
                    + "\n txtWef=" + txtWef.Text
                    + "\n txtWet=" + txtWef.Text);
                v_bool = true;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Information.','Records saved successfully');", true);
            }
            catch (Exception ex)
            {
                v_bool = false;
                errMessage = "Error saving record ..."+ ex.Message.ToString();
                errMessage = errMessage.ToString().Replace("'", "");
                //errMsg(errMessage, "Error.");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MyJavaFunction('Error.','" + errMessage + "');", true);
                System.Diagnostics.Debug.WriteLine("ERROR =====>" + ex.Message + "..\n " + errMessage);

                //Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowMessage", string.Format("<script type='text/javascript'>MyJavaFunction('{0}')</script>", errMessage));
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Error", string.Format("<script type='text/javascript'>alert('{0}')</script>", ex.Message.ToString()));
            
            
            }
            return v_bool;
        }



        /// <summary>
        /// /////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="MessageItem"></param>
        [DataObjectMethod(DataObjectMethodType.Insert)]
        public static void InsertMessage(MessageItem MessageItem)
        {

            MySqlCommand cmd = new MySqlCommand("InsertMessage", new MySqlConnection(GetConnectionString()));

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new MySqlParameter("param3", MessageItem.Message));
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();

        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public static List<MessageItem> GetMessages()
        {

            MySqlCommand cmd = new MySqlCommand("ShowAll", new MySqlConnection(GetConnectionString()));

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection.Open();
            MySqlDataReader dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            List<MessageItem> MessageItemlist = new List<MessageItem>();

            while (dr.Read())
            {
                MessageItem MessageItem = new MessageItem();
                MessageItem.Entry_ID = Convert.ToInt32(dr["Entry_ID"]);
                MessageItem.Message = Convert.ToString(dr["Message"]);
                MessageItemlist.Add(MessageItem);

            }

            dr.Close();

            return MessageItemlist;

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

            string name = GridView1.SelectedRow.Cells[2].Text;
            txtOrgCode.Text = GridView1.SelectedRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
            txtShtDesc.Text = GridView1.SelectedRow.Cells[2].Text.Trim().Replace("&nbsp;", "");
            txtDesc.Text = GridView1.SelectedRow.Cells[3].Text.Trim().Replace("&nbsp;","");
            txtPostalAddress.Text = GridView1.SelectedRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
            txtPhysicalAddress.Text = GridView1.SelectedRow.Cells[5].Text.Trim().Replace("&nbsp;", "");
            txtType.Text = GridView1.SelectedRow.Cells[6].Text.Trim().Replace("&nbsp;", "");
            txtParentOrgCode.Text = GridView1.SelectedRow.Cells[7].Text.Trim().Replace("&nbsp;", "");
            txtParentShtDesc.Text = GridView1.SelectedRow.Cells[8].Text.Trim().Replace("&nbsp;", "");
            txtParentOrg.Text = GridView1.SelectedRow.Cells[9].Text.Trim().Replace("&nbsp;", "");
            txtWef.Text = GridView1.SelectedRow.Cells[10].Text.Trim().Replace("&nbsp;", "");
            txtWet.Text = GridView1.SelectedRow.Cells[11].Text.Trim().Replace("&nbsp;", "");
            System.Diagnostics.Debug.WriteLine("Last Name======>" + name +
                "\nCell0=" + GridView1.SelectedRow.Cells[0].Text +
                "\nCell1=" + GridView1.SelectedRow.Cells[1].Text +
                "\nCell8=" + GridView1.SelectedRow.Cells[8].Text +
                "\nCell9=" + GridView1.SelectedRow.Cells[9].Text);

            btnAdd.Enabled = false;
            btnSaveOrg.Enabled = true;
            btnSaveNAddNew.Enabled = true;
            btnDelete.Enabled = true;
            Editing.Visible = true;
            pnlEditingData.Visible = true;
            GridView1.Visible = false;
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtParentOrgCode.Text = DropDownList1.SelectedValue;
            txtParentOrg.Text = DropDownList1.SelectedItem.Text;
            System.Diagnostics.Debug.WriteLine("txtParentOrgCode===>"+txtParentOrgCode.Text +
                    "txtParentOrg====>" + txtParentOrg.Text);
        }


        //binding treeview methods from here ======================================
        //=========================================================================
        private DataTable GetData(string query)
        {
            DataTable dt = new DataTable();
            MySqlCommand cmd = new MySqlCommand(query, new MySqlConnection(GetConnectionString()));

            MySqlDataAdapter sda = new MySqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            cmd.Connection.Close();

            return dt;

            /* Sql server version
            string constr = new String this.GetConnectionString();
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);
                    }
                }
                return dt;
            }*/
        }

        private void PopulateTreeView(DataTable dtParent, int parentId, TreeNode treeNode)
        {
            foreach (DataRow row in dtParent.Rows)
            {
                TreeNode child = new TreeNode
                {
                    Text = row["org_desc"].ToString(),
                    Value = row["org_code"].ToString()
                };
                if (parentId == 0)
                {
                    TreeView1.Nodes.Add(child);
                    DataTable dtChild = this.GetData("SELECT org_code, org_desc FROM serenehrdb.shr_organizations WHERE org_parent_org_code = " + child.Value);
                    PopulateTreeView(dtChild, int.Parse(child.Value), child);
                }
                else
                {
                    treeNode.ChildNodes.Add(child);
                    DataTable dtChild = this.GetData("SELECT org_code, org_desc FROM serenehrdb.shr_organizations WHERE org_parent_org_code = " + child.Value);
                    PopulateTreeView(dtChild, int.Parse(child.Value), child);
                }
            }
        }

        //End populate tree view methods=============================================
        //===========================================================================

        public DateTime GetDate(String strDate) {
            DateTime dt = DateTime.ParseExact(strDate, "dd/MM/YYYY", null);
            /*if (DateTime.TryParseExact("24/01/2013",
                                        "dd/MM/yyyy",
                                        CultureInfo.InvariantCulture,
                                        DateTimeStyles.None,
                out dt))
            {
                //valid date
            }
            else
            {
                //invalid date
            }*/
            return dt;
        }

        protected void btnDtSave_Click(object sender, EventArgs e)
        {
            DateTime dob = DateTime.Parse(Request.Form[txtWef.UniqueID]);
        }

        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("tree====>"+TreeView1.SelectedNode.Value.ToString());
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.Cells[1].Text == TreeView1.SelectedNode.Value.ToString())
                {
                    GridView1.SelectRow(row.RowIndex);
                    System.Diagnostics.Debug.WriteLine("tree====>" + row.Cells[0].Text + " -- " + row.Cells[1].Text + " -- " + row.Cells[2].Text + " RowIndex=" + row.RowIndex.ToString());
                }
            }

            
            

        }

    }
}