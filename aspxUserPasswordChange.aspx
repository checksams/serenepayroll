<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxUserPasswordChange.aspx.cs" Inherits="SerenePayroll.aspxUserPasswordChange" %>
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
                    <asp:Panel ID="pnlButtons" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCF0">
                        <asp:Label ID="lblChangePassword" runat="server" Text="Change Password" 
                        Width="100%" Font-Bold="true" BackColor="#99DDF0" ></asp:Label>
                        <br>
                        <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" 
                            Enabled="true" />
                        <asp:Button ID="btnPopup" runat="server" Text="Popup" 
                            onclick="btnPopup_Click" Visible="True" />
                    </asp:Panel>

                                    
                    <asp:Panel ID="Editing" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCF0">

                    <asp:Panel ID="pnlEditingData" runat="server" Wrap="False" Visible="true" 
                        BackColor="#99CCFF">                        
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width:20%">
                                        <asp:Label ID="lblUserName" runat="server" Text="User Name : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUserName" runat="server" Width="217px" Enabled="false" BackColor="#eeeeee"> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPassword" runat="server" Text="Password : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPassword" runat="server" Width="217px" Enabled="true" TextMode="Password"> </asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="txtPassword" 
                                         CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                                         ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblNewPassword" runat="server" Text="New Password : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtNewPassword" runat="server" Width="217px" Enabled="true" TextMode="Password"> </asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNewPassword" 
                                         CssClass="failureNotification" ErrorMessage="New Password is required." ToolTip="New Password is required." 
                                         ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                                     </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblReEnterNewPwd" runat="server" Text="Re-enter the New Password : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtReEnterNewPwd" runat="server" Width="217px" Enabled="true" TextMode="Password"> </asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtReEnterNewPwd" 
                                         CssClass="failureNotification" ErrorMessage="Re-enter New Password is required." ToolTip="Re-enter New Password is required." 
                                         ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        
                    </asp:Panel>
                    </asp:Panel>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
