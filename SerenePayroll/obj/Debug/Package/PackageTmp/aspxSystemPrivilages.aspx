<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxSystemPrivilages.aspx.cs" Inherits="SerenePayroll.aspxSystemPrivilages" %>
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
                    <asp:Panel ID="pnlButtons" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
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
                    </asp:Panel>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                        SelectCommand="get_user_privillages" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                    
                                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit System Privillage Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        Enabled="false"
                        BackColor="#99CCFF">                        
                            <table style="width: 100%;">
                                <tr style="visibility:collapse">
                                    <td style="width:20%">
                                        <asp:Label ID="lblUpCode" runat="server" Text="Id : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUpCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblname" runat="server" Text="Privillage Name : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtname" runat="server" Width="217px" BackColor="White"
                                        Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDesc" runat="server" Text="Privillage Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDesc" runat="server" Width="400"  BackColor="White"
                                        Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblType" runat="server" Text="Type : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlType" runat="server" Width="217px" BackColor="White" >
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="ACCESS">ACCESS</asp:ListItem>
                                            <asp:ListItem Value="AUTHORISE">AUTHORISE</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMinAmt" runat="server" Text="Minimum Limit Amount : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMinAmt" runat="server" Width="217px"  BackColor="White"
                                            Enabled="true"
                                            onkeypress="document.getElementById('txtMinAmt').innerHTML=this.value;"
                                            AutoPostBack="True"
                                            ontextchanged="txtMinAmt_TextChanged" /> 
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMaxAmt" runat="server" Text="Maximum Limit Amount : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMaxAmt" runat="server" Width="217px"  BackColor="White"
                                            Enabled="true"
                                            onkeypress="document.getElementById('txtMaxAmt').innerHTML=this.value;"
                                            AutoPostBack="True"
                                            ontextchanged="txtMaxAmt_TextChanged" /> 
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible=true 
                        BackColor="#99CCF0">
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="up_code" 
                            DataSourceID="SqlDataSource1"
                            onselectedindexchanged="GridView1_SelectedIndexChanged"
                            onitemcommand="GridView1_ItemCommand" PageSize="20">

                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="up_code" HeaderText="Id" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="up_code" />
                                <asp:BoundField DataField="up_name" HeaderText="Privillage Name" 
                                    SortExpression="up_name" />
                                <asp:BoundField DataField="up_desc" HeaderText="Privillage Description" 
                                    SortExpression="up_desc" />
                                <asp:BoundField DataField="up_min_amt" HeaderText="Minimum Limit Amount" 
                                    HeaderStyle-CssClass = "currencyGridColumn" ItemStyle-CssClass="currencyGridColumn"  
                                    SortExpression="up_min_amt" />
                                <asp:BoundField DataField="up_max_amt" HeaderText="Maximum Limit Amount" 
                                    HeaderStyle-CssClass = "currencyGridColumn" ItemStyle-CssClass="currencyGridColumn" 
                                    SortExpression="up_max_amt" />
                                <asp:BoundField DataField="up_type" HeaderText="Type"  
                                    SortExpression="up_type" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
