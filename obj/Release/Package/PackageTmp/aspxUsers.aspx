<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxUsers.aspx.cs" Inherits="SerenePayroll.aspxUsers" %>
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
    
    <script type="text/javascript">
        function SelectAllCheckboxes(spanChk)
            {
             var oItem = spanChk.children;
             var theBox= (spanChk.type=="checkbox") ?
             spanChk : spanChk.children.item[0];
             xState=theBox.checked;
             elm=theBox.form.elements;
 
             for(i=0;i<elm.length;i++)
              if(elm[i].type=="checkbox" &&
                elm[i].id!=theBox.id)
                {
                 if(elm[i].checked!=xState)
                   elm[i].click();
                }
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
                    
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible=true 
                        BackColor="#99CCF0">
                        <asp:Label ID="lblUsers" runat="server" Text="Users" 
                        Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>

                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="usr_code" 
                            DataSourceID="SqlDataSource1"
                            onselectedindexchanged="GridView1_SelectedIndexChanged"
                            onitemcommand="GridView1_ItemCommand" PageSize="5">

                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="usr_code" HeaderText="Id" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="usr_code" />
                                <asp:BoundField DataField="usr_name" HeaderText="User Name" 
                                    SortExpression="usr_name" />
                                <asp:BoundField DataField="usr_full_name" HeaderText="Full Name" 
                                    SortExpression="usr_full_name" />
                                <asp:BoundField DataField="usr_emp_code" HeaderText="Emp. Record Id." 
                                    SortExpression="usr_emp_code" />
                                <asp:BoundField DataField="usr_pwd_reset" HeaderText="Reset Password" 
                                    SortExpression="usr_pwd_reset" />
                                <asp:BoundField DataField="usr_last_login" HeaderText="Last Login Date" 
                                    SortExpression="usr_last_login" />
                                <asp:BoundField DataField="usr_login_atempts" HeaderText="Login Atempts" 
                                    SortExpression="usr_login_atempts" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>

                    <asp:Panel ID="pnlButtons" runat="server" Wrap="False" Visible="true" 
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
                        SelectCommand="get_users" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                    
                                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit System Roles Details       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCFF">                        
                            <table style="width: 800px;">
                                <tr style="visibility:collapse">
                                    <td style="width:20%">
                                        <asp:Label ID="lblUsrCode" runat="server" Text="Id : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUsrCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblname" runat="server" Text="User Name : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtname" runat="server" Width="217px" BackColor="White"
                                        Enabled="true"> </asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblFullName" runat="server" Text="Full Name : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFullName" runat="server" Width="400"  BackColor="White"
                                        Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblEmpCode" runat="server" Text="Employment Record Id. : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEmpCode" runat="server" Width="217px" BackColor="White"
                                        Enabled="false"> </asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblPwdReset" runat="server" Text="Reset Password : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlPwdReset" runat="server" Width="217px" BackColor="White">
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="YES">YES</asp:ListItem>
                                            <asp:ListItem Value= "NO">NO</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLastLogin" runat="server" Text="Last Login Date : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLastLogin" runat="server" Width="217px" BackColor="White"
                                        Enabled="false"> </asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblLastLoginAttempts" runat="server" Text="Last Login Attempts : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLastLoginAttempts" runat="server" Width="217px" BackColor="White"
                                        Enabled="false"> </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                    
                    <asp:Panel ID="pnlRightsAdmin" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCF0" ScrollBars="Auto">
                        <br>
                        <asp:Label ID="lblRightsAdmin" runat="server" Text="User Rights Administration" 
                        Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                        <table width="100%">
                            <tr>
                                <td style="width:40%; height:inherit; vertical-align:top">                                
                                    <asp:Panel ID="pnlRights" runat="server" Wrap="False" Visible="true" 
                                        BackColor="#99CCF0" ScrollBars="Auto">
                                        <asp:Label ID="lblRights" runat="server" Text="Rights" 
                                        Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                                            DataSourceID="SqlDataSource2" AllowPaging="True" AllowSorting="True" 
                                            DataKeyNames="ur_code"
                                            Width="100%"
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
                                                    <HeaderTemplate>
                                                        <input id="chkAllRights" onclick="javascript:SelectAllCheckboxes(this);" runat="server"
                                                            type="checkbox" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkRightSelect" runat="server" />
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:TemplateField  HeaderText="Id">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_ur_code" runat="server" Text='<%# Eval("ur_code") %>'
                                                        Width="10px"></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>
                                                    
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Role Name">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_ur_name" runat="server" Text='<%# Eval("ur_name") %>'
                                                        ></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>
                                                    
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Role Description">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_ur_desc" runat="server" Text='<%# Eval("ur_desc") %>'
                                                        ></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>
                                                    
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <asp:Label ID="lblPrivEmptyMessage" runat="server" 
                                                    Text="NO RECORDS TO DISPLAY"  BackColor="White"/>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                            ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                            SelectCommand="get_user_roles_list" 
                                            SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtUsrCode" Name="v_usr_code" 
                                                    PropertyName="Text" Type="Int64" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </asp:Panel>
                                </td>
                                <td style="width:70px">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnGrant" Width="110px"
                                                    runat="server" Text="Grant >" onclick="btnGrant_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnGrantAll" Width="110px" Visible="false"
                                                    runat="server" Text="Grant all >>" onclick="btnGrantAll_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnRevoke" Width="110px"
                                                    runat="server" Text="< Revoke" onclick="btnRevoke_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnRevokeAll" Width="110px"  Visible="false"
                                                    runat="server" Text="<< Revoke all" onclick="btnRevokeAll_Click" />
                                            </td>
                                        </tr>
                                    </table>


                                </td>
                                <td  style="height:inherit; vertical-align:top">                    
                                    <asp:Panel ID="pnlRightsGranted" runat="server" Wrap="False" Visible="true" 
                                        BackColor="#99CCF0" ScrollBars="Auto">
                                        <asp:Label ID="lblpnlRightsGranted" runat="server" Text="Rights Granted" 
                                        Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                                        
                                        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" 
                                            AllowSorting="True" AutoGenerateColumns="False" 
                                            DataSourceID="SqlDataSource3"
                                            Width="100%"
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
                                                    <HeaderTemplate>
                                                        <input id="chkAllRightsGranted" onclick="javascript:SelectAllCheckboxes(this);" runat="server"
                                                            type="checkbox" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkRightGrantedSelect" runat="server" />
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:TemplateField  HeaderText="Id">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_ur_code" runat="server" Text='<%# Eval("ur_code") %>'
                                                        Width="10px"></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>
                                                    
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Role Name">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_ur_name" runat="server" Text='<%# Eval("ur_name") %>'
                                                        ></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>
                                                    
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Role Description">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_ur_desc" runat="server" Text='<%# Eval("ur_desc") %>'
                                                        ></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>
                                                    
                                                    </EditItemTemplate>
                                                </asp:TemplateField> 
                                                <asp:TemplateField >    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_usg_code" runat="server" Text='<%# Eval("usg_code") %>'
                                                         Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>
                                                    
                                                    </EditItemTemplate>
                                                </asp:TemplateField> 
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <asp:Label ID="lblGrantEmptyMessage" runat="server" 
                                                    Text="NO RECORDS TO DISPLAY" BackColor="White" />
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:serenehrdbConnectionString %>" 
                                            ProviderName="<%$ ConnectionStrings:serenehrdbConnectionString.ProviderName %>" 
                                            SelectCommand="get_user_roles_granted" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtUsrCode" Name="v_usr_code" 
                                                    PropertyName="Text" Type="Int64" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                    </asp:Panel>                                
                                
                                
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>          
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
