<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="aspxImportFromExcel.aspx.cs" Inherits="SerenePayroll.aspxImportFromExcel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <asp:FileUpload ID="fu_ImportCSV" runat="server" />
        <asp:Button ID="btn_ImportCSV" runat="server" Text="Import CSV" OnClick="btn_ImportCSV_Click" />
        <br />
        <br />
        <asp:Label ID="lbl_ErrorMsg" runat="server" Visible="false"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblOsPlatform" runat="server" Visible="false"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblOsPlatform2" runat="server" Visible="false"></asp:Label>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333"
            GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
    </div>
</asp:Content>
