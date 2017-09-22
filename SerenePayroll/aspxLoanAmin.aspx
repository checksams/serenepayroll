<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxLoanAmin.aspx.cs" Inherits="SerenePayroll.aspxLoanAmin" %>
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
            border-style:ridge; 
            background-color:#fff; 
            width: 100%; 
            -moz-border-radius-topright: 50px 30px;
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
            -moz-border-radius: 1em;
        } 
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="page_dimmer" id="pagedimmer" style="display:none "> </div> 
    <div class="msg_box_container" id="msgbox" style="display:none "> 
    <table class="errorTableRound" cellpadding="5"> 
    <tr style="background-color:inherit;"> 
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
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible="true" 
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
                            <table style="width:700px;">
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
                                <tr>
                                    <td>
                                        <asp:Label ID="lblOtherNames" runat="server" Text="Other Names : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherNames" runat="server" Width="400" Enabled="False" ForeColor="Black"> </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <br>
                            
                            <asp:Panel ID="pnlButtons" runat="server" Wrap="False" Visible="true" 
                                BackColor="#99CCF0">
                                <asp:Button ID="btnNewLoan" runat="server" Text="New Loan" 
                                    onclick="btnNewLoan_Click" />
                                <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                    onclick="btnCancel_Click" />
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                                    onclick="btnDelete_Click"  />
                                <asp:Button ID="btnProcess" runat="server" Text="Process Loan" 
                                    onclick="btnProcess_Click" />
                                <asp:Button ID="btnAuthoriseLoan" runat="server" Text="Authorise Loan" 
                                    onclick="btnAuthoriseLoan_Click" />
                           </asp:Panel>
                           
                           <asp:Panel ID="pnlEmpLoans" runat="server" Wrap="False" Visible="true" 
                                BackColor="#99CCF0">
                                
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                    ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                    SelectCommand="get_loan_types_ddl" SelectCommandType="StoredProcedure">
                                </asp:SqlDataSource>
                                <table style="width:700px;">
                                    <tr style="width:100%;">
                                        <td>
                                            <table style="width:100%;">
                                                <tr>
                                                    <td style="width:150px;">
                                                        <asp:Label ID="lbl_el_code" runat="server" Text="Loan Id :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_code" runat="server" Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"></asp:TextBox>
                                                    </td>
                                                </tr>                                                
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_lt_code" runat="server" Text="Loan Type :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddl_el_lt_code" runat="server" Width="150px"
                                                            DataSourceID="SqlDataSource3" DataTextField="lt_desc" 
                                                            DataValueField="lt_code" BackColor="white">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_eff_date" runat="server" Text="Loan effective date<br> (DD/MM/YYYY) :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_eff_date" runat="server"  Width="150px" BackColor="white"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_loan_applied_amt" runat="server" Text="Applied Amount :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_loan_applied_amt" runat="server" Width="150px"
                                                        CssClass="currency"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_service_charge" runat="server" Text="Service Charge :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_service_charge" runat="server" Width="150px"
                                                        CssClass="currency"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_instalment_amt" runat="server" Text="Installment Amount :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_instalment_amt" runat="server" Width="150px"
                                                        CssClass="currency"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_tot_instalments" runat="server" Text="Total Installments :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_tot_instalments" runat="server" Width="150px"
                                                        CssClass="currency"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_issued_amt" runat="server" Text="Issued Amount :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_issued_amt" runat="server" Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"
                                                        CssClass="currency"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_tot_tax_amt" runat="server" Text="Tax Amount :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_tot_tax_amt" runat="server"  Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"
                                                        CssClass="currency"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="vertical-align:top">
                                            <table style="width:100%;">
                                                <tr style="width:150px;">
                                                    <td>
                                                        <asp:Label ID="lbl_el_intr_rate" runat="server" Text="Interest Rate :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_intr_rate" runat="server" Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_intr_div_factr" runat="server" Text="Division Factor :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_intr_div_factr" runat="server" Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_done_by" runat="server" Text="Done by :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_done_by" runat="server" Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_authorised_by" runat="server" Text="Authorised by :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_authorised_by" runat="server" Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_authorised_date" runat="server" 
                                                         Text="Authorised Date<br> (DD/MM/YYYY) :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_authorised_date" runat="server" Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_authorised" runat="server" Text="Authorised? :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_authorised" runat="server" Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_el_final_repay_date" runat="server"  
                                                        Text="Expected Last Repay Date<br> (DD/MM/YYYY) :"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_el_final_repay_date" runat="server" Width="150px" Enabled="false"
                                                         BackColor="#eeeeee"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br>
                           </asp:Panel>
                           <asp:Panel ID="pnlEmpLoanListing" runat="server" Wrap="False" Visible="true" 
                                BackColor="#99CCF0">

                               <asp:Label ID="lblEmployeeLoans" runat="server" Text="Employee Loans" 
                                Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>

                                <asp:GridView ID="GridView2" runat="server" AllowSorting="True"
                                    AutoGenerateColumns="False"                                    
                                    onselectedindexchanged="GridView2_SelectedIndexChanged"
                                    DataKeyNames="el_code" PageSize="3" >
                                    
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <RowStyle BackColor="#EFF3FB" />         
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <EditRowStyle BackColor="#AAFFFF" />
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>                                 
                                        <asp:CommandField ShowSelectButton="True" />
                                        <asp:BoundField DataField="el_code" HeaderText="Id" InsertVisible="False" 
                                            ReadOnly="True" SortExpression="el_code" />
                                        <asp:BoundField DataField="el_lt_code" HeaderText="Loan Type Id"
                                            SortExpression="el_lt_code" HeaderStyle-CssClass = "hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                        <asp:BoundField DataField="lt_desc" HeaderText="Loan Type" 
                                            SortExpression="lt_desc" />
                                        <asp:BoundField DataField="el_eff_date" HeaderText="Loan Effective Date :" 
                                            SortExpression="el_eff_date" />
                                        <asp:BoundField DataField="el_loan_applied_amt" 
                                            HeaderText="Applied Amount" SortExpression="el_loan_applied_amt" 
                                            HeaderStyle-CssClass = "currencyGridColumn" ItemStyle-CssClass="currencyGridColumn" />
                                        <asp:BoundField DataField="el_service_charge" HeaderText="Service Charge" 
                                            SortExpression="el_service_charge"
                                            HeaderStyle-CssClass = "currencyGridColumn" ItemStyle-CssClass="currencyGridColumn"  />
                                        <asp:BoundField DataField="el_issued_amt" HeaderText="Issued Amount" 
                                            SortExpression="el_issued_amt" 
                                            HeaderStyle-CssClass = "currencyGridColumn" ItemStyle-CssClass="currencyGridColumn" />
                                        <asp:BoundField DataField="el_tot_tax_amt" HeaderText="Total Tax Amount" 
                                            SortExpression="el_tot_tax_amt" 
                                            HeaderStyle-CssClass = "currencyGridColumn" ItemStyle-CssClass="currencyGridColumn" />
                                        <asp:BoundField DataField="el_intr_rate" HeaderText="Interest Rate" 
                                            SortExpression="el_intr_rate" 
                                            HeaderStyle-CssClass = "currencyGridColumn" ItemStyle-CssClass="currencyGridColumn" />
                                        <asp:BoundField DataField="el_intr_div_factr" HeaderText="Division Factor" 
                                            SortExpression="el_intr_div_factr" 
                                            HeaderStyle-CssClass = "currencyGridColumn" ItemStyle-CssClass="currencyGridColumn" />
                                        <asp:BoundField DataField="el_done_by" HeaderText="Done By" 
                                            SortExpression="el_done_by" />
                                        <asp:BoundField DataField="el_authorised_by" HeaderText="Authorised by" 
                                            SortExpression="el_authorised_by" />
                                        <asp:BoundField DataField="el_authorised" HeaderText="Authorised?" 
                                            SortExpression="el_authorised" />
                                        <asp:BoundField DataField="el_authorised_date" HeaderText="Authorised Date" 
                                            SortExpression="el_authorised_date" />
                                        <asp:BoundField DataField="el_instalment_amt" HeaderText="Installment Amount" 
                                            SortExpression="el_instalment_amt" 
                                            HeaderStyle-CssClass = "currencyGridColumn" ItemStyle-CssClass="currencyGridColumn" />
                                        <asp:BoundField DataField="el_tot_instalments" HeaderText="Totat Installments" 
                                            SortExpression="el_tot_instalments" />
                                        <asp:BoundField DataField="el_final_repay_date" HeaderText="Expected Last Repay Date" 
                                            
                                            SortExpression="el_final_repay_date" />
                                        
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <table id="Table1" runat="server" 
                                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                                            <tr>
                                                <td>
                                                    No Employee Loans to display.</td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                    ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                    SelectCommand="get_emp_loans" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="txtEmpCode" Name="v_emp_code" 
                                            PropertyName="Text" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>                                
                           </asp:Panel>
                    </asp:Panel>
                    </asp:Panel>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
