<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxPayrolls.aspx.cs" Inherits="SerenePayroll.aspxPayrolls" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

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
    </script>
    
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.dynDateTime.min.js" type="text/javascript"></script>
    <script src="Scripts/calendar-en.min.js" type="text/javascript"></script>
    <link href="Styles/calendar-blue.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=txtWef.ClientID %>").dynDateTime({
                showsTime: true,
                ifFormat: "%d/%m/%Y",  //"%Y/%m/%d %H:%M",
                daFormat: "%l;%M %p, %e %m, %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
            $("#<%=txtWet.ClientID %>").dynDateTime({
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

    <table style="width:100%;  height:500px" cellpadding="0" cellspacing="0">
        <tr style="height:inherit; vertical-align:top">
            <td style="background-color:#99CCFF; width:250px; height:inherit">
                <div style="background-color:#99CCFF; height:inherit">
                


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

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                        SelectCommand="get_payrolls" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                    
                                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit Payroll Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCFF">                        
                            <table style="width: 100%;">
                                <tr style="visibility:collapse">
                                    <td style="width:20%">
                                        <asp:Label ID="lblJtCode" runat="server" Text="JobID : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPrCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblShtDesc" runat="server" Text="Payroll Short Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtShtDesc" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDesc" runat="server" Text="Payroll Full Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDesc" runat="server" Width="400" Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblOrg" runat="server" Text="Organization : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlOrg" runat="server" Width="217px"
                                            DataSourceID="SqlDataSource2" DataTextField="org_desc" 
                                            DataValueField="org_code">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                            
                                            ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                            SelectCommand="SELECT org_code, org_desc FROM shr_organizations WHERE (org_parent_org_code IS NULL) OR (org_parent_org_code = 0)"></asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblWef" runat="server" Text="W.E.F. : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtWef" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                        <img alt="Date" src="/Images/calender.png" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblWet" runat="server" Text="W.E.T. : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtWet" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                        <img alt="Date" src="/Images/calender.png" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblWeekDays" runat="server" Text="Week Days" width="100%" 
                                            Font-Bold="True"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblWorkingHours" runat="server" Text="Working Hours" 
                                            width="100%" Font-Bold="True"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDay1Hrs" runat="server" Text="Sunday : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDay1Hrs" runat="server" Width="100px" Enabled="true"> </asp:TextBox>                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDay2Hrs" runat="server" Text="Monday : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDay2Hrs" runat="server" Width="100px" Enabled="true"> </asp:TextBox>                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDay3Hrs" runat="server" Text="Tuesday : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDay3Hrs" runat="server" Width="100px" Enabled="true"> </asp:TextBox>                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDay4Hrs" runat="server" Text="Wednesday : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDay4Hrs" runat="server" Width="100px" Enabled="true"> </asp:TextBox>                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDay5Hrs" runat="server" Text="Thursday : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDay5Hrs" runat="server" Width="100px" Enabled="true"> </asp:TextBox>                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDay6Hrs" runat="server" Text="Friday : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDay6Hrs" runat="server" Width="100px" Enabled="true"> </asp:TextBox>                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDay7Hrs" runat="server" Text="Saturday : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDay7Hrs" runat="server" Width="100px" Enabled="true"> </asp:TextBox>                                        
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible=true 
                        BackColor="#99CCF0">
                        <asp:GridView ID="GridView1" runat="server" 
                            AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                            DataKeyNames="pr_code" DataSourceID="SqlDataSource1"
                            onselectedindexchanged="GridView1_SelectedIndexChanged"
                            onitemcommand="GridView1_ItemCommand">
                            
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="pr_code" HeaderText="Id" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="pr_code" />
                                <asp:BoundField DataField="pr_sht_desc" HeaderText="Short Description" 
                                    SortExpression="pr_sht_desc" />
                                <asp:BoundField DataField="pr_desc" HeaderText="Payroll Description" 
                                    SortExpression="pr_desc" />
                                <asp:BoundField DataField="pr_org_code" HeaderText="Org. Code" 
                                    SortExpression="pr_org_code" />
                                <asp:BoundField DataField="org_desc" HeaderText="Organization" 
                                    SortExpression="org_desc" />
                                <asp:BoundField DataField="pr_wef" HeaderText="W.E.F. (DD/MM/YYYY)" 
                                    SortExpression="pr_wef" />
                                <asp:BoundField DataField="pr_wet" HeaderText="W.E.T. (DD/MM/YYYY)" 
                                    SortExpression="pr_wet" />
                                <asp:BoundField DataField="pr_day1_hrs" HtmlEncode="false" HeaderText="Sunday <br>Hours" 
                                    SortExpression="pr_day1_hrs" />
                                <asp:BoundField DataField="pr_day2_hrs" HtmlEncode="false" HeaderText="Monday <br>Hours" 
                                    SortExpression="pr_day2_hrs" />
                                <asp:BoundField DataField="pr_day3_hrs" HtmlEncode="false" HeaderText="Tuesday <br>Hours" 
                                    SortExpression="pr_day3_hrs" />
                                <asp:BoundField DataField="pr_day4_hrs" HtmlEncode="false" HeaderText="Wednesday <br>Hours" 
                                    SortExpression="pr_day4_hrs" />
                                <asp:BoundField DataField="pr_day5_hrs" HtmlEncode="false" HeaderText="Thursday <br>Hours" 
                                    SortExpression="pr_day5_hrs" />
                                <asp:BoundField DataField="pr_day6_hrs" HtmlEncode="false" HeaderText="Friday <br>Hours" 
                                    SortExpression="pr_day6_hrs" />
                                <asp:BoundField DataField="pr_day7_hrs" HtmlEncode="false" HeaderText="Saturday <br>Hours" 
                                    SortExpression="pr_day7_hrs" />

                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
