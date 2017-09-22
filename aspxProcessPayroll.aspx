<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxProcessPayroll.aspx.cs" Inherits="SerenePayroll.aspxProcessPayroll" %>

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
        function DisplayReports(title, msg) {
            var orignalstring = document.getElementById("divReports2").innerHTML;
            var newstring = orignalstring.replace("[TITLE]", "Employee Listing Report.");
            document.getElementById("divReports2").innerHTML = newstring;

            orignalstring = document.getElementById("divReports2").innerHTML;
            newstring = orignalstring.replace("[MESSAGE]", "");
            document.getElementById("divReports2").innerHTML = newstring;

            document.getElementById('divReports1').style.visibility = 'visible';
            document.getElementById('divReports1').style.display = 'inline';
            document.getElementById('divReports2').style.visibility = 'visible';
            document.getElementById('divReports2').style.display = 'inline';
        }
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
        
    <div class="page_dimmer" id="divReports1" style="display:none "> </div> 
    <div class="report_container2" id="divReports2" style="display:none "> 
    <table class="errorTableRound" cellpadding="5"> 
    <tr style="background-color:inherit;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;"> 
    <td colspan="1" style="font-weight:bolder">Pay Slips</td> 
    <td align="right">
        <input type="Button" value="X" 
        onClick="document.getElementById('divReports1').style.visibility = 'hidden'; 
        document.getElementById('divReports2').style.visibility = 'hidden'">
    </td>
    </tr> 
    <tr> 
    <td valign="top" style="height:100%"> 
        <rsweb:ReportViewer ID="rvPaySlip_001" runat="server" Font-Names="Verdana" Width="100%" Height="98%" bottom="0px"
         BackColor="#ffffff" ForeColor="#000000"
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
            <LocalReport ReportPath="Reports/rptPaySlip_001.rdlc" >
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet_rptPaySlip_001" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
    
    </td> 
    </tr>
    </table> 
    </div> 
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="SerenePayroll.serenehrdbDataSet_rptPaySlip_001TableAdapters.rpt_payslip_001TableAdapter">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtTrCode" Name="v_tr_code" 
                    PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="txtPrCode" Name="v_pr_code" 
                    PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="txtEmpCode" Name="v_emp_code" 
                    PropertyName="Text" Type="Int64" />
            </SelectParameters>
    </asp:ObjectDataSource>
    
    <table style="width:100%;  height:500px" cellpadding="0" cellspacing="0">
        <tr style="height:inherit; vertical-align:top">
            <td style="background-color:#99CCFF; width:250px; height:inherit">
                <div style="background-color:#99CCFF; height:inherit">
                    <asp:Button ID="btnHideSrch" runat="server" visible="false"
                                Text="Search Details (View/Hide)" Height="20px" 
                                onclick="btnHideSrch_Click" Width="100%" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlSearch" runat="server" Wrap="False" Visible="false" 
                        BackColor="#99CCF0">
                         
                         <table style="width:100%;" cellpadding="0" cellspacing="0" border="0">
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
                                <asp:Label ID="lblOrganizationSrch" runat="server" Text="Organization" visible="False"></asp:Label>
                            </td></tr>
                            <tr><td>
                             <asp:TextBox ID="txtOrganizationSrch" runat="server" width="210px" visible="False"
                                    AutoPostBack="True"></asp:TextBox>
                            </td></tr>
                         </table>
                    </asp:Panel>
                    <input id="btnPayRollDisplay" type="button" value="Payrolls" 
                        visible="true" Style="text-align:left; Width:100%; background-color:#7AC1C7; Height:20px"
                    />
                    <asp:Button ID="btnPayRollDisplay2" runat="server" visible="false"
                                Text="Payrolls (View/Hide)" Height="20px" Style="text-align:left"
                                Width="100%" BackColor="#7AC1C7" />
                    <br>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" visible="true" 
                        BackColor="#99CCF0" ScrollBars="Auto">
                        <asp:GridView ID="GridView1" runat="server" 
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="pr_code" 
                            DataSourceID="SqlDataSource1"
                            onselectedindexchanged="GridView1_SelectedIndexChanged"
                            onitemcommand="GridView1_ItemCommand" AllowPaging="True">

                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#A2C19E"/>
                            <PagerSettings Mode="NumericFirstLast" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="pr_code" HeaderText="Id" InsertVisible="False" Visible="true"
                                    ReadOnly="True" SortExpression="pr_code" />
                                <asp:BoundField DataField="pr_desc" HeaderText="Payroll" 
                                    SortExpression="pr_desc" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                    <br>
                    <input id="BtnReports" type="button" value="Reports" 
                        visible="true" Style="text-align:left; Width:100%; background-color:#7AC1C7; Height:20px"
                    />
                    <br>
                    <asp:LinkButton ID="lnkPaySlip" runat="server" onclick="lnkPaySlip_Click">Pay Slip</asp:LinkButton>
                    <br>
                    <asp:LinkButton ID="LinkButton1" runat="server" onclick="lnkPaySlip2_Click">Pay Slip 2</asp:LinkButton>
                </div>
            </td>
            <td style="background-color:#DDDDDD">
                &nbsp;&nbsp;</td>
            <td>
                <div  style="height:inherit; border-spacing:3px">
                    <asp:Button ID="btnPopup" runat="server" Text="Popup" 
                        onclick="btnPopup_Click" Visible="False" />

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                        SelectCommand="get_payrolls" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                                                       
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                                                       
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                        SelectCommand="get_payroll_transactions" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtPrCode" Name="v_pr_code" 
                                PropertyName="Text" Type="Int32" />
                            <asp:ControlParameter ControlID="ddlAuth" DefaultValue="NO" Name="v_status" 
                                PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                                                       
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Payroll Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCFF">  
                                                       
                            <table style="width: 100px;">
                                <tr style="visibility:collapse">
                                    <td style="width:20px">
                                        <asp:Label ID="lblPrCode" runat="server" Text="Id : "></asp:Label>   
                                        <asp:TextBox ID="txtPrCode" runat="server" Width="50px" Enabled="False"> </asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblEmpCode" runat="server" Text="emp_code : " Visible="false"></asp:Label>
                                        <asp:TextBox ID="txtEmpCode" runat="server" Width="50px" Enabled="False" Visible="false"> </asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblTrCode" runat="server" Text="tr_code : " Visible="false"></asp:Label>
                                        <asp:TextBox ID="txtTrCode" runat="server" Width="50px" Enabled="False" Visible="false"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:20px">
                                        <asp:Label ID="lblDesc" runat="server" Text="Payroll" Font-Bold="True"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMonth" runat="server" Text="Month" Font-Bold="True"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblYear" runat="server" Text="Year" Font-Bold="True"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtDesc" runat="server" Width="217px" Enabled="False" ForeColor="Black"> </asp:TextBox>                                        
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlMonth" runat="server" Width="50px" Enabled="True" ForeColor="Black">
                                            <asp:ListItem Value="01">01</asp:ListItem>
                                            <asp:ListItem Value="02">02</asp:ListItem>
                                            <asp:ListItem Value="03">03</asp:ListItem>
                                            <asp:ListItem Value="04">04</asp:ListItem>
                                            <asp:ListItem Value="05">05</asp:ListItem>
                                            <asp:ListItem Value="06">06</asp:ListItem>
                                            <asp:ListItem Value="07">07</asp:ListItem>
                                            <asp:ListItem Value="08">08</asp:ListItem>
                                            <asp:ListItem Value="09">09</asp:ListItem>
                                            <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="11">11</asp:ListItem>
                                            <asp:ListItem Value="12">12</asp:ListItem>
                                        </asp:DropDownList>                                     
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlYear" runat="server" Width="60px" Enabled="True" ForeColor="Black">
                                            <asp:ListItem Value="2010">2010</asp:ListItem>
                                            <asp:ListItem Value="2011">2011</asp:ListItem>
                                            <asp:ListItem Value="2012">2012</asp:ListItem>
                                            <asp:ListItem Value="2013">2013</asp:ListItem>
                                            <asp:ListItem Value="2014">2014</asp:ListItem>
                                            <asp:ListItem Value="2015" Selected="True">2015</asp:ListItem>
                                            <asp:ListItem Value="2016">2016</asp:ListItem>
                                            <asp:ListItem Value="2017">2017</asp:ListItem>
                                            <asp:ListItem Value="2018">2018</asp:ListItem>
                                            <asp:ListItem Value="2019">2019</asp:ListItem>
                                            <asp:ListItem Value="2020">2020</asp:ListItem>
                                        </asp:DropDownList>
                                        
                                        <asp:DropDownList ID="ddlAuth" runat="server" Width="60px" Enabled="True" 
                                            ForeColor="Black" onselectedindexchanged="ddlAuth_SelectedIndexChanged">
                                            <asp:ListItem Value="NO" Selected="True">NO</asp:ListItem>
                                            <asp:ListItem Value="YES">YES</asp:ListItem>
                                            <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:Button ID="btnPopPayroll" runat="server" onclick="btnPopPayroll_Click" 
                                            Text="Populate Payroll" />
                                        <asp:Button ID="btnProcessPayroll" runat="server" 
                                            Text="Process Payroll" onclick="btnProcessPayroll_Click" />
                                        <asp:Button ID="btnAuthPayroll" runat="server" 
                                            Text="Authorise Payroll" onclick="btnAuthPayroll_Click1" />
                                        <asp:Button ID="btnRollbackPayroll" runat="server" style="visibility:hidden"
                                            Text="Rollback Payroll" onclick="btnRollbackPayroll_Click" />
                                    </td>
                                </tr>
                            </table>
                            <br>
                            <asp:Panel ID="pnlTransactions" runat="server" Wrap="False" Visible="true" 
                                BackColor="#99CCF0" ScrollBars="Auto">
                                <asp:Label ID="lblTransactions" runat="server" Text="Payroll Transaction" 
                                Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                                
                                <asp:GridView ID="GridView3" runat="server" AllowSorting="True" 
                                    DataSourceID="SqlDataSource3"  width="800px"
                                    onselectedindexchanged="GridView3_SelectedIndexChanged" 
                                    AutoGenerateColumns="False" DataKeyNames="tr_code">
                                
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <RowStyle BackColor="#EFF3FB" />
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <Columns>
                                        <asp:CommandField ShowSelectButton="True" />
                                        <asp:BoundField DataField="tr_code" HeaderText="Id" InsertVisible="False" 
                                            ReadOnly="True" SortExpression="tr_code" />
                                        <asp:BoundField DataField="tr_type" HeaderText="Type" 
                                            SortExpression="tr_type" />
                                        <asp:BoundField DataField="tr_done_by" HeaderText="Prepared By" 
                                            SortExpression="tr_done_by" />
                                        <asp:BoundField DataField="tr_date" HeaderText="Initialization Date" 
                                            SortExpression="tr_date" DataFormatString = "{0:dd/MM/yyyy}" />
                                        <asp:BoundField DataField="tr_pr_month" HeaderText="Month" 
                                            SortExpression="tr_pr_month" />
                                        <asp:BoundField DataField="tr_pr_year" HeaderText="Year" 
                                            SortExpression="tr_pr_year" />
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <table ID="Table1" runat="server" 
                                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                                            <tr>
                                                <td>
                                                    No Payroll Transactions to display.</td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                                
                            </asp:Panel>
                            <br>
                            
                            <asp:Panel ID="pnlEmployees" runat="server" Wrap="False" Visible="true" 
                                BackColor="#99CCF0" ScrollBars="Auto">
                                <asp:Button ID="btnEmployees" runat="server" Text="Payroll Employee Listing (View/Hide)" 
                                Width="100%" Font-Bold="true" BackColor="#99DDF0"  BorderStyle="None" 
                                    style="text-align:left"
                                    onclick="btnEmployees_Click"></asp:Button>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                    ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                    SelectCommand="get_payroll_employees" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="txtPrCode" Name="v_pr_code" 
                                            PropertyName="Text" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <br>
                                <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
                                    AutoGenerateColumns="False" DataKeyNames="emp_code" 
                                    width="800px"
                                    onselectedindexchanged="GridView2_SelectedIndexChanged"
                                    OnRowCommand="GridView2_RowCommand" 
                                    OnRowDeleting="GridView2_RowDeleting" 
                                    OnRowEditing="GridView2_RowEditing" 
                                    OnRowUpdating="GridView2_RowUpdating" AllowPaging="True" 
                                    OnPageIndexChanging="GridView2_PageIndexChanging"
                                    PageSize="5">

                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <RowStyle BackColor="#EFF3FB" />
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <Columns>
                                        <asp:CommandField ShowSelectButton="True" />
                                        <asp:BoundField DataField="emp_code" HeaderText="Id" 
                                            InsertVisible="False" ReadOnly="True" SortExpression="emp_code" />
                                        <asp:BoundField DataField="emp_sht_desc" HeaderText="Employee Code" 
                                            SortExpression="emp_sht_desc" />
                                        <asp:BoundField DataField="emp_surname" HeaderText="Surname" 
                                            SortExpression="emp_surname" />
                                        <asp:BoundField DataField="emp_other_names" HeaderText="Other Names" 
                                            SortExpression="emp_other_names" />
                                        <asp:BoundField DataField="emp_id_no" HeaderText="National ID No." 
                                            SortExpression="emp_id_no" />
                                        <asp:BoundField DataField="emp_nssf_no" HeaderText="NSSF No." 
                                            SortExpression="emp_nssf_no" />
                                        <asp:BoundField DataField="emp_pin_no" HeaderText="PIN No." 
                                            SortExpression="emp_pin_no" />
                                        <asp:BoundField DataField="emp_nhif_no" HeaderText="NHIF No." 
                                            SortExpression="emp_nhif_no" />
                                        <asp:BoundField DataField="emp_lasc_no" HeaderText="LASC No." 
                                            SortExpression="emp_lasc_no" />
                                    </Columns>
                                    <EditRowStyle BackColor="#AAFFFF" />
                                    <AlternatingRowStyle BackColor="White" />
                                    <EmptyDataTemplate>
                                        <table ID="Table1" runat="server" 
                                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                                            <tr>
                                                <td>
                                                    No Employees to display.</td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </asp:Panel>
                            <br>
                            
                            <asp:Panel ID="pnlEmpPayElemets" runat="server" Wrap="False" Visible="true" 
                                BackColor="#99CCF0" ScrollBars="Auto">
                                <asp:Label ID="lblEmpPayElemets" runat="server" BackColor="#99DDF0" 
                                Text="Employee Pay Elements Listing" Width="100%" Font-Bold="true"></asp:Label>
                                
                                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                                    DataKeyNames="ppe_code" width="800px">

                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <RowStyle BackColor="#EFF3FB" />
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="ppe_code" HeaderText="Id" 
                                            InsertVisible="False" ReadOnly="True" SortExpression="ppe_code" />
                                        <asp:BoundField DataField="pel_sht_desc" HeaderText="Pay Element Code" 
                                            SortExpression="pel_sht_desc" />
                                        <asp:BoundField DataField="pel_desc" HeaderText="Pay Element" 
                                            SortExpression="pel_desc" />
                                        <asp:BoundField DataField="pel_taxable" HeaderText="Taxable" 
                                            SortExpression="pel_taxable" />
                                        <asp:BoundField DataField="pel_deduction" HeaderText="Deduction?" 
                                            SortExpression="pel_deduction" />
                                        <asp:BoundField DataField="pel_depends_on" HeaderText="Depends on" 
                                            SortExpression="pel_depends_on" Visible="false" />
                                        <asp:BoundField DataField="pel_type" HeaderText="Type" 
                                            SortExpression="pel_type" />
                                        <asp:BoundField DataField="ppe_amt" HeaderText="Amount"
                                            SortExpression="ppe_amt" ItemStyle-HorizontalAlign="Right" />
                                        <asp:BoundField DataField="ppe_ded_amt_b4_tax" HeaderText="Deduction Amt. <br>Before Tax" 
                                            HtmlEncode="False"
                                            SortExpression="ppe_ded_amt_b4_tax" ItemStyle-HorizontalAlign="Right"/>
                                        <asp:BoundField DataField="ppe_ot_hours" HeaderText="Overtime <br>Hours" 
                                            HtmlEncode="False"
                                            SortExpression="ppe_ot_hours" ItemStyle-HorizontalAlign="Right"/>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <table id="Table1" runat="server" 
                                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                                            <tr>
                                                <td>
                                                    No Pay Elements to display.</td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                    ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                    SelectCommand="get_emp_prd_pay_elements" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="txtEmpCode" Name="v_emp_code" 
                                            PropertyName="Text" Type="Int32" />
                                        <asp:ControlParameter ControlID="txtPrCode" Name="v_pr_code" 
                                            PropertyName="Text" Type="Int32" />
                                        <asp:ControlParameter ControlID="txtTrCode" Name="v_tr_code" 
                                            PropertyName="Text" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:Panel>
                            <br>
                            <br>

                    </asp:Panel>
                    </asp:Panel>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
