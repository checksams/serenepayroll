<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxSystemRoles.aspx.cs" Inherits="SerenePayroll.aspxSystemRoles" %>
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
                        <asp:Label ID="lblUserRoles" runat="server" Text="User Roles" 
                        Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>

                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ur_code" 
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
                                <asp:BoundField DataField="ur_code" HeaderText="Id" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="ur_code" />
                                <asp:BoundField DataField="ur_name" HeaderText="Role Name" 
                                    SortExpression="ur_name" />
                                <asp:BoundField DataField="ur_desc" HeaderText="Role Description" 
                                    SortExpression="ur_desc" />
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
                        SelectCommand="get_user_roles" SelectCommandType="StoredProcedure">
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
                                        <asp:Label ID="lblUrCode" runat="server" Text="Id : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUrCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblname" runat="server" Text="Role Name : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtname" runat="server" Width="217px" BackColor="White"
                                        Enabled="true"> </asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDesc" runat="server" Text="Role Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDesc" runat="server" Width="400"  BackColor="White"
                                        Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                    
                    <asp:Panel ID="pnlPrivillagesAdmin" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCF0" ScrollBars="Auto">
                        <br>
                        <asp:Label ID="lblPrivillagesAdmin" runat="server" Text="Privillage Administration" 
                        Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                        <table width="100%">
                            <tr>
                                <td style="width:40%; height:inherit; vertical-align:top">                                
                                    <asp:Panel ID="pnlPrivillages" runat="server" Wrap="False" Visible="true" 
                                        BackColor="#99CCF0" ScrollBars="Auto">
                                        <asp:Label ID="lblPrivillages" runat="server" Text="Privillages" 
                                        Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                                            DataSourceID="SqlDataSource2" AllowPaging="True" AllowSorting="True" 
                                            DataKeyNames="up_code"
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
                                                        <input id="chkAllPrivs" onclick="javascript:SelectAllCheckboxes(this);" runat="server"
                                                            type="checkbox" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkPrivSelect" runat="server" />
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:TemplateField  HeaderText="Id">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_up_code" runat="server" Text='<%# Eval("up_code") %>'
                                                        Width="10px"></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>
                                                    
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Privillage Name">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_up_name" runat="server" Text='<%# Eval("up_name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Min. Amount">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_up_min_amt" runat="server" Text='<%# Eval("up_min_amt") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Max. Amount">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_up_max_amt" runat="server" Text='<%# Eval("up_max_amt") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Type">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_up_type" runat="server" Text='<%# Eval("up_type") %>'></asp:Label>
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
                                            SelectCommand="get_user_privillages_list" 
                                            SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtUrCode" Name="v_ur_code" 
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
                                    <asp:Panel ID="pnlPrivillagesGranted" runat="server" Wrap="False" Visible="true" 
                                        BackColor="#99CCF0" ScrollBars="Auto">
                                        <asp:Label ID="lblpnlPrivillagesGranted" runat="server" Text="Privillages Granted" 
                                        Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                                        
                                        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" 
                                            AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource3">
                                            
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
                                                        <input id="chkAllGrants" onclick="javascript:SelectAllCheckboxes(this);" runat="server"
                                                            type="checkbox" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkGrantSelect" runat="server" />
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:TemplateField  HeaderText="Id">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_up_code" runat="server" Text='<%# Eval("up_code") %>'
                                                        Width="10px"></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>
                                                    
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:TemplateField  HeaderText="Privillage Name">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_up_name" runat="server" Text='<%# Eval("up_name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Min. Amount">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_urp_min_amt" runat="server" Text='<%# Eval("urp_min_amt") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Max. Amount">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_urp_max_amt" runat="server" Text='<%# Eval("urp_max_amt") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField  HeaderText="Type">    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_up_type" runat="server" Text='<%# Eval("up_type") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>

                                                    </FooterTemplate>                                    
                                                    <EditItemTemplate>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField>    
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_urp_code" runat="server" Text='<%# Eval("urp_code") %>'
                                                        Visible="true"></asp:Label>
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
                                            SelectCommand="get_user_role_privlg" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="txtUrCode" Name="v_ur_code" 
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
