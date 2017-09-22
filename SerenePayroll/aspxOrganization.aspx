<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxOrganization.aspx.cs" Inherits="SerenePayroll.aspxOrganization" %>
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

        <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click" />
        <asp:Button ID="btnSaveOrg" runat="server" Text="Save" 
            onclick="btnSaveOrg_Click" Enabled="False" />
        <asp:Button ID="btnSaveNAddNew" runat="server" onclick="btnSaveNAddNew_Click" 
            Text="Save and Add New" Enabled="False" />
        <asp:Button ID="btnDelete" runat="server" onclick="btnDelete_Click" 
            Text="Delete" Enabled="False" />
        <asp:Button ID="btnCancelSaving" runat="server" onclick="btnCancelSaving_Click" 
            Text="Cancel" />
        <asp:Button ID="Popup" runat="server" Text="Popup" onclick="Popup_Click" 
            Visible="False" />
        <br>

    <table style="background-color:#99CCFF; width:100%;">
        <tr>
            <td valign="top" style="background-color:#99CCFF; width:200px;">
                <asp:TreeView ID="TreeView1" runat="server" ImageSet="Arrows" NodeIndent="15" 
                            Visible="true" onselectednodechanged="TreeView1_SelectedNodeChanged">
                    <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                    <NodeStyle Font-Names="Tahoma" Font-Size="8pt" ForeColor="Black" HorizontalPadding="2px"
                        NodeSpacing="0px" VerticalPadding="2px"></NodeStyle>
                    <ParentNodeStyle Font-Bold="False" />
                    <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" HorizontalPadding="0px"
                        VerticalPadding="0px" />
                </asp:TreeView>
            </td>        
            <td style="width:10px; background-color:#dddddd">        
            </td>        
            <td valign="top">
                <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                    BackColor="#99CCF0">
                    <asp:Button ID="btnEditPnl" runat="server" 
                        Text="Edit Organization Details        (View/Hide)" Height="20px" 
                        onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                    BackColor="#99CCFF">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width:20%">
                                <asp:Label ID="lblOrgID" runat="server" Text="Organization ID : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtOrgCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblShtDesc" runat="server" Text="Organization Short Code : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtShtDesc" runat="server" Width="217px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDesc" runat="server" Text="Organization Description : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDesc" runat="server" Width="217px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblPostalAddress" runat="server" Text="Postal Address : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPostalAddress" runat="server" TextMode="MultiLine" Width="70%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblPhysicalAddress" runat="server" Text="Physical Address : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPhysicalAddress" runat="server" TextMode="MultiLine" Width="70%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblType" runat="server" Text="Type : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtType" runat="server" Width="217px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="visibility:collapse">
                            <td>
                                <asp:Label ID="lblParentOrgCode" runat="server" Text="Parent Org_Code : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtParentOrgCode" runat="server" Width="217px" Enabled="False"></asp:TextBox>
                            </td>
                        </tr>
            
                        <tr style="visibility:collapse">
                            <td>
                                <asp:Label ID="lblParentShtDesc" runat="server" Text="Parent Short Desc : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtParentShtDesc" runat="server" Width="217px" Enabled="False"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl" runat="server" Text="Parent Organization : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtParentOrg" runat="server" Width="217px" Enabled="false"></asp:TextBox>
                                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" AppendDataBoundItems="True" 
                                    DataSourceID="SqlDataSource2" DataTextField="org_desc" 
                                    DataValueField="org_code" 
                                    onselectedindexchanged="DropDownList1_SelectedIndexChanged">
                                        <asp:ListItem Value="">Please Select</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                    ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                    SelectCommand="select org_code, org_sht_desc, org_desc from serenehrdb.shr_organizations">
                                </asp:SqlDataSource>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <asp:Label ID="lblWef" runat="server" Text="Effective From : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtWef" runat="server" Width="217px"></asp:TextBox>
                                 <img alt="Date" src="/Images/calender.png" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblWet" runat="server" Text="Effective To : "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtWet" runat="server" Width="217px"></asp:TextBox>
                                <img alt="Date" src="/Images/calender.png" />
                            </td>
                        </tr>
                    </table>
                    <br>
                </asp:Panel>
                </asp:Panel>
    
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible="true"
        BackColor="#99CCF0">
        <br>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
            SelectCommand="SELECT org_code, org_sht_desc, org_desc, org_postal_address, org_physical_address, org_type, org_parent_org_code, org_parent_org_sht_desc, parent_organization, org_wef, org_wet, org_level FROM vw_orgarnization_view">
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="org_code" 
            DataSourceID="SqlDataSource1" Width="100%" 
            onselectedindexchanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="org_code" HeaderText="Id" 
                    InsertVisible="False" ReadOnly="True" SortExpression="org_code" Visible="true" ItemStyle-Width="0%" HeaderStyle-Width="0%">
                    <HeaderStyle Width="0%" />
                    <ItemStyle Width="0px"></ItemStyle>
                </asp:BoundField>      
                <asp:BoundField DataField="org_sht_desc" HeaderText="Orgarnization Short Desc." 
                    SortExpression="org_sht_desc" />
                <asp:BoundField DataField="org_desc" HeaderText="Orgarnization Full Description" 
                    SortExpression="org_desc" />
                <asp:BoundField DataField="org_postal_address" HeaderText="Postal Address" 
                    SortExpression="org_postal_address" />
                <asp:BoundField DataField="org_physical_address" 
                    HeaderText="Physical Address" SortExpression="org_physical_address" />
                <asp:BoundField DataField="org_type" HeaderText="Type" 
                    SortExpression="org_type" />
                <asp:BoundField DataField="org_parent_org_code" 
                    HeaderText="Parent Id" SortExpression="org_parent_org_code" Visible="true"/>
                <asp:BoundField DataField="org_parent_org_sht_desc" 
                    HeaderText="Parent Org Short Desc." SortExpression="org_parent_org_sht_desc" Visible="true"/>
                <asp:BoundField DataField="parent_organization" 
                    HeaderText="Parent Organization" SortExpression="parent_organization" />
                <asp:BoundField DataField="org_wef" HeaderText="W.E.F" 
                    SortExpression="org_wef" HtmlEncode="True" HtmlEncodeFormatString="True" />
                <asp:BoundField DataField="org_wet" HeaderText="W.E.T." 
                    SortExpression="org_wet" HtmlEncode="True" />
                <asp:BoundField DataField="org_level" HeaderText="Level" 
                    SortExpression="org_level"/>
            </Columns>
            <SelectedRowStyle Font-Bold="True" />
        </asp:GridView>
    </asp:Panel>
</asp:Content>
