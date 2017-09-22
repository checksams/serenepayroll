using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SerenePayroll
{
    public partial class About : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnPopup_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(
                this.GetType(), 
                "myScript", 
                "$.Zebra_Dialog('<strong>Zebra_Dialog</strong>, a small, compact and highly' + " +
                        "'configurable dialog box plugin for jQuery', { " +
                        "'type':     'error', " +
                        "'title':    'Error' " +
                        "});", 
                true);


        }

    }
}
