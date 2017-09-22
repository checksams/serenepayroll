<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxEmployeeDetails.aspx.cs" Inherits="SerenePayroll.aspxEmployeeDetails" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="JavaScript" type="text/javascript" src="/Scripts/CustomeFunctions.js">  </script>

    <script type="text/javascript">
        function MyJavaFunction(title, msg) {
            //alert("This is another function bbbbbbbbbbbbb.");
            var orignalstring = document.getElementById("msgbox").innerHTML;
            var newstring = orignalstring.replace("[TITLE]", title);
            document.getElementById("msgbox").innerHTML = newstring;

            orignalstring = document.getElementById("msgbox").innerHTML;
            newstring = orignalstring.replace("[MESSAGE]", msg);
            document.getElementById("msgbox").innerHTML = newstring;

            document.getElementById('pagedimmer').style.visibility = 'visible';
            document.getElementById('pagedimmer').style.display = 'inline';
            document.getElementById('msgbox').style.visibility = 'visible';
            document.getElementById('msgbox').style.display = 'inline';
        }

        function DisplayReport(title, msg) {
            var orignalstring = document.getElementById("Div2").innerHTML;
            var newstring = orignalstring.replace("[TITLE]", "Employee Listing Report.");
            document.getElementById("Div2").innerHTML = newstring;

            orignalstring = document.getElementById("Div2").innerHTML;
            newstring = orignalstring.replace("[MESSAGE]", "");
            document.getElementById("Div2").innerHTML = newstring;

            document.getElementById('Div1').style.visibility = 'visible';
            document.getElementById('Div1').style.display = 'inline';
            document.getElementById('Div2').style.visibility = 'visible';
            document.getElementById('Div2').style.display = 'inline';
        }

        function MyKeyPress(domItem) {
            var orignalstring = document.getElementById(domItem).innerHTML;
            var newstring;
            for (var i = 0; i < orignalstring.length; i++) {
                var myChar = orignalstring.charAt(i)
            }
            newstring = "9";
            document.getElementById("msgbox").innerHTML = newstring;
        }
    </script>
    
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.dynDateTime.min.js" type="text/javascript"></script>
    <script src="Scripts/calendar-en.min.js" type="text/javascript"></script>
    <link href="Styles/calendar-blue.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=txt_emp_final_date.ClientID %>").dynDateTime({
                showsTime: true,
                ifFormat: "%d/%m/%Y",  //"%Y/%m/%d %H:%M",
                daFormat: "%l;%M %p, %e %m, %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });  
            $("#<%=txt_emp_join_date.ClientID %>").dynDateTime({
                showsTime: true,
                ifFormat: "%d/%m/%Y",  //"%Y/%m/%d %H:%M",
                daFormat: "%l;%M %p, %e %m, %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
            $("#<%=txt_emp_contract_date.ClientID %>").dynDateTime({
                showsTime: true,
                ifFormat: "%d/%m/%Y",  //"%Y/%m/%d %H:%M",
                daFormat: "%l;%M %p, %e %m, %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
        });
    </script>

    <style type="text/css">
        .TableCSS 
        { 
            border-style:none; 
            background-color:#3BA0D8; 
            width: 100%; 
        } 

        .TableHeader 
        { 
            background-color:#66CCFF; 
            color:#0066FF; 
            font-size:large; 
            font-family:Verdana; 
            }     

        .TableData 
        { 
            background-color:#82C13E;
            color:#fff; 
            font-family:Courier New; 
            font-size:medium;  
        } 
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



    <div class="page_dimmer" id="pagedimmer" style="display:none "> </div> 
    <div class="msg_box_container" id="msgbox" style="display:none "> 
    <table class="errorTableRound" cellpadding="5"> 
    <tr style="background-color:inherit;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;"> 
    <td colspan="2" style="font-weight:bolder">[TITLE]</td> 
    </tr> 
    <tr> 
    <td>[MESSAGE]</td> 
    </tr> 
    <tr> 
    <td colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="Button" value="OK" 
        onClick="document.getElementById('pagedimmer').style.visibility = 'hidden'; 
        document.getElementById('msgbox').style.visibility = 'hidden'"></td> 
    </tr> 
    </table> 
    </div> 


    <div id="Div1" style="display:none "> </div> 
    <div class="report_container" id="Div2" style="display:none "> 
    <table class="errorTableRound" cellpadding="5"> 
    <tr style="background-color:#99DDF0;"> 
    <td colspan="2" style="font-weight:bolder"  align="left">[TITLE]</td> 
    <td colspan="2" align="right">
        <input type="Button" value="X" 
        onClick="document.getElementById('Div1').style.visibility = 'hidden'; 
        document.getElementById('Div2').style.visibility = 'hidden'"></td> 
    </tr> 
    <tr style="background-color:white;"> 
        <td>[MESSAGE]<br>    
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
       
            <rsweb:ReportViewer ID="ReportViewer1" runat="server"  Width="100%" bottom="0px"
                Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
                WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt"
                 ZoomMode="Percent" ZoomPercent="10"
                >
                 <LocalReport ReportPath="Report1.rdlc">
                     <DataSources>
                          <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />

                     </DataSources>

                 </LocalReport>

            </rsweb:ReportViewer>  
    
        </td> 
        <td>
        </td>
    </tr> 
    </table> 
    </div>    
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="SerenePayroll.serenehrdb_rptEmpListTableAdapters.get_employeesTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtEmpCodeSrch" DefaultValue="%" 
                Name="v_sht_desc" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtSurnameSrch" DefaultValue="%" 
                Name="v_surname" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtOtherNameSrch" DefaultValue="%" 
                Name="v_other_names" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtOrganizationSrch" DefaultValue="%" 
                Name="v_organization" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    

    <div  id="rptEmpList" style="display:none "> </div> 
    <div  id="rptEmpList2" style="display:none "> 
    <table class="errorTableRound" cellpadding="5"> 
    <tr style="background-color:inherit;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;"> 
    <td colspan="2" style="font-weight:bolder">Employee Listing</td> 
    </tr> 
    <tr> 
    <td> 
        <rsweb:ReportViewer ID="rvEmpList" runat="server">
            <LocalReport ReportPath="~/Reports/rptEmpList.rdlc">

            </LocalReport>

        </rsweb:ReportViewer>
    </td> 
    </tr> 
    <tr> 
    <td colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="Button" value="OK" 
        onClick="document.getElementById('rptEmpList').style.visibility = 'hidden'; 
        document.getElementById('rptEmpList2').style.visibility = 'hidden'"></td> 
    </tr> 
    </table> 
    </div> 



    <table style="width:100%;  height:500px" cellpadding="0" cellspacing="0">
        <tr style="height:inherit; vertical-align:top">
            <td style="background-color:#99CCFF; width:250px; height:inherit">
                <div style="background-color:#99CCFF; height:inherit; width:250px">
                     <table style="width:100%;">
                        <tr><td>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                onclick="btnSearch_Click" />
                        </td></tr>
                        <tr><td>
                            <asp:Label ID="lblEmpCodeSrch" runat="server" Text="Employee's Code"></asp:Label>
                        </td></tr>
                        <tr><td>
                         <asp:TextBox ID="txtEmpCodeSrch" runat="server" AutoPostBack="True"></asp:TextBox>
                        </td></tr>
                        <tr><td>
                            <asp:Label ID="lblSurnameSrch" runat="server" Text="Surname"></asp:Label>
                        </td></tr>
                        <tr><td>
                         <asp:TextBox ID="txtSurnameSrch" runat="server" width="210px" AutoPostBack="True"></asp:TextBox>
                        </td></tr>
                        <tr><td>
                            <asp:Label ID="lblOtherNameSrch" runat="server" Text="Other Names"></asp:Label>
                        </td></tr>
                        <tr><td>
                         <asp:TextBox ID="txtOtherNameSrch" runat="server" width="210px" 
                                AutoPostBack="True"></asp:TextBox>
                        </td></tr>
                        <tr><td>
                            <asp:Label ID="lblOrganizationSrch" runat="server" Text="Organization"></asp:Label>
                        </td></tr>
                        <tr><td>
                         <asp:TextBox ID="txtOrganizationSrch" runat="server" width="210px" 
                                AutoPostBack="True"></asp:TextBox>
                        </td></tr>
                        <tr><td>
                            <br>
                            <asp:Label ID="lblEmployees" runat="server" Text="Reports" 
                                Width="100%" Font-Bold="true" BackColor="#99DDF0"></asp:Label>
                        </td></tr>
                        <tr><td>
                            <asp:LinkButton ID="lnkEmpList" runat="server" onclick="lnkEmpList_Click">Employee Listing</asp:LinkButton>
                        </td></tr>
                     </table>
                </div>
            </td>
            <td>
                <div  style="height:inherit;">
                    <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click" />
                    <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" 
                        Enabled="False" />
                    <asp:Button ID="btnSaveNAddNew" runat="server" Text="Save and Add New" 
                        onclick="btnSaveNAddNew_Click" Enabled="False" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                        onclick="btnDelete_Click" Enabled="False" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                        onclick="btnCancel_Click" />
                    <asp:Button ID="btnPopup" runat="server" Text="Popup" 
                        onclick="btnPopup_Click" Visible="False" />
                    <asp:Button ID="btnImpEmployees" runat="server" Text="Import From CSV file" 
                        onclick="btnImpEmployees_Click" Visible="true" />

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        SelectCommand="get_employees" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtEmpCodeSrch" Name="v_sht_desc" 
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtSurnameSrch" Name="v_surname" 
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtOtherNameSrch" Name="v_other_names" 
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtOrganizationSrch" Name="v_organization" 
                                PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>      
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit Employee Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False"
                        BackColor="#99CCFF">                
                            <table style="width: 80%; ">
                                <tr>
                                    <td valign="top">
                                        <table style="width: 100%; ">
                                            <tr style="visibility:collapse">
                                                <td style="width:20%;">
                                                    <asp:Label ID="lbl_emp_code" runat="server" Text="ID : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_code" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_sht_desc" runat="server" Text="Employee's Code : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_sht_desc" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_surname" runat="server" Text="Surname : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_surname" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_other_names" runat="server" Text="Other Names : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_other_names" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_tel_no1" runat="server" Text="Telephone No1 : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_tel_no1" runat="server" Width="217px" Enabled="true" 
                                                        onkeypress="document.getElementById('txt_emp_tel_no1').innerHTML=this.value;"
                                                        AutoPostBack="True"
                                                        ontextchanged="txt_emp_tel_no1_TextChanged"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_tel_no2" runat="server" Text="Telophone No2 : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_tel_no2" runat="server" Width="217px" Enabled="true"
                                                        onkeypress="document.getElementById('txt_emp_tel_no2').innerHTML=this.value;"
                                                        AutoPostBack="True"
                                                        ontextchanged="txt_emp_tel_no2_TextChanged"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_sms_no" runat="server" Text="SMS No. : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_sms_no" runat="server" Width="217px" Enabled="true"
                                                        onkeypress="document.getElementById('txt_emp_sms_no').innerHTML=this.value;"
                                                        AutoPostBack="True"
                                                        ontextchanged="txt_emp_sms_no_TextChanged"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_join_date" runat="server" Text="Join Date : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_join_date" runat="server" Width="217px"> </asp:TextBox>
                                                    <img alt="Date" src="/Images/calender.png" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_contract_date" runat="server" Text="Contract date : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_contract_date" runat="server" Width="217px"> </asp:TextBox>
                                                    <img alt="Date" src="/Images/calender.png" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_final_date" runat="server" Text="Termination date : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_final_date" runat="server" Width="217px"> </asp:TextBox>
                                                    <img alt="Date" src="/Images/calender.png" />
                                                </td>
                                            </tr>
                                            <tr style="visibility:collapse">
                                                <td>
                                                    <asp:Label ID="lbl_emp_org_code" runat="server" Text="emp_org_code : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_org_code" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_organization" runat="server" Text="Employee's Organization : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_organization" runat="server" Width="217px" Enabled="true" Visible="false"> </asp:TextBox>
                                                    <asp:DropDownList ID="DropDownList1" runat="server" Width="217px" 
                                                        DataSourceID="SqlDataSource2" DataTextField="org_desc" 
                                                        DataValueField="org_code" AutoPostBack="True" 
                                                        onselectedindexchanged="DropDownList1_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                                        
                                                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                                        SelectCommand="SELECT org_code, org_desc FROM shr_organizations WHERE (org_parent_org_code = 0) OR (org_parent_org_code IS NULL)"></asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_gender" runat="server" Text="Gender : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_gender" runat="server" Width="217px" Enabled="true" Visible="false"> </asp:TextBox>
                                                    <asp:DropDownList ID="ddlGender" runat="server" AutoPostBack="True"   Width="217px"
                                                        onselectedindexchanged="ddlGender_SelectedIndexChanged">
                                                        <asp:ListItem>MALE</asp:ListItem>
                                                        <asp:ListItem>FEMALE</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_work_email" runat="server" Text="Work Email : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_work_email" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_personal_email" runat="server" Text="Personal Email : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_personal_email" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStatus" runat="server" Text="Employee Status : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmpStatus" runat="server" Width="217px" Enabled="true"  Visible="false"> </asp:TextBox>
                                                    <asp:DropDownList ID="ddlEmpStatus" runat="server" AutoPostBack="True"   Width="217px"
                                                        onselectedindexchanged="ddlEmpStatus_SelectedIndexChanged">
                                                        <asp:ListItem>ACTIVE</asp:ListItem>
                                                        <asp:ListItem>INACTIVE</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPayrollAllowed" runat="server" Text="Payroll Allowed : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPayrollAllowed" runat="server" Width="217px" Enabled="true" Visible="false"> </asp:TextBox>
                                                    <asp:DropDownList ID="ddlPayrollAllowed" runat="server" AutoPostBack="True"   Width="217px"
                                                        onselectedindexchanged="ddlPayAllowed_SelectedIndexChanged">
                                                        <asp:ListItem>YES</asp:ListItem>
                                                        <asp:ListItem>NO</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td rowspan="4">
                                                    <br>
                                                </td>
                                                <td rowspan="4">
                                                    <br>
                                                </td>
                                            </tr>
                                        </table>                                               
                                    </td>
                                    <td Style="vertical-align:top"> 
                                        <table style="width: 100%;">                                            
                                            <tr>
                                                <td  style="width:20%">
                                                    <asp:Button ID="btnEmpPhoto" runat="server" Text="View/Hide Employee's Photo. : " 
                                                        BackColor="#7AC1C7" Width="200px"
                                                        onclick="btnEmpPhoto_Click"></asp:Button>
                                                    <br>                          
                                                    <asp:Button ID="btnUploadEmpPhoto" runat="server" BackColor="#7AC1C7"
                                                        Width="200px"
                                                        onclick="btnUploadEmpPhoto_Click" Text="Preview Uploaded Photo. : " />
                                                    <br>                          
                                                    <asp:Button ID="btnSaveEmpPhoto" runat="server" BackColor="#7AC1C7"
                                                        Width="200px" 
                                                        onclick="btnSaveEmpPhoto_Click" Text="Save Employee's Photo. : " />
                                                    
                                                </td>
                                                <td>
                                                    <asp:Image ID="imgEmpPhoto" runat="server" Width="100px" Height="100px" Visible="false"
                                                    CssClass="img"
                                                     />
                                                </td>
                                            </tr>
                                            <tr><td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:FileUpload runat="server" ID="fupEmpPhotoUpload" />
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_id_no" runat="server" Text="ID No. : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_id_no" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_nssf_no" runat="server" Text="NSSF No. : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_nssf_no" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_pin_no" runat="server" Text="PIN No. : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_pin_no" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_nhif_no" runat="server" Text="NHIF No. : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_nhif_no" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_lasc_no" runat="server" Text="LASC No. : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_lasc_no" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_nxt_kin_sname" runat="server" Text="Next of Kin Surname : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_nxt_kin_sname" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_nxt_kin_onames" runat="server" Text="Next of Kin Other Names : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_nxt_kin_onames" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_nxt_kin_tel_no" runat="server" Text="Next of Kin Tel No. : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_nxt_kin_tel_no" runat="server" Width="217px" Enabled="true"
                                                    onkeypress="AllowOnlyTelNumbers(event);" > </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_pr_code" runat="server" Text="Payroll : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_emp_pr_code" runat="server" width="217px"
                                                        DataSourceID="SqlDataSource3" DataTextField="pr_desc" 
                                                        DataValueField="pr_code" AutoPostBack="True"
                                                        
                                                        >
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                                        SelectCommand="get_payrolls_ddl" SelectCommandType="StoredProcedure">
                                                    </asp:SqlDataSource>
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_bnk_code" runat="server" Text="Bank : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_emp_bnk_code" runat="server" AutoPostBack="True" 
                                                        DataSourceID="SqlDataSource4" DataTextField="bnk_name" 
                                                        DataValueField="bnk_code"  Width="217px" 
                                                        onselectedindexchanged="ddl_emp_bnk_code_SelectedIndexChanged"                                                        
                                                        >
                                                    </asp:DropDownList>                                               
                                                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                                        SelectCommand="get_bank_list" SelectCommandType="StoredProcedure">
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_bbr_code" runat="server" Text="Bank Branch: "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_emp_bbr_code" runat="server" AutoPostBack="True" 
                                                        DataSourceID="SqlDataSource5" DataTextField="bbr_name" 
                                                        DataValueField="bbr_code"  Width="217px">
                                                    </asp:DropDownList>                                               
                                                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                                        SelectCommand="get_bank_branch_list" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="ddl_emp_bnk_code" Name="v_bnk_code" 
                                                                PropertyName="SelectedValue" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_emp_bank_acc_no" runat="server" Text="Bank Account No. : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_emp_bank_acc_no" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                                </td>
                                            </tr>
                                        </table> 
                                        <div>
                                    </td>
                                </tr>                              
                            </table>    
                        
                    </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible="true"
                        BackColor="#99CCF0">&nbsp;<asp:ListView ID="ListView1" runat="server" 
                            DataSourceID="SqlDataSource1" 
                            DataKeyNames="emp_code" 
                            onselectedindexchanged="ListView1_SelectedIndexChanged"
                            onitemcommand="ListView1_ItemCommand" >
                            <LayoutTemplate> 
                                <table runat="server"> 
                                    <tr runat="server"> 
                                        <td runat="server">
                                            <table ID="itemPlaceholderContainer" runat="server" border="1" 
                                                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                                <tr runat="server" style="background-color: #E0FFFF;color: #333333;">
                                                    <th runat="server">
                                                        Select</th>
                                                    <th runat="server">
                                                        ID</th>
                                                    <th runat="server">
                                                        Code</th>
                                                    <th runat="server">
                                                        Surname</th>
                                                    <th runat="server">
                                                        Other Names</th>
                                                    <th runat="server">
                                                        Telephone No. 1</th>
                                                    <th runat="server">
                                                        Telephone No. 2</th>
                                                    <th runat="server">
                                                        SMS No.</th>
                                                    <th runat="server">
                                                        Join Date</th>
                                                    <th runat="server">
                                                        Contract Date</th>
                                                    <th runat="server" style="visibility:collapse; width:0px">
                                                        </th>
                                                    <th runat="server">
                                                        Org. ID</th>
                                                    <th runat="server">
                                                        Organization</th>
                                                    <th runat="server">
                                                        Gender</th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th id="Th1" runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th id="Th2" runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th id="Th3" runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th id="Th4" runat="server" style="visibility:collapse">
                                                        </th>
                                                    <th id="Th5" runat="server" style="visibility:collapse">
                                                        </th>
                                                </tr>
                                                <tr ID="itemPlaceholder" runat="server">
                                                </tr>
                                            </table>
                                        </td> 
                                    </tr> 
                                    <tr runat="server"> 
                                        <td runat="server" 
                                            style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF">
                                            <asp:DataPager ID="DataPager1" runat="server" PageSize="20">
                                                <Fields>
                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                                        ShowLastPageButton="True" />
                                                </Fields>
                                                
                                            </asp:DataPager>
                                        </td>
                                    </tr> 
                                </table> 
                            </LayoutTemplate>      
                            <InsertItemTemplate>
                                <tr style="">
                                    <td>
                                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                                            Text="Insert" />
                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                            Text="Clear" />
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:TextBox ID="emp_sht_descTextBox" runat="server" 
                                            Text='<%# Bind("emp_sht_desc") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_surnameTextBox" runat="server" 
                                            Text='<%# Bind("emp_surname") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_other_namesTextBox" runat="server" 
                                            Text='<%# Bind("emp_other_names") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_tel_no1TextBox" runat="server" 
                                            Text='<%# Bind("emp_tel_no1") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_tel_no2TextBox" runat="server" 
                                            Text='<%# Bind("emp_tel_no2") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_sms_noTextBox" runat="server" 
                                            Text='<%# Bind("emp_sms_no") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_join_dateTextBox" runat="server" 
                                            Text='<%# Bind("emp_join_date") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_contract_dateTextBox" runat="server" 
                                            Text='<%# Bind("emp_contract_date") %>' />
                                    </td>
                                    <td style="visibility:collapse; width:0px">
                                        <asp:TextBox ID="emp_final_dateTextBox" runat="server"
                                            Text='<%# Bind("emp_final_date") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_org_codeTextBox" runat="server" 
                                            Text='<%# Bind("emp_org_code") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_organizationTextBox" runat="server" 
                                            Text='<%# Bind("emp_organization") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_genderTextBox" runat="server" 
                                            Text='<%# Bind("emp_gender") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_work_emailTextBox" runat="server" 
                                            Text='<%# Bind("emp_work_email") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_personal_emailTextBox" runat="server" 
                                            Text='<%# Bind("emp_personal_email") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_id_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_id_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nssf_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nssf_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_pin_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_pin_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nhif_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nhif_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_lasc_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_lasc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nxt_kin_snameTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nxt_kin_sname") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nxt_kin_onamesTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nxt_kin_onames") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nxt_kin_tel_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nxt_kin_tel_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_pr_codeTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_pr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_bnk_codeTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_bnk_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_bbr_codeTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_bbr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_bank_acc_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_bank_acc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_status" runat="server"  width="0px"
                                            Text='<%# Bind("emp_status") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_payroll_allowed" runat="server"  width="0px"
                                            Text='<%# Bind("emp_payroll_allowed") %>' />
                                    </td>
                                </tr>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <tr style="background-color: #E0FFFF;color: #333333;">
                                    <td>
                                        <asp:LinkButton ID="lnkSelect" Text="Select" CommandName="Select" runat="server" 
                                        CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton> 
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_codeLabel" runat="server" Text='<%# Eval("emp_code") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_sht_descLabel" runat="server" 
                                            Text='<%# Eval("emp_sht_desc") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_surnameLabel" runat="server" 
                                            Text='<%# Eval("emp_surname") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_other_namesLabel" runat="server" 
                                            Text='<%# Eval("emp_other_names") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_tel_no1Label" runat="server" 
                                            Text='<%# Eval("emp_tel_no1") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_tel_no2Label" runat="server" 
                                            Text='<%# Eval("emp_tel_no2") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_sms_noLabel" runat="server" 
                                            Text='<%# Eval("emp_sms_no") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_join_dateLabel" runat="server" 
                                            Text='<%# Eval("emp_join_date") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_contract_dateLabel" runat="server" 
                                            Text='<%# Eval("emp_contract_date") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_final_dateLabel" runat="server" 
                                            Text='<%# Eval("emp_final_date") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_org_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_org_code") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_organizationLabel" runat="server" 
                                            Text='<%# Eval("emp_organization") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_genderLabel" runat="server" 
                                            Text='<%# Eval("emp_gender") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_work_emailLabel" runat="server" 
                                            Text='<%# Eval("emp_work_email") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_personal_emailLabel" runat="server" 
                                            Text='<%# Eval("emp_personal_email") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_id_noLabel" runat="server" 
                                            Text='<%# Eval("emp_id_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nssf_noLabel" runat="server" 
                                            Text='<%# Eval("emp_nssf_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_pin_noLabel" runat="server" 
                                            Text='<%# Eval("emp_pin_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nhif_noLabel" runat="server" 
                                            Text='<%# Eval("emp_nhif_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_lasc_noLabel" runat="server" 
                                            Text='<%# Eval("emp_lasc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nxt_kin_snameLabel" runat="server" 
                                            Text='<%# Eval("emp_nxt_kin_sname") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nxt_kin_onamesLabel" runat="server" 
                                            Text='<%# Eval("emp_nxt_kin_onames") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nxt_kin_tel_noLabel" runat="server" 
                                            Text='<%# Eval("emp_nxt_kin_tel_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_pr_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_pr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_bnk_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_bnk_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_bbr_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_bbr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_bank_acc_noLabel" runat="server" 
                                            Text='<%# Eval("emp_bank_acc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_statusLabel" runat="server" 
                                            Text='<%# Eval("emp_status") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_payroll_allowedLabel" runat="server" 
                                            Text='<%# Eval("emp_payroll_allowed") %>' />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <SelectedItemTemplate>
                                <tr style="background-color: #E2DED6; color: #333333; font-weight: bold;">
                                    <td> 
                                        <asp:LinkButton ID="lnkSelect" Text="Select" CommandName="Select" runat="server"
                                            CommandArgument='<%# Container.DataItemIndex %>' ForeColor="White">
                                        </asp:LinkButton>
                                    </td> 
                                    <td>
                                        <asp:Label ID="emp_codeLabel" runat="server" Text='<%# Eval("emp_code") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_sht_descLabel" runat="server" 
                                            Text='<%# Eval("emp_sht_desc") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_surnameLabel" runat="server" 
                                            Text='<%# Eval("emp_surname") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_other_namesLabel" runat="server" 
                                            Text='<%# Eval("emp_other_names") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_tel_no1Label" runat="server" 
                                            Text='<%# Eval("emp_tel_no1") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_tel_no2Label" runat="server" 
                                            Text='<%# Eval("emp_tel_no2") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_sms_noLabel" runat="server" 
                                            Text='<%# Eval("emp_sms_no") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_join_dateLabel" runat="server" 
                                            Text='<%# Eval("emp_join_date") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_contract_dateLabel" runat="server" 
                                            Text='<%# Eval("emp_contract_date") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_final_dateLabel" runat="server" 
                                            Text='<%# Eval("emp_final_date") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_org_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_org_code") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_organizationLabel" runat="server" 
                                            Text='<%# Eval("emp_organization") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_genderLabel" runat="server" 
                                            Text='<%# Eval("emp_gender") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_work_emailLabel" runat="server" 
                                            Text='<%# Eval("emp_work_email") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_personal_emailLabel" runat="server" 
                                            Text='<%# Eval("emp_personal_email") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_id_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_id_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nssf_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nssf_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_pin_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_pin_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nhif_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nhif_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_lasc_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_lasc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nxt_kin_snameLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nxt_kin_sname") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nxt_kin_onamesLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nxt_kin_onames") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nxt_kin_tel_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nxt_kin_tel_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_pr_codeLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_pr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_bnk_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_bnk_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_bbr_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_bbr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_bank_acc_noLabel" runat="server" 
                                            Text='<%# Eval("emp_bank_acc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_statusLabel" runat="server" 
                                            Text='<%# Eval("emp_status") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_payroll_allowedLabel" runat="server" 
                                            Text='<%# Eval("emp_payroll_allowed") %>' />
                                    </td>
                                </tr>
                            </SelectedItemTemplate>
                            <AlternatingItemTemplate>
                                <tr style="background-color: #FFFFFF;color: #284775;">
                                    <td> 
                                        <asp:LinkButton ID="lnkSelect" Text="Select" CommandName="Select" runat="server"
                                            CommandArgument='<%# Container.DataItemIndex %>' ForeColor="White">
                                        </asp:LinkButton>
                                    </td> 
                                    <td>
                                        <asp:Label ID="emp_codeLabel" runat="server" Text='<%# Eval("emp_code") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_sht_descLabel" runat="server" 
                                            Text='<%# Eval("emp_sht_desc") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_surnameLabel" runat="server" 
                                            Text='<%# Eval("emp_surname") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_other_namesLabel" runat="server" 
                                            Text='<%# Eval("emp_other_names") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_tel_no1Label" runat="server" 
                                            Text='<%# Eval("emp_tel_no1") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_tel_no2Label" runat="server" 
                                            Text='<%# Eval("emp_tel_no2") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_sms_noLabel" runat="server" 
                                            Text='<%# Eval("emp_sms_no") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_join_dateLabel" runat="server" 
                                            Text='<%# Eval("emp_join_date") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_contract_dateLabel" runat="server" 
                                            Text='<%# Eval("emp_contract_date") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_final_dateLabel" runat="server" 
                                            Text='<%# Eval("emp_final_date") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_org_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_org_code") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_organizationLabel" runat="server" 
                                            Text='<%# Eval("emp_organization") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_genderLabel" runat="server" 
                                            Text='<%# Eval("emp_gender") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_work_emailLabel" runat="server" 
                                            Text='<%# Eval("emp_work_email") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_personal_emailLabel" runat="server" 
                                            Text='<%# Eval("emp_personal_email") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_id_noLabel" runat="server" width="0px"
                                            Text='<%# Eval("emp_id_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nssf_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nssf_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_pin_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_pin_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nhif_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nhif_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_lasc_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_lasc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nxt_kin_snameLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nxt_kin_sname") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nxt_kin_onamesLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nxt_kin_onames") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_nxt_kin_tel_noLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_nxt_kin_tel_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_pr_codeLabel" runat="server"  width="0px"
                                            Text='<%# Eval("emp_pr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_bnk_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_bnk_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_bbr_codeLabel" runat="server" 
                                            Text='<%# Eval("emp_bbr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_bank_acc_noLabel" runat="server" 
                                            Text='<%# Eval("emp_bank_acc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_statusLabel" runat="server" 
                                            Text='<%# Eval("emp_status") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:Label ID="emp_payroll_allowedLabel" runat="server" 
                                            Text='<%# Eval("emp_payroll_allowed") %>' />
                                    </td>
                                </tr>
                            </AlternatingItemTemplate>
                            <EditItemTemplate>
                                <tr style="background-color: #999999;">
                                    <td> 
                                        <asp:LinkButton ID="lnkSelect" Text="Select" CommandName="Select" runat="server"
                                            CommandArgument='<%# Container.DataItemIndex %>' ForeColor="White">
                                        </asp:LinkButton>
                                    </td> 
                                    <td>
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                                            Text="Update" />
                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                            Text="Cancel" />
                                    </td>
                                    <td>
                                        <asp:Label ID="emp_codeLabel1" runat="server" Text='<%# Eval("emp_code") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_sht_descTextBox" runat="server" 
                                            Text='<%# Bind("emp_sht_desc") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_surnameTextBox" runat="server" 
                                            Text='<%# Bind("emp_surname") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_other_namesTextBox" runat="server" 
                                            Text='<%# Bind("emp_other_names") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_tel_no1TextBox" runat="server" 
                                            Text='<%# Bind("emp_tel_no1") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_tel_no2TextBox" runat="server" 
                                            Text='<%# Bind("emp_tel_no2") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_sms_noTextBox" runat="server" 
                                            Text='<%# Bind("emp_sms_no") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_join_dateTextBox" runat="server" 
                                            Text='<%# Bind("emp_join_date") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_contract_dateTextBox" runat="server" 
                                            Text='<%# Bind("emp_contract_date") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_final_dateTextBox" runat="server" 
                                            Text='<%# Bind("emp_final_date") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_org_codeTextBox" runat="server" 
                                            Text='<%# Bind("emp_org_code") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_organizationTextBox" runat="server" 
                                            Text='<%# Bind("emp_organization") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_genderTextBox" runat="server" 
                                            Text='<%# Bind("emp_gender") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_work_emailTextBox" runat="server" 
                                            Text='<%# Bind("emp_work_email") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emp_personal_emailTextBox" runat="server" 
                                            Text='<%# Bind("emp_personal_email") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_id_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_id_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nssf_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nssf_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_pin_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_pin_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nhif_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nhif_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_lasc_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_lasc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nxt_kin_snameTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nxt_kin_sname") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nxt_kin_onamesTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nxt_kin_onames") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_nxt_kin_tel_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_nxt_kin_tel_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_pr_codeTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_pr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_bnk_codeTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_bnk_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_bbr_codeTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_bbr_code") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_bank_acc_noTextBox" runat="server"  width="0px"
                                            Text='<%# Bind("emp_bank_acc_no") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_status" runat="server"  width="0px"
                                            Text='<%# Bind("emp_status") %>' />
                                    </td>
                                    <td style="visibility:collapse">
                                        <asp:TextBox ID="emp_payroll_allowed" runat="server"  width="0px"
                                            Text='<%# Bind("emp_payroll_allowed") %>' />
                                    </td>
                                </tr>
                            </EditItemTemplate>
                            <EmptyDataTemplate>
                                <table runat="server" 
                                    style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                                    <tr>
                                        <td>
                                            No data was returned.</td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>



                    </asp:Panel>
                    <asp:Panel ID="pnlDisplayImportData" runat="server" Wrap="False" Visible="False"
                        BackColor="#99CCFF">   
                        <table id="tblImportEmp"  runat="server" width="100%" visible="true">
                        <tr>
                            <td>                                    
                                <asp:FileUpload ID="FileUpload1" runat="server"/> 
                                <asp:Button ID="btnUpLoad" runat="server" Text="Upload" 
                                    onclick="btnUpLoad_Click" />
                                <asp:Button ID="btnClearData" runat="server" Text="Clear Data" 
                                    onclick="btnClearData_Click" />
                                <asp:Button ID="btnSaveDataToDb" runat="server" Text="Save Data to Database" 
                                    onclick="btnSaveDataToDb_Click" />
                                <asp:Button ID="btnExportErrData" runat="server" 
                                    Text="Export Unloaded Data to CSV file" onclick="btnExportErrData_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>                                    
                                <asp:Label ID="lblUploadStatus" runat="server" Text="Upload Status"></asp:Label>
                            </td>
                        </tr>
                        </table>
                        <asp:GridView ID="gvImportEmpData" runat="server" CellPadding="4" ForeColor="#333333"
                            GridLines="None">
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                    </asp:Panel>       
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
