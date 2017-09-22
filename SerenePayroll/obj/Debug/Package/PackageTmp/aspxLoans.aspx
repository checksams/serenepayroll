<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxLoans.aspx.cs" Inherits="SerenePayroll.aspxLoans" %>
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
            <td style="background-color:#99CCFF; width:10px; height:inherit">
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
                        SelectCommand="get_loan_types" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                    
                                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit Loan Type Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCFF">                        
                            <table style="width: 100%;">
                                <tr style="visibility:collapse">
                                    <td style="width:20%">
                                        <asp:Label ID="lblLtCode" runat="server" Text="Id : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLtCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblShtDesc" runat="server" Text="Short Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtShtDesc" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDesc" runat="server" Text="Loan Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDesc" runat="server" Width="400" Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_min_repay_prd" runat="server" Text="Minimum Repayment Period : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_min_repay_prd" runat="server" Width="217" Enabled="true"
                                            onkeypress="document.getElementById('txt_min_repay_prd').innerHTML=this.value;"
                                            AutoPostBack="True"
                                            ontextchanged="txt_min_repay_prd_TextChanged"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_max_repay_prd" runat="server" Text="Maximum Repayment Period : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_max_repay_prd" runat="server" Width="217" Enabled="true"
                                            onkeypress="document.getElementById('txt_max_repay_prd').innerHTML=this.value;"
                                            AutoPostBack="True"
                                            ontextchanged="txt_max_repay_prd_TextChanged"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_min_amt" runat="server" Text="Minimum Loan Amount : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_min_amt" runat="server" Width="217" Enabled="true"
                                            onkeypress="document.getElementById('txt_min_amt').innerHTML=this.value;"
                                            AutoPostBack="True"
                                            ontextchanged="txt_min_amt_TextChanged"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_max_amt" runat="server" Text="Maximum Loan Amount : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_max_amt" runat="server" Width="217" Enabled="true"
                                            onkeypress="document.getElementById('txt_max_amt').innerHTML=this.value;"
                                            AutoPostBack="True"
                                            ontextchanged="txt_max_amt_TextChanged"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblWef" runat="server" Text="W.E.F. (DD/MM/YYYY) : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtWef" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                        <img alt="Date" src="/Images/calender.png" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblWet" runat="server" Text="W.E.T. (DD/MM/YYYY) : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtWet" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                        <img alt="Date" src="/Images/calender.png" />
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible=true 
                        BackColor="#99CCF0">
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="lt_code" 
                            DataSourceID="SqlDataSource1"
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
                                <asp:BoundField DataField="lt_code" HeaderText="Id" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="lt_code" />
                                <asp:BoundField DataField="lt_sht_desc" HeaderText="Short Description" 
                                    SortExpression="lt_sht_desc" />
                                <asp:BoundField DataField="lt_desc" HeaderText="Loan Description" 
                                    SortExpression="lt_desc" />
                                <asp:BoundField DataField="lt_min_repay_prd" HeaderText="Minimum Repay Period" 
                                    SortExpression="lt_min_repay_prd" />
                                <asp:BoundField DataField="lt_max_repay_prd" HeaderText="Maximum Repay Period" 
                                    SortExpression="lt_max_repay_prd" />
                                <asp:BoundField DataField="lt_min_amt" HeaderText="Minimum Amount" 
                                    SortExpression="lt_min_amt" />
                                <asp:BoundField DataField="lt_max_amt" HeaderText="Maximum Amount" 
                                    SortExpression="lt_max_amt" />
                                <asp:BoundField DataField="lt_wef" HeaderText="W.E.F." 
                                    SortExpression="lt_max_amt" />
                                <asp:BoundField DataField="lt_wet" HeaderText="W.E.T" 
                                    SortExpression="lt_max_amt" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>

                    
                    <asp:Panel ID="pnlRates" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCF0"> 
                        <br> 
                        <asp:Label ID="Label1" runat="server" Text="Loan Interest Rate Setup " 
                            Font-Bold="True" ForeColor="Black" Height="25px" Width="100%"></asp:Label>
                        <br />
                        <asp:Button ID="btnAddRate" runat="server" Text="Add" onclick="btnAddRate_Click"  Visible="False" />
                        <asp:Button ID="btnSaveRate" runat="server" Text="Save" onclick="btnSaveRate_Click" 
                            Enabled="False" Visible="False"  />
                        <asp:Button ID="btnSaveNAddRate" runat="server" Text="Save and Add New" 
                            onclick="btnSaveNAddRate_Click" Enabled="False"  Visible="False"  />
                        <asp:Button ID="btnDeleteRate" runat="server" Text="Delete" 
                            onclick="btnDeleteRate_Click" Enabled="False"  Visible="False"  />
                        <asp:Button ID="btnCancelRate" runat="server" Text="Cancel" 
                            onclick="btnCancelRate_Click"  Visible="False" />
                        <br />
                        
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                            ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                            SelectCommand="get_loan_intr_rates" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtLtCode" Name="v_lir_code" 
                                    PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                            DataKeyNames="lir_code" ShowFooter="True" ShowHeaderWhenEmpty="True" 
                            OnRowCommand="GridView2_RowCommand"
                            OnRowEditing="GridView2_RowEditing" 
                            OnRowUpdating="GridView2_RowUpdating" 
                            OnRowDeleting="GridView2_RowDeleting"                            
                            >

                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />

                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LkBItem" runat="server" CommandName="Edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="LinkDelete" runat="server" CommandName="Delete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>">Delete</asp:LinkButton>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:LinkButton ID="LkB1" runat="server" CommandName="Insert"  CommandArgument="<%# ((GridViewRow) Container).RowIndex %>">Insert</asp:LinkButton>
                                    </FooterTemplate>                                    
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="LinkUpdate" runat="server" CommandName="Update" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>">Update</asp:LinkButton>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Id">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_lir_code" runat="server" Text='<%# Eval("lir_code") %>'
                                             Width="50px"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_lir_code" runat="server" Enabled="false"
                                             Width="50px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_lir_code" runat="server" Enabled="false" Text='<%#DataBinder.Eval(Container.DataItem, "lir_code") %>'
                                             Width="50px"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Rate">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_lir_rate" runat="server" Text='<%# Eval("lir_rate") %>' Width="100px"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_lir_rate" runat="server" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_lir_rate" runat="server" Width="100px" Text='<%#DataBinder.Eval(Container.DataItem, "lir_rate") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Division Factor">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_lir_div_factr" runat="server"  Width="100px"
                                            Text='<%# Eval("lir_div_factr") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_lir_div_factr" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_lir_div_factr" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "lir_div_factr") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="W.E.F.">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_lir_wef" runat="server"  Width="100px"
                                        Text='<%# Eval("lir_wef") %>' DataFormatString = "{0:dd/MM/yyyy}" HtmlEncode="false"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_lir_wef" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_lir_wef" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "lir_wef") %>'  DataFormatString = "{0:dd/MM/yyyy}" HtmlEncode="false"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="W.E.T.">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_lir_wet" runat="server"  Width="100px"
                                        Text='<%# Eval("lir_wet") %>' DataFormatString = "{0:dd/MM/yyyy}" HtmlEncode="false"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_lir_wet" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_lir_wet" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "lir_wet") %>'  DataFormatString = "{0:dd/MM/yyyy}" HtmlEncode="false"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel> 
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
