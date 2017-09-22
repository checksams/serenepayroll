<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxPayElements.aspx.cs" Inherits="SerenePayroll.aspxPayElements" %>
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
                    <asp:Button ID="btnPopulatePEtoEmp" runat="server" 
                        Text="Populate Pay Elements to Employees" onclick="btnPopulatePEtoEmp_Click" />
                    <asp:Button ID="btnPopup" runat="server" Text="Popup" 
                        onclick="btnPopup_Click" Visible="False" />

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                        SelectCommand="get_payelements" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit Pay Element Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCFF">                        
                            <table style="width: 100%;">
                                <tr style="visibility:collapse">
                                    <td style="width:20%">
                                        <asp:Label ID="lblPelCode" runat="server" Text="Id : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPelCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
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
                                        <asp:Label ID="lblDesc" runat="server" Text="Pey Element Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDesc" runat="server" Width="400" Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTaxable" runat="server" Text="Taxable: "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTaxable" runat="server" Width="217px">
                                            <asp:ListItem Value="YES">YES</asp:ListItem>
                                            <asp:ListItem Value="NO">NO</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDeduction" runat="server" Text="Deduction : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDeduction" runat="server" Width="217px">
                                            <asp:ListItem Value="YES">YES</asp:ListItem>
                                            <asp:ListItem Value="NO">NO</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>                                  
                                <tr style="visibility:collapse">
                                    <td>
                                        <asp:Label ID="lblDependsOn" runat="server" Text="Depends On : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDependsOn" runat="server" Width="217px">
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td>
                                        <asp:Label ID="lblType" runat="server" Text="Type : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlType" runat="server" Width="217px">
                                            <asp:ListItem Value="SALARY">SALARY</asp:ListItem>
                                            <asp:ListItem Value="TAX">TAX</asp:ListItem>
                                            <asp:ListItem Value="ALLOWANCE">ALLOWANCE</asp:ListItem>
                                            <asp:ListItem Value="LOAN">LOAN</asp:ListItem>
                                            <asp:ListItem Value="USER DEFINED">USER DEFINED</asp:ListItem>
                                            <asp:ListItem Value="BENEFIT">BENEFIT</asp:ListItem>
                                            <asp:ListItem Value="REGISTERED PENSION SCHEME">REGISTERED PENSION SCHEME</asp:ListItem>
                                            <asp:ListItem Value="UN-REGISTERED PENSION SCHEME">UN-REGISTERED PENSION SCHEME</asp:ListItem>
                                            <asp:ListItem Value="MEDICAL SCHEME">MEDICAL SCHEME</asp:ListItem>
                                            <asp:ListItem Value="LIFE INSURANCE">LIFE INSURANCE</asp:ListItem>
                                            <asp:ListItem Value="HOME OWNERSHIP">HOME OWNERSHIP</asp:ListItem>
                                            <asp:ListItem Value="NORMAL OVERTIME">NORMAL OVERTIME</asp:ListItem>
                                            <asp:ListItem Value="HOLIDAY OVERTIME">HOLIDAY OVERTIME</asp:ListItem>
                                            <asp:ListItem Value="ABSENCE">ABSENCE</asp:ListItem>
                                            <asp:ListItem Value="STATEMENT ITEM">STATEMENT ITEM</asp:ListItem>
                                            <asp:ListItem Value="OTHER">OTHER</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAppliedTo" runat="server" Text="Charged On : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlAppliedTo" runat="server" Width="217px">
                                            <asp:ListItem Value="EMPLOYEE">EMPLOYEE</asp:ListItem>
                                            <asp:ListItem Value="EMPLOYER">EMPLOYER</asp:ListItem>
                                            <asp:ListItem Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>                        
                                <tr>
                                    <td>
                                        <asp:Label ID="lblNontaxAllowedAmt" runat="server" Text="Non-Tax Allowed Amount : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtNontaxAllowedAmt" runat="server"  Width="217px" CssClass="currency"
                                        onkeypress="AllowOnlyNumeric(event);" 
                                            ToolTip="Maximum amount that should not be taxable (Applies to registered Pensions)." ></asp:TextBox>
                                    </td>
                                </tr>                        
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPrescribedAmt" runat="server" Text="Prescribed Amount : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPrescribedAmt" runat="server"  Width="217px" CssClass="currency"
                                        onkeypress="AllowOnlyNumeric(event);" 
                                            ToolTip="Government Priscribed Market Minimum Value of Benefit Amount" ></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible=true 
                        BackColor="#99CCF0">
                        <table>
                            <tr>
                                <td valign="top">
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="pel_code" 
                                        DataSourceID="SqlDataSource1"
                                        onselectedindexchanged="GridView1_SelectedIndexChanged"
                                        onitemcommand="GridView1_ItemCommand"                                       
                                        PageSize="20" PagerSettings-Position="TopAndBottom">

                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns> 
                                            <asp:CommandField ShowSelectButton="True" SelectText="Select"/>
                                            <asp:BoundField DataField="pel_code" HeaderText="Id" InsertVisible="False" 
                                                ReadOnly="True" SortExpression="pel_code" />
                                            <asp:BoundField DataField="pel_sht_desc" HeaderText="Short Desc" 
                                                SortExpression="pel_sht_desc" />
                                            <asp:BoundField DataField="pel_desc" HeaderText="Description" 
                                                SortExpression="pel_desc" />
                                            <asp:BoundField DataField="pel_taxable" HeaderText="Taxable" 
                                                SortExpression="pel_taxable" />
                                            <asp:BoundField DataField="pel_deduction" HeaderText="Deduction?" 
                                                SortExpression="pel_deduction" />
                                            <asp:BoundField DataField="pel_depends_on" HeaderText="Depends On" 
                                                SortExpression="pel_depends_on" />
                                            <asp:BoundField DataField="pel_type" HeaderText="Element Type" 
                                                SortExpression="pel_type" />
                                            <asp:BoundField DataField="pel_applied_to" HeaderText="Charged On" 
                                                SortExpression="pel_applied_to" />
                                            <asp:BoundField DataField="pel_nontax_allowed_amt" HeaderText="Non-Tax Allowed Amount" 
                                                HeaderStyle-CssClass="currencyGridColumn"
                                                SortExpression="pel_nontax_allowed_amt" ItemStyle-HorizontalAlign="Right" />
                                            <asp:BoundField DataField="pel_prescribed_amt" HeaderText="Prescribed Amount" 
                                                HeaderStyle-CssClass="currencyGridColumn"
                                                SortExpression="pel_prescribed_amt" ItemStyle-HorizontalAlign="Right"/>
                                            <asp:TemplateField>                                                
                                                <HeaderTemplate>
                                                    <asp:Label ID="lblOrder" runat="server" Text="Ordering"></asp:Label>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkOrder" runat="server"  OnCheckedChanged="ChckedChanged"
                                                    Checked='<%# Eval("pel_selected").ToString().Equals("1") %>'
                                                    AutoPostBack="true"
                                                    />
                                                </ItemTemplate>
                                                <FooterTemplate>

                                                </FooterTemplate>                                    
                                                <EditItemTemplate>

                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                                
                                                            
                                        </Columns>
                                    </asp:GridView>
                                </td>
                                <td>
                                    <asp:ImageButton ID="imgbtnUpArrow" runat="server" 
                                        ImageUrl="~/Images/uparrow.png" onclick="imgbtnUpArrow_Click" /><br>
                                    <asp:ImageButton ID="imgbtnDownArrow" runat="server" 
                                        ImageUrl="~/Images/downarrow.png" onclick="imgbtnDownArrow_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="pnlPayrolls" runat="server" Wrap="False" Visible="false" 
                        BackColor="#99CCF0">
                        <br>  
                        <table width="100%">
                            <tr>  
                                <td valign="top">                    
                                    <asp:Label ID="lblAttachPayrolls" runat="server" Text="Attach Payrolls" 
                                    Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                                    <br>
                                    <asp:DropDownList ID="ddlPayrolls" runat="server" DataSourceID="SqlDataSource2" 
                                        DataTextField="pr_desc" DataValueField="pr_code">
                                    </asp:DropDownList>
                                    <asp:Button ID="btnAttachPyrll" runat="server" Text="Attach Payroll" 
                                        onclick="btnAttachPyrll_Click" />
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                        SelectCommand="get_payrolls" SelectCommandType="StoredProcedure">
                                    </asp:SqlDataSource>
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                                        DataSourceID="SqlDataSource3" DataKeyNames="pp_code"
                                        OnRowDeleting="GridView2_RowDeleting"
                                        AllowSorting="True"   >
                            
                                        <FooterStyle BackColor="#407CE1" Font-Bold="True" ForeColor="White" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#DDDDF9" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#304CE1" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:ButtonField ButtonType="Link" Text="Delete" CommandName="Delete" />
                                            <asp:BoundField DataField="pp_code" HeaderText="Id" InsertVisible="False" 
                                                ReadOnly="True" SortExpression="pp_code" />
                                            <asp:BoundField DataField="pr_desc" HeaderText="Payroll Description" 
                                                SortExpression="pr_desc" />
                                            <asp:BoundField DataField="pel_desc" HeaderText="Pay Element Description" 
                                                SortExpression="pel_desc" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                        SelectCommand="get_proll_pelements" SelectCommandType="StoredProcedure" 
                                        DeleteCommand="delete_proll_pelements" DeleteCommandType="StoredProcedure">
                                        <DeleteParameters>
                                            <asp:Parameter Name="v_pp_code" Type="Int32" />
                                        </DeleteParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="txtPelCode" Name="v_pel_code" 
                                                PropertyName="Text" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                        
                                </td> 
                                <td valign="top">               
                                    <asp:Label ID="lblPostAmounts" runat="server" Text="Post Amount to Employees on this payroll." 
                                    Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                                    <br>
                                    <asp:Label ID="lblAmountToPost" runat="server" Text="Amount to post :"></asp:Label>
                                    <asp:TextBox ID="txtAmountToPost" runat="server" Width="217px"></asp:TextBox>
                                    <br><br>
                                    <asp:Button ID="btnPostAmount" runat="server" Text="Post Amount" 
                                        onclick="btnPostAmount_Click" />
                                </td>  
                            </tr>  
                        </table>
                        
                    </asp:Panel>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
