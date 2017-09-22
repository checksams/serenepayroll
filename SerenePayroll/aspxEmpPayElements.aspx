<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxEmpPayElements.aspx.cs" Inherits="SerenePayroll.aspxEmpPayElements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<script language="JavaScript" type="text/javascript" src="/Scripts/CustomeFunctions.js">  </script>

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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">&nbsp;&nbsp;




    <div class="page_dimmer" id="pagedimmer" style="display:none "> </div> 
    <div class="msg_box_container" id="msgbox" style="display:none "> 
    <table class="errorTableRound" border="0px" frame="above" cellpadding="2" 
            cellspacing="0" dir="ltr">
        <tr class="trFloating"> 
            <td class="tdFloatingLeft">&nbsp;&nbsp;[TITLE]
            </td> 
            <td class="tdFloatingRight"align="right">
                <input type="Button" value="X" 
                onClick="document.getElementById('pagedimmer').style.visibility = 'hidden'; 
                document.getElementById('msgbox').style.visibility = 'hidden'">&nbsp;
            </td> 
        </tr> 
        <tr>
            <td colspan="2" class="tdMessage" >
                 [MESSAGE]   
            </td> 
        </tr> 
        <tr> 
            <td colspan="2">&nbsp;&nbsp;
                <input type="Button" value="OK" 
                onClick="document.getElementById('pagedimmer').style.visibility = 'hidden'; 
                document.getElementById('msgbox').style.visibility = 'hidden'">
            </td> 
        </tr> 
    </table> 
    <br>
    </div> 

    <table style="width:100%;  height:500px" cellpadding="0" cellspacing="0">
        <tr style="height:inherit; vertical-align:top">
            <td style="background-color:#99CCFF; width:250px; height:inherit">
                <div style="background-color:#99CCFF; height:inherit">
                    <asp:Button ID="btnHideSrch" runat="server" 
                                Text="Search Details (View/Hide)" Height="20px" 
                                onclick="btnHideSrch_Click" Width="100%" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlSearch" runat="server" Wrap="False" Visible="true" 
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
                    <br>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible=true 
                        BackColor="#99CCF0" ScrollBars="Auto">
                        <asp:GridView ID="GridView1" runat="server" 
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="emp_code" 
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
                                <asp:BoundField DataField="emp_code" HeaderText="Id  " InsertVisible="False" Visible="true"
                                    ReadOnly="True" SortExpression="emp_code" />
                                <asp:BoundField DataField="emp_sht_desc" HeaderText="Emp. Code." 
                                    SortExpression="emp_sht_desc" />
                                <asp:BoundField DataField="emp_surname" HeaderText="Surname" 
                                    SortExpression="emp_surname" />
                                <asp:BoundField DataField="emp_other_names" HeaderText="Other names" 
                                    SortExpression="emp_other_names" />
                                <asp:BoundField DataField="emp_tel_no1" HeaderText="Tel No. 1"   Visible="false"
                                    SortExpression="emp_tel_no1" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>

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
                        SelectCommand="get_employees" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtEmpCodeSrch" DefaultValue="%" 
                                Name="v_sht_desc" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtSurnameSrch" DefaultValue="%" 
                                Name="v_surname" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtOtherNameSrch" DefaultValue="%" 
                                Name="v_other_names" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtOrganizationSrch" DefaultValue="%" 
                                Name="v_organization" PropertyName="Text" Type="String"  />
                        </SelectParameters>
                    </asp:SqlDataSource>
                                                       
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Employee Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCFF">                        
                            <table style="width: 100%;">
                                <tr style="visibility:collapse">
                                    <td style="width:20%">
                                        <asp:Label ID="lblEmpCode" runat="server" Text="Id : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEmpCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblShtDesc" runat="server" Text="Employee's Code : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtShtDesc" runat="server" Width="217px" Enabled="False" ForeColor="Black"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSurname" runat="server" Text="Surname : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSurname" runat="server" Width="400" Enabled="False" ForeColor="Black"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="visibility:collapse;">
                                    <td>
                                        <asp:Label ID="lblOtherNames" runat="server" Text="Other Names : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherNames" runat="server" Width="400" Enabled="False" ForeColor="Black"> </asp:TextBox>
                                    </td>
                                </tr>
                            </table>   
                            <br>

                            <asp:Panel ID="pnlAddPayElements" runat="server" Wrap="False" Visible="true" 
                                BackColor="#99CCFF">           
                                <asp:Button ID="btnAddPayElements" runat="server" Text="Add Pay Elements   (View/Hide)" style="text-align:left"
                                Width="261px" Height="20px" BackColor="#7AC1C7" 
                                    onclick="btnAddPayElements_Click" ></asp:Button>
                                <br>       
                                <asp:Panel ID="pnlPayElements" runat="server" Wrap="False" Visible="false" 
                                    BackColor="#99CCFF">               
                                    <table style="width:800px; border-width:1px; border-color:Black; border-style:solid;">
                                        <tr style="visibility:collapse;">
                                            <td valign="top" style="width:20%">    
                                                <asp:Label ID="lblEpeCode" runat="server" Text="Id"></asp:Label>
                                                    
                                            </td>
                                            <td valign="top">    
                                                <asp:TextBox ID="txtEpeCode" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>    
                                                <asp:Label ID="lblPelCode" runat="server" Text="Pay Element :"></asp:Label>
                                            </td>
                                            <td>    
                                                <asp:DropDownList ID="ddlPelCode" runat="server" Width="217px" 
                                                    DataSourceID="SqlDataSource3" DataTextField="pel_desc" 
                                                    DataValueField="pel_code">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                                    ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                                    SelectCommand="get_payelements" SelectCommandType="StoredProcedure">
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>    
                                                <asp:Label ID="lblAmt" runat="server" Text="Amount :"></asp:Label>
                                                    
                                            </td>
                                            <td>    
                                                <asp:TextBox ID="txtAmt" runat="server" Width="217px" CssClass="currency"
                                                onkeypress="AllowOnlyNumeric(event);" > </asp:TextBox>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>    
                                                <asp:Label ID="lblOtHours" runat="server" Text="Overtime Hours :"></asp:Label>
                                                    
                                            </td>
                                            <td>    
                                                <asp:TextBox ID="txtOtHours" runat="server" Width="217px" CssClass="currency"
                                                onkeypress="AllowOnlyNumeric(event);" > </asp:TextBox>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>    
                                                    
                                            </td>
                                            <td>    
                                                <asp:Button ID="btnSaveAddedPayElement" runat="server" Text="Save Pay Element" 
                                                    onclick="btnSaveAddedPayElement_Click" /> 

                                            </td>
                                        </tr>
                                    </table> 
                                </asp:Panel>
                            </asp:Panel>

                            <br>                
                            <asp:Label ID="lblPayElementsTable" runat="server" Text="Employee Pay Elements Listing" 
                            Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                            <br>
                            <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
                                AutoGenerateColumns="False"
                                OnRowCommand="GridView2_RowCommand"
                                OnRowEditing="GridView2_RowEditing" 
                                OnRowUpdating="GridView2_RowUpdating" 
                                OnRowDeleting="GridView2_RowDeleting">

                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <EditRowStyle BackColor="#AAFFFF" />
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
                                            <asp:Label ID="lbl_epe_code" runat="server" Text='<%# Eval("epe_code") %>'
                                                 Width="50px"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_epe_code" runat="server" Enabled="false"
                                                 Width="50px"></asp:TextBox>
                                        </FooterTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lbl_epe_code" runat="server" Text='<%# Eval("epe_code") %>'
                                                 Width="50px"></asp:Label>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Pay Element Code">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_pel_sht_desc" runat="server" Text='<%# Eval("pel_sht_desc") %>'
                                                 Width="50px"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_pel_sht_desc" runat="server" Enabled="false"
                                                 Width="50px"></asp:TextBox>
                                        </FooterTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lbl_pel_sht_desc" runat="server" Text='<%# Eval("pel_sht_desc") %>'
                                                 Width="50px"></asp:Label>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Pay Element Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_pel_desc" runat="server" Text='<%# Eval("pel_desc") %>'
                                                ></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_pel_desc" runat="server" Enabled="false"
                                                 ></asp:TextBox>
                                        </FooterTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lbl_pel_desc" runat="server" Text='<%# Eval("pel_desc") %>'
                                                 ></asp:Label>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Taxable">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_pel_taxable" runat="server" Text='<%# Eval("pel_taxable") %>'
                                                 Width="50px"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_pel_taxable" runat="server" Enabled="false"
                                                 Width="50px"></asp:TextBox>
                                        </FooterTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lbl_pel_taxable" runat="server" Text='<%# Eval("pel_taxable") %>'
                                                 Width="50px"></asp:Label>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Deduction?">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_pel_deduction" runat="server" Text='<%# Eval("pel_deduction") %>'
                                                 Width="50px"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_pel_deduction" runat="server" Enabled="false"
                                                 Width="50px"></asp:TextBox>
                                        </FooterTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lbl_pel_deduction" runat="server" Text='<%# Eval("pel_deduction") %>'
                                                 Width="50px"></asp:Label>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Type">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_pel_type" runat="server" Text='<%# Eval("pel_type") %>'
                                                 ></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_pel_type" runat="server" Enabled="false"
                                                 ></asp:TextBox>
                                        </FooterTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lbl_pel_type" runat="server" Text='<%# Eval("pel_type") %>'
                                                 ></asp:Label>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_epe_amt" runat="server" Text='<%# Eval("epe_amt") %>'
                                                 Width="100px"  Style="text-align:right;"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_epe_amt" runat="server" Enabled="true" DataFormatString = "{0:00.##}"
                                                onkeypress="AllowOnlyNumeric(event);"
                                                 Width="100px"  Style="text-align:right;"></asp:TextBox>
                                        </FooterTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_epe_amt" runat="server" Enabled="true"  Style="text-align:right;"
                                                onkeypress="AllowOnlyNumeric(event);"
                                                Text='<%#DataBinder.Eval(Container.DataItem, "epe_amt") %>'
                                                 Width="100px"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="O.T. Hours">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_epe_ot_hours" runat="server" Text='<%# Eval("epe_ot_hours") %>'
                                                 Width="100px"  Style="text-align:right;"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_epe_ot_hours" runat="server" Enabled="true" DataFormatString = "{0:00.##}"
                                                onkeypress="AllowOnlyNumeric(event);"
                                                 Width="100px"  Style="text-align:right;"></asp:TextBox>
                                        </FooterTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_epe_ot_hours" runat="server" Enabled="true"  Style="text-align:right;"
                                                onkeypress="AllowOnlyNumeric(event);"
                                                Text='<%#DataBinder.Eval(Container.DataItem, "epe_ot_hours") %>'
                                                 Width="100px"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Created by">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_epe_created_by" runat="server" Text='<%# Eval("epe_created_by") %>'
                                                 Width="50px"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_epe_created_by" runat="server" Enabled="false"
                                                 Width="50px"></asp:TextBox>
                                        </FooterTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lbl_epe_created_by" runat="server" Text='<%# Eval("epe_created_by") %>'
                                                 Width="50px"></asp:Label>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
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
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                SelectCommand="get_emp_pay_elements" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtEmpCode" Name="v_emp_code" 
                                        PropertyName="Text" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                    </asp:Panel>
                    </asp:Panel>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
