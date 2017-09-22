<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxBanks.aspx.cs" Inherits="SerenePayroll.aspxBanks" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
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
    <td colspan="1" style="font-weight:bolder">Banks</td> 
    <td align="right">
        <input type="Button" value="X" 
        onClick="document.getElementById('divReports1').style.visibility = 'hidden';
    document.getElementById('divReports2').style.visibility = 'hidden'">
    </td>
    </tr> 
    <tr> 
    <td valign="top" style="height:100%"> 
        <rsweb:ReportViewer ID="lnkBankRpt" runat="server" Font-Names="Verdana" Width="100%" Height="98%" bottom="0px"
         BackColor="#ffffff" ForeColor="#000000"
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
            <LocalReport ReportPath="Reports/rptBanksListing.rdlc" >
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet2" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
    
    </td> 
    </tr>
    </table> 
    </div> 
    


    <table style="width:100%;  height:500px" cellpadding="0" cellspacing="0">
        <tr style="height:inherit; vertical-align:top">
            <td style="background-color:#99CCFF; width:0px; height:inherit">
                <div style="background-color:#99CCFF; height:inherit; width:250px">
                     <table style="width:100%;">
                        <tr><td>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                onclick="btnSearch_Click" />
                        </td></tr>
                        <tr><td>
                            <asp:Label ID="lblBnkShtDescSrch" runat="server" Text="Bank Code"></asp:Label>
                        </td></tr>
                        <tr><td>
                         <asp:TextBox ID="txtBnkShtDescSrch" runat="server" AutoPostBack="True"></asp:TextBox>
                        </td></tr>
                        <tr><td>
                            <asp:Label ID="lblBnknameSrch" runat="server" Text="Bank Name"></asp:Label>
                        </td></tr>
                        <tr><td>
                         <asp:TextBox ID="txtBnknameSrch" runat="server" width="210px" AutoPostBack="True"></asp:TextBox>
                        </td></tr>
                        <tr><td>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>

                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="SerenePayroll.DataSet2TableAdapters.shr_banksTableAdapter" UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_bnk_code" Type="Int32" />
                                        <asp:Parameter Name="Original_bnk_sht_desc" Type="String" />
                                        <asp:Parameter Name="Original_bnk_name" Type="String" />
                                        <asp:Parameter Name="Original_bnk_postal_address" Type="String" />
                                        <asp:Parameter Name="Original_bnk_physical_address" Type="String" />
                                        <asp:Parameter Name="Original_bnk_kba_code" Type="String" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="bnk_sht_desc" Type="String" />
                                        <asp:Parameter Name="bnk_name" Type="String" />
                                        <asp:Parameter Name="bnk_postal_address" Type="String" />
                                        <asp:Parameter Name="bnk_physical_address" Type="String" />
                                        <asp:Parameter Name="bnk_kba_code" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="bnk_sht_desc" Type="String" />
                                        <asp:Parameter Name="bnk_name" Type="String" />
                                        <asp:Parameter Name="bnk_postal_address" Type="String" />
                                        <asp:Parameter Name="bnk_physical_address" Type="String" />
                                        <asp:Parameter Name="bnk_kba_code" Type="String" />
                                        <asp:Parameter Name="Original_bnk_code" Type="Int32" />
                                        <asp:Parameter Name="Original_bnk_sht_desc" Type="String" />
                                        <asp:Parameter Name="Original_bnk_name" Type="String" />
                                        <asp:Parameter Name="Original_bnk_postal_address" Type="String" />
                                        <asp:Parameter Name="Original_bnk_physical_address" Type="String" />
                                        <asp:Parameter Name="Original_bnk_kba_code" Type="String" />
                                    </UpdateParameters>
                                </asp:ObjectDataSource>
                        </td></tr>
                        <tr><td>
                    <br>
                    <asp:LinkButton ID="lnkBankRptPrint" runat="server" onclick="lnkBankRptPrint_Click">List of Banks</asp:LinkButton>
                        </td></tr>
                            
                       
                     </table>
                


                </div>
            </td>
            <td>
                <div  style="height:inherit;">
                    <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click"  Visible="True" />
                    <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" 
                        Enabled="False" Enable="False"  />
                    <asp:Button ID="btnSaveNAddNew" runat="server" Text="Save and Add New" 
                        onclick="btnSaveNAddNew_Click" Enabled="False"  Enable="True"  />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                        onclick="btnDelete_Click" Enabled="False"  Enable="True"  />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                        onclick="btnCancel_Click"  Visible="True" />
                    <asp:Button ID="btnPopup" runat="server" Text="Popup" 
                        onclick="btnPopup_Click" Visible="False" />

                    <asp:Button ID="btnImpTaxRates" runat="server" Text="Import From CSV file" 
                        onclick="btnImpTaxRates_Click" Visible="true" />
                    <asp:Button ID="btnExpTaxRates" runat="server" Text="Export To CSV file" 
                        onclick="btnExpTaxRates_Click" Visible="False" />
                    <asp:Button ID="btnDeleteAll" runat="server" Text="Delete All" 
                        onclick="btnDeleteAll_Click" Visible="true" />
                    <asp:Button ID="btnDeleteAllBankDtls" runat="server" 
                        Text="Delete All Bank Details" onclick="btnDeleteAllBankDtls_Click" />
                    
                                    

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                        SelectCommand="get_banks" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtBnkShtDescSrch" Name="v_sht_desc" 
                                PropertyName="Text" Type="String" DefaultValue="%" />
                            <asp:ControlParameter ControlID="txtBnknameSrch" Name="v_bnk_name" 
                                PropertyName="Text" Type="String" DefaultValue="%" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    
                                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit Bank Details       (View/Hide)" Height="20px" visible="false"
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCFF">                        
                            <table style="width: 100%;">
                                <tr style="visibility:collapse">
                                    <td style="width:20%">
                                        <asp:Label ID="lblBnkCode" runat="server" Text="Id : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtBnkCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblShtDesc" runat="server" Text="Bank Code : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtShtDesc" runat="server" Width="217px" Enabled="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBnkName" runat="server" Text="Bank Name : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtBnkName" runat="server" Width="400" Enabled="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPostalAddr" runat="server" Text="Postal Address : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPostalAddr" runat="server" Width="400" Enabled="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPhysicalAddr" runat="server" Text="Physical Address : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPhysicalAddr" runat="server" Width="400" Enabled="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblKBAcode" runat="server" Text="KBA code : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtKBAcode" runat="server" Width="217" Enabled="True"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCF0"> 
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="bnk_code" 
                            DataSourceID="SqlDataSource1"
                            onselectedindexchanged="GridView1_SelectedIndexChanged"
                            onitemcommand="GridView1_ItemCommand" PageSize="4">

                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="bnk_code" HeaderText="Id" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="bnk_code" />
                                <asp:BoundField DataField="bnk_sht_desc" HeaderText="Bank Code" 
                                    SortExpression="bnk_sht_desc" />
                                <asp:BoundField DataField="bnk_name" HeaderText="Bank Name" 
                                    SortExpression="bnk_name" />
                                <asp:BoundField DataField="bnk_postal_address" HeaderText="Postal Address" 
                                    SortExpression="bnk_postal_address" />
                                <asp:BoundField DataField="bnk_physical_address" HeaderText="Physical Address" 
                                    SortExpression="bnk_physical_address" />
                                <asp:BoundField DataField="bnk_kba_code" HeaderText="KBA code" 
                                    SortExpression="bnk_kba_code" />
                            </Columns>
                        </asp:GridView>

                    </asp:Panel>                  

                    
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

                        <br>
                        <asp:Label ID="lblDefDivFactor" runat="server"
                                Text="Default Division Factor" Visible="False"></asp:Label>
                        <asp:TextBox ID="txtDefDivFactor" runat="server" Width="217px" Visible="False"></asp:TextBox>
                        <br>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                            ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                            SelectCommand="get_bank_branches" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtBnkCode" Name="v_bnk_code" 
                                    PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br>
                        <asp:GridView ID="GridView2" runat="server" AllowPaging="false"
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="bbr_code" 
                            ShowFooter="True" ShowHeaderWhenEmpty="True" 
                            OnRowCommand="GridView2_RowCommand"
                            OnRowEditing="GridView2_RowEditing" 
                            OnRowUpdating="GridView2_RowUpdating" 
                            OnRowDeleting="GridView2_RowDeleting" >

                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#DDDDBF" />
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
                                        <asp:Label ID="lbl_bbr_code" runat="server" Text='<%# Eval("bbr_code") %>'
                                             Width="50px"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_bbr_code" runat="server" Enabled="false"
                                             Width="50px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_bbr_code" runat="server" Enabled="false" Text='<%#DataBinder.Eval(Container.DataItem, "bbr_code") %>'
                                             Width="50px"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bank Branch Code">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_bbr_sht_desc" runat="server" Text='<%# Eval("bbr_sht_desc") %>'
                                             Width="100px"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_bbr_sht_desc" runat="server"
                                             Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_bbr_sht_desc" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "bbr_sht_desc") %>'
                                             Width="100px"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Branch Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_bbr_name" runat="server" Text='<%# Eval("bbr_name") %>' ></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_bbr_name" runat="server" width="98%"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_bbr_name" runat="server"  width="98%"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "bbr_name") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Postal Address">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_bbr_postal_address" runat="server"
                                            Text='<%# Eval("bbr_postal_address") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_bbr_postal_address" runat="server" Text=""></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_bbr_postal_address" runat="server"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "bbr_postal_address") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Physical Address">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_bbr_physical_address" runat="server"
                                            Text='<%# Eval("bbr_physical_address") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_bbr_physical_address" runat="server" Text=""></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_bbr_physical_address" runat="server" 
                                        Text='<%#DataBinder.Eval(Container.DataItem, "bbr_physical_address") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tel. No. 1">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_bbr_tel_no1" runat="server"  Width="100px"
                                            Text='<%# Eval("bbr_tel_no1") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_bbr_tel_no1" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_bbr_tel_no1" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "bbr_tel_no1") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tel. No. 2">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_bbr_tel_no2" runat="server"  Width="100px"
                                            Text='<%# Eval("bbr_tel_no2") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txt_bbr_tel_no2" runat="server" Text="" Width="100px"></asp:TextBox>
                                    </FooterTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_bbr_tel_no2" runat="server"  Width="100px"
                                        Text='<%#DataBinder.Eval(Container.DataItem, "bbr_tel_no2") %>'></asp:TextBox>
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
