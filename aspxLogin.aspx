<%@ Page Title="" Language="C#" MasterPageFile="~/SiteLogin.Master" AutoEventWireup="true" CodeBehind="aspxLogin.aspx.cs" Inherits="WebApplication2.aspxLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
    <script language="JavaScript" type="text/javascript" src="/Scripts/CustomeFunctions.js">  </script>

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

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div align="center">
    
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

    <br><br><br><br>
    <table>
       <tr>
          <td>User Name:</td>
          <td><input id="txtUserName" type="text" runat="server"></td>
          <td><ASP:RequiredFieldValidator ControlToValidate="txtUserName"
               Display="Static" ErrorMessage="* Username is required" runat="server" ForeColor="Red"
               ID="vUserName" /></td>
       </tr>
       <tr>
          <td>Password:</td>
          <td><input id="txtUserPass" type="password" runat="server"></td>
          <td><ASP:RequiredFieldValidator ControlToValidate="txtUserPass"
              Display="Static" ErrorMessage="* Password is required." runat="server" 
                ForeColor="Red"
              ID="vUserPass" />
          </td>
       </tr>
       <tr style="visibility:hidden">
          <td>Persistent Cookie:</td>
          <td><ASP:CheckBox id="chkPersistCookie" runat="server" autopostback="false" /></td>
          <td></td>
       </tr>
       <tr>
          <td>&nbsp;</td>
          <td>
            <asp:Button ID="cmdLogin" runat="server" Text="Logon" 
                onclick="cmdLogin_Click" /></td>
          <td></td>
       </tr>
    </table>

    <asp:Label id="lblMsg" ForeColor="red" Font-Name="Verdana" Font-Size="10" runat="server" />
</div>				
</asp:Content>
