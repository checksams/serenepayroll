<%@ Page Title="" Language="C#" MasterPageFile="~/SiteLogin.Master" AutoEventWireup="true" CodeBehind="aspxLogin.aspx.cs" Inherits="WebApplication2.aspxLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div align="center">
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
