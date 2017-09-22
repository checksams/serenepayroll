<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxTaxeRates.aspx.cs" Inherits="SerenePayroll.aspxTaxeRates" %>
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
            <td style="background-color:#99CCFF; width:0px; height:inherit">
                <div style="background-color:#99CCFF; height:inherit">
                


                </div>
            </td>
            <td>
                <div  style="height:inherit;">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                        SelectCommand="get_taxes" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                    
                                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit Payroll Details       (View/Hide)" Height="20px" visible="false"
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCFF">                        
                            <table style="width: 100%;">
                                <tr style="visibility:collapse">
                                    <td style="width:20%">
                                        <asp:Label ID="lblTxCode" runat="server" Text="Id : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTxCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblShtDesc" runat="server" Text="Tax Short Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtShtDesc" runat="server" Width="217px" Enabled="False"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDesc" runat="server" Text="Tax Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDesc" runat="server" Width="400" Enabled="False"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblWef" runat="server" Text="W.E.F. (DD/MM/YYYY) : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtWef" runat="server" Width="217px" Enabled="False"></asp:TextBox>
                                        <img alt="Date" src="/Images/calender.png" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblWet" runat="server" Text="W.E.T. (DD/MM/YYYY) : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtWet" runat="server" Width="217px" Enabled="False"></asp:TextBox>
                                        <img alt="Date" src="/Images/calender.png" />
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCF0">
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="tx_code" 
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
                                <asp:BoundField DataField="tx_code" HeaderText="Id" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="tx_code" />
                                <asp:BoundField DataField="tx_sht_desc" HeaderText="Short Description" 
                                    SortExpression="tx_sht_desc" />
                                <asp:BoundField DataField="tx_desc" HeaderText="Description" 
                                    SortExpression="tx_desc" />
                                <asp:BoundField DataField="tx_wef" HeaderText="W.E.F." 
                                    SortExpression="tx_wef" />
                                <asp:BoundField DataField="tx_wet" HeaderText="W.E.T." 
                                    SortExpression="tx_wet" />
                            </Columns>
                        </asp:GridView>

                    </asp:Panel>
                    
                    <div style="background-color:#99CCFF">                    
                        <asp:Button ID="btnImpTaxRates" runat="server" Text="Import From CSV file" 
                            onclick="btnImpTaxRates_Click" Visible="true" />
                        <asp:Button ID="btnExpTaxRates" runat="server" Text="Export To CSV file" 
                            onclick="btnExpTaxRates_Click" Visible="False" />
                        <asp:Button ID="btnDeleteAll" runat="server" Text="Delete All" 
                            onclick="btnDeleteAll_Click" Visible="true" />
                    </div>

                    
                    <asp:Panel ID="pnlDisplayImportData" runat="server" Wrap="False" Visible="False"
                        BackColor="#99CCFF">   
                        <table id="tblImport"  runat="server" width="100%" visible="true">
                        <tr>
                            <td>                                    
                                <asp:FileUpload ID="FileUpload1" runat="server"/> 
                                <asp:Button ID="btnUpLoad" runat="server" Text="Upload" 
                                    onclick="btnUpLoad_Click" />
                                <asp:Button ID="btnClearData" runat="server" Text="Cancel" 
                                    onclick="btnClearData_Click" />
                                <asp:Button ID="btnSaveDataToDb" runat="server" Text="Save Data to Database" 
                                    onclick="btnSaveDataToDb_Click" />
                                <asp:Button ID="btnExportErrData" runat="server" 
                                    Text="Export Unloaded Data to CSV file" onclick="btnExportErrData_Click" 
                                    Visible="False" />
                            </td>
                        </tr>
                        <tr>
                            <td>                                    
                                <asp:Label ID="lblUploadStatus" runat="server" Text="Upload Status"></asp:Label>
                            </td>
                        </tr>
                        </table>
                        <asp:GridView ID="gvImportData" runat="server" CellPadding="4" ForeColor="#333333"
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

                    <asp:Panel ID="pnlTaxRates" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCF0">                        
                        <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click"  Visible="False" />
                        <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" 
                            Enabled="False" Visible="False"  />
                        <asp:Button ID="btnSaveNAddNew" runat="server" Text="Save and Add New" 
                            onclick="btnSaveNAddNew_Click" Enabled="False"  Visible="False"  />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                            onclick="btnDelete_Click" Enabled="False"  Visible="False"  />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                            onclick="btnCancel_Click"  Visible="False" />
                        <asp:Button ID="btnPopup" runat="server" Text="Popup" 
                            onclick="btnPopup_Click" Visible="False" />

                        <br>
                        <asp:Label ID="lblDefDivFactor" runat="server"
                                Text="Default Division Factor" Visible="False"></asp:Label>
                        <asp:TextBox ID="txtDefDivFactor" runat="server" Width="217px" Visible="False"></asp:TextBox>
                        <br>
                        <br>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                            DeleteCommand="delete_tax_rates" DeleteCommandType="StoredProcedure" 
                            InsertCommand="update_tax_rates" InsertCommandType="StoredProcedure" 
                            ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                            SelectCommand="get_tax_rates" SelectCommandType="StoredProcedure" 
                            UpdateCommand="update_tax_rates" UpdateCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="v_txr_code" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="v_txr_code" Type="Int32" />
                                <asp:Parameter Name="v_desc" Type="String" />
                                <asp:Parameter Name="v_rate_type" Type="String" />
                                <asp:Parameter Name="v_rate" Type="Int32" />
                                <asp:Parameter Name="v_div_factr" Type="Int32" />
                                <asp:Parameter Name="v_wef" Type="String" />
                                <asp:Parameter Name="v_wet" Type="String" />
                                <asp:Parameter Name="v_tx_code" Type="Int32" />
                                <asp:Parameter Name="v_range_from" Type="Int32" />
                                <asp:Parameter Name="v_range_to" Type="Int32" />
                                <asp:Parameter Name="v_frequency" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtTxCode" Name="v_tx_code" 
                                    PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="v_txr_code" Type="Int32" />
                                <asp:Parameter Name="v_desc" Type="String" />
                                <asp:Parameter Name="v_rate_type" Type="String" />
                                <asp:Parameter Name="v_rate" Type="Int32" />
                                <asp:Parameter Name="v_div_factr" Type="Int32" />
                                <asp:Parameter Name="v_wef" Type="String" />
                                <asp:Parameter Name="v_wet" Type="String" />
                                <asp:Parameter Name="v_tx_code" Type="Int32" />
                                <asp:Parameter Name="v_range_from" Type="Int32" />
                                <asp:Parameter Name="v_range_to" Type="Int32" />
                                <asp:Parameter Name="v_frequency" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridView2" runat="server" AllowPaging="false"
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="txr_code" 
                            ShowFooter="True" ShowHeaderWhenEmpty="True" 
                            OnRowCommand="GridView2_RowCommand"
                            OnRowEditing="GridView2_RowEditing" 
                            OnRowUpdating="GridView2_RowUpdating" 
                            OnRowDeleting="GridView2_RowDeleting" >
                            
                            <FooterStyle BackColor="#eeeeee" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#eeeeee" />
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
                                        <asp:Label ID="lbl_txr_code" runat="server" Text='<%# Eval("txr_code") %>'
                                             Width="50px"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_txr_code" runat="server" Enabled="false"
                                             Width="50px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_txr_code" runat="server" Enabled="false" Text='<%#DataBinder.Eval(Container.DataItem, "txr_code") %>'
                                             Width="50px"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_txr_desc" runat="server" Text='<%# Eval("txr_desc") %>'
                                             Width="100px"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_txr_desc" runat="server"
                                             Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_txr_desc" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "txr_desc") %>'
                                             Width="100px"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate Type">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlRateType" runat="server" AutoPostBack="True"   Width="150px" 
                                        SelectedValue='<%# Eval("txr_rate_type") %>' Enabled="false">
                                            <asp:ListItem Value="FIXED">FIXED</asp:ListItem>
                                            <asp:ListItem Value="STEP RANGE">STEP RANGE</asp:ListItem>
                                            <asp:ListItem Value="RECURSIVE">RECURSIVE</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlRateType" runat="server" AutoPostBack="True"   Width="150px">
                                            <asp:ListItem Value="FIXED">FIXED</asp:ListItem>
                                            <asp:ListItem Value="STEP RANGE">STEP RANGE</asp:ListItem>
                                            <asp:ListItem Value="RECURSIVE">RECURSIVE</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlRateType" runat="server" AutoPostBack="True"   Width="150px" 
                                        SelectedValue='<%# Eval("txr_rate_type") %>'>
                                            <asp:ListItem Value="FIXED">FIXED</asp:ListItem>
                                            <asp:ListItem Value="STEP RANGE">STEP RANGE</asp:ListItem>
                                            <asp:ListItem Value="RECURSIVE">RECURSIVE</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_txr_rate" runat="server" Text='<%# Eval("txr_rate") %>' Width="100px"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_txr_rate" runat="server" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_txr_rate" runat="server" Width="100px" Text='<%#DataBinder.Eval(Container.DataItem, "txr_rate") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Division Factor">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_txr_div_factr" runat="server"  Width="100px"
                                            Text='<%# Eval("txr_div_factr") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_txr_div_factr" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_txr_div_factr" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "txr_div_factr") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Range From">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_txr_range_from" runat="server"  Width="100px"
                                            Text='<%# Eval("txr_range_from") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_txr_range_from" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_txr_range_from" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "txr_range_from") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Range To">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_txr_range_to" runat="server"  Width="100px"
                                            Text='<%# Eval("txr_range_to") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_txr_range_to" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_txr_range_to" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "txr_range_to") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="W.E.F.">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_txr_wef" runat="server"  Width="100px"
                                        Text='<%# Eval("txr_wef") %>' DataFormatString = "{0:dd/MM/yyyy}" HtmlEncode="false"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_txr_wef" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_txr_wef" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "txr_wef") %>'  DataFormatString = "{0:dd/MM/yyyy}" HtmlEncode="false"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="W.E.T.">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_txr_wet" runat="server" Text='<%# Eval("txr_wet") %>' Width="100px"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_txr_wet" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_txr_wet" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "txr_wet") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate Frequency">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_txr_frequency" runat="server" AutoPostBack="True"   Width="150px" 
                                        SelectedValue='<%# Eval("txr_frequency") %>' Enabled="false">
                                            <asp:ListItem Value="MONTHLY">MONTHLY</asp:ListItem>
                                            <asp:ListItem Value="ANNUALLY">ANNUALLY</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddl_txr_frequency" runat="server" AutoPostBack="True"   Width="150px">
                                            <asp:ListItem Value="MONTHLY">MONTHLY</asp:ListItem>
                                            <asp:ListItem Value="ANNUALLY">ANNUALLY</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddl_txr_frequency" runat="server" AutoPostBack="True"   Width="150px" 
                                        SelectedValue='<%#DataBinder.Eval(Container.DataItem, "txr_frequency") %>'>
                                            <asp:ListItem Value="MONTHLY">MONTHLY</asp:ListItem>
                                            <asp:ListItem Value="ANNUALLY">ANNUALLY</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmptyMessage" runat="server" 
                                    Text="NO RECORDS TO DISPLAY" />
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </asp:Panel>

                </div>
            </td>
        </tr>
    </table>
</asp:Content>
