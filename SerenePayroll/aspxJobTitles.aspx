<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxJobTitles.aspx.cs" Inherits="SerenePayroll.aspxJobTitles" %>
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
                        SelectCommand="SELECT jt_code, jt_sht_code, jt_desc FROM vw_job_titlles">
                    </asp:SqlDataSource>
                    
                                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCF0">
                        <asp:Button ID="btnEditPnl" runat="server" 
                            Text="Edit Job Titles       (View/Hide)" Height="20px" 
                            onclick="btnEditPnl_Click" Width="261px" BackColor="#7AC1C7" />
                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="False" 
                        BackColor="#99CCFF">                        
                            <table style="width: 100%;">
                                <tr style="visibility:collapse">
                                    <td style="width:20%">
                                        <asp:Label ID="lblJtCode" runat="server" Text="JobID : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtJtCode" runat="server" Width="217px" Enabled="False"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblJtShtDesc" runat="server" Text="Job Short Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtJtShtDesc" runat="server" Width="217px" Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDesc" runat="server" Text="Job Full Description : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDesc" runat="server" Width="400" Enabled="true"> </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="pnlDisplayAllRecs" runat="server" Wrap="False" Visible=true 
                        BackColor="#99CCF0">&nbsp;<asp:ListView ID="ListView1" runat="server" 
                            DataSourceID="SqlDataSource1" 
                            DataKeyNames="jt_code" 
                            onselectedindexchanged="ListView1_SelectedIndexChanged"
                            onitemcommand="ListView1_ItemCommand">
                            <LayoutTemplate> 
                                <table id="Table1" runat="server" class="TableCSS"> 
                                    <tr id="Tr1" runat="server" class="TableHeader"> 
                                        <td id="Td4" runat="server" width="10px">Select</td> 
                                        <td id="Td1" runat="server" width="0px">Id</td> 
                                        <td id="Td2" runat="server">Job Code</td> 
                                        <td id="Td3" runat="server">Job Description</td> 
                                    </tr> 
                                    <tr id="ItemPlaceholder" runat="server"> 
                                    </tr> 
                                    <tr id="Tr2" runat="server"> 
                                        <td id="Td6" runat="server" colspan="2"> 
                                            <asp:DataPager ID="DataPager1" runat="server"> 
                                                <Fields> 
                                                    <asp:NextPreviousPagerField ButtonType="Link" /> 
                                                    <asp:NumericPagerField /> 
                                                    <asp:NextPreviousPagerField ButtonType="Link" /> 
                                                </Fields> 
                                            </asp:DataPager> 
                                        </td> 
                                    </tr> 
                                </table> 
                            </LayoutTemplate>      
                            <ItemTemplate> 
                                <tr class="TableData"> 
                                    <td style="width:10px"> 
                                        <asp:LinkButton ID="lnkSelect" Text="Select" CommandName="Select" runat="server" 
                                        CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>                                         
                                    </td> 
                                    <td style="width:0px"> 
                                        <asp:Label  
                                            ID="lblJtCode" 
                                            runat="server" 
                                            Text='<%# Eval("jt_code")%>' 
                                            > 
                                        </asp:Label> 
                                    </td> 
                                    <td> 
                                        <asp:Label  
                                            ID="lblShtDesc" 
                                            runat="server" 
                                            Text='<%# Eval("jt_sht_code")%>'> 
                                        </asp:Label> 
                                    </td>
                                    <td> 
                                        <asp:Label  
                                            ID="lblDesc" 
                                            runat="server" 
                                            Text='<%# Eval("jt_desc")%>'> 
                                        </asp:Label> 
                                    </td>
                                </tr> 
                            </ItemTemplate> 
                            
                            <SelectedItemTemplate> 
                                <tr style="background-color: #336699; color: White;"> 
                                    <td style="width:10px"> 
                                        <asp:LinkButton ID="lnkSelect" Text="Select" CommandName="Select" runat="server"
                                            CommandArgument='<%# Container.DataItemIndex %>' ForeColor="White">
                                        </asp:LinkButton>
                                    </td> 
                                    <td style="width:0px"> 
                                        <asp:Label  
                                            ID="lblJtCode" 
                                            runat="server" 
                                            Text='<%# Eval("jt_code")%>' 
                                            > 
                                        </asp:Label> 
                                    </td> 
                                    <td> 
                                        <asp:Label  
                                            ID="lblShtDesc" 
                                            runat="server" 
                                            Text='<%# Eval("jt_sht_code")%>'> 
                                        </asp:Label> 
                                    </td>
                                    <td> 
                                        <asp:Label  
                                            ID="lblDesc" 
                                            runat="server" 
                                            Text='<%# Eval("jt_desc")%>'> 
                                        </asp:Label> 
                                    </td>
                                </tr> 
                            </SelectedItemTemplate> 
                            
                            <EmptyDataTemplate>
                                <table >
                                    <tr>
                                        <td>No data was returned.</td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>



                    </asp:Panel>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
